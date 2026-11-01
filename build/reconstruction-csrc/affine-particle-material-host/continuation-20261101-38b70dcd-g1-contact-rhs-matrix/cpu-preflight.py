"""Freeze two contact branches and verify their full layouts without creating a GPU context."""
import ast
import hashlib
import json
from pathlib import Path
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.g1_contact_rhs_capture import select_stages
from reconstruction.csrc.g1_contact_rhs_replay import instrument256, kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries

base = Path(__file__).resolve().parent
previous = base.parent / 'continuation-20261101-38b70dcd-g1-rigid-tangent'
build_path = root / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
assert build['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
hashes = dict(json.loads((previous / 'plan.json').read_text())['input_sha256'])
new_paths = [root / 'reconstruction/csrc/g1_contact_rhs_capture.py',
             root / 'reconstruction/csrc/g1_contact_rhs_replay.py', build_path, Path(__file__)]
for path in new_paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
for path in new_paths[:2]:
    ast.parse(path.read_text())
    assert all(len(line) <= 128 for line in path.read_text().splitlines()), str(path)
    (base / (path.stem + '-as-run.py')).write_bytes(path.read_bytes())
records, kernels = {}, None
for side in ('original', 'source'):
    path = previous / side / 'definition-before/graph.json'
    nodes = linear_order(json.loads(path.read_text()))[0]
    stages = select_stages(nodes, 44, 49)
    names = {s['key']: s['node']['name'] for s in stages}
    assert kernels is None or names == kernels
    kernels = names
    snapshots = sum(len(s['sizes']) + len(s['outputs']) for s in stages)
    total = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages)
    assert snapshots == 55
    records[side] = {'stages': stages, 'snapshot_nodes': snapshots, 'total_snapshot_bytes': total,
                     'graph_nodes_after': 17467 + snapshots, 'graph_edges_after': 17466 + snapshots + 4}
static = {}
for key, name in kernels.items():
    texts, original = kernel_texts(build, name)
    hashes[str(original)] = hashlib.sha256(original.read_bytes()).hexdigest()
    static[key] = {}
    for side, text in texts.items():
        changed, sites = instrument256(text, name)
        assert changed.count('mul.wide.u32 %audit_lane_offset, %audit_lane, 4096;') == sites
        assert [len(bytes.fromhex(value)) for value in records[side]['stages'][0 if key == 'force' else 1]
                ['node']['parameter_hex']] == build['kernels'][name]['parameters']
        (base / (key + '-' + side + '-entry.ptx')).write_text(entries(text)[name])
        (base / (key + '-' + side + '-instrumented-preflight.ptx')).write_text(changed)
        static[key][side] = {'static_sites': sites, 'max_dynamic_sites_per_thread': 64 if key == 'force' else 144,
                             'allocated_records_per_thread': 256}
plan = {'previous_goal_turn': 'progress: completed rigid-vector handoff/evidence and published 23ec2760',
        'backends': ['original', 'source'], 'frames': 60, 'stages': ['force', 'matrix'],
        'packets_per_stage': 120, 'kernels': kernels, 'input_sha256': hashes,
        'real_pre_call_output_initials_required': True, 'outputs_per_call': 2,
        'extra_isolation_only_if_complete_strict_gate_does_not_pass': True,
        'frozen_C8_cohort_extended': False, 'production_changed': False, 'whole_solver_complete': False}
(base / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(base / 'CPU-layout-preflight.json').write_text(json.dumps(
    {'records': records, 'probe': static, 'GPU_context_created': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Preflight passed; snapshot bytes:', [records[s]['total_snapshot_bytes'] for s in records])
print('Static probe sites:', static, flush=True)
