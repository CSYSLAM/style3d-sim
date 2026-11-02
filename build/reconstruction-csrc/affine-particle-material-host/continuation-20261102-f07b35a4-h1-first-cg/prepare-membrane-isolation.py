"""Prepare all real triangle operands and prove which endpoint seed differences they can touch; CPU only."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
output = BASE / 'membrane-isolation-inputs'
output.mkdir(exist_ok=False)
report = json.loads((BASE / 'producer-operands-report.json').read_text())
cases = [next(row for row in report['rows'] if row['label'] == label and row['stage'] == 'membrane')
         for label in ('sdk0', 'rebuilt0')]
hashes = {}
packets = []
for case in cases:
    path = Path(case['packet'])
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(path, allow_pickle=False) as packet:
        packets.append({key: packet[key].copy() for key in packet.files})
for i in (0, 1, 2, 3, 4, 6):
    assert np.array_equal(packets[0][f'before-arg-{i}'], packets[1][f'before-arg-{i}'])
for i in range(8, 13):
    assert np.array_equal(packets[0][f'parameter-{i}'], packets[1][f'parameter-{i}'])
probe_path = Path(cases[0]['probes'][0]['file'])
hashes[str(probe_path)] = hashlib.sha256(probe_path.read_bytes()).hexdigest()
with np.load(probe_path, allow_pickle=False) as packet:
    assert np.all(packet['counts'][:66930] == 81) and not packet['counts'][66930:].any()
    trace = packet['raw-trace'][:66930, :81].copy()
addresses = trace.view('<u8').reshape(66930, 81, 2)[:, :, 0]
values = trace.view('<u4').reshape(66930, 81, 4)[:, :, 2].copy()
assert np.all(np.diff(np.sort(addresses, axis=1), axis=1) != 0)
targets = np.zeros(addresses.shape, dtype='u8')
before = np.zeros(addresses.shape, dtype='u4')
matched = np.zeros(addresses.shape, dtype=bool)
seed_differences = {}
for i in (5, 7):
    span = cases[0]['outputs'][str(i)]
    mask = (addresses >= span['address']) & (addresses < span['address'] + span['bytes'])
    assert np.all((addresses[mask] - span['address']) % 4 == 0)
    words = (addresses[mask] - span['address']) // 4
    targets[mask] = (np.uint64(i) << np.uint64(32)) | words
    seeds = [packet[f'before-arg-{i}'].view('u4') for packet in packets]
    before[mask] = seeds[0][words]
    assert np.array_equal(seeds[0][words], seeds[1][words])
    changed = np.flatnonzero(seeds[0] != seeds[1])
    assert not len(np.intersect1d(changed, words))
    seed_differences[str(i)] = {'words': changed.tolist(), 'intersect_actual_triangle_targets': False}
    matched |= mask
assert matched.all()
left, right = before.copy(), values.copy()
assert np.all((left & 0x7f800000) != 0x7f800000)
assert np.all((right & 0x7f800000) != 0x7f800000)
left[left & 0x7f800000 == 0] &= 0x80000000
right[right & 0x7f800000 == 0] &= 0x80000000
after = np.add(left.view('f4'), right.view('f4'), dtype='f4').view('u4')
after[after & 0x7f800000 == 0] &= 0x80000000
assert np.all((after & 0x7f800000) != 0x7f800000)
chunks = []
for start in range(0, 66930, 4096):
    stop = min(66930, start + 4096)
    path = output / f'triangles-{start:05d}-{stop:05d}.npz'
    np.savez_compressed(path, targets=targets[start:stop], operands=values[start:stop],
                        before=before[start:stop], after=after[start:stop])
    chunks.append({'start': start, 'stop': stop, 'file': str(path),
                   'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'triangles': 66930, 'records': 5421330, 'chunks': chunks,
    'input_sha256': hashes, 'SDK_packet': cases[0]['packet'], 'source_packet': cases[1]['packet'],
    'seed_differences': seed_differences, 'every_triangle_has_81_distinct_targets': True,
    'all_non_output_input_spans_and_scalar_parameters_equal': True,
    'all_touched_output_initial_words_equal_across_endpoints': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('All66930 actual triangle inputs, 5421330 operands, distinct targets and untouched endpoint seed differences guarded')
