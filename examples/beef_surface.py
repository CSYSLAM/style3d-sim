# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Developers
# SPDX-License-Identifier: Apache-2.0

"""Reconstruct a closed, textured render surface without changing the granular solve."""

import numpy as np
import warp as wp

if __package__:
    from .beef_material import beef_material_coordinates, beef_texture
else:
    from beef_material import beef_material_coordinates, beef_texture


def connected_components(count, bonds):
    """Hook larger roots to smaller roots, then compress paths without a Python loop over bonds."""
    parent = np.arange(count, dtype=np.int32)
    while len(bonds):
        roots = parent[bonds]
        updated = parent.copy()
        np.minimum.at(updated, roots.max(axis=1), roots.min(axis=1))
        while not np.array_equal(updated, updated[updated]):
            updated = updated[updated]
        if np.array_equal(parent, updated):
            break
        parent = updated
    return parent


@wp.kernel
def surface_field(
    grid: wp.uint64,
    positions: wp.array(dtype=wp.vec3),
    labels: wp.array(dtype=int),
    label: int,
    lower: wp.vec3,
    voxel_size: float,
    support: float,
    radius: float,
    clearance: float,
    field: wp.array3d(dtype=float),
):
    i, j, k = wp.tid()
    point = lower + voxel_size * wp.vec3(float(i), float(j), float(k))
    center = wp.vec3(0.0)
    weight = float(0.0)
    own_distance = support
    foreign_distance = support
    for p in wp.hash_grid_query(grid, point, support):
        offset = point - positions[p]
        distance = wp.length(offset)
        if labels[p] == label:
            own_distance = wp.min(own_distance, distance)
            w = wp.max(1.0 - wp.dot(offset, offset) / (support * support), 0.0)
            w = w * w * w
            center += w * positions[p]
            weight += w
        else:
            foreign_distance = wp.min(foreign_distance, distance)
    value = support
    if weight > 1.0e-6:
        # Zhu-Bridson's weighted particle center smooths the lattice while retaining isolated grains.
        value = wp.length(point - center / weight) - radius
        # Sparse overlapping kernels can average to a point in an empty cut; require material density too.
        value = wp.max(value, radius * (0.5 - weight))
        if foreign_distance < support:
            # Keep independently fractured pieces disjoint even when their reconstructed radii overlap on recontact.
            value = wp.max(value, 0.5 * (own_distance - foreign_distance) + clearance)
    field[i, j, k] = value


@wp.kernel
def surface_uvs(
    grid: wp.uint64,
    positions: wp.array(dtype=wp.vec3),
    rest_positions: wp.array(dtype=wp.vec3),
    labels: wp.array(dtype=int),
    label: int,
    vertices: wp.array(dtype=wp.vec3),
    support: float,
    uvs: wp.array(dtype=wp.vec2),
):
    i = wp.tid()
    point = vertices[i]
    rest = wp.vec3(0.0)
    weight = float(0.0)
    for p in wp.hash_grid_query(grid, point, support):
        if labels[p] == label:
            offset = point - positions[p]
            w = wp.max(1.0 - wp.dot(offset, offset) / (support * support), 0.0)
            w = w * w * w
            rest += w * rest_positions[p]
            weight += w
    if weight > 1.0e-6:
        rest /= weight
    # Transport the volumetric marbling with each piece, including newly exposed cut faces.
    material = beef_material_coordinates(rest)
    # Images have a top-left origin; texture V starts at the bottom of the uploaded image.
    uvs[i] = wp.vec2((0.5 + 255.0 * material[0]) / 256.0, (0.5 + 127.0 * (1.0 - material[1])) / 128.0)


@wp.kernel
def copy_surface_indices(source: wp.array(dtype=int), vertex_offset: int, index_offset: int, output: wp.array(dtype=int)):
    i = wp.tid()
    output[index_offset + i] = source[i] + vertex_offset


