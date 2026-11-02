# CPU后继历史及更正

本页旧39819等待说明已被用户的共享GPU要求取代，原文保留于AUDIT_CONTINUATION-exclusive-v1.md。
70166/99307/39819三原工具均已由本agent停止并实际终态143；停止前自己的GPU worker为0。
旧audit-status等completeFalse是停止前历史，不得当作live，不能重启它们。

新的shared-GPU-v2已经完成四例3/60帧、五正常Core60、四原版重复和多个真实核诊断。
当前真实结果与下一步以reconstruction/csrc/OFFICIAL_DEMO_FOUR_SHARED_GPU_RESULTS.md为准。
足时长原test_final共10次正常返回；ANYmal两次是多行lambda漏读比较导致假阳性，原/源全部136刚体速度均越界。
不要将退出0等同于物理验收或逐位一致；原失败、生产镜像和固定cohort保持。

旧auditor-preflight.json固定的是第一版root official_demo_audit.py，后来仅增共享GPU准入支持。
第一版原文本保存于official_demo_audit-v1-as-run.py；旧hash应对这个as-run版本核对，不能改旧记录迁就新文件。
当前版本预检及完整复核在shared-GPU-v2/auditor-preflight.json与independent-cpu.json，均实际0。
