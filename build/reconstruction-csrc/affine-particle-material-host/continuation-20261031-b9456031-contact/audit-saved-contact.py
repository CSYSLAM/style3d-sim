"""Offline byte audit of the fixed first capture and all saved contact trajectories; no GPU resampling."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

root = Path.cwd().resolve()
base = Path(__file__).resolve().parent
validation = base.parent / 'validation-8f4127f0-tet-contact'
output = validation / 'saved-contact-cpu-audit.json'
assert not output.exists()
reference = base / 'original16-view-aware'
source = validation / 'source-first16'
inputs = {}


def read(path):
    data = path.read_bytes()
    inputs[str(path.relative_to(root))] = hashlib.sha256(data).hexdigest()
    return data


def exact_arrays(left, right):
    read(left)
    read(right)
    with np.load(left) as a, np.load(right) as b:
        assert set(a.files) == set(b.files)
        for key in a.files:
            x, y = a[key], b[key]
            assert x.shape == y.shape and x.dtype == y.dtype, key
            assert np.isfinite(x).all() and np.isfinite(y).all(), key
            assert x.tobytes() == y.tobytes(), (left.name, right.name, key)
        return len(a.files)


rows = json.loads(read(source / 'report.json'))['cases']
assert len(rows) == 16 and all(row['passed'] for row in rows)
states, buffers, graph_pairs = 0, 0, 0
for row in rows:
    name = row['case']
    left, right = reference / name, source / name
    states += exact_arrays(left / 'capture.npz', right / 'capture.npz')
    a = json.loads(read(left / 'capture.runtime.json'))
    b = json.loads(read(right / 'capture.runtime.json'))
    assert a['image_sha256'].startswith('64a0be7f') and b['image_sha256'].startswith('8f4127f0')
    assert a['example_sha256'] == b['example_sha256'] and a['extra'] == b['extra']
    fields = json.loads(read(left / 'fields.json'))
    expected = {f'dump_{token}_post_arg{i}.bin' for token, args in fields.items() for i in args}
    assert expected == set(row['buffers']) and all(row['buffers'].values())
    for filename in sorted(expected):
        assert read(left / filename) == read(right / filename), (name, filename)
        buffers += 1
    graph = validation / 'graph60'
    for mode in (0, 1):
        exact_arrays(graph / f'original-{name}-{mode}.npz', graph / f'source-{name}-{mode}.npz')
        graph_pairs += 1
    for backend in ('original', 'source'):
        exact_arrays(graph / f'{backend}-{name}-0.npz', graph / f'{backend}-{name}-1.npz')
        graph_pairs += 1
assert buffers == 160 and graph_pairs == 64
constructor = json.loads(read(validation / 'constructor/audit.json'))
assert all(constructor['checks'].values())
result = {'source_sha256': rows and json.loads(read(validation / 'build.json'))['extension_sha256'],
          'first_capture_pairs': len(rows), 'first_capture_state_arrays': states, 'post_buffers': buffers,
          'graph_pairs': graph_pairs, 'all_saved_bytes_equal': True, 'source0_replaced': False,
          'gpu_resampled': False, 'whole_solver_complete': False, 'input_sha256': inputs,
          'audit_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
output.write_text(json.dumps(result, indent=2) + '\n')
print('offline exact bytes: first pairs', len(rows), 'buffers', buffers, 'graph pairs', graph_pairs)
