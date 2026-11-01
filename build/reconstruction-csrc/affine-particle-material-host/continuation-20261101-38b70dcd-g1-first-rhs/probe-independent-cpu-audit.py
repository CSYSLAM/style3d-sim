"""Recheck the complete recorded buffers, actual probe ABI and every per-thread literal operand from raw bytes."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent / 'atomic'
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.pcg_alias_replay import span_groups

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
report = json.loads((BASE / 'replay/report.json').read_text())
assert report['complete'] and report['actual_probe_calls'] == 4
counts = Counter()
for row in report['packets']:
    side = row['side']
    path = BASE / 'replay' / ('joint-' + side + '-frame-00.npz')
    assert hashlib.sha256(path.read_bytes()).hexdigest() == row['saved_sha256']
    with np.load(BASE / side / 'joint-packets/frame-00.npz', allow_pickle=False) as saved, \
            np.load(path, allow_pickle=False) as data:
        stage = json.loads((BASE / side / 'snapshot-layout.json').read_text())['stages'][0]
        raw = [saved['parameter-' + str(i)].tobytes() for i in range(15)]
        values = [int.from_bytes(v, 'little') for v in raw]
        bindings = {int(i): saved['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
        groups = span_groups(values, bindings)
        for number, (group, metadata) in enumerate(zip(groups, row['groups'], strict=True)):
            assert {k: group[k] for k in ('indices', 'start', 'end')} == {
                k: metadata[k] for k in ('indices', 'start', 'end')}
            padding = 256 + group['start'] % 256
            initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
            initial[padding:padding + len(group['initial'])] = group['initial']
            assert data['initial-group-' + str(number)].tobytes() == initial.tobytes()
            mask = np.ones(len(initial), dtype=bool)
            for i in group['indices']:
                offset = padding + values[i] - group['start']
                assert row['actual_binding_replay_addresses'][str(i)] == metadata['device_base'] + offset
                assert metadata['device_base'] % 256 == 0
                if i == 10:
                    mask[offset:offset + len(bindings[i])] = False
            for backend in ('original', 'source'):
                after = data[backend + '-group-' + str(number)]
                assert after.shape == initial.shape and np.array_equal(after[mask], initial[mask])
                if 10 in group['indices']:
                    offset = padding + values[10] - group['start']
                    assert data[backend + '-probe-output-10'].tobytes() == after[offset:offset + 2112].tobytes()
                    counts['complete_output_words'] += 528
                counts['full_after_bytes'] += after.nbytes
                counts['unwritten_input_and_guard_bytes'] += int(mask.sum())
        for backend in ('original', 'source'):
            for i, value in enumerate(raw):
                expected = (row['actual_binding_replay_addresses'][str(i)].to_bytes(8, 'little')
                            if i in bindings else value)
                assert data[backend + '-actual-parameter-' + str(i)].tobytes() == expected
                counts['actual_ABI_bytes'] += len(value)
            for i, pointer in enumerate(row['extra_parameter_addresses'], 15):
                assert data[backend + '-actual-parameter-' + str(i)].tobytes() == pointer.to_bytes(8, 'little')
                counts['actual_ABI_bytes'] += 8
        a, b = data['original-counts'], data['source-counts']
        assert a.tobytes() == b.tobytes() and a.shape == (256,) and not a[86:].any()
        original, source = data['original-records'], data['source-records']
        assert original[:, :12].tobytes() == source[:, :12].tobytes()
        assert len(original) == int(a.sum()) == row['actual_operands']
        cursor = 0
        for lane, size in enumerate(a):
            seen = set()
            for record in original[cursor:cursor + int(size)]:
                address = int.from_bytes(record[:8].tobytes(), 'little')
                delta = address - row['actual_output_replay_addresses']['10']
                assert lane < 86 and 0 <= delta < 2112 and delta % 4 == 0 and delta not in seen
                seen.add(delta)
                assert np.isfinite(record[8:12].copy().view('<f4')[0])
            cursor += int(size)
        assert cursor == len(original)
        counts['actual_per_thread_operands_compared'] += len(original)
        counts['packets'] += 1
output = BASE / 'probe-independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'counts': dict(counts), 'all_recorded_thread_sequences_equal': True,
                              'all_full_input_and_guard_bytes_rechecked': True,
                              'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps(dict(counts), indent=2))
