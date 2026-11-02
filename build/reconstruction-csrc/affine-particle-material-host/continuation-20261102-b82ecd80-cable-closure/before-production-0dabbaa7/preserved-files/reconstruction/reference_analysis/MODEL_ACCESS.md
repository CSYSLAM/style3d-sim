# Model 字段访问图（kernel 侧）

> 来源：PTX 里对按值 `Model`（1864 B）形参的 `[param+off]` 访问；只统计真正被读/写的偏移。

共 **21** 个不同偏移被访问，其中 **20** 个能与 Python 侧字段对上。

| 偏移 | 次数 | Python 侧字段 | 访问模块 |
|---|---|---|---|
| +0x018 | 7 | `particle_count` (int) | fluid, granular |
| +0x030 | 1 | `particle_masses` (Span) | fluid |
| +0x078 | 3 | `particle_world` (Span) | fluid, granular |
| +0x080 | 3 | `particle_world.size` (size_t) | fluid, granular |
| +0x088 | 1 | `particle_radii` (Span) | granular |
| +0x0c0 | 1 | `fluid_particle_count` (int) | fluid |
| +0x0c8 | 1 | `fluid_particle_indices` (Span) | fluid |
| +0x0d8 | 1 | `fluid_rest_density` (float) | fluid |
| +0x0dc | 1 | `fluid_smoothing_radius` (float) | fluid |
| +0x0e8 | 1 | `fluid_boundary_count` (int) | fluid |
| +0x0f0 | 1 | `fluid_boundary_positions` (Span) | fluid |
| +0x100 | 1 | `fluid_boundary_volumes` (Span) | fluid |
| +0x110 | 1 | `granular_particle_count` (int) | granular |
| +0x118 | 1 | `granular_particle_indices` (Span) | granular |
| +0x138 | 1 | `granular_bond_damping` (float) | granular |
| +0x13c | 1 | `granular_yield_strain` (float) | granular |
| +0x140 | 3 | `granular_max_compaction` (float) | granular |
| +0x144 | 2 | `granular_break_strain` (float) | granular |
| +0x14c | 6 | `granular_bond_formation_gap` (float) | granular |
| +0x150 | 1 | `granular_bond_formation_speed` (float) | granular |
| +0x154 | 2 | `granular_max_dynamic_bonds` (int) | granular |
