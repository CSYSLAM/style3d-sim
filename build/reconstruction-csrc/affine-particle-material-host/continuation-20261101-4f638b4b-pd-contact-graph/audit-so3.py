"""Independently check persisted SO3 packet bytes, replay guards, public-state correspondence, and fixed C8."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report
from reconstruction.csrc.graph_definition_compare import linear_order


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


capture, replay = BASE / 'so3-captures', BASE / 'so3-replays'
plan = json.loads((replay / 'plan.json').read_text())
report = json.loads((replay / 'report.json').read_text())
assert report['complete'] and report['actual_calls'] == 5760
assert len(plan['packets']) == len(report['packets']) == 960
hashes = dict(plan['input_sha256'])
hashes[str(replay / 'report.json')] = sha(replay / 'report.json')
calls, output_bytes, guarded_bytes, last_q_checks = 0, 0, 0, 0
for entry, row in zip(plan['packets'], report['packets']):
    assert all(entry[key] == row[key] for key in ('worker', 'graph', 'stage', 'frame', 'path'))
    path, actual_path = Path(entry['path']), replay / 'packets' / row['replay_packet']
    hashes[str(actual_path)] = sha(actual_path)
    with np.load(path) as packet, np.load(actual_path) as actual:
        values = [int.from_bytes(bytes.fromhex(v), 'little') for v in entry['node']['parameter_hex']]
        assert len(row['checks']) == 6
        for i in range(4):
            new = int.from_bytes(actual['actual-parameter-' + str(i)].tobytes(), 'little')
            assert new == row['replay_pointers'][str(i)]
            assert new % 256 == values[i] % 256
            assert new - row['allocated_device_bases'][str(i)] == row['padding'][str(i)]
            for j in range(i):
                assert min(values[i] + entry['sizes'][str(i)], values[j] + entry['sizes'][str(j)]) <= max(
                    values[i], values[j])
        for i in range(4, len(values)):
            assert actual['actual-parameter-' + str(i)].tobytes() == bytes.fromhex(entry['node']['parameter_hex'][i])
        for trial in range(2):
            for backend in ('original-runtime', 'original-ptx', 'source-ptx'):
                tag = backend + '-trial-' + str(trial)
                for i in range(4):
                    prefix = 256 + values[i] % 256
                    size = entry['sizes'][str(i)]
                    initial = np.full(prefix + size + 256, 211, dtype='u1')
                    initial[prefix:prefix + size] = packet['before-arg-' + str(i)]
                    after = actual[tag + '-buffer-' + str(i)]
                    assert after.dtype == np.dtype('u1') and after.shape == initial.shape
                    mask = np.ones(len(initial), dtype=bool)
                    if i in (2, 3):
                        mask[prefix:prefix + size] = False
                        expected = packet['after-arg-' + str(i)].tobytes()
                        assert actual[tag + '-output-' + str(i)].tobytes() == expected
                        assert after[prefix:prefix + size].tobytes() == expected
                        output_bytes += size
                    assert after[mask].tobytes() == initial[mask].tobytes()
                    guarded_bytes += int(mask.sum())
                calls += 1
        if entry['stage'] == 'update-3':
            side = 'original' if entry['worker'] == 0 else 'source'
            public_path = capture / str(entry['worker']) / (side + '-w3-b1-n2-s1-mixed-pd-b0-both-hit0-1.npz')
            hashes[str(public_path)] = sha(public_path)
            with np.load(public_path) as public:
                assert packet['before-arg-0'].tobytes() == public['particle_q'][entry['frame']].tobytes()
            last_q_checks += 1
assert calls == 5760 and last_q_checks == 240
for worker in range(4):
    for graph in range(2):
        folder = capture / str(worker) / ('so3-graph-' + str(graph))
        before = json.loads((folder / 'definition-before/graph.json').read_text())
        after = json.loads((folder / 'graph-after-topology.json').read_text())
        layout = json.loads((folder / 'snapshot-layout.json').read_text())
        order = linear_order(before)[0]
        positions = {node['handle']: i for i, node in enumerate(linear_order(after)[0])}
        assert len(before['nodes']) == 276 and len(after['nodes']) == 300
        assert len(before['edges']) == 275 and len(after['edges']) == 307
        assert set(map(tuple, before['edges'])) <= set(map(tuple, after['edges']))
        for stage in layout['stages']:
            previous, target, following = (order[stage['rank'] + d]['handle'] for d in (-1, 0, 1))
            for snapshot in layout['snapshots']:
                if snapshot['stage'] != stage['key']:
                    continue
                assert positions[previous] < positions[snapshot['node']] < positions[target] if (
                    snapshot['phase'] == 'before') else positions[target] < positions[snapshot['node']] < positions[following]
old = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
cohort = old / 'graph-fixed-C8/cohorts/w3-b1-n2-s1-mixed-pd-b0-both-hit0-g1'
statistics = []
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(cohort / f'original{i}.npz')) for i in range(8)]
    hashes.update({str(p): sha(p) for p in cohort.glob('*.npz')})
    for worker, side in enumerate(('original', 'source', 'source', 'source')):
        path = capture / str(worker) / (side + '-w3-b1-n2-s1-mixed-pd-b0-both-hit0-1.npz')
        data = stack.enter_context(np.load(path))
        checks = spread_report(originals, [data])
        assert all(len(data[key]) == 60 and np.isfinite(data[key]).all() for key in data.files)
        statistics.append({'worker': worker, 'backend': side,
                           'within_existing_fixed_C8': all(v['substeps_within_spread'] == 60 for v in checks.values()),
                           'statistics': checks})
for path, expected in hashes.items():
    assert sha(Path(path)) == expected, path
result = {'actual_calls_independently_checked': calls, 'complete_output_bytes_checked': output_bytes,
          'unwritten_input_and_guard_bytes_checked': guarded_bytes, 'last_SO3_q_public_q_byte_checks': last_q_checks,
          'eight_graph_snapshot_orders_checked': True, 'diagnostic_trajectory_fixed_C8_checks': statistics,
          'input_sha256': hashes, 'GPU_used': False, 'fixed_C8_reclassified': False,
          'samples_added_to_cohort': False, 'production_changed': False, 'whole_solver_complete': False}
(BASE / 'so3-independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print('Independent CPU:5760 calls strict,240 public q snapshots match;C8 diagnostic membership',
      [r['within_existing_fixed_C8'] for r in statistics])
