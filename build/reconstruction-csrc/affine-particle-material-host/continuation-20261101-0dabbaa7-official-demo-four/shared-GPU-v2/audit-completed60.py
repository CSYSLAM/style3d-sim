"""Recheck completed public-core runs and SDK repeats without importing either solver or the original comparator."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'completed60-independent-cpu.json'
assert not OUTPUT.exists()
hashes = {}


def pin(path):
    path = Path(path)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    return path


def read(path):
    return json.loads(pin(path).read_text())


def compare(left_path, right_path):
    # Flatten each substep independently so this audit does not reuse the runner's comparison implementation.
    result = {}
    with np.load(pin(left_path), allow_pickle=False) as left, np.load(pin(right_path), allow_pickle=False) as right:
        assert set(left.files) == set(right.files)
        for field in sorted(left.files):
            a, b = left[field], right[field]
            assert a.dtype == b.dtype == np.dtype('<f4') and a.shape == b.shape and a.ndim == 3
            assert np.isfinite(a).all() and np.isfinite(b).all()
            mismatch = (a.view('<u4') != b.view('<u4')).reshape(len(a), -1).any(axis=1)
            indices = np.nonzero(mismatch)[0]
            result[field] = {'substeps': len(a), 'length_match': True,
                             'bitwise_substeps': int(len(a) - mismatch.sum()),
                             'first_diff_substep': int(indices[0]) if len(indices) else None,
                             'max_abs': float(np.max(np.abs(np.subtract(a, b, dtype='f8')))), 'nonfinite': False}
    result['bitwise'] = all(value['bitwise_substeps'] == value['substeps'] for value in result.values())
    return result


pin(Path(__file__))
normal = read(BASE / 'normal-core60/status.json')
assert normal['complete'] and not normal['error'] and not normal['skipped']
workers = normal['completed'] + [dict(read(BASE / 'normal-core60/cable-bend-actual-exit.json'), case='cable-bend')]
assert len(workers) == 5 and len({worker['case'] for worker in workers}) == 5
normal_rows = []
for worker in workers:
    name = worker['case']
    report = read(BASE / 'normal-core60' / (name + '.json'))
    assert worker['actual_exit'] == report['exit'] == 0
    assert report['source_only'] and report['public_core_abi']
    assert not report['ab_bridge_used'] and not report['reference_solver_mapped'] and not report['solver_api_ready']
    assert report['arguments'] == ['--viewer', 'null', '--num-frames', '60']
    assert report['source_sha256'] == '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
    assert hashlib.sha256(pin(report['source_image']).read_bytes()).hexdigest() == report['source_sha256']
    assert hashlib.sha256(pin(report['example']).read_bytes()).hexdigest() == report['example_sha256']
    assert report['source_launch_counts'] and sum(report['source_launch_counts'].values()) > 0
    assert 'graph replay not recounted' in report['count_semantics']
    pin(BASE / 'normal-core60' / (name + '.log'))
    normal_rows.append({'case': name, 'actual_exit': 0, 'source_only': True,
                        'graph_numerical_equivalence_claimed': False, 'all_graph_states_finite_claimed': False})

repeat = read(BASE / 'native-repeat60/report.json')
status = read(BASE / 'native-repeat60/status.json')
assert status['complete'] and status['running'] is None and len(status['completed']) == 4
assert repeat['original_runs_per_case'] == 2 and not repeat['statistical_acceptance_claimed']
repeat_rows = []
for row in repeat['cases']:
    name = row['case']
    workers = [worker for worker in status['completed'] if worker['case'] == name]
    assert len(workers) == 1 and workers[0]['actual_exit'] == 0
    runtime = read(BASE / 'native-repeat60' / name / 'repeat.runtime.json')
    assert runtime['image_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
    assert runtime['frames'] == 60 and runtime['extra'] == [] and runtime['backend'] == 'original'
    original = BASE / 'long60' / name / 'original.npz'
    source = BASE / 'long60' / name / 'source.npz'
    repeated = BASE / 'native-repeat60' / name / 'repeat.npz'
    actual = {'case': name, 'original_vs_original': compare(original, repeated),
              'first_source_vs_repeated_original': compare(repeated, source),
              'two_originals_are_not_a_C8_acceptance_cohort': True, 'frozen_first_source_replaced': False}
    assert actual == row, name
    repeat_rows.append(actual)

replay_base = BASE / 'particles-full-inputs/full-input-replays'
plan = read(replay_base / 'plan.json')
before_rows = []
with np.load(pin(replay_base / 'worker-0.npz'), allow_pickle=False) as left:
    with np.load(pin(replay_base / 'worker-1.npz'), allow_pickle=False) as right:
        for packet in plan['packets'][:3]:
            stage = packet['stage']
            fields = []
            for binding in stage['bindings']:
                key = stage['key'] + '/before/' + binding['label']
                a, b = left[key], right[key]
                assert a.shape == b.shape and a.dtype == b.dtype == np.dtype('u1')
                fields.append({'argument': binding['argument'], 'bytes': a.nbytes,
                               'different_bytes': int(np.count_nonzero(a != b))})
            before_rows.append({'stage': stage['key'], 'fields': fields})

for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'normal_public_core60': normal_rows, 'SDK_repeat60': repeat_rows,
          'first_three_cross_end_initial_inputs': before_rows, 'input_sha256': hashes,
          'GPU_used': False, 'frozen_failures_reclassified': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified5 public-core60 exits,4 SDK repeat comparisons and first3 complete-input differences')
print(json.dumps(before_rows, indent=2))
