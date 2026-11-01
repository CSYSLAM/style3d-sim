"""Audit actual memcpy descriptors and scalar traces; derive every recorded alpha and nonfirst beta input pair."""
from collections import Counter
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_cg_scalar_trace import select_events
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import Copy3D

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and len(status['completed']) == 11
rows, hashes, counts = [], {}, Counter()
pairs = {name: [] for name in ('alpha_num', 'alpha_den', 'beta_num', 'beta_den')}
for run in plan['runs']:
    folder = BASE / run['label'] / 'trace'
    graph = json.loads((folder / 'definition-before/graph.json').read_text())
    nodes = linear_order(graph)[0]
    events = select_events(nodes)
    layout = json.loads((folder / 'layout.json').read_text())
    assert events == layout['events'] and layout['bytes'] == 68176
    topology = json.loads((folder / 'graph-after-topology.json').read_text())
    order = linear_order(topology)[0]
    assert len(order) == 17999 and len(topology['edges']) == 18264
    assert set(map(tuple, graph['edges'])) <= set(map(tuple, topology['edges']))
    positions = {node['handle']: i for i, node in enumerate(order)}
    path = folder / 'observations-0.npz'
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(path, allow_pickle=False) as saved:
        blob = saved['blob'].copy()
    assert blob.dtype == np.dtype('u1') and blob.shape == (68176,)
    watches, offset = {}, 0
    edges = set(map(tuple, topology['edges']))
    for row in layout['snapshots']:
        rank = row['rank']
        assert row['offset'] == offset and row['label'] not in watches
        expected_source = int.from_bytes(bytes.fromhex(nodes[row['source_rank']]['parameter_hex'][row['parameter']]), 'little')
        assert row['source'] == expected_source
        actual = Copy3D.from_buffer_copy(bytes.fromhex(row['actual_copy_parameters_hex']))
        assert actual.srcMemoryType == actual.dstMemoryType == 2
        assert actual.srcDevice == expected_source and actual.dstDevice == layout['device_base'] + offset
        assert (actual.WidthInBytes, actual.Height, actual.Depth) == (row['bytes'], 1, 1)
        assert (row['predecessor'], row['handle']) in edges
        assert positions[nodes[rank - 1]['handle']] < positions[row['handle']] < positions[nodes[rank]['handle']] \
            if row['phase'] == 'before' else \
            positions[nodes[rank]['handle']] < positions[row['handle']] < positions[nodes[rank + 1]['handle']]
        watches[row['label']] = blob[offset:offset + row['bytes']].copy()
        offset += row['bytes']
        counts['actual_memcpy_descriptor_bytes'] += ct.sizeof(Copy3D)
    assert offset == len(blob) and len(watches) == 532
    ids = watches['model-body-indices'].view('<i4').reshape(44, 4)
    assert sorted(ids.reshape(-1).tolist()) == list(range(176)) and ids[12].tolist() == [48, 49, 50, 51]
    numbers = np.asarray([[int(watches['cg-' + str(nl) + '-' + str(k) + '-numerator'].view('<u4')[0])
                           for k in range(50)] for nl in range(5)], dtype='<u4')
    denominators = np.asarray([[int(watches['cg-' + str(nl) + '-' + str(k) + '-denominator'].view('<u4')[0])
                                for k in range(50)] for nl in range(5)], dtype='<u4')
    pairs['alpha_num'].append(numbers.reshape(-1))
    pairs['alpha_den'].append(denominators.reshape(-1))
    pairs['beta_num'].append(numbers[:, 1:].reshape(-1))
    pairs['beta_den'].append(numbers[:, :-1].reshape(-1))
    nonlinear = []
    for nl in range(5):
        x = watches['apply-' + str(nl) + '-before-0'].view('<f4').reshape(176, 3)
        delta = watches['apply-' + str(nl) + '-before-2'].view('<f4').reshape(176, 3)
        actual = watches['apply-' + str(nl) + '-after-1'].view('<f4').reshape(176, 3)
        predicted = np.add(x, delta, dtype='<f4')
        assert actual.tobytes() == predicted.tobytes()
        assert not watches['apply-' + str(nl) + '-after-2'].view('<u4').any()
        num, den = numbers[nl].view('<f4'), denominators[nl].view('<f4')
        valid = (np.abs(den) > np.float32(1e-30)) & ~np.isnan(num) & ~np.isnan(den)
        alpha = np.zeros(50, dtype='<f4')
        with np.errstate(all='ignore'):
            alpha[valid] = num[valid] / den[valid]
        nonlinear.append({'nonlinear': nl, 'negative_denominators': int(np.count_nonzero(den < 0)),
                          'guarded_alpha_iterations': np.flatnonzero(~valid).tolist(),
                          'maximum_abs_CPU_alpha': float(np.nanmax(np.abs(alpha))),
                          'largest_alpha_iteration': int(np.nanargmax(np.abs(alpha))),
                          'max_abs_body12_delta': float(np.abs(delta[ids[12]]).max()),
                          'body12_after_positions': actual[ids[12]].tolist()})
        counts['actual_apply_outputs_checked'] += 2
        counts['actual_apply_output_words_checked'] += 1056
    velocities = [float(np.abs(watches['velocity-' + str(k)].view('<f4').reshape(176, 3)[ids[12]]).max())
                  for k in range(6)]
    with np.load(BASE / run['label'] / 'recorded-states.npz', allow_pickle=False) as public:
        assert watches['velocity-5'].tobytes() == public['particle_qd'][0].tobytes()
        final = float(public['body_qd'][0].reshape(-1)[76])
    rows.append({'label': run['label'], 'nonlinear': nonlinear,
                 'body12_proxy_velocity_maxima_by_substep': velocities, 'final_body12_component4': final})
    counts['captured_alpha_pairs'] += 250
    counts['captured_beta_pairs'] += 245
    counts['blob_bytes_checked'] += len(blob)
    print(run['label'], 'fourth-substep max alpha', [round(n['maximum_abs_CPU_alpha'], 6) for n in nonlinear],
          'body12 delta', [round(n['max_abs_body12_delta'], 6) for n in nonlinear], 'final component', final, flush=True)
output = BASE / 'trace-independent-cpu-audit.json'
assert not output.exists() and not (BASE / 'coefficients.npz').exists()
np.savez_compressed(BASE / 'coefficients.npz', **{name: np.concatenate(values) for name, values in pairs.items()})
output.write_text(json.dumps({'counts': dict(counts), 'runs': rows, 'input_sha256': hashes,
                              'partial_scalar_capture_not_full_actual_CG_vector_replay': True,
                              'CPU_division_is_descriptive_until_controlled_GPU_check': True,
                              'production_changed': False, 'old_C8_reclassified': False,
                              'whole_solver_complete': False}, indent=2) + '\n')
