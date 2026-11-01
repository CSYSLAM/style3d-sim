# 后续静态绑定与隔离源码候选

七处accumulate/commit/multiply真实call、50条参数load已经独立核准，字段表在
`host-bond-argument-binding/static-field-bindings.json`。authored和dynamic的pairs/rest/history/active/tangent用途已静态对应。
mat3 resize继续追到append的两个实际分支，均将36个value字节清零后调用typed uninitialized_fill；完整反汇编及CPU覆盖证明已保存。
这仍不是六组合的SDK运行结果或CUPTI构造验收。

新增整数value helper仅隔离构建，原四API保持，26设备入口仍逐一匹配接受清单。
`candidate-guard-only`只放开bonds保护；`candidate-static-cache`额外恢复上述authored/dynamic默认值及动态CSR/缓存构造顺序。
两image已编译、反向撤销全部源码delta的CPU审计通过，未改变任何迭代数学，没有SDK ELF依赖；生产dec/Core47不动。
实际原版支持发现仍排队。`run-candidates.py`等待六SDK＋六当前guard发现完成后，才采两候选各六组并保留所有严格首差。
不能用这些编译/CPU结果代替GPU状态、constructor、graph、initcheck或完整solver验收。
