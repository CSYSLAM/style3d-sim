"""Independently verify the candidate delta, actual twelve short runs and all fixed-C8 failure statistics."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare, spread_report

hashes = {str(Path(__file__)): hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
first = json.loads((BASE / 'candidate-guard-only/build.json').read_text())
build = json.loads((BASE / 'candidate-force-order/build.json').read_text())
original = (ROOT / 'reconstruction/csrc/native/source_solver.cpp').read_text()
guard = (BASE / 'candidate-guard-only/source_solver.cpp').read_text()
expected = original
for old, new in first['changes']:
    assert expected.count(old) == 1
    expected = expected.replace(old, new, 1)
assert guard == expected
old_call = '                accumulate_self_particle_pairs(in, stream);\n'
anchor = '            // Contacts precede the joint forces/drives; SO(3) follows those constraint forces.\n'
expected = guard.replace(old_call, '', 1).replace(anchor,
    '            // Actual SDK order: self accumulation follows drive/limits; preserve the earlier stiffness scale.\n'
    '            if (self) accumulate_self_particle_pairs(in, stream);\n', 1)
assert expected == (BASE / 'candidate-force-order/source_solver.cpp').read_text()
dynamic = subprocess.check_output(['readelf', '-d', build['image']], text=True)
assert '_core' not in dynamic and 'style3d-sim-bin' not in dynamic
(BASE / 'candidate-force-order/elf-dynamic.txt').write_text(dynamic)
plan = json.loads((BASE / 'discovery/plan.json').read_text())
reported = json.loads((BASE / 'force-order-captures/report.json').read_text())['cases']
checks, schema = [], schemas()[0]
for case, row in zip(plan['cases'], reported):
    assert row['case'] == case['name'] and row['actual_exit'] == 0
    sdk = BASE / 'discovery' / case['name'] / 'original'
    source = BASE / 'force-order-captures' / case['name']
    with np.load(sdk / 'capture.npz', allow_pickle=False) as a, np.load(source / 'capture.npz', allow_pickle=False) as b:
        states = compare(a, b)
        assert states == row['state'] and all(np.isfinite(b[key]).all() for key in b.files)
    metadata = compare_launches(sdk / 'launches.txt', source / 'launches.txt', schema)
    assert metadata == row['metadata'] and metadata['equal']
    checks.append({'case': case['name'], 'strict': states['bitwise'], 'owned_calls': metadata['right_launches']})
    for folder in (sdk, source):
        for path in folder.glob('*'):
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(checks) == 12 and sum(row['strict'] for row in checks) == 10
short = BASE / 'short-fixed-C8'
assert json.loads((short / 'status.json').read_text())['complete']
short_plan = json.loads((short / 'plan.json').read_text())
short_report = json.loads((short / 'report.json').read_text())
fixed = []
for case, reported_case in zip(short_plan['cases'], short_report['cases']):
    cohort = short / 'cohorts' / case['name']
    assert (cohort / 'original0.npz').read_bytes() == (
        BASE / 'discovery' / case['name'] / 'original/capture.npz').read_bytes()
    assert (cohort / 'source0.npz').read_bytes() == (
        BASE / 'force-order-captures' / case['name'] / 'capture.npz').read_bytes()
    originals = [np.load(cohort / f'original{i}.npz', allow_pickle=False) for i in range(8)]
    sources = [np.load(cohort / f'source{i}.npz', allow_pickle=False) for i in range(3)]
    try:
        actual = [spread_report(originals, [source]) for source in sources]
        assert actual == reported_case['statistics']
        passed = [all(v['substeps_within_spread'] == 3 for v in stat.values()) for stat in actual]
        assert passed == reported_case['sources_within_C8'] == [False, False, False]
        fixed.append({'case': case['name'], 'sources_within_C8': passed, 'source0_copied_exactly': True})
    finally:
        for data in originals + sources:
            data.close()
    for path in cohort.glob('*.npz'):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, value in {**first['input_sha256'], **build['input_sha256']}.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == value, name
    hashes[name] = value
for name, value in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == value, name
record = {'short_cases': checks, 'fixed_C8_cases': fixed, 'input_sha256': hashes,
          'exact_two_guard_changes_and_one_self_force_move': True, 'candidate_independent_ELF': True,
          'GPU_used': False, 'candidate_promoted': False, 'whole_solver_complete': False}
(BASE / 'candidate-short-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:candidate exact two guards/one move;12 metadata equal,10 strict;both original source0 fixed C8 failures retained')
