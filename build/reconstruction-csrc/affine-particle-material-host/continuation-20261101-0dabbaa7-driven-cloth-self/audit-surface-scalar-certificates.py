"""Independently audit every saved GPU scalar, history, same-target thread order, actual ABI and protected byte."""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--certificates', type=Path, default=BASE / 'surface-scalar-certificates-isolated')
args = parser.parse_args()
folder = args.certificates.resolve()
plan = json.loads((folder / 'plan.json').read_text())
report_path = folder / 'report.json'
report = json.loads(report_path.read_text())
assert report['complete'] and report['error'] is None
assert report['actual_calls'] == report['expected_calls'] == plan['expected_GPU_calls'] == 593
hashes = dict(plan['input_sha256'])
for path in (Path(__file__), folder / 'plan.json', report_path, folder / 'serial-atomic.ptx'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
metrics = {'actual_GPU_calls': 0, 'untouched_scalar_certificates': 0, 'covered_origin_scalars': 0,
           'history_words': 0, 'base_parameter_bytes': 0, 'protected_bytes': 0, 'per_target_thread_edges': 0}
for packet, actual in zip(plan['packets'], report['packets']):
    origin = Path(packet['folder'])
    assert actual['packet'] == packet['folder']
    raw = json.loads((origin / 'atomic-operands.json').read_text())
    assert raw['original']['thread_operands'] == raw['source']['thread_operands']
    terms = [[] for _ in range(144)]
    for lane, operations in enumerate(raw['original']['thread_operands']):
        for ordinal, (target, bits) in enumerate(operations):
            terms[target].append([lane, ordinal, bits])
    with np.load(origin / 'outputs.npz', allow_pickle=False) as data:
        before = data['before'].copy()
        vectors = {'captured': data['captured_after'].view('<u4').copy(),
                   **{name: data[name + '-aggregate'].view('<u4').copy() for name in
                      ('original-runtime', 'original-ptx', 'source-ptx')}}
    expected_origins = {name: set() for name in vectors}
    path = Path(actual['output'])
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert hashes[str(path)] == actual['output_sha256']
    checks = {row['index']: row for row in actual['actual_GPU_checks']}
    maximum = max(len(c['terms']) for c in packet['certificates'])
    with np.load(path, allow_pickle=False) as data:
        for index, certificate in enumerate(packet['certificates']):
            scalar, word = certificate['scalar'], certificate['target_bits']
            for name in certificate['origins']:
                assert int(vectors[name][scalar]) == word and scalar not in expected_origins[name]
                expected_origins[name].add(scalar)
                metrics['covered_origin_scalars'] += 1
            if certificate['untouched']:
                assert not terms[scalar] and not certificate['terms'] and int(before.view('<u4')[scalar]) == word
                metrics['untouched_scalar_certificates'] += 1
                continue
            assert terms[scalar] == certificate['terms']
            n, order = len(terms[scalar]), certificate['order']
            assert sorted(order) == list(range(n))
            values = np.asarray([row[2] for row in terms[scalar]], dtype='<u4')
            by_lane = {}
            for position, term_index in enumerate(order):
                lane, ordinal, _ = terms[scalar][term_index]
                by_lane.setdefault(lane, []).append((position, ordinal))
            for chain in by_lane.values():
                assert [o for _, o in chain] == sorted(o for _, o in chain)
                metrics['per_target_thread_edges'] += len(chain) - 1
            total, history = before[scalar], []
            assert int(total.view('<u4')) == certificate['before_bits']
            for term_index in order:
                history.append(total)
                total = np.float32(total + values.view('<f4')[term_index])
            assert int(total.view('<u4')) == word
            assert np.asarray(history, dtype='<f4').view('<u4').tolist() == certificate['CPU_history_bits']
            tag = f'certificate-{index:03d}'
            lengths = [maximum * 4 + 512, maximum * 4 + 512, 516, maximum * 4 + 512]
            initial = [np.full(size, 211, dtype='u1') for size in lengths]
            initial[0][256:256 + n * 4] = values.view('u1')
            initial[1][256:256 + n * 4] = np.asarray(order, dtype='<u4').view('u1')
            initial[2][256:260] = np.asarray([certificate['before_bits']], dtype='<u4').view('u1')
            after = [data[tag + '-buffer-' + str(i)] for i in range(4)]
            assert after[0].tobytes() == initial[0].tobytes() and after[1].tobytes() == initial[1].tobytes()
            assert int(after[2][256:260].copy().view('<u4')[0]) == word
            assert after[3][256:256 + n * 4].tobytes() == np.asarray(history, dtype='<f4').tobytes()
            for i, end in ((2, 260), (3, 256 + n * 4)):
                assert after[i][:256].tobytes() == initial[i][:256].tobytes()
                assert after[i][end:].tobytes() == initial[i][end:].tobytes()
                metrics['protected_bytes'] += 256 + len(after[i]) - end
            metrics['protected_bytes'] += len(after[0]) + len(after[1])
            params = [data[tag + '-parameter-' + str(i)].tobytes() for i in range(5)]
            assert [len(value) for value in params] == [8, 8, 8, 8, 4]
            assert int.from_bytes(params[-1], 'little') == n
            assert len({int.from_bytes(value, 'little') for value in params[:4]}) == 4
            assert all(int.from_bytes(value, 'little') % 256 == 0 for value in params[:4])
            assert checks[index]['scalar'] == scalar and checks[index]['target_bits'] == word
            metrics['history_words'] += n
            metrics['base_parameter_bytes'] += sum(map(len, params))
            metrics['actual_GPU_calls'] += 1
    assert all(indices == set(range(144)) for indices in expected_origins.values())
assert metrics['actual_GPU_calls'] == 593 and metrics['covered_origin_scalars'] == 2304
isolated = False
if folder.name == 'surface-scalar-certificates-isolated':
    waits = json.loads((folder / 'GPU-waits.json').read_text())
    assert waits['GPU_worker_started'] and waits['waits'][-1]['compute_apps'] == ''
    hashes[str(folder / 'GPU-waits.json')] = hashlib.sha256((folder / 'GPU-waits.json').read_bytes()).hexdigest()
    isolated = True
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'metrics': metrics, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'isolated_gate_satisfied': isolated, 'cross_target_joint_global_order_proven': False,
          'first_fixed_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False}
(folder / 'independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('Independent CPU scalar evidence:', metrics, ';isolated gate', isolated)
