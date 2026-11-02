"""Independently audit ANYmal eager/Graph final states and their original repeat without importing a solver."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PREVIOUS = BASE.parent / 'continuation-20261101-0dabbaa7-official-demo-four/shared-GPU-v2'
OUTPUT = BASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 3
hashes = dict(plan['input_sha256'])
states, rows = {}, []


def pin(path):
    path = Path(path)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    return path


def compare(a, b):
    assert set(a) == set(b)
    result = {}
    for field in sorted(a):
        left, right = a[field], b[field]
        assert left.shape == right.shape and left.dtype == right.dtype == np.dtype('<f4')
        result[field] = {'bitwise': left.tobytes() == right.tobytes(),
                         'max_abs': float(np.abs(np.subtract(left, right, dtype='f8')).max())}
    result['all_bitwise'] = all(item['bitwise'] for item in result.values())
    return result


def metric(tag, final):
    assert all(np.isfinite(value).all() for value in final.values())
    below = (final['body_q'][:, 2] > -0.006).all()
    speed = np.max(np.abs(final['body_qd']), axis=1)
    return {'tag': tag, 'minimum_body_z': float(final['body_q'][:, 2].min()),
            'maximum_body_z': float(final['body_q'][:, 2].max()),
            'maximum_absolute_spatial_velocity': float(speed.max()),
            'velocity_bound_failure_count': int(np.count_nonzero(speed >= 0.25)),
            'height_bound_passed': bool(below), 'settled_velocity_bound_passed': bool((speed < 0.25).all())}


for worker in status['completed']:
    tag = worker['tag']
    assert worker['actual_exit'] == 0
    assert [g for g in status['GPU_waits'] if g['tag'] == tag][-1]['free_memory_MiB'] >= 4096
    directory = BASE / tag
    if tag.endswith('eager'):
        runtime = json.loads(pin(directory / 'capture.runtime.json').read_text())
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if tag == 'original-eager'
                    else '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e')
        assert runtime['image_sha256'] == expected and runtime['frames'] == 500 and runtime['extra'] == []
        with np.load(pin(directory / 'capture.npz'), allow_pickle=False) as archive:
            states[tag] = {key: archive[key].copy() for key in archive.files}
        assert all(len(value) == 2000 and np.isfinite(value).all() for value in states[tag].values())
        states[tag + '-final'] = {key: value[-1] for key, value in states[tag].items()}
        row = metric(tag, states[tag + '-final'])
        high = np.max(states[tag]['body_q'][:, :, 2], axis=1) > 10.0
        first = np.flatnonzero(high)
        row['first_public_substep_above10m'] = int(first[0]) if len(first) else None
        if worker['backend'] == 'source':
            counts = json.loads(pin(directory / 'capture.launches.json').read_text())
            assert counts and sum(counts.values()) > 0
    else:
        report = json.loads(pin(directory / 'report.json').read_text())
        assert report['exit'] == 0 and report['image_sha256'].startswith('64a0be7f') and report['reference_solver_mapped']
        with np.load(pin(directory / 'report.npz'), allow_pickle=False) as archive:
            states[tag] = {key: archive[key].copy() for key in archive.files}
        row = metric(tag, states[tag])
    pin(directory / 'run.log')
    pin(directory / 'command.json')
    rows.append(row)
for backend in ('original', 'source'):
    with np.load(pin(PREVIOUS / 'functional-tests/anymal' / (backend + '.npz')), allow_pickle=False) as archive:
        states[backend + '-graph-first'] = {key: archive[key].copy() for key in archive.files}
    rows.append(metric(backend + '-graph-first', states[backend + '-graph-first']))
comparisons = {
    'original_vs_source_eager_full2000': compare(states['original-eager'], states['source-eager']),
    'original_Graph_repeat_vs_first': compare(states['original-graph-first'], states['original-graph-repeat']),
    'first_source_vs_first_original_Graph': compare(states['original-graph-first'], states['source-graph-first']),
    'original_eager_final_vs_original_Graph_first': compare(states['original-eager-final'], states['original-graph-first']),
    'source_eager_final_vs_source_Graph_first': compare(states['source-eager-final'], states['source-graph-first']),
}
for path in (Path(__file__), BASE / 'plan.json', BASE / 'status.json'):
    pin(path)
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
OUTPUT.write_text(json.dumps({'rows': rows, 'comparisons': comparisons, 'input_sha256': hashes, 'GPU_used': False,
    'old_failures_reclassified': False, 'two_Graph_originals_are_not_C8': True,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps(rows, indent=2))
