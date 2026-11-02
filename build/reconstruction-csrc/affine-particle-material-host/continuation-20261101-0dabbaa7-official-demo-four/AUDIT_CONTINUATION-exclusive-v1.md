# 四个正式demo：独立CPU复核接续

这是604f3097准备检查点之后的补充；原准备清单、文件和旧失败不变。
正式GPU A/B仍是session70166/PID80087，公开Core是session99307/PID85092，先确认旧身份，不重复启动。

新增reconstruction.csrc.official_demo_audit独立重算原始NPZ：逐位状态、首差子步、F64最大差、finite及记录长度。
它不导入原高层compare函数；已在真实Newton/PD cable两份严格失败及当前0dab Dzhanibekov严格通过数据上实测，
与全部已存报告完全一致，CPU工具实际退出0。auditor-preflight.json保留数据和源码SHA；这不改判旧C8。

独立审计还核各实际worker退出、runtime镜像SHA/场景SHA/参数、source kernel计数、启动前空闲门禁，
以及正常Core报告的source-only、无SDK映射、无A/B bridge和实际退出。正常入口没有原始状态，因此不冒称Graph数值对照。
失败worker、缺失capture、明确skip都分别保留；进程退出0不能等同于strict或完整demo通过。

自动CPU后继已启动，工具session39819；实际PID/boot/start_ticks见audit-waiter-identity.json。
它严格等待同一个正常Core进程，输入hash固定于audit-request.json，之后才运行实际CPU审计。
不会创建GPU上下文，也不重启两个GPU队列。audit-status.json/CPU-audit.log和未来结果仍为动态文件，未完成前不封存。

```bash
source scripts/reconstruction_env.sh
four_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-official-demo-four
.venv/bin/python -B -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d)' "$four_phase/audit-status.json"
```

CPU结束后先从原工具取得实际终态，再读independent-cpu.json，核每个case及public_core字段。
不要从父status推断根工具退出0。源码/SDK图像、数学、容差、360冻结pyc及所有旧候选/失败不改。
这批三帧不足以覆盖粒子/球落布碰撞；通过后仍需原配置至少60帧及后续完整验收。
新电脑不能继承PID；旧任务真实结束后才可选择新目录重新测试，不覆盖既有数据。
