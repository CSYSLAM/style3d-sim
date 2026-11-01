"""Audit actual prefix graphs and common inputs, preserving any force difference and the old frozen failure."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_first_rhs import rendered_transport
from reconstruction.csrc.graph_definition_compare import linear_order

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and [r['label'] for r in status['completed'][:2]] == ['sdk0', 'rebuilt0']
namespace = {'__name__': 'reconstruction.csrc.first_rhs_cpu_audit',
             '__package__': 'reconstruction.csrc', '__file__': str(BASE / 'transport-template.py')}
exec(compile(rendered_transport(), namespace['__file__'], 'exec'), namespace)
data, hashes, control_base, config_base = {}, {}, None, None
with np.load(plan['input_checkpoint'], allow_pickle=False) as saved:
    checkpoint = {k: saved[k][30].tobytes() for k in ('body_q', 'body_qd', 'particle_q', 'particle_qd')}
for run in plan['runs']:
    folder = BASE / run['label']
    runtime = json.loads((folder / 'worker/runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['public_core_abi'] and runtime['real_graph_observed']
    assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (run['backend'] == 'original')
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                if run['backend'] == 'original' else '7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53')
    assert runtime['image_sha256'] == expected
    injection = json.loads((folder / 'injection.json').read_text())
    assert injection['graph_counts_before'] == injection['graph_counts_after'] == [17467, 17466]
    if config_base is None:
        config_base = injection['config']
    assert config_base == injection['config']
    with np.load(folder / 'before.npz', allow_pickle=False) as before:
        for state in ('state0', 'state1'):
            assert all(before[state + '-' + k].tobytes() == v for k, v in checkpoint.items())
        assert not before['feedback-angle-flags'].any()
    with np.load(folder / 'control-before.npz', allow_pickle=False) as control:
        raw = {k: (control[k].dtype.str, control[k].shape, control[k].tobytes()) for k in control.files}
        if control_base is None:
            control_base = raw
        assert raw == control_base
    trace = folder / 'trace'
    graph = json.loads((trace / 'definition-before/graph.json').read_text())
    nodes = linear_order(graph)[0]
    stages = namespace['select_stages'](nodes, 44, 49)
    layout = json.loads((trace / 'snapshot-layout.json').read_text())
    assert layout['stages'] == json.loads(json.dumps(stages)) and len(layout['snapshots']) == 50
    topology = json.loads((trace / 'graph-after-topology.json').read_text())
    positions = {n['handle']: i for i, n in enumerate(linear_order(topology)[0])}
    assert len(positions) == 17517 and len(topology['edges']) == 17522
    assert set(map(tuple, graph['edges'])) <= set(map(tuple, topology['edges']))
    offset = 0
    for copy in layout['snapshots']:
        stage = next(s for s in stages if s['key'] == copy['stage'])
        i, rank = copy['argument'], stage['rank']
        assert copy['source'] == int.from_bytes(bytes.fromhex(stage['node']['parameter_hex'][i]), 'little')
        assert copy['offset'] == offset and copy['bytes'] == stage['sizes'][i]
        assert positions[nodes[rank - 1]['handle']] < positions[copy['node']] < positions[stage['node']['handle']] \
            if copy['phase'] == 'before' else \
            positions[stage['node']['handle']] < positions[copy['node']] < positions[nodes[rank + 1]['handle']]
        offset += copy['bytes']
    assert offset == layout['total_snapshot_bytes'] == 70772
    packets = {}
    for stage in stages:
        path = trace / (stage['key'] + '-packets/frame-00.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as saved:
            packet = {k: saved[k].copy() for k in saved.files}
        for i, raw in enumerate(stage['node']['parameter_hex']):
            assert packet['parameter-' + str(i)].tobytes().hex() == raw
        packets[stage['key']] = packet
    assert not packets['joint']['before-arg-8'].view('<f4').any()
    assert packets['joint']['after-arg-10'].tobytes() == packets['drive']['before-arg-26'].tobytes()
    data[run['label']] = packets
differences = {}
for kind, output in [('rhs', 9), ('joint', 10), ('drive', 26)]:
    left, right = data['sdk0'][kind], data['rebuilt0'][kind]
    differences[kind] = {}
    for prefix in ('before', 'after'):
        a, b = left[prefix + '-arg-' + str(output)], right[prefix + '-arg-' + str(output)]
        words = np.flatnonzero(a.view('<u4') != b.view('<u4'))
        differences[kind][prefix] = {'different_words': len(words), 'indices': words.tolist(),
                                     'max_abs_error': float(np.abs(a.view('<f4').astype('f8') - b.view('<f4')).max())}
    indices = [int(k.removeprefix('before-arg-')) for k in left if k.startswith('before-arg-')]
    differences[kind]['all_non_output_pointer_inputs_bitwise_equal'] = all(
        left['before-arg-' + str(i)].tobytes() == right['before-arg-' + str(i)].tobytes()
        for i in indices if i not in ({3, 4, 26} if kind == 'drive' else {output}))
previous = BASE.with_name('continuation-20261101-38b70dcd-g1-checkpoint-substeps')
reproduced = {}
for label in data:
    with np.load(previous / label / 'trace/drive0-packets/frame-00.npz', allow_pickle=False) as old:
        reproduced[label] = old['before-arg-26'].tobytes() == data[label]['drive']['before-arg-26'].tobytes()
result = {'force_boundaries': differences, 'old_first_force_before_bitwise_reproduced': reproduced,
          'input_sha256': hashes, 'joint_initial_multiplier_all_positive_or_negative_zero': True,
          'original_velocity_helper_bug_retained': True, 'new_numeric_C_cohort_created': False,
          'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({'force_boundaries': differences, 'old_first_force_reproduced': reproduced}, indent=2))
