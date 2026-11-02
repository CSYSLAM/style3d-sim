"""Prepare all actual cloth primitives against each endpoint's original RHS seed; no GPU execution."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'cloth-native-inputs'
folder.mkdir(exist_ok=False)
report = json.loads((BASE / 'producer-operands-report.json').read_text())
assert report['complete'] and report['actual_probe_calls'] == 8
audit = json.loads((BASE / 'producer-operands-independent-cpu.json').read_text())
assert audit['all_packet_PTX_operands_equal']
cases, hashes = [], {}
for case in report['rows']:
    tag = case['label'] + '-' + case['stage']
    destination = folder / tag
    destination.mkdir(exist_ok=False)
    count = 66930 if case['stage'] == 'stretch' else 100634
    output_arg = 5 if case['stage'] == 'stretch' else 7
    packet_path, trace_path = Path(case['packet']), Path(case['probes'][0]['file'])
    for path in (packet_path, trace_path):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(packet_path, allow_pickle=False) as packet:
        seed = packet[f'before-arg-{output_arg}'].view('u4').copy()
    with np.load(trace_path, allow_pickle=False) as packet:
        counts = packet['counts'][:count].copy()
        assert not packet['counts'][count:].any() and counts.max() <= 12
        trace = packet['raw-trace'][:count, :12].copy()
    if case['stage'] == 'stretch':
        assert np.all(counts == 9)
    else:
        assert np.all((counts == 0) | (counts == 12))
    used = np.arange(12)[None, :] < counts[:, None]
    addresses = trace.view('<u8').reshape(count, 12, 2)[:, :, 0]
    operands = trace.view('<u4').reshape(count, 12, 4)[:, :, 2].copy()
    span = case['outputs'][str(output_arg)]
    assert np.all((addresses[used] >= span['address']) & (addresses[used] < span['address'] + span['bytes']))
    assert np.all((addresses[used] - span['address']) % 4 == 0)
    targets = np.zeros((count, 12), dtype='u4')
    targets[used] = (addresses[used] - span['address']) // 4
    masked = targets.astype('u8')
    masked[~used] = np.uint64(2**63) + np.broadcast_to(np.arange(12), masked.shape)[~used]
    assert np.all(np.diff(np.sort(masked, axis=1), axis=1) != 0)
    before = np.zeros((count, 12), dtype='u4')
    before[used] = seed[targets[used]]
    left, right = before.copy(), operands.copy()
    assert not operands[~used].any()
    assert np.all((left & 0x7f800000) != 0x7f800000) and np.all((right & 0x7f800000) != 0x7f800000)
    left[left & 0x7f800000 == 0] &= 0x80000000
    right[right & 0x7f800000 == 0] &= 0x80000000
    after = np.add(left.view('f4'), right.view('f4'), dtype='f4').view('u4')
    after[after & 0x7f800000 == 0] &= 0x80000000
    after[~used] = 0
    chunks = []
    for start in range(0, count, 4096):
        stop = min(count, start + 4096)
        path = destination / f'primitives-{start:06d}-{stop:06d}.npz'
        np.savez_compressed(path, counts=counts[start:stop], targets=targets[start:stop],
                            operands=operands[start:stop], before=before[start:stop], after=after[start:stop])
        chunks.append({'start': start, 'stop': stop, 'file': str(path),
                       'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
    cases.append({'tag': tag, 'stage': case['stage'], 'label': case['label'], 'count': count,
                  'output_arg': output_arg, 'packet': str(packet_path), 'trace': str(trace_path),
                  'atomic_records': int(counts.sum()), 'chunks': chunks})
for path in (Path(__file__), BASE / 'producer-operands-report.json', BASE / 'producer-operands-independent-cpu.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(folder / 'plan.json').write_text(json.dumps({'cases': cases, 'input_sha256': hashes,
    'planned_actual_SDK_PTX_source_calls': 1005384, 'both_endpoint_RHS_seeds_preserved': True,
    'all_primitive_targets_within_each_thread_distinct': True, 'whole_solver_complete': False}, indent=2) + '\n')
print('Four actual cloth seed cases prepared:', [(row['tag'], row['count'], row['atomic_records']) for row in cases])