class BeefSurface:
    def __init__(self, spacing, rest_positions, bonds=None, broken=None):
        if (bonds is None) != (broken is None):
            raise ValueError("Surface fracture tracking requires both bonds and broken flags")
        self.rest_positions = rest_positions
        self.device = rest_positions.device
        self.voxel_size = spacing / 3.0
        self.support, self.radius = 2.0 * spacing, 0.6 * spacing
        # Half a voxel on each side leaves enough room for marching-cubes interpolation at oblique cut faces.
        self.clearance = 0.5 * self.voxel_size
        self.bonds = bonds.numpy() if bonds is not None else None
        self.broken = broken
        self.broken_count = -1
        self.component_labels = np.zeros(len(rest_positions), dtype=np.int32)
        self.labels = wp.zeros(len(rest_positions), dtype=int, device=self.device)
        self.grid = wp.HashGrid(64, 32, 32, device=self.device)
        self.field = None
        self.marching_cubes = None
        self.fields = {}
        self.texture = beef_texture()

    def update_components(self):
        if self.broken is not None:
            broken = self.broken.numpy().astype(bool)
            count = int(broken.sum())
            # Fracture is irreversible, so a constant broken-bond count implies the same material partition.
            if count != self.broken_count:
                self.component_labels = connected_components(len(self.rest_positions), self.bonds[~broken])
                self.labels.assign(self.component_labels)
                self.broken_count = count

    def rebuild(self, positions):
        points = positions.numpy()
        if not np.isfinite(points).all():
            raise ValueError("Cannot reconstruct a surface from non-finite beef positions")
        self.update_components()
        self.grid.build(positions, self.support)
        parts = []
        active_labels = np.unique(self.component_labels)
        self.fields = {label: cached for label, cached in self.fields.items() if label in active_labels}
        for label in active_labels:
            part = self.rebuild_component(positions, points[self.component_labels == label], int(label))
            if len(part[0]):
                parts.append(part)
        if len(parts) == 1:
            return parts[0]
        vertices = wp.empty(sum(len(part[0]) for part in parts), dtype=wp.vec3, device=self.device)
        indices = wp.empty(sum(len(part[1]) for part in parts), dtype=int, device=self.device)
        uvs = wp.empty(len(vertices), dtype=wp.vec2, device=self.device)
        vertex_offset, index_offset = 0, 0
        for part_vertices, part_indices, part_uvs in parts:
            wp.copy(vertices, part_vertices, dest_offset=vertex_offset)
            wp.copy(uvs, part_uvs, dest_offset=vertex_offset)
            wp.launch(
                copy_surface_indices,
                dim=len(part_indices),
                inputs=[part_indices, vertex_offset, index_offset],
                outputs=[indices],
                device=self.device,
            )
            vertex_offset += len(part_vertices)
            index_offset += len(part_indices)
        return vertices, indices, uvs

    def rebuild_component(self, positions, points, label):
        # Follow moving pieces and keep a full exterior layer beyond the compact kernel's support.
        padding = self.support + self.voxel_size
        self.lower = np.floor((points.min(axis=0) - padding) / self.voxel_size) * self.voxel_size
        self.upper = np.ceil((points.max(axis=0) + padding) / self.voxel_size) * self.voxel_size
        shape = tuple(np.rint((self.upper - self.lower) / self.voxel_size).astype(int) + 1)
        cached = self.fields.get(label)
        if cached is None or cached[0].shape != shape:
            self.field = wp.empty(shape, dtype=float, device=self.device)
            self.marching_cubes = wp.MarchingCubes(*shape)
            self.fields[label] = self.field, self.marching_cubes
        else:
            self.field, self.marching_cubes = cached
        self.marching_cubes.domain_bounds_lower_corner = wp.vec3(*self.lower)
        self.marching_cubes.domain_bounds_upper_corner = wp.vec3(*self.upper)
        wp.launch(
            surface_field,
            dim=shape,
            inputs=[
                self.grid.id,
                positions,
                self.labels,
                label,
                wp.vec3(*self.lower),
                self.voxel_size,
                self.support,
                self.radius,
                self.clearance,
            ],
            outputs=[self.field],
            device=self.device,
        )
        # Dynamic extraction allocates and synchronizes; keep it outside the simulation's CUDA graph.
        self.marching_cubes.surface(self.field, 0.0)
        vertices, indices = self.marching_cubes.verts, self.marching_cubes.indices
        uvs = wp.empty(len(vertices), dtype=wp.vec2, device=self.device)
        wp.launch(
            surface_uvs,
            dim=len(vertices),
            inputs=[self.grid.id, positions, self.rest_positions, self.labels, label, vertices, self.support],
            outputs=[uvs],
            device=self.device,
        )
        return vertices, indices, uvs

    def log_mesh(self, viewer, vertices, indices, uvs):
        name = "beef_surface"
        # Newton's GL mesh caches indices and fixed-size buffers, so replace only this render object.
        if hasattr(viewer, "objects"):
            old_mesh = viewer.objects.pop(viewer._qualify(name), None)
            if old_mesh is not None:
                old_mesh.destroy()
        viewer.log_mesh(name, vertices, indices, uvs=uvs, texture=self.texture, color=(1.0, 1.0, 1.0), roughness=0.68)
        if hasattr(viewer, "objects"):
            # GL's log_mesh uploads the texture but does not enable texture sampling in its material.
            mesh = viewer.objects[viewer._qualify(name)]
            roughness, metallic, checker, _ = mesh.material
            mesh.material = (roughness, metallic, checker, 1.0)
            # These UVs encode material attributes, not spatial texels; mipmaps would mix unrelated fat and lean values.
            gl = viewer.renderer.gl
            gl.glBindTexture(gl.GL_TEXTURE_2D, mesh.texture_id)
            gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR)
            gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_CLAMP_TO_EDGE)
            gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_CLAMP_TO_EDGE)
            gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
        if hasattr(viewer, "stage") and hasattr(viewer, "_meshes"):
            # USD's log_mesh authors topology and UVs only once; reconstruction changes both every frame.
            from pxr import UsdGeom

            mesh = viewer._meshes[viewer._qualify(name)]
            frame = viewer._frame_index
            mesh.GetFaceVertexCountsAttr().Set([3] * (len(indices) // 3), frame)
            mesh.GetFaceVertexIndicesAttr().Set(indices.numpy(), frame)
            UsdGeom.PrimvarsAPI(mesh).GetPrimvar("st").Set(uvs.numpy(), frame)

