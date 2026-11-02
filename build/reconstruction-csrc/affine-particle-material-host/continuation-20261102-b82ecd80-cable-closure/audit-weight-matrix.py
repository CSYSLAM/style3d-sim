"""Independently compare all fixed closure state/buffer bytes and actual worker provenance on CPU."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--kind', choices=('dynamic-mixed-short-weight',), required=True)
args = parser.parse_args()
folder = BASE / args.kind
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
report = json.loads((folder / 'report.json').read_text())
expected_cases = 48 if args.kind == 'penalty30' else 16
assert status['complete'] and status['running'] is None
assert len(plan['cases']) == len(report['cases']) == expected_cases
assert len(status['completed']) == 2 * expected_cases and all(row['actual_exit'] == 0 for row in status['completed'])
checkpoint = BASE / 'before-production-0dabbaa7'
saved = json.loads((checkpoint / 'checkpoint.json').read_text())
resolved_inputs = {}
for name, expected in plan['input_sha256'].items():
    path = Path(name)
    if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
        relative = str(path.relative_to(ROOT))
        assert saved['files'][relative] == expected
        path = checkpoint / 'preserved-files' / relative
        assert hashlib.sha256(path.read_bytes()).hexdigest() == expected
        resolved_inputs[name] = str(path)
hashes = dict(plan['input_sha256'])
schema = schemas()[0]
rows, state_bytes, buffer_bytes, owned_calls, penalty_arrays = [], 0, 0, 0, 0
for case, result in zip(plan['cases'], report['cases']):
    assert case['name'] == result['case'] and result['passed']
    group = folder / case['name']
    expected_shapes = {'particle_q': (plan['frames'], 8 * case['worlds'], 3),
                       'particle_qd': (plan['frames'], 8 * case['worlds'], 3),
                       'body_q': (plan['frames'], 2 * case['worlds'], 7),
                       'body_qd': (plan['frames'], 2 * case['worlds'], 6)}
    for backend in ('original', 'source'):
        actual = group / backend / 'actual'
        provenance = json.loads((actual / 'candidate-provenance.json').read_text())
        runtime = json.loads((actual / 'capture.runtime.json').read_text())
        assert provenance['complete'] and provenance['SDK_mapped'] == (backend == 'original')
        assert runtime['frames'] == plan['frames'] and runtime['extra'] == case['extra']
        expected_image = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                          if backend == 'original' else plan['source_image_sha256'])
        assert runtime['image_sha256'] == expected_image
        helper = str(ROOT / 'reconstruction/csrc/candidate_demo_worker.py')
        assert provenance['runner_sha256'] == plan['input_sha256'][helper]
        for path in (group / backend).rglob('*'):
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(group / 'original/actual/capture.npz', allow_pickle=False) as old, \
            np.load(group / 'source/actual/capture.npz', allow_pickle=False) as new:
        assert set(old.files) == set(new.files) == set(expected_shapes)
        for key, shape in expected_shapes.items():
            assert old[key].shape == new[key].shape == shape and old[key].dtype == new[key].dtype == np.dtype('<f4')
            assert np.isfinite(old[key]).all() and np.isfinite(new[key]).all()
            assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
            state_bytes += old[key].nbytes
    if args.kind != 'penalty30':
        metadata = compare_launches(group / 'original/launches.txt', group / 'source/launches.txt', schema)
        assert metadata == result['metadata'] and metadata['equal']
        counts = json.loads((group / 'source/actual/capture.launches.json').read_text())
        assert sum(counts.values()) == metadata['right_launches']
        owned_calls += metadata['right_launches']
        names = sorted(path.name for path in (group / 'original').glob('dump_*.bin'))
        assert len(names) == 6
        for name in names:
            a, b = [(group / backend / name).read_bytes() for backend in ('original', 'source')]
            assert len(a) == len(b) == case['worlds'] * 8 * 12 and a == b
            buffer_bytes += len(a)
            if '_pre_' in name:
                assert a != (group / 'original' / name.replace('_pre_', '_post_')).read_bytes()
    elif case['actions']:
        with np.load(group / 'original/actual/penalties.npz', allow_pickle=False) as old, \
                np.load(group / 'source/actual/penalties.npz', allow_pickle=False) as new:
            keys = {f'before-{i}' for i in range(30)} | {'reset-4', 'reset-9', 'masked-reset', 'ramp-off', 'ramp-on'}
            assert set(old.files) == set(new.files) == keys
            for key in keys:
                assert old[key].shape == new[key].shape == (case['worlds'], 4)
                assert old[key].dtype == new[key].dtype == np.dtype('<f4')
                assert np.isfinite(old[key]).all() and np.isfinite(new[key]).all()
                assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
                penalty_arrays += 1
                buffer_bytes += old[key].nbytes
    rows.append({'case': case['name'], 'all_complete_bytes_equal': True})
for path in (Path(__file__), folder / 'plan.json', folder / 'status.json', folder / 'report.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
record = {'kind': args.kind, 'strict_cases': len(rows), 'actual_workers': len(status['completed']),
          'complete_state_bytes_CPU_checked': state_bytes, 'complete_buffer_bytes_CPU_checked': buffer_bytes,
          'owned_calls_checked': owned_calls, 'penalty_arrays_checked': penalty_arrays, 'cases': rows,
          'pinned_input_checkpoint_locations': resolved_inputs, 'input_sha256': hashes,
          'production_modified': False, 'whole_solver_complete': False}
(BASE / (args.kind + '-independent-cpu.json')).write_text(json.dumps(record, indent=2) + '\n')
print('CPU checked', args.kind, ':', len(rows), 'strict cases;', owned_calls, 'owned calls;', penalty_arrays, 'penalty arrays')
