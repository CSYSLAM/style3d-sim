#!/usr/bin/env python3
"""Check provenance and aggregate distinct coverage into the final Markdown report."""
import collections
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def read(name):return json.loads((ROOT/'validate'/name).read_text())


def main():
    audit=read('ptx_source_audit.json');binary=ROOT.parent/'_core.cpython-312-x86_64-linux-gnu.so'
    assert audit['binary_sha256']==digest(binary)
    assert audit['translator_sha256']==digest(ROOT/'recover/ptx2c.py')
    for row in audit['kernels']:
        assert digest(ROOT/row['ptx'])==row['ptx_sha256']
        assert digest(ROOT/row['source'])==row['source_sha256']
        assert all(row[k] for k in ['fresh_binary_matches_snapshot','all_statements_accounted','reproducible','compile_pass','original_load_pass','mechanical_load_pass'])
    files={
        'original':['review_algorithm_results.json','readable_original_results.json','fluid_original_results.json'],
        'mechanical':['review_algorithm_mechanical_results.json','readable_mechanical_results.json','fluid_mechanical_results.json'],
        'human':['review_algorithm_human_results.json','readable_human_results.json']}
    result={};reports={}
    for mode,names in files.items():
        kernels=set();checks=0;per=collections.Counter()
        for name in names:
            report=read(name);reports[name]=report
            assert report['failed']==0 and report['passed']==len(report['checks'])
            if 'binary_sha256' in report:assert report['binary_sha256']==audit['binary_sha256']
            for key,entry in report['entries'].items():
                if entry.get('source'):assert digest(ROOT/entry['source'])==entry['source_sha256'],entry['source']
                if mode!='human' or entry['implementation']=='readable_cuda':kernels.add(key)
            for check in report['checks']:
                key=check['kernel']
                if mode=='human' and report['entries'][key]['implementation']!='readable_cuda':continue
                checks+=1;per[key]+=1
        result[mode]={'entries':len(kernels),'checks':checks,'per_entry':dict(per)}
    assert result['original']['per_entry']==result['mechanical']['per_entry']
    human_files={e['source'] for n in files['human'] for e in reports[n]['entries'].values() if e['implementation']=='readable_cuda'}
    expected={str(p.relative_to(ROOT)) for d in ['recover/human','reconstructed'] for p in (ROOT/d).glob('*.cu')}
    assert human_files==expected
    for name in ['memcheck_algorithm.log','memcheck_readable.log','memcheck_fluid.log','synccheck_readable.log']:
        assert 'ERROR SUMMARY: 0 errors' in (ROOT/'validate'/name).read_text()
    summary=dict(binary_sha256=audit['binary_sha256'],translator_sha256=audit['translator_sha256'],
                 static_entries=audit['total'],statements=audit['statements'],coverage=result,
                 report_hashes={n:digest(ROOT/'validate'/n) for n in reports})
    (ROOT/'validate/verification_summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
    introduction='''# PTX、机械 CUDA 与可读实现的验证报告

本文记录当前实现和验证范围，配合 [算法主文](ALGORITHM_ANALYSIS_ZH.md)、[131 个入口附录](ALGORITHM_KERNEL_CATALOG_ZH.md) 与 [主机实参表](host/VERIFIED_ARGUMENTS_ZH.md) 阅读。

## 1. 对照对象与结论

| 对照层次 | 覆盖 | 结果 |
|---|---:|---|
| 当前二进制 PTX 与保存的快照 | 131 个入口 | 完整函数体一致，忽略空白 |
| PTX 语句与机械源文件的行号映射 | 106,114 条语句 | 全部计入，含 15 个内嵌 shuffle 复合块 |
| 机械 CUDA 编译 / 加载 | 131 / 131 | 全部通过 |
| 原始 PTX 模块 JIT 加载 | 131 | 全部通过 |
| 原始 PTX 与独立公式 | 46 个入口、408 项输出检查 | 全部通过 |
| 机械 CUDA 与独立公式 | 46 个入口、408 项输出检查 | 全部通过 |
| 人工可读 CUDA 与独立公式 | 全部 34 个文件、195 项输出检查 | 全部通过 |

这里的“语句”不计标签及声明；内嵌 shuffle 复合块按一条源语句计数，它内部包含多条指令。131 项静态覆盖不是 131 项完整物理模型证明。没有独立公式测试的 85 个入口，在后面的逐入口表中明确显示为 0。

二进制 SHA-256：

```text
'''+audit['binary_sha256']+'''
```

环境：NVIDIA GeForce RTX 5090 D v2，驱动 595.71.05。全入口机械编译使用 `nvcc -cubin -arch=sm_120`；数值测试中的原始 PTX 由当前驱动 JIT，机械/人工 CUDA 编译为 PTX 后加载。这里核对 PTX 语义，不声称与二进制每一种目标架构 SASS 的逐位执行轨迹等同。

## 2. 机械源文件如何对应原始指令

[翻译器](recover/ptx2c.py) 使用 CUDA C++ 表达参数、标签、分支、谓词、地址转换、访存、原子和同步；标量运算保留为小段内联 PTX，以保留位宽、signed/unsigned、FMA、转换舍入、近似指令及位模式。它是混合表达，不是全部变量已恢复物理命名的高级源码。

- 每条源语句保留 `// PTX:行号 原文`，可以直接回到对应快照。
- 访存按实际类型执行；shared/local/global 地址转换分别处理。向量访存拆成分量访问，缓存策略与性能不作为等价性结论。
- `atomicAdd/Min/Max/Exch/CAS` 等分别映射，保留操作类别；分支保留有序/无序浮点比较。
- warp shuffle 的有效 lane 谓词与相应加法保存在同一个内联块中，避免丢掉内部语句。
- 三角函数慢路径用到的 `__cudart_i2opi_f` 常量数据随相关入口提供。
- 未支持的语法、指令或全局符号会使生成终止，不产生成功占位结果。

[全入口审计脚本](validate/audit_ptx_sources.py) 从 `.so` 重新提取 PTX，独立逐行扫描语句，核对源行映射，重新生成 CUDA 并比较完整文本，再编译与加载。结果见 [ptx_source_audit.json](validate/ptx_source_audit.json)，每个入口的编译日志和 cubin 位于 `validate/audit_build/`。

## 3. 独立公式场景

参考答案由 NumPy 公式和显式整数索引计算，未用机械翻译器产生参考值。三套场景的入口并集为 46；17+27+3 中 `evaluate_rows` 重叠一次。每项检查对应一个输出数组或矩阵块，不等于同数量的独立物理场景。

| 套件 | 不同入口 | 输出检查 | 主要范围 |
|---|---:|---:|---|
| [基础算法公式](validate/review_algorithm_claims.py) | 17 | 216 | 弹簧、膜内、弯曲、四面体、SO(3)、空气阻力、颗粒提交、CG、块逆、流体网格/核 |
| [可读实现对应场景](validate/review_readable_kernels.py) | 27 | 152 | 稀疏布局、批世界、AABB、缓存、非零输出、活动掩码、可选指针、空行/零容量、融合归约 |
| [流体完整局部行](validate/review_fluid_paths.py) | 3 | 40 | 密度、压力权重、梯度、黏性、参考坐标、边界过滤、64/65 动态邻居两侧、力/块对角/矩阵作用 |

可读实现对应场景用 300 元素覆盖跨块和尾部线程，用不同 `tile/stride` 覆盖世界索引，用非零初始输出区分累加、覆盖和保留；流体专项使用非恒等粒子映射、非单位体积、时间步 0.17、平滑半径 1.3、非零黏性及欠密输入。PCG 融合入口使用 256 线程块；流体专项使用主机实际的 128 线程块。

整数按整数比较，结构化条目分别比较列号和数值。基础套件通常使用 `rtol=4e-5, atol=3e-6`，具体特殊判据见脚本与结果；可读套件为 `rtol=5e-5, atol=5e-6`，先核对非有限值类别；流体专项为 `rtol=1e-4, atol=3e-5`。浮点原子加的顺序和 FMA 可能影响末位，结论是规定容差内一致，不是所有浮点结果逐位一致。

| 报告 | 原始 PTX | 机械 CUDA | 人工 CUDA |
|---|---|---|---|
| 基础 | [216 项](validate/review_algorithm_results.json) | [216 项](validate/review_algorithm_mechanical_results.json) | [报告](validate/review_algorithm_human_results.json)：其中 43 项实际执行人工 CUDA |
| 可读场景 | [152 项](validate/readable_original_results.json) | [152 项](validate/readable_mechanical_results.json) | [152 项](validate/readable_human_results.json) |
| 流体专项 | [40 项](validate/fluid_original_results.json) | [40 项](validate/fluid_mechanical_results.json) | 无人工实现 |

人工基础模式中的另外 173 项回退执行原始 PTX，未算入 195 项人工覆盖。原始和机械模式执行相同输入，因此其检查数也不应相加作为不同场景数。

## 4. 主机实参与运行检查

已由主机指令追踪确认：`initialize_rhs` 的系数 `1/h²`；弯曲、四面体阻尼和空气阻力的系数 `1/h`；流体 View 的 `h_f/K/μ/h`；流体世界尺度初始值 1 与位移上限 `ratio*h_f`；初始键/动态键的 `L0/Lh/active` 跨入口绑定；Newton 和 PD-Newton 的三种线性分派。逐项地址、寄存器与对象偏移见 [主机实参表](host/VERIFIED_ARGUMENTS_ZH.md)。

Compute Sanitizer 在机械版本上报告：

| 检查 | 场景 | 结果 |
|---|---|---|
| [memcheck](validate/memcheck_algorithm.log) | 基础 216 项 | 0 errors |
| [memcheck](validate/memcheck_readable.log) | 可读对应 152 项 | 0 errors |
| [memcheck](validate/memcheck_fluid.log) | 流体 40 项 | 0 errors |
| [synccheck](validate/synccheck_readable.log) | 可读对应场景，含融合归约 | 0 errors |

这些结果限定于已运行输入；memcheck/synccheck 也不是完整数据竞争证明。所有新文档采用上述具有类型和独立公式的测试结果。通用 `ab.cpp` 仅把逐字节相同视为 `PASS`，零变化为 `NO_CHANGE`；需要浮点容差的结论由这些独立脚本提供。

## 5. 复现命令

在 `_re_analysis/` 目录执行，需要 NumPy、CUDA Driver、可用 GPU、`cuobjdump`、`nvcc`，内存/同步检查另需 `compute-sanitizer`。

```bash
python3 validate/audit_ptx_sources.py
python3 validate/review_algorithm_claims.py
python3 validate/review_algorithm_claims.py --mechanical
python3 validate/review_algorithm_claims.py --human
python3 validate/review_readable_kernels.py original
python3 validate/review_readable_kernels.py mechanical
python3 validate/review_readable_kernels.py human
python3 validate/review_fluid_paths.py original
python3 validate/review_fluid_paths.py mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_algorithm.log python3 validate/review_algorithm_claims.py --mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_readable.log python3 validate/review_readable_kernels.py mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_fluid.log python3 validate/review_fluid_paths.py mechanical
compute-sanitizer --tool synccheck --error-exitcode 99 --log-file validate/synccheck_readable.log python3 validate/review_readable_kernels.py mechanical
python3 validate/summarize_verification.py
```

最后一条重新核对二进制、翻译器、所有机械/人工源文件的 SHA-256，计算去重覆盖，输出本文及 [汇总 JSON](validate/verification_summary.json)。若源文件已经变化而结果尚未重跑，它会拒绝使用旧摘要。

## 6. 逐入口完整覆盖表

每行的静态、编译、加载均已通过。数值列是该入口对应的输出检查数量；0 表示未加入独立公式运行场景，不是运行失败，也不是运行通过。人工列只统计实际执行人工源文件的检查。完整签名与功能解释见 [入口附录](ALGORITHM_KERNEL_CATALOG_ZH.md)。

| 模块 / 入口 | PTX 语句数 | 静态/编译/加载 | 原始数值 | 机械数值 | 人工数值 |
|---|---:|---|---:|---:|---:|
'''
    rows=[]
    for row in audit['kernels']:
        key=row['module']+'/'+row['kernel'];label=key.replace('|','\\|')
        counts=[result[m]['per_entry'].get(key,0) for m in ['original','mechanical','human']]
        rows.append(f'| [{label}]({row["ptx"]}) | {row["statement_count"]} | 通过 | '+ ' | '.join(map(str,counts))+' |')
    ending='''

## 7. 仍需单独完成的范围

剩余工作主要是完整 `step` 的动态控制流与长时间轨迹，PD 外层分裂，全部 affine-body 块预条件及其他刚性模型，SO(3) 退化/对偶更新，硬接触与 surface/rolling 的全部历史分支，自碰撞过滤/解缠，新键形成，以及 Cosserat/Dahl 的完整应变与历史状态。详细范围见 [主文第 23 节](ALGORITHM_ANALYSIS_ZH.md#s23)。

这些部分可以继续依靠 PTX 和主机数据流恢复；当前尚未展开的分支没有足够证据写成确定公式。静态完整、局部数值通过和完整系统等价是三个不同结论。
'''
    (ROOT/'PTX_CODE_VERIFICATION_ZH.md').write_text(introduction+'\n'.join(rows)+ending)
    print(json.dumps({m:{k:v for k,v in d.items() if k!='per_entry'} for m,d in result.items()}))


if __name__=='__main__':main()
