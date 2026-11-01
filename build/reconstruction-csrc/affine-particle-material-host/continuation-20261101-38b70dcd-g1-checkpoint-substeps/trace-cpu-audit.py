"""Audit all graph copies and actual first-use drive states; locate response growth across the six substeps."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_checkpoint_substeps import rendered_transport
from reconstruction.csrc.graph_definition_compare import linear_order

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
namespace = {'__name__': 'reconstruction.csrc.substep_transport_audit',
             '__package__': 'reconstruction.csrc', '__file__': str(BASE / 'transport-template.py')}
exec(compile(rendered_transport(), namespace['__file__'], 'exec'), namespace)
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and len(status['completed']) == 11
counts, rows, hashes = Counter(), [], {}
for run in plan['runs']:
    folder = BASE / run['label'] / 'trace'
    definition = json.loads((folder / 'definition-before/graph.json').read_text())
    nodes, original_edges = linear_order(definition)
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    stages = namespace['select_stages'](nodes, 44, 49)
    assert layout['stages'] == json.loads(json.dumps(stages))
    topology = json.loads((folder / 'graph-after-topology.json').read_text())
    ordered = linear_order(topology)[0]
    positions = {row['handle']: i for i, row in enumerate(ordered)}
    assert len(ordered) == 17767 and len(topology['edges']) == 17802
    assert set(map(tuple, definition['edges'])) <= set(map(tuple, topology['edges']))
    assert len(layout['snapshots']) == 300 and layout['graph_nodes_added'] == 300
    offset = 0
    for copy in layout['snapshots']:
        stage = next(stage for stage in stages if stage['key'] == copy['stage'])
        arg, rank = copy['argument'], stage['rank']
        assert copy['source'] == int.from_bytes(bytes.fromhex(stage['node']['parameter_hex'][arg]), 'little')
        assert copy['bytes'] == stage['sizes'][arg] and copy['offset'] == offset
        assert positions[nodes[rank - 1]['handle']] < positions[copy['node']] < positions[stage['node']['handle']] \
            if copy['phase'] == 'before' else \
            positions[stage['node']['handle']] < positions[copy['node']] < positions[nodes[rank + 1]['handle']]
        offset += copy['bytes']
    assert offset == layout['total_snapshot_bytes']
    counts['snapshot_bytes'] += offset
    counts['snapshot_nodes'] += 300
    previous_angle, previous_flag, substeps = None, None, []
    for step in range(6):
        packets = {}
        for kind in ('drive', 'velocity', 'angle'):
            stage = next(stage for stage in stages if stage['key'] == kind + str(step))
            path = folder / (stage['key'] + '-packets/frame-00.npz')
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
            with np.load(path, allow_pickle=False) as saved:
                packet = {key: saved[key].copy() for key in saved.files}
            packets[kind] = packet
            for i, raw in enumerate(stage['node']['parameter_hex']):
                assert packet['parameter-' + str(i)].tobytes().hex() == raw
                counts['captured_ABI_bytes'] += len(bytes.fromhex(raw))
            for i, size in stage['sizes'].items():
                assert packet['before-arg-' + str(i)].shape == (size,)
            for i in stage['outputs']:
                assert packet['after-arg-' + str(i)].shape == (stage['sizes'][i],)
            counts['captured_calls'] += 1
        drive, velocity, angle = (packets[kind] for kind in ('drive', 'velocity', 'angle'))
        before_flags = drive['before-arg-4'].view('<i4')
        assert np.all(before_flags == int(step != 0))
        assert np.all(drive['after-arg-4'].view('<i4') == 1)
        assert np.all(drive['before-arg-6'].view('<i4') == 1)
        assert drive['after-arg-3'].tobytes() == angle['before-arg-1'].tobytes()
        assert drive['after-arg-4'].tobytes() == angle['before-arg-2'].tobytes()
        if previous_angle is not None:
            assert drive['before-arg-3'].tobytes() == previous_angle
            assert drive['before-arg-4'].tobytes() == previous_flag
        previous_angle, previous_flag = angle['after-arg-1'].tobytes(), angle['after-arg-2'].tobytes()
        assert velocity['before-arg-2'].tobytes() == angle['before-arg-0'].tobytes()
        pqd = velocity['after-arg-3'].view('<f4').reshape(176, 3)
        ids = angle['before-arg-3'].view('<i4').reshape(44, 4)[12]
        assert np.isfinite(pqd).all()
        delta = angle['after-arg-1'].view('<f4').astype('f8') - angle['before-arg-1'].view('<f4')
        largest = int(np.abs(delta).argmax())
        substeps.append({'substep': step, 'first_use_drives': int(np.count_nonzero(before_flags == 0)),
                         'max_abs_particle_qd': float(np.abs(pqd).max()),
                         'body12_proxy_particle_ids': ids.tolist(), 'body12_proxy_velocities': pqd[ids].tolist(),
                         'max_abs_body12_proxy_qd': float(np.abs(pqd[ids]).max()),
                         'largest_angle_change_drive': largest, 'largest_angle_change': float(delta[largest]),
                         'angle_after': angle['after-arg-1'].view('<f4').tolist()})
    with np.load(BASE / run['label'] / 'recorded-states.npz', allow_pickle=False) as public:
        assert velocity['after-arg-3'].tobytes() == public['particle_qd'][0].tobytes()
        assert angle['before-arg-0'].tobytes() == public['particle_q'][0].tobytes()
        component = float(public['body_qd'][0].reshape(-1)[76])
    rows.append({'label': run['label'], 'backend': run['backend'], 'substeps': substeps,
                 'final_body12_component4': component})
    print(run['label'], 'body12 component4', component,
          'proxy speed maxima', [round(row['max_abs_body12_proxy_qd'], 6) for row in substeps], flush=True)
result = {'counts': dict(counts), 'runs': rows, 'input_sha256': hashes,
          'all_actual_first_use_flags_and_state_chains_rechecked': True,
          'original_nodes_and_edges_and_unique_order_rechecked': True,
          'old_internal_cache_not_restored': True, 'original_velocity_helper_bug_retained': True,
          'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False}
output = BASE / 'trace-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
