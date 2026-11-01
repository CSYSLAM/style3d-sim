"""Check actual tangent accumulator continuity, directions, private-cache provenance and contact-buffer stability."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
capture = BASE / 'tangent-captures'
terminal = json.loads((capture / 'status.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 4
hashes, metrics = {}, {'chains': 0, 'adjacent_extra_links': 0, 'final_extra_links': 0,
                      'direction_links': 0, 'private_cache_links': 0, 'constant_contact_links': 0,
                      'public_contact_count_links': 0}
outputs = {'SO3-tangent': 'arg-5', 'grain-tangent': 'arg-2', 'authored-tangent': 'arg-5',
           'dynamic-tangent': 'arg-5', 'rigid-tangent': 'arg-30', 'soft-tangent': 'arg-25', 'rolling-tangent': 'arg-2'}
directions = {'SO3-tangent': 'arg-0', 'grain-tangent': 'arg-1', 'authored-tangent': 'arg-4',
              'dynamic-tangent': 'arg-4', 'rigid-tangent': 'arg-29', 'soft-tangent': 'arg-24', 'rolling-tangent': 'arg-1'}
for worker in range(4):
    backend = 'original' if worker == 0 else 'source'
    public_path = capture / str(worker) / (backend + '-w3-b1-n2-s1-mixed-pd-b0-both-hit0-1.npz')
    hashes[str(public_path)] = hashlib.sha256(public_path.read_bytes()).hexdigest()
    with np.load(public_path, allow_pickle=False) as public:
        for graph in range(2):
            folder = capture / str(worker) / f'tangent-graph-{graph}'
            layout_path = folder / 'snapshot-layout.json'
            hashes[str(layout_path)] = hashlib.sha256(layout_path.read_bytes()).hexdigest()
            layout = json.loads(layout_path.read_text())
            stages = {stage['rank']: stage for stage in layout['stages']}
            for frame in range(graph, 60, 2):
                path = folder / f'frames/frame-{frame:02d}.npz'
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
                with np.load(path, allow_pickle=False) as saved:
                    data = {key: saved[key].tobytes() for key in saved.files}

                def value(stage, phase, label):
                    return data[stage['key'] + '/' + phase + '/' + label]

                constants = {}
                for stage in layout['stages']:
                    kind = stage['kind']
                    if kind in ('rigid-force', 'rigid-matrix', 'rigid-tangent'):
                        constant_labels = {'arg-0', *('arg-' + str(i) for i in range(2, 19)), 'arg-23', 'arg-24', 'arg-25'}
                    elif kind.startswith('rolling-'):
                        constant_labels = {b['label'] for b in stage['bindings']
                                           if b['label'].startswith('view-') and b['offset'] < 224}
                    elif kind in ('soft-force', 'soft-matrix'):
                        constant_labels = {'arg-0', *('arg-' + str(i) for i in range(2, 10)),
                                           *('arg-' + str(i) for i in range(12, 21)), 'arg-28', 'arg-29', 'arg-30'}
                    elif kind == 'soft-tangent':
                        constant_labels = {'arg-0', *('arg-' + str(i) for i in range(2, 16)),
                                           'arg-19', 'arg-20', 'arg-21', 'arg-33', 'arg-34', 'arg-37'}
                    else:
                        continue
                    for binding in stage['bindings']:
                        label = binding['label']
                        if label not in constant_labels:
                            continue
                        key = binding['address'], binding['bytes']
                        payload = value(stage, 'before', label)
                        if key in constants:
                            assert constants[key] == payload, (worker, frame, stage['key'], label, 'Contact input changed')
                            metrics['constant_contact_links'] += 1
                        else:
                            constants[key] = payload
                for nonlinear in range(3):
                    base = nonlinear * 86
                    rhs = stages[11 + base]
                    grain = stages[15 + base]
                    force = stages[21 + base]
                    assert value(stages[18 + base], 'before', 'arg-0') == public['rigid_count'][frame].tobytes()
                    assert value(stages[20 + base], 'before', 'arg-0') == public['soft_count'][frame].tobytes()
                    metrics['public_contact_count_links'] += 2
                    for iteration in range(5):
                        start = 36 + base + iteration * 12
                        chain = [stages[rank] for rank in range(start, start + 7)]
                        assert [stage['kind'] for stage in chain] == list(outputs)
                        direction = value(stages[start - 2], 'after', 'arg-6')
                        assert not any(value(chain[0], 'before', outputs[chain[0]['kind']]))
                        for index, stage in enumerate(chain):
                            assert value(stage, 'before', directions[stage['kind']]) == direction
                            metrics['direction_links'] += 1
                            if index:
                                previous = chain[index - 1]
                                assert value(previous, 'after', outputs[previous['kind']]) == value(
                                    stage, 'before', outputs[stage['kind']])
                                metrics['adjacent_extra_links'] += 1
                            if stage['kind'] == 'grain-tangent':
                                for off in range(0, 64, 8):
                                    label = 'view-' + str(off)
                                    assert value(stage, 'before', label) == value(grain, 'before', label)
                                    metrics['private_cache_links'] += 1
                                for off, label in ((64, 'arg-3'), (72, 'arg-4'), (80, 'arg-5')):
                                    assert value(stage, 'before', 'view-' + str(off)) == value(grain, 'after', label)
                                    metrics['private_cache_links'] += 1
                            if stage['kind'] in ('authored-tangent', 'dynamic-tangent'):
                                bond = stages[(16 if stage['kind'] == 'authored-tangent' else 17) + base]
                                for a, b, phase in (('arg-0', 'arg-4', 'before'), ('arg-1', 'arg-7', 'before'),
                                                    ('arg-2', 'arg-12', 'after')):
                                    assert value(stage, 'before', a) == value(bond, phase, b)
                                    metrics['private_cache_links'] += 1
                            if stage['kind'] == 'SO3-tangent':
                                for label in ('arg-1', 'arg-2', 'arg-3'):
                                    assert value(stage, 'before', label) == value(force, 'before', label)
                                    metrics['private_cache_links'] += 1
                            q_label = {'rigid-tangent': 'arg-27', 'soft-tangent': 'arg-23',
                                       'rolling-tangent': 'view-224'}.get(stage['kind'])
                            if q_label:
                                assert value(stage, 'before', q_label) == value(rhs, 'before', 'arg-1')
                        assert value(chain[-1], 'after', 'arg-2') == value(stages[start + 7], 'before', 'arg-5')
                        metrics['final_extra_links'] += 1
                        metrics['chains'] += 1
assert metrics['chains'] == 3600 and metrics['adjacent_extra_links'] == 21600
assert metrics['final_extra_links'] == 3600 and metrics['direction_links'] == 25200
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
record = {'metrics': metrics, 'input_sha256': hashes, 'GPU_used': False,
          'constant_comparison_includes_raw_unused_tails_but_does_not_interpret_them': True,
          'private_caches_not_reconstructed_from_public_state': True, 'whole_solver_complete': False}
(BASE / 'extra-flow-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU tangent/extra flow checks:', metrics)
