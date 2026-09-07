"""Bounded Gaussian action distribution for the locomotion2 RSL-RL policy."""

from __future__ import annotations

import math

import torch
from torch import nn
from torch.nn import functional as F
from torch.distributions import Normal

from rsl_rl.modules.distribution import Distribution


class _TanhOutput(nn.Module):
    def __init__(self, latent_mean_bound: float) -> None:
        super().__init__()
        self.latent_mean_bound = latent_mean_bound

    def forward(self, value: torch.Tensor) -> torch.Tensor:
        mean = self.latent_mean_bound * torch.tanh(
            value / self.latent_mean_bound
        )
        return torch.tanh(mean)


class TanhGaussianDistribution(Distribution):
    """Diagonal Normal transformed through tanh into ``[-1, 1]``.

    The inverse-transform correction is included in ``log_prob`` so PPO sees
    the same action distribution that is passed to the environment.
    """

    def __init__(
        self,
        output_dim: int,
        init_std: float = 0.3,
        std_range: tuple[float, float] = (1e-4, 0.8),
        std_type: str = "scalar",
        learn_std: bool = True,
        latent_mean_bound: float = 3.0,
        latent_sample_bound: float = 6.0,
    ) -> None:
        super().__init__(output_dim)
        if init_std <= 0.0:
            raise ValueError("init_std must be positive")
        if std_type not in ("scalar", "log"):
            raise ValueError("std_type must be 'scalar' or 'log'")
        if len(std_range) != 2 or not 0.0 < std_range[0] < std_range[1]:
            raise ValueError("std_range must be an increasing positive pair")
        if not math.isfinite(latent_mean_bound) or latent_mean_bound <= 0.0:
            raise ValueError("latent_mean_bound must be positive and finite")
        if (
            not math.isfinite(latent_sample_bound)
            or latent_sample_bound <= latent_mean_bound
        ):
            raise ValueError("latent_sample_bound must be finite and exceed the mean bound")
        self.std_type = std_type
        self.std_range = (float(std_range[0]), float(std_range[1]))
        self.latent_mean_bound = float(latent_mean_bound)
        self.latent_sample_bound = float(latent_sample_bound)
        self.action_bound = math.tanh(self.latent_sample_bound)
        if std_type == "scalar":
            self.std_param = nn.Parameter(
                torch.full((output_dim,), init_std), requires_grad=learn_std
            )
        else:
            self.log_std_param = nn.Parameter(
                torch.full((output_dim,), math.log(init_std)),
                requires_grad=learn_std,
            )
        self.log_std_range = tuple(math.log(value) for value in self.std_range)
        self._distribution: Normal | None = None
        Normal.set_default_validate_args(False)

    @property
    def input_dim(self) -> int:
        return self.output_dim

    def _std(self) -> torch.Tensor:
        if self.std_type == "scalar":
            return self.std_param.clamp(*self.std_range)
        return self.log_std_param.clamp(*self.log_std_range).exp()

    def init_mlp_weights(self, mlp: nn.Module) -> None:
        final_linear = next(
            (module for module in reversed(list(mlp.modules())) if isinstance(module, nn.Linear)),
            None,
        )
        if final_linear is None:
            raise ValueError("actor MLP does not contain a linear output layer")
        nn.init.zeros_(final_linear.weight)
        nn.init.zeros_(final_linear.bias)

    def _bounded_mean(self, value: torch.Tensor) -> torch.Tensor:
        return self.latent_mean_bound * torch.tanh(value / self.latent_mean_bound)

    def update(self, mlp_output: torch.Tensor) -> None:
        mean = self._bounded_mean(mlp_output)
        self._distribution = Normal(mean, self._std().expand_as(mean))

    def _require_distribution(self) -> Normal:
        if self._distribution is None:
            raise RuntimeError("distribution has not been updated")
        return self._distribution

    def sample(self) -> torch.Tensor:
        latent = self._require_distribution().sample().clamp(
            -self.latent_sample_bound, self.latent_sample_bound
        )
        return torch.tanh(latent)

    def deterministic_output(self, mlp_output: torch.Tensor) -> torch.Tensor:
        return torch.tanh(self._bounded_mean(mlp_output))

    def as_deterministic_output_module(self) -> nn.Module:
        return _TanhOutput(self.latent_mean_bound)

    @property
    def mean(self) -> torch.Tensor:
        return torch.tanh(self._require_distribution().mean)

    @property
    def std(self) -> torch.Tensor:
        return self._require_distribution().stddev

    @property
    def entropy(self) -> torch.Tensor:
        # The transformed entropy has no simple closed form. This is the
        # standard pre-transform entropy approximation used by PPO as a bonus.
        return self._require_distribution().entropy().sum(dim=-1)

    @property
    def params(self) -> tuple[torch.Tensor, ...]:
        distribution = self._require_distribution()
        return distribution.mean, distribution.stddev

    def log_prob(self, outputs: torch.Tensor) -> torch.Tensor:
        distribution = self._require_distribution()
        bounded = outputs.clamp(-self.action_bound, self.action_bound)
        pre_tanh = torch.atanh(bounded)
        log_jacobian = 2.0 * (
            math.log(2.0) - pre_tanh - F.softplus(-2.0 * pre_tanh)
        )
        return (distribution.log_prob(pre_tanh) - log_jacobian).sum(dim=-1)

    def kl_divergence(
        self,
        old_params: tuple[torch.Tensor, ...],
        new_params: tuple[torch.Tensor, ...],
    ) -> torch.Tensor:
        old_mean, old_std = old_params
        new_mean, new_std = new_params
        return torch.distributions.kl_divergence(
            Normal(old_mean, old_std), Normal(new_mean, new_std)
        ).sum(dim=-1)
