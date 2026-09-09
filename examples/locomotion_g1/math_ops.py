"""Torch math used by the G1 environment."""

from __future__ import annotations

import torch


def quat_rotate_inverse(
    quaternion_xyzw: torch.Tensor, vector: torch.Tensor
) -> torch.Tensor:
    """Rotate world-frame vectors into frames described by XYZW quaternions."""

    q_xyz = quaternion_xyzw[..., :3]
    q_w = quaternion_xyzw[..., 3:4]
    twice_cross = 2.0 * torch.linalg.cross(q_xyz, vector, dim=-1)
    return vector - q_w * twice_cross + torch.linalg.cross(q_xyz, twice_cross, dim=-1)


def yaw_rotate_inverse(
    quaternion_xyzw: torch.Tensor, vector: torch.Tensor
) -> torch.Tensor:
    """Rotate vectors into the gravity-aligned yaw frame of a quaternion."""

    x, y, z, w = quaternion_xyzw.unbind(dim=-1)
    yaw = torch.atan2(2.0 * (w * z + x * y), 1.0 - 2.0 * (y * y + z * z))
    cosine = torch.cos(yaw)
    sine = torch.sin(yaw)
    result = vector.clone()
    result[..., 0] = cosine * vector[..., 0] + sine * vector[..., 1]
    result[..., 1] = -sine * vector[..., 0] + cosine * vector[..., 1]
    return result


def yaw_quaternion(yaw: torch.Tensor) -> torch.Tensor:
    """Construct XYZW quaternions for world-Z rotations."""

    result = torch.zeros((*yaw.shape, 4), dtype=yaw.dtype, device=yaw.device)
    result[..., 2] = torch.sin(0.5 * yaw)
    result[..., 3] = torch.cos(0.5 * yaw)
    return result


class TermHistory:
    """Per-term oldest-to-newest history matching IsaacLab's observation ABI."""

    def __init__(
        self,
        num_envs: int,
        term_dims: tuple[int, ...],
        history_length: int,
        *,
        device: torch.device,
    ) -> None:
        self.history_length = history_length
        self.buffers = [
            torch.zeros((num_envs, history_length, dim), device=device)
            for dim in term_dims
        ]

    def update(
        self,
        terms: tuple[torch.Tensor, ...],
        reset_ids: torch.Tensor | None = None,
    ) -> torch.Tensor:
        if len(terms) != len(self.buffers):
            raise ValueError(f"expected {len(self.buffers)} terms, got {len(terms)}")
        for buffer, value in zip(self.buffers, terms, strict=True):
            buffer.copy_(torch.roll(buffer, shifts=-1, dims=1))
            buffer[:, -1].copy_(value)
            if reset_ids is not None and reset_ids.numel() > 0:
                buffer[reset_ids] = value[reset_ids].unsqueeze(1)
        return self.output()

    def fill(
        self, terms: tuple[torch.Tensor, ...], env_ids: torch.Tensor
    ) -> torch.Tensor:
        for buffer, value in zip(self.buffers, terms, strict=True):
            buffer[env_ids] = value[env_ids].unsqueeze(1)
        return self.output()

    def output(self) -> torch.Tensor:
        return torch.cat(
            [buffer.flatten(start_dim=1) for buffer in self.buffers], dim=-1
        )
