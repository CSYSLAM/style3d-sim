"""Geometry regressions for the procedural, single-layer bag example."""

import numpy as np

from examples.example_cloth_balls import (
    BAG_BOTTOM,
    BAG_CELLS,
    BALL_RADIUS,
    CELL_SIZE,
    HANDLE_CELLS,
    HANDLE_TOP_CELLS,
    PARTICLE_RADIUS,
    ball_positions,
    create_bag_mesh,
)


def test_bag_has_welded_seams_open_rim_and_two_handle_holes():
    points, triangles, _, _, pins = create_bag_mesh()
    assert len(np.unique(points, axis=0)) == len(points)
    assert len(np.unique(np.sort(triangles, axis=1), axis=0)) == len(triangles)
    directed_edges = triangles[:, ((0, 1), (1, 2), (2, 0))].reshape(-1, 2)
    edges, inverse, counts = np.unique(np.sort(directed_edges, axis=1), axis=0, return_inverse=True, return_counts=True)
    assert np.all((counts == 1) | (counts == 2))
    # Every sewn edge must have opposing face directions, not overlapping or flipped panels.
    directions = np.where(directed_edges[:, 0] < directed_edges[:, 1], 1, -1)
    balance = np.bincount(inverse, weights=directions)
    assert np.all(balance[counts == 2] == 0)
    boundary = edges[counts == 1]
    rim_height = BAG_BOTTOM + BAG_CELLS[2] * CELL_SIZE
    on_rim = np.all(np.isclose(points[boundary, 2], rim_height), axis=1)
    rim = boundary[on_rim]
    assert len(rim) == 2 * sum(BAG_CELLS[:2])
    _, boundary_degrees = np.unique(boundary, return_counts=True)
    assert np.all(boundary_degrees == 2)
    assert len(points) - len(edges) + len(triangles) == -1
    assert len(pins) == len(np.unique(pins)) == 4
    assert np.isin(pins, rim).all()
    # The shell has exactly three disjoint boundary loops: the mouth and two closed grip openings.
    boundary_neighbors = {}
    for a, b in boundary:
        boundary_neighbors.setdefault(a, set()).add(b)
        boundary_neighbors.setdefault(b, set()).add(a)
    remaining = set(boundary_neighbors)
    loops = []
    while remaining:
        loop, pending = set(), [remaining.pop()]
        while pending:
            vertex = pending.pop()
            loop.add(vertex)
            adjacent = boundary_neighbors[vertex] & remaining
            remaining.difference_update(adjacent)
            pending.extend(adjacent)
        loops.append(np.asarray(sorted(loop)))
    assert len(loops) == 3
    handles = [loop for loop in loops if not np.all(np.isclose(points[loop, 2], rim_height))]
    assert len(handles) == 2
    assert len(handles[0]) == len(handles[1]) == 2 * sum(HANDLE_CELLS) - 4
    for sign, loop in zip((-1, 1), sorted(handles, key=lambda loop: points[loop, 1].mean()), strict=True):
        hole = points[loop]
        np.testing.assert_allclose(hole[:, 1], sign * BAG_CELLS[1] * CELL_SIZE * 0.5)
        np.testing.assert_allclose(hole[:, 0].min(), -HANDLE_CELLS[0] * CELL_SIZE * 0.5)
        np.testing.assert_allclose(hole[:, 0].max(), HANDLE_CELLS[0] * CELL_SIZE * 0.5)
        np.testing.assert_allclose(hole[:, 2].max(), rim_height - HANDLE_TOP_CELLS * CELL_SIZE)
        np.testing.assert_allclose(hole[:, 2].min(), rim_height - (HANDLE_TOP_CELLS + HANDLE_CELLS[1]) * CELL_SIZE)
    # Check connectivity so an extra disconnected shell cannot pass the edge-count tests.
    neighbors = [set() for _ in points]
    for a, b in edges:
        neighbors[a].add(b)
        neighbors[b].add(a)
    visited, pending = {0}, [0]
    while pending:
        for vertex in neighbors[pending.pop()] - visited:
            visited.add(vertex)
            pending.append(vertex)
    assert len(visited) == len(points)


def test_panel_rest_geometry_is_positive_and_unstretched():
    points, triangles, panels, panel_triangles, _ = create_bag_mesh()
    rest = panels[panel_triangles]
    edge_u, edge_v = rest[:, 1] - rest[:, 0], rest[:, 2] - rest[:, 0]
    signed_areas = 0.5 * (edge_u[:, 0] * edge_v[:, 1] - edge_u[:, 1] * edge_v[:, 0])
    assert np.all(signed_areas > 0.0)
    world = points[triangles]
    for a, b in ((0, 1), (1, 2), (2, 0)):
        np.testing.assert_allclose(
            np.linalg.norm(world[:, b] - world[:, a], axis=1),
            np.linalg.norm(rest[:, b] - rest[:, a], axis=1),
            rtol=1.0e-5,
            atol=1.0e-7,
        )
    width, depth, height = np.asarray(BAG_CELLS) * CELL_SIZE
    # Each opening is a rectangle with four half-cell corner triangles left in the cloth.
    hole_area = (np.prod(HANDLE_CELLS) - 2) * CELL_SIZE**2
    expected_area = width * depth + 2.0 * height * (width + depth) - 2.0 * hole_area
    np.testing.assert_allclose(signed_areas.sum(), expected_area, rtol=1.0e-6)
    assert len(np.unique(triangles)) == len(points)
    assert len(np.unique(panel_triangles)) == len(panels)
    normals = np.cross(world[:, 1] - world[:, 0], world[:, 2] - world[:, 0])
    center = np.array((0.0, 0.0, BAG_BOTTOM + height * 0.5))
    assert np.all(np.einsum("ij,ij->i", normals, world.mean(axis=1) - center) > 0.0)


def test_balls_start_separated_inside_bag_and_on_floor():
    inside, ground = ball_positions()
    assert inside.shape == (6, 3)
    assert ground.shape == (2, 3)
    half_widths = np.asarray(BAG_CELLS[:2]) * CELL_SIZE * 0.5
    assert np.all(np.abs(inside[:, :2]) + BALL_RADIUS + PARTICLE_RADIUS < half_widths)
    assert np.all(inside[:, 2] - BALL_RADIUS - PARTICLE_RADIUS > BAG_BOTTOM)
    assert np.all(inside[:, 2] + BALL_RADIUS < BAG_BOTTOM + BAG_CELLS[2] * CELL_SIZE)
    assert np.all(np.any(np.abs(ground[:, :2]) - BALL_RADIUS > half_widths, axis=1))
    np.testing.assert_allclose(ground[:, 2], BALL_RADIUS)
    centers = np.concatenate((inside, ground))
    distances = np.linalg.norm(centers[:, None] - centers[None, :], axis=2)
    assert np.all(distances[np.triu_indices(len(centers), k=1)] > 2.0 * BALL_RADIUS)
