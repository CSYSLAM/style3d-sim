"""Locate every H1 initcheck warning in the post-simulation unsigned-integer NaN scan without erasing failures."""
import hashlib
import json
from pathlib import Path
import re
import shutil

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'public-h1-d2h396-names'
status = json.loads((folder / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert [row['actual_exit'] for row in status['completed']] == [97, 97]
upstream = BASE / 'upstream-test-as-run'
upstream.mkdir(exist_ok=False)
hashes, copied = {}, {}
for relative in ('newton/examples/__init__.py', 'newton/tests/unittest_utils.py',
                 'newton/_src/sim/model.py', 'newton/_src/geometry/bvh.py'):
    source = ROOT / '.venv/lib/python3.12/site-packages' / relative
    target = upstream / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, target)
    sha = hashlib.sha256(source.read_bytes()).hexdigest()
    hashes[str(source)] = sha
    copied[str(target.relative_to(BASE))] = sha
runner = (upstream / 'newton/examples/__init__.py').read_text()
assert runner.index('viewer.close()') < runner.index('nan_members = find_nan_members(example.model)')
scanner = (upstream / 'newton/tests/unittest_utils.py').read_text()
assert 'for key, attr in obj.__dict__.items():' in scanner
assert 'arr = attr.numpy()' in scanner and 'if np.isnan(arr).any():' in scanner
model = (upstream / 'newton/_src/sim/model.py').read_text()
assert 'self.bvh_shape_enabled = wp.empty(shape_count, dtype=wp.uint32, device=device)' in model
assert 'self.bvh_shape_count_enabled = int(num_enabled.numpy()[0])' in model
rows, payloads = [], []
for backend in ('original', 'source'):
    directory = folder / backend
    trace = json.loads((directory / 'array-reads396.json').read_text())
    assert trace['extra_GPU_copies'] == 0 and not trace['GPU_array_contents_modified']
    log = (folder / (backend + '.log')).read_text()
    matches = list(re.finditer(r'H1_D2H396_BEGIN (.*)\n(?=(?:========= )*Host API memory access)', log))
    assert len(matches) == 1
    marker = matches[0]
    record = json.loads(marker[1])
    assert record['array_member'] == 'bvh_shape_enabled' and record['dtype'].endswith("uint32'>")
    assert record['model_shape_count'] == 99 and record['model_bvh_enabled_count'] == 50
    assert any('nan_members = find_nan_members(example.model)' in line for line in record['stack'])
    assert trace['reads'][record['index']] == {**record, **{key: trace['reads'][record['index']][key]
        for key in ('result_shape', 'result_dtype', 'result_sha256')}}
    end = log.index('H1_D2H396_END ' + str(record['index']), marker.end())
    addresses = [int(value, 16) for value in re.findall(r'Uninitialized access at (0x[0-9a-f]+)', log)]
    inside = re.findall(r'Uninitialized access at (0x[0-9a-f]+)', log[marker.end():end])
    assert len(addresses) == len(inside) == 7 and 'ERROR SUMMARY: 7 errors' in log
    offsets = [address - record['ptr'] for address in addresses]
    assert offsets == list(range(192, 385, 32))
    assert all(offset < 396 and offset + 32 > 50 * 4 for offset in offsets)
    payload = np.load(directory / f"read-{record['index']:03d}.npy", allow_pickle=False)
    assert payload.dtype == np.uint32 and payload.shape == (99,) and not np.isnan(payload).any()
    assert hashlib.sha256(payload.tobytes()).hexdigest() == trace['reads'][record['index']]['result_sha256']
    payloads.append(payload)
    runtime = json.loads((directory / 'worker/runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['reference_solver_mapped'] == (backend == 'original')
    for path in [directory / 'array-reads396.json', directory / f"read-{record['index']:03d}.npy",
                 directory / 'worker/runtime.json', folder / (backend + '.log')]:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    rows.append({'backend': backend, 'actual_initcheck_exit': 97, 'reported_errors': 7,
                 'array': record['array_member'], 'total_uint32_items': 99, 'active_uint32_items': 50,
                 'aligned_error_block_offsets': offsets, 'all_errors_inside_same_post_run_numpy_read': True,
                 'unsigned_integer_nan_scan_result': False, 'array_contents_written_by_observer': False})
payloads_equal = payloads[0].tobytes() == payloads[1].tobytes()
target = BASE / 'h1-inactive-tail-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': rows, 'input_sha256': hashes, 'upstream_source_copies': copied,
    'both_observed_uint32_payloads_bitwise_equal': payloads_equal,
    'post_simulation_host_read_does_not_write_physics_state': True,
    'original_initcheck_errors_rejudged_as_zero': False, 'C8_changed': False,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Both H1 initcheck failures localized: post-run find_nan_members, BVH uint32 active50/capacity99; exits97 retained')
