"""Append one DEMO_CLOSURE_TABLE.md row from a demo's closure.json (the row is derived only from recorded data)."""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def main(name):
    r = json.loads((ROOT/'build/reconstruction-demos-source'/name/'closure/closure.json').read_text())
    if r.get('closed_by', '').startswith('stage 1'):
        row = f"| {name} | {r['frames']} | 闭环 | 第一阶段：原版 1 次与源码 1 次全程逐位一致 |\n"
        with (ROOT/'reconstruction/csrc/DEMO_CLOSURE_TABLE.md').open('a') as table:
            table.write(row)
        print(row, end='')
        return
    a, b, c = r['A_launch_sequence'], r['B_uploads'], r['C_arguments']
    parts = [f"A {a['original']} {'一致' if a['identical'] else '不一致'}",
             f"B {b['original']} {'一致' if b['identical'] else '不一致'}",
             f"C {c['original']} {'一致' if c['identical'] else '不一致'}"]
    e = r['E_distribution']
    if isinstance(e, dict):
        first = min((v['original_self_first_difference'] for v in r['D_bitwise_prefix'].values()
                     if v['original_self_first_difference'] is not None), default=None)
        parts.append(f'原版自身从 substep {first} 起不可复现')
        for key, v in e.items():
            parts.append(f"{key}: spread 内子步 源码 {min(v['source_within'])}~{max(v['source_within'])} / 原版 "
                         f"{min(v['original_within'])}~{max(v['original_within'])}（共 {v['substeps']}），秩检验 p="
                         f"{min(v['p_within_worse'], v['p_ratio_worse']):.3f}{'' if v['pass'] else ' 不通过'}")
    else:
        parts.append('原版可复现，全程逐位一致' if all(v['pass'] for v in r['D_bitwise_prefix'].values())
                     else '逐位不一致')
    row = f"| {name} | {r['frames']} | {'闭环' if r['closed'] else '未闭环'} | {'；'.join(parts)} |\n"
    with (ROOT/'reconstruction/csrc/DEMO_CLOSURE_TABLE.md').open('a') as table:
        table.write(row)
    print(row, end='')


if __name__ == '__main__':
    main(sys.argv[1])
