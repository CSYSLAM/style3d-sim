"""Bounded Gaussian action distribution for the locomotion2 RSL-RL policy."""

from __future__ import annotations

import math

import torch
from torch import nn
from torch.distributions import Normal

from rsl_rl.modules.distribution import Distribution


class _TanhOutput(nn.Module):
    def forward(self, value: torch.Tensor) -> torch.Tensor:
        # Keep actions strictly inside the inverse-tanh domain.  Exact +/-1
        # values make the log-probability correction singular after a large
        # policy update.
        bound = 1.0 - torch.finfo(value.dtype).eps
        return torch.tanh(value).clamp(-bound, bound)


class TanhGaussianDistribution(Distribution):
    """Diagonal Normal transformed through tanh into ``[-1, 1]``.

    The inverse-transform correction is included in ``log_prob`` so PPO sees
    the same action distribution that is passed to the environment.
    """

    def __init__(
        self,
        output_dim: int,
        init_std: float = 0.3,
        std_range: tuple[float, float] = (3e-2, 2.0),
        std_type: str = "scalar",
        learn_std: bool = True,
        mean_limit: float = 8.0,
    ) -> None:
        super().__init__(output_dim)
        if init_std <= 0.0:
            raise ValueError("init_std must be positive")
        if std_type not in ("scalar", "log"):
            raise ValueError("std_type must be 'scalar' or 'log'")
        if len(std_range) != 2 or not 0.0 < std_range[0] < std_range[1]:
            raise ValueError("std_range must be an increasing positive pair")
        if not math.isfinite(mean_limit) or mean_limit <= 0.0:
            raise ValueError("mean_limit must be positive and finite")
        self.std_type = std_type
        self.std_range = (float(std_range[0]), float(std_range[1]))
        self.mean_limit = float(mean_limit)
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

    def update(self, mlp_output: torch.Tensor) -> None:
        # A saturated tanh policy has almost no useful action gradient.  A
        # finite bound also keeps Gaussian log-probability differences within
        # a range where PPO's exponentiation cannot immediately overflow.
        mlp_output = torch.nan_to_num(
            mlp_output, nan=0.0, posinf=self.mean_limit, neginf=-self.mean_limit
        ).clamp(-self.mean_limit, self.mean_limit)
        self._distribution = Normal(mlp_output, self._std().expand_as(mlp_output))

    def _require_distribution(self) -> Normal:
        if self._distribution is None:
            raise RuntimeError("distribution has not been updated")
        return self._distribution

    def sample(self) -> torch.Tensor:
        value = self._require_distribution().sample()
        bound = 1.0 - torch.finfo(value.dtype).eps
        return torch.tanh(value).clamp(-bound, bound)

    def deterministic_output(self, mlp_output: torch.Tensor) -> torch.Tensor:
        mlp_output = torch.nan_to_num(
            mlp_output, nan=0.0, posinf=self.mean_limit, neginf=-self.mean_limit
        ).clamp(-self.mean_limit, self.mean_limit)
        bound = 1.0 - torch.finfo(mlp_output.dtype).eps
        return torch.tanh(mlp_output).clamp(-bound, bound)

    @property
    def action_bound(self) -> float:
        """Strict numerical action bound used by the tanh transform."""

        # This scalar bound is used by callers that do not know the action
        # dtype.  It is looser than the float32 clamp and still strictly less
        # than one for all supported floating dtypes.
        return 1.0 - 1.0e-7

    def as_deterministic_output_module(self) -> nn.Module:
        return _TanhOutput()

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
        eps = torch.finfo(outputs.dtype).eps
        bounded = outputs.clamp(-1.0 + eps, 1.0 - eps)
        pre_tanh = torch.atanh(bounded)
        correction = torch.log1p(-bounded.square() + eps)
        return (distribution.log_prob(pre_tanh) - correction).sum(dim=-1)

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
