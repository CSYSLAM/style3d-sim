"""Freeze rolling view layout, authentic node selection and diagnostic scripts before GPU execution."""
import ast
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.audit_cudahook import SCALAR_WORDS
from reconstruction.csrc.g1_contact_rhs_replay import instrument256, kernel_texts
from reconstruction.csrc.g1_rolling_capture import rendered_source as capture_source
from reconstruction.csrc.g1_rolling_replay import rendered_source as replay_source
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_compare import normalise
from reconstruction.csrc.ptx_store_origins_typed import store_origins

base = Path(__file__).resolve().parent
previous = base.parent / 'continuation-20261101-38b70dcd-g1-contact-rhs-matrix'
build_path = root / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
assert build['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
native = root / 'reconstruction/csrc/native/source_solver.cpp'
fragment = re.search(r'    struct RollingView \{\n.*?\n    \};', native.read_text(), re.S)[0]
names = ('count capacity shape0 shape1 point0 point1 offset0 offset1 normal margin0 margin1 shape_body shape_type '
         'transform scale ke kd rolling torsional local_shapes shapes_per_world worlds body_ids body_indices body_com '
         'inertia body_count particles_per_world x previous inverse_dt epsilon').split()
cpp = '#include <cstdint>\n#include <cstddef>\n#include <iostream>\n' + fragment + '\nint main() {\n'
cpp += 'std::cout << sizeof(RollingView) << "\\n";\n'
for name in names:
    cpp += f'std::cout << "{name} " << offsetof(RollingView, {name}) << "\\n";\n'
cpp += '}\n'
(base / 'rolling-view-abi.cpp').write_text(cpp)
command = ['c++', '-std=c++17', str(base / 'rolling-view-abi.cpp'), '-o', str(base / 'rolling-view-abi')]
(base / 'rolling-view-abi.command.json').write_text(json.dumps(command, indent=2) + '\n')
compiled = subprocess.run(command, text=True, capture_output=True)
(base / 'rolling-view-abi.compile.log').write_text(compiled.stdout + compiled.stderr)
assert compiled.returncode == 0, compiled.stderr
actual = subprocess.check_output([str(base / 'rolling-view-abi')], text=True)
(base / 'rolling-view-abi.txt').write_text(actual)
lines = actual.splitlines()
offsets = {name: int(offset) for name, offset in (line.split() for line in lines[1:])}
assert int(lines[0]) == 248 and offsets == dict(zip(names, [*range(0, 240, 8), 240, 244]))
assert SCALAR_WORDS['R'] == {8, 152, 160, 168, 208, 216, 240}
templates = {'capture': capture_source(), 'replay': replay_source()}
for label, text in templates.items():
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), label
    (base / (label + '-template.py')).write_text(text)
namespace = {'__name__': 'reconstruction.csrc.rolling_capture_preflight', '__package__': 'reconstruction.csrc',
             '__file__': str(base / 'capture-template.py')}
exec(compile(templates['capture'], str(base / 'capture-template.py'), 'exec'), namespace)
records, kernels = {}, None
for side in ('original', 'source'):
    graph_path = previous / side / 'definition-before/graph.json'
    nodes = linear_order(json.loads(graph_path.read_text()))[0]
    stages = namespace['select_stages'](nodes, 44, 49)
    names_for_side = {stage['key']: stage['node']['name'] for stage in stages}
    assert kernels is None or kernels == names_for_side
    kernels = names_for_side
    assert sum(len(s['sizes']) + len(s['outputs']) for s in stages) == 52
    total = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages)
    assert total == 196776
    records[side] = {'stages': stages, 'total_snapshot_bytes': total, 'snapshot_nodes': 52,
                     'expected_graph_nodes': 17519, 'expected_graph_edges': 17522}
proofs = {}
for key, name in kernels.items():
    texts, original = kernel_texts(build, name)
    proofs[key] = {}
    for side, text in texts.items():
        entry = entries(text)[name]
        fields = [(0, offset) for offset in namespace['POINTER_OFFSETS']] + [(1, 0)]
        proof = store_origins(entry, fields)
        assert proof['parameter_count'] == 2 and proof['potential_written_pointer_fields'] == [(1, 0)]
        changed, sites = instrument256(text, name)
        assert sorted(set(re.findall(r'\b(?:red|atom)\.[\w.]+', entry))) == ['red.global.add.f32']
        (base / (key + '-' + side + '-entry.ptx')).write_text(entry)
        (base / (key + '-' + side + '-instrumented-preflight.ptx')).write_text(changed)
        proofs[key][side] = {'stores': proof, 'static_atomic_sites': sites,
                             'normalized_entry_sha256': hashlib.sha256(normalise(entry).encode()).hexdigest()}
    proofs[key]['normalized_PTX_equal'] = (
        proofs[key]['original']['normalized_entry_sha256'] == proofs[key]['source']['normalized_entry_sha256'])
hashes = dict(json.loads((previous / 'plan.json').read_text())['input_sha256'])
paths = [Path(__file__), root / 'reconstruction/csrc/g1_rolling_capture.py',
         root / 'reconstruction/csrc/g1_rolling_replay.py', root / 'reconstruction/csrc/ptx_store_origins_typed.py',
         base / 'capture-template.py', base / 'replay-template.py', base / 'rolling-view-abi.cpp', build_path]
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, sha in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
plan = {'previous_goal_turn': 'progress: published contact dual-output strict proof and frozen G1 assets in4355dd84',
        'backends': ['original', 'source'], 'frames': 60, 'stages': ['force', 'matrix'], 'kernels': kernels,
        'packets_per_stage': 120, 'input_sha256': hashes,
        'binding_encoding': '1 = actual output parameter1; 256 + offset/8 = embedded parameter0 pointer',
        'view_scalar_bytes_must_be_preserved': True, 'actual_pre_call_initials_required': True,
        'extra_isolation_only_if_complete_strict_gate_does_not_pass': True,
        'frozen_cohort_extended': False, 'production_changed': False, 'whole_solver_complete': False}
(base / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(base / 'CPU-layout-preflight.json').write_text(json.dumps(
    {'native_CXX_size': 248, 'native_CXX_field_offsets': offsets, 'records': records, 'PTX_proofs': proofs,
     'GPU_context_created': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('CPU native-view offsets/rolling payloads passed;52 snapshots/196776 bytes per frame.', flush=True)
print('Atomic sites:', {key: {s: proof[s]['static_atomic_sites'] for s in ('original', 'source')}
                       for key, proof in proofs.items()}, flush=True)
