# 被真实引用的 `.rodata` 常量（按引用点分类）

> 来源：反汇编 rip 相对寻址的注释地址；按**引用它的指令**分类，避免把字符串当浮点解读。

## 浮点常量（引用指令为 `movss`/`movsd`）

| 地址 | 值 | 引用次数 | 首个引用者 |
|---|---|---|---|
| 0x1f47a0 | nan, 0 | 106 | `synreal::SolverNewton::step(synreal::State con` |
| 0x1fcf80 | 1, 3 | 54 | `synreal::SolverNewton::step(synreal::State con` |
| 0x1f478c | 3.40282e+38, 0.999 | 41 | `synreal::SolverNewton::step(synreal::State con` |

## 整型 / dim3 常量（`mov`/`movl` 直接取 8 字节）

| 地址 | u32 | 引用次数 | 首个引用者 |
|---|---|---|---|
| 0x201070 | (1, 1, 1) | 140 | `__device_stub__ZN7synreal6kernel34update_preco` |
| 0x1fcf90 | (256, 1, 1065336439) | 130 | `synreal::SolverNewton::reset_joint_drive_state` |
| 0x1fcf70 | (1, 1, 1) | 113 | `__device_stub__ZN7synreal6kernel24evaluate_con` |
| 0x1f4778 | (1, 1, 12) | 62 | `pybind11::detail::smart_holder_type_caster_sup` |
