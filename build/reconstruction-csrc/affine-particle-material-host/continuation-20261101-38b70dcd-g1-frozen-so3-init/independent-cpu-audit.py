"""Independently verify all frozen-input SO3 output bytes, memory guards and actual ABI arguments."""
from collections import Counter
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
report = json.loads((BASE / 'report.json').read_text())
assert report['complete'] and report['error'] is None and report['actual_calls'] == 3960
assert json.loads((BASE / 'execute.status.json').read_text()) == {
    'actual_exit': 0, 'complete': True, 'whole_solver_complete': False,
}
assert [(row['label'], row['frame']) for row in report['packets']] == list(map(tuple, plan['cases']))
assert len(report['packets']) == 660
assert plan['cases'][:2] == [['source1', 30], ['source1', 31]]
sizes = {0: 176 * 3 * 4, 1: 44 * 4 * 4, 2: 44 * 9 * 4, 3: 44 * 9 * 4}
assert {int(i): size for i, size in plan['payload_sizes'].items()} == sizes
assert plan['padding'] == 256 and plan['guard_byte'] == 211 and plan['canary_bytes'] == [127, 165]
assert plan['geometry'] == [1, 1, 1, 256, 1, 1, 0] and plan['parameters'] == [8] * 7
counts, inputs = Counter(), {}
with ExitStack() as stack:
    frozen = {label: stack.enter_context(np.load(path, allow_pickle=False))
              for label, path in plan['input_npz_paths'].items()}
    with np.load(plan['mapping_packet'], allow_pickle=False) as packet:
        mapping = packet['before-arg-1'].tobytes()
    for row in report['packets']:
        label, frame = row['label'], row['frame']
        positions = frozen[label]['particle_q'][frame]
        assert positions.dtype == np.dtype('<f4') and positions.shape == (176, 3)
        raw = positions.tobytes()
        assert row['position_bytes_sha256'] == hashlib.sha256(raw).hexdigest()
        bases = {int(i): value for i, value in row['allocated_device_bases'].items()}
        pointers = {int(i): value for i, value in row['actual_parameter_addresses'].items()}
        assert set(bases) == set(pointers) == set(range(4))
        assert all(bases[i] and bases[i] % 256 == 0 and pointers[i] == bases[i] + 256 for i in bases)
        intervals = sorted((bases[i], bases[i] + sizes[i] + 512) for i in bases)
        assert all(a[1] <= b[0] for a, b in zip(intervals, intervals[1:]))
        checks = {check['tag']: check for check in row['checks']}
        expected_tags = {backend + '-canary' + str(seed) for backend in plan['backends'] for seed in range(2)}
        assert len(checks) == len(row['checks']) == 6 and set(checks) == expected_tags
        path = BASE / 'packets' / f'{label}-frame-{frame:02d}.npz'
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            primary = {i: packet['original-runtime-canary0-output-' + str(i)].tobytes() for i in (2, 3)}
            for tag, check in checks.items():
                seed = int(tag[-1])
                payloads = {0: raw, 1: mapping, 2: bytes([plan['canary_bytes'][seed]]) * sizes[2],
                            3: bytes([plan['canary_bytes'][seed]]) * sizes[3]}
                for i in range(7):
                    actual = packet[tag + '-parameter-' + str(i)].tobytes()
                    value = pointers[i] if i < 4 else (176 if i == 6 else 44)
                    assert actual == value.to_bytes(8, 'little')
                    counts['actual_ABI_bytes'] += len(actual)
                    counts['pointer_fields' if i < 4 else 'scalar_bytes'] += 1 if i < 4 else len(actual)
                for i, size in sizes.items():
                    initial = np.full(size + 512, 211, dtype='u1')
                    initial[256:256 + size] = np.frombuffer(payloads[i], dtype='u1')
                    after = packet[tag + '-buffer-' + str(i)]
                    assert after.dtype == np.dtype('u1') and after.shape == initial.shape
                    mask = np.ones(len(initial), dtype=bool)
                    if i in (2, 3):
                        mask[256:256 + size] = False
                        output = packet[tag + '-output-' + str(i)]
                        assert output.dtype == np.dtype('u1') and output.shape == (size,)
                        assert output.tobytes() == after[256:256 + size].tobytes() == primary[i]
                        assert check['outputs_equal_to_primary_SDK'][str(i)]
                        if i == 3:
                            assert np.all(output.view('<u4') == 0)
                        else:
                            assert np.isfinite(output.view('<f4')).all()
                        counts['complete_output_arrays'] += 1
                        counts['complete_output_words'] += size // 4
                    assert np.array_equal(after[mask], initial[mask])
                    counts['unwritten_input_and_guard_bytes'] += int(mask.sum())
                    counts['full_after_bytes'] += len(after)
                assert check['unwritten_equal']
                counts['actual_calls'] += 1
        counts['packets'] += 1
assert counts['actual_calls'] == 3960 and counts['packets'] == 660 and counts['complete_output_arrays'] == 7920
assert counts['actual_ABI_bytes'] == 221760 and counts['unwritten_input_and_guard_bytes'] == 19261440
result = {'counts': dict(counts), 'input_sha256': inputs,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'all_complete_outputs_and_actual_ABI_rechecked': True, 'all_full_input_and_guard_bytes_rechecked': True,
          'old_hidden_state_or_old_atomic_schedule_reproduced': False,
          'old_C8_reclassified': False, 'whole_solver_complete': False}
output = BASE / 'independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({'counts': dict(counts), 'whole_solver_complete': False}, indent=2), flush=True)
