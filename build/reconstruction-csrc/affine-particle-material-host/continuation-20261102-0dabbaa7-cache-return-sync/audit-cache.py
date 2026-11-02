"""Independently validate complete cache payloads, guard bytes, consumer ABI and pinned provenance on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
report_path = BASE / 'report.json'
report = json.loads(report_path.read_text())
raw_path = BASE / 'raw.npz'
assert hashlib.sha256(raw_path.read_bytes()).hexdigest() == report['raw_sha256']
for path, expected in report['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
specifications = [('scalar', 4, None), ('vec3', 12, None), ('mat3', 36, None), ('block-entry', 40, None),
                  ('int', 4, None), ('uint', 4, None), ('index2', 8, None), ('aabb', 24, None),
                  ('scalar-entry', 8, None), ('index3', 12, None), ('vec4', 16, None),
                  ('int-one', 4, 1), ('int-minus-one', 4, -1)]
expected_cases = [(name, width, count, value)
                  for name, width, value in specifications for count in (1, 129, 128871)]
assert len(expected_cases) == len(report['cases']) == report['actual_library_calls'] == 39
payload_bytes = guard_bytes = parameter_bytes = 0
with np.load(raw_path, allow_pickle=False) as arrays:
    expected_keys = set()
    for number, ((name, width, count, value), row) in enumerate(zip(expected_cases, report['cases'])):
        assert (row['number'], row['type'], row['count'], row['payload_bytes']) == (number, name, count, count * width)
        data = arrays[f'{number}/actual']
        expected_keys.add(f'{number}/actual')
        assert data.dtype == np.dtype('u1') and data.shape == (count * width + 512,)
        assert np.all(data[:256] == 211) and np.all(data[-256:] == 211)
        expected = bytes(count * width) if value is None else int(value).to_bytes(4, 'little', signed=True) * count
        assert data[256:-256].tobytes() == expected, number
        parameters = []
        for index, size in enumerate((8, 8, 4, 4)):
            key = f'{number}/parameter-{index}'
            expected_keys.add(key)
            argument = arrays[key]
            assert argument.dtype == np.dtype('u1') and argument.shape == (size,)
            parameters.append(int.from_bytes(argument.tobytes(), 'little'))
            parameter_bytes += size
        assert parameters[0] > 0 and parameters[1] > 0 and parameters[0] != parameters[1]
        assert parameters[0] % 256 == parameters[1] % 256 == 0
        assert parameters[2:] == [count * width, count * width + 512]
        assert row['legacy_stream_query_immediately_after_library_return'] == 0
        assert row['nonblocking_consumer_checked_without_extra_fence'] == (value is None)
        payload_bytes += count * width
        guard_bytes += 512
    assert set(arrays.files) == expected_keys
assert report['negative_control_pending_status'] == 600
assert report['actual_nonblocking_consumer_calls'] == 33
assert not report['reference_mapped'] and not report['production_modified']
inputs = dict(report['input_sha256'])
inputs.update({str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in (Path(__file__), report_path, raw_path, BASE / 'consumer-and-negative-control.ptx')})
result = {'cases': 39, 'full_payload_bytes_CPU_checked': payload_bytes, 'guard_bytes_CPU_checked': guard_bytes,
          'consumer_parameter_bytes_CPU_checked': parameter_bytes, 'observed_ready_queries': 39,
          'observed_pending_negative_query': 600, 'observed_nonblocking_consumers': 33,
          'integer_cases_have_nonblocking_consumer': False, 'consumer_error_flags_saved_as_raw': False,
          'CUDA_query_observations_independently_reexecuted_on_CPU': False,
          'input_sha256': inputs, 'all_other_initialization_paths_proved': False,
          'production_modified': False, 'whole_solver_complete': False}
(BASE / 'cache-independent-cpu.json').write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified39 full typed payloads,', payload_bytes, 'payload bytes,', guard_bytes, 'guard bytes')
