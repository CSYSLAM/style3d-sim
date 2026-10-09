# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Developers
# SPDX-License-Identifier: Apache-2.0

"""A material-space beef albedo shared by particle and reconstructed-surface rendering."""

import numpy as np
import warp as wp

LEAN_DARK = wp.constant(wp.vec3(0.20, 0.018, 0.028))
LEAN_LIGHT = wp.constant(wp.vec3(0.36, 0.046, 0.059))
FAT_COLOR = wp.constant(wp.vec3(0.74, 0.67, 0.54))


@wp.func
def beef_material_coordinates(rest: wp.vec3):
    # Warping several noise scales produces irregular connective tissue rather than parallel fish-like stripes.
    coarse = rest * 11.0
    warp = wp.vec3(
        wp.noise(wp.uint32(17), coarse),
        wp.noise(wp.uint32(31), coarse + wp.vec3(4.3, 1.7, 8.1)),
        wp.noise(wp.uint32(47), coarse + wp.vec3(7.9, 3.4, 2.6)),
    )
    point = rest + 0.025 * warp
    vein = wp.noise(wp.uint32(59), point * 16.0) + 0.18 * wp.noise(wp.uint32(71), point * 38.0)
    branching = wp.noise(wp.uint32(83), point * 35.0) + 0.16 * wp.noise(wp.uint32(97), point * 71.0)
    region = wp.noise(wp.uint32(101), point * 9.0 + wp.vec3(1.2, 4.6, 7.3))
    thickness = 0.008 + 0.020 * wp.smoothstep(-0.3, 0.3, region)
    main_fat = 1.0 - wp.smoothstep(thickness * 0.35, thickness, wp.abs(vein))
    fine_fat = 1.0 - wp.smoothstep(0.003, 0.012, wp.abs(branching))
    # Interrupt the fine branches to keep some lean regions instead of enclosing every noise cell in fat.
    fine_fat *= wp.smoothstep(0.05, 0.3, region)
    fat = wp.max(main_fat, 0.55 * fine_fat)
    # A strip of subcutaneous fat follows one flank of the steak rather than covering all of its perimeter.
    center_y = 0.006 * wp.sin(9.0 * rest[0] + 0.4)
    half_width = 0.138 * (1.0 + 0.07 * wp.sin(11.0 * rest[0] + 0.6))
    footprint = (rest[0] / 0.36) ** 2.0 + ((rest[1] - center_y) / half_width) ** 2.0
    cap_start = 0.84 + 0.05 * wp.noise(wp.uint32(113), point * 23.0)
    fat_cap = wp.smoothstep(cap_start, cap_start + 0.10, footprint) * wp.smoothstep(0.0, 0.04, -rest[1])
    fat = wp.max(fat, fat_cap)
    grain = wp.noise(wp.uint32(127), wp.vec3(point[0] * 80.0, point[1] * 320.0, point[2] * 180.0))
    tone = wp.clamp(0.48 + 0.70 * wp.noise(wp.uint32(139), point * 18.0) + 0.06 * grain, 0.0, 1.0)
    return wp.vec2(fat, tone)


@wp.kernel
def color_beef_particles(rest_positions: wp.array(dtype=wp.vec3), colors: wp.array(dtype=wp.vec3)):
    i = wp.tid()
    material = beef_material_coordinates(rest_positions[i])
    lean = wp.lerp(LEAN_DARK, LEAN_LIGHT, material[1])
    fat = FAT_COLOR * (0.85 + 0.15 * material[1])
    colors[i] = wp.lerp(lean, fat, material[0])


def beef_texture():
    """Encode fat coverage and muscle variation in a compact, smoothly sampled color lookup."""
    fat = np.linspace(0.0, 1.0, 256)[None, :, None]
    tone = np.linspace(0.0, 1.0, 128)[:, None, None]
    lean = np.asarray(LEAN_DARK) + tone * (np.asarray(LEAN_LIGHT) - np.asarray(LEAN_DARK))
    fat_color = np.asarray(FAT_COLOR) * (0.85 + 0.15 * tone)
    albedo = lean + fat * (fat_color - lean)
    return np.round(albedo * 255.0).astype(np.uint8)
