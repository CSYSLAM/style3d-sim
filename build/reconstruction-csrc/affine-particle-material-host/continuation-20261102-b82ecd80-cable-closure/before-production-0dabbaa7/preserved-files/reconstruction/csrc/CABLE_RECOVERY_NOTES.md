# 缆绳三入口恢复：当前证据和下一步

当前kernel阶段131/131自有入口已验证；完整update_cable_penalties、prepare_cable_tangents、evaluate_cables
已恢复并通过三seed GPU及路径审计，详见三个CABLE_*_AUDIT.md。库模板实例化及host/demo验收仍待完成。
机械PTX包装不能计入交付；下面记录共享几何及其原PTX来源，供剩余两个入口复用。

## 已恢复并单独验证的旋转模块

`kernels/cable_rotation.cuh` 是具名CUDA/C++实现，不是寄存器/指令逐条包装。
输入是body的三个仿射列向量及9个row-major惯性值；返回惯性加权旋转及是否采用了该路径。
CableView的offset16已根据旧PTX确认为惯性张量。`cable_types.cuh`此前的暂定字段名body_matrix
本轮保留，以免改动刚验证模块的依赖记录；读取时按row-major float[9]处理，后续可以统一更正字段名。

恢复算法与旧update PTX对应：

1. 双精度构造 `J = trace(I)/2 * identity - I`，按最大绝对分量缩放。
   每个连续三元组按原地址顺序作为加权列：`B[k] = A * J[k,:]`；按本文row-major记法即`B=A*transpose(J)`。
   对称惯性时等于`A*J`，非对称探针不可省略这个转置。
2. 最多8轮加权极分解，逆转置来自余子式/行列式；行列式必须大于1e-30且有限。
   `gamma = sqrt(sqrt(norm2(inverse_transpose)/norm2(current)))`；
   `next = 0.5 * fma(gamma,current,inverse_transpose/gamma)`。
   差的平方范数按原y-first FMA及逐列累加；<=1e-24提前停止，NaN继续到轮数上限。
3. 计算并对称化 `B * transpose(R)`，检查 `trace(S)*identity-S` 的行列式>1e-30。
4. 通过后double转float；否则调用原有float nearest_rotation回退。

`probe_cable_rotation.py`在旧update入口的第一body旋转出口插入只读寄存器探针：
加权出口BB73_18读取f1161..f1169，回退出口BB73_37读取r465..r473，并提前返回。
这个探针只用于验证该子模块，不能冒充完整update入口或完整原始求解器的对比。
source端是直接调用新helper的独立测试kernel，无旧PTX fallback。

原版内部出口探针/新helper seed1/2/3，各19类场景、38项比较，合计114项全部逐位一致。
矩阵和加权/回退标志都比较，包含三世界、禁用lane和越界线程的未写尾部。
场景覆盖普通/非对称/物理各向异性/非物理惯性、零/负/极小/极大/NaN/Inf惯性、
仿射扰动、反射、零矩阵、秩1、极小/极大/NaN/Inf仿射及1e-30行列式门限附近。
本探针证据仅覆盖旋转出口。后续已接入完整update并完成float32/float64路径审计，详见CABLE_UPDATE_AUDIT.md。

```bash
.venv/bin/python -m reconstruction.csrc.probe_cable_rotation 1
.venv/bin/python -m reconstruction.csrc.probe_cable_rotation 2
.venv/bin/python -m reconstruction.csrc.probe_cable_rotation 3
```

证据在 `build/reconstruction-csrc/cable-rotation-audit/`，包含helper probe源码/PTX、GPU JSON和provenance。

## 已恢复的 update 几何及原 PTX 映射

以旧 `076_update_cable_penalties.ptx` 为准，不根据物理常识猜公式。
两端world frame的平移是 `translation + A * (authored_frame_position - body_com)`，
旋转是上面的body rotation乘authored quaternion basis；静态端直接使用authored world frame。
Quaternion basis的旧实现保留了乘零、加零和特定FMA次序，不可直接套另一个库的简化式。
父端frame basis列在BB73_38前为：x=(f1196,f1195,f1194)、y=(f1193,f1192,f1191)、z=(f1190,f1189,f1188)。
两端point在r476/r475/r474和r503/r504/r505；子端x=(f1224,f1225,f1226)、z=(f1227,f1228,f1229)。

从BB73_67后可直接核对的具名数学：

- 线性残差 `transpose(parent_basis) * (child_point-parent_point)`，三个dot都是y-first。
- `c = clamp(dot(parent_z,child_z),-1,1)`，`denom=1+c`，`cross_z=parent_z cross child_z`。
- 一般弯曲向量是 `cross_z * (2/max(1e-12,denom))`，长度>20时缩到20。
  若denom<=1e-12且cross_z平方和<=1e-12，则用父x在父z法平面的投影归一化乘20；
  投影长度不大于1e-9时另选轴，fabs(parent_z.x)>0.9选y，否则选x，再投影。
  比较有ordered/unordered差异，必须照旧PTX保留。
- 扭转使用平行输运后的parent_x与child_x：denom>1e-8时
  `transport = normalize(parent_x-(parent_z+child_z)*(dot(parent_x,child_z)/denom))`。
  近反向分支在BB73_77后，cross_z长度>1e-7时走atan2/sin/cos Rodrigues旋转，
  否则用投影轴的180度反射；实现位于cable_geometry.cuh，并已按原PTX核对。
- `twist = atan2(dot(cross(transport,child_x),child_z), dot(child_x,transport))`。
- bend_x/y是弯曲向量在父x/y上的投影减rest.x/y；twist减rest.z后只做一次±2pi折返。
- 四个penalty分别用abs(linear_z)、length(linear_xy)、length(bend_xy)、abs(twist_error)，
  `min(authored_base, fma(residual,linear_or_angular_beta,old_penalty))`，不因beta为零跳过FMA。

完整update已用literal旧PTX和源码逐位验证整个penalty、只读数组和三个seed，命令见CABLE_UPDATE_AUDIT.md。
prepare/evaluate已复用上述几何，并单独恢复和验证Jacobian、模式优先级及累加顺序；详见对应审核记录。
