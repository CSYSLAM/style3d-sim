# 下一步bonds/刚体构造核对：固定SDK静态证据

已重新对当前SDK64a运行原范围的objdump，Granular::initialize反汇编与上一份字节完全相同。
命令、SHA及八个准确call位置见`bond-constructor-static-observations.json`；没有GPU执行，也没有修改生产。

当前源码`prepare_bonds`上传pairs/rest/history/active，只分配tangent；dynamic随后上传partner与CSR。
固定SDK则存在以下实际host调用：

| call地址 | Granular对象偏移 | 直接观察到的操作 |
| --- | --- | --- |
| 0x129e0b | 0x968 | int fill_assign，值1 |
| 0x129e1a | 0x8e8 | mat3 resize；实际默认value仍需CUPTI观测 |
| 0x129419 | 0x9c8 | int fill_assign，值-1 |
| 0x129437 | 0x9e8 | ivec2 fill_assign，值(0,0) |
| 0x129454 | 0xa08 | float fill_assign，值0 |
| 0x129471 | 0xa28 | float fill_assign，值0 |
| 0x12948e | 0xa48 | int fill_assign，值0 |
| 0x1294c7 | 0xa68 | mat3 fill_assign，36字节全零 |

0x1293d7/0x1293ef的两次int range_assign位于上述负一/零fill之前。
这些与现源码的构造方式或顺序不同，后续必须核allocation/upload/typed/pointer绑定及library时序。
对象字段语义名称和动态执行分支尚未做本阶段runtime绑定，不能仅据本表写死修复。

继续顺序：先等当前dec生产74及constructor门禁，完成本阶段六组SDK/guard发现；
再隔离放开bonds限制的候选并采真实constructor，按实际绑定恢复。不得直接移除生产guard、改求解数学或抹掉旧失败。
