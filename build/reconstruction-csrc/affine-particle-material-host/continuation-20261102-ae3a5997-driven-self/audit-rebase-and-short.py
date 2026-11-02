"""Independently check the exact rebase, actual ELF and all twelve captured SDK/source state and ABI pairs."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

build = json.loads((BASE / 'candidate-force-order/build.json').read_text())
for name, expected in build['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
parent = BASE.parent / 'continuation-20261102-d09d4be9-granular-contacts/candidate-guard-only/source_solver.cpp'
original, expected = parent.read_text(), parent.read_text()
for patch in build['SDK_proven_patches']:
    assert expected.count(patch['before']) == 1
    expected = expected.replace(patch['before'], patch['after'], 1)
cpp = BASE / 'candidate-force-order/source_solver.cpp'
assert cpp.read_text() == expected
for patch in reversed(build['SDK_proven_patches']):
    assert expected.count(patch['after']) == 1
    expected = expected.replace(patch['after'], patch['before'], 1)
assert expected == original
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
dynamic = subprocess.check_output(['readelf', '-d', str(image)], text=True)
symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(image)], text=True)
needed = [line.split('[', 1)[1].split(']', 1)[0] for line in dynamic.splitlines() if '(NEEDED)' in line]
allowed = {'libcuda.so.1', 'libcudart.so.12', 'libstdc++.so.6', 'libgcc_s.so.1', 'libc.so.6', 'ld-linux-x86-64.so.2'}
assert needed and set(needed) == allowed
assert [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line] == ['PyInit__source_solver']
(BASE / 'candidate-force-order/elf-dynamic.txt').write_text(dynamic)
(BASE / 'candidate-force-order/elf-exports.txt').write_text(symbols)
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/discovery'
plan = json.loads((legacy / 'plan.json').read_text())
terminal = json.loads((BASE / 'force-order-captures/status.json').read_text())
report = json.loads((BASE / 'force-order-captures/report.json').read_text())
assert terminal['complete'] and terminal['running'] is None and len(terminal['completed']) == 12
assert all(row['actual_exit'] == 0 for row in terminal['completed'])
hashes, rows = {}, []
for case, row in zip(plan['cases'], report['cases'], strict=True):
    assert row['case'] == case['name'] and row['actual_exit'] == 0
    left, right = legacy / case['name'] / 'original', BASE / 'force-order-captures' / case['name']
    with np.load(left / 'capture.npz', allow_pickle=False) as a, np.load(right / 'capture.npz', allow_pickle=False) as b:
        assert set(a.files) == set(b.files) and all(np.isfinite(data[key]).all() for data in (a, b) for key in data.files)
        states = compare(a, b)
        assert states == row['state']
    abi = compare_launches(left / 'launches.txt', right / 'launches.txt', schemas()[0])
    assert abi == row['metadata'] and abi['equal'] and row['owned_coverage']
    assert (left / 'layout.json').read_bytes() == (right / 'layout.json').read_bytes()
    for folder in (left, right):
        for path in folder.glob('*'):
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    rows.append({'case': case['name'], 'state_strict': states['bitwise'], 'owned_calls': abi['right_launches']})
assert sum(row['state_strict'] for row in rows) == 10 and sum(row['owned_calls'] for row in rows) == 9243
output = BASE / 'rebase-short-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps({'cases': rows, 'exact_three_hunks_reversible_to_ae': True,
    'candidate_sha256': build['image_sha256'], 'ELF_needed': needed, 'only_CUDA_system_dependencies': True,
    'input_sha256': hashes, 'all_state_arrays_finite': True, 'production_changed': False, 'GPU_runs': 0,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Independent rebase/ELF/12 captured states and ABI pass: 9243 calls, 10 strict states, two failures retained')
