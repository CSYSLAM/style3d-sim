"""Verify all actual initcheck receipts, zero-error logs, image mappings and complete sixty-step state bytes."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'initcheck60-cache-order'
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 12
assert all(row['actual_exit'] == 0 and row['zero_error_summary'] for row in status['completed'])
hashes = dict(plan['input_sha256'])
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
rows, compared_bytes = [], 0
for case in plan['cases']:
    group = folder / case['name']
    for backend in ('original', 'source'):
        directory = group / backend
        message = (directory / 'sanitizer.log').read_text()
        assert 'COMPUTE-SANITIZER' in message and 'ERROR SUMMARY: 0 errors' in message
        provenance = json.loads((directory / 'wrapper-provenance.json').read_text())
        runtime = json.loads((directory / 'capture.runtime.json').read_text())
        assert provenance['complete'] and provenance['error'] is None
        assert provenance['original_SDK_mapped'] == (backend == 'original')
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                    if backend == 'original' else plan['source_image_sha256'])
        assert runtime['image_sha256'] == expected and runtime['frames'] == 60 and runtime['extra'] == case['extra']
        for path in directory.iterdir():
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(group / 'original/capture.npz', allow_pickle=False) as old, \
            np.load(group / 'source/capture.npz', allow_pickle=False) as new:
        assert set(old.files) == set(new.files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
        count = 0
        for key in old.files:
            assert old[key].shape == new[key].shape and old[key].shape[0] == 60
            assert old[key].dtype == new[key].dtype == np.dtype('<f4')
            assert np.isfinite(old[key]).all() and np.isfinite(new[key]).all()
            assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
            count += old[key].nbytes
        compared_bytes += count
    rows.append({'case': case['name'], 'both_actual_exits': 0, 'both_initcheck_errors': 0,
                 'complete_state_bytes_CPU_compared': count, 'strict': True})
for path in (Path(__file__), folder / 'plan.json', folder / 'status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
report = {'cases': rows, 'actual_sanitizer_workers': 12, 'all_zero_errors': True,
          'six_complete_sixty_step_state_pairs_strict': True, 'complete_state_bytes_CPU_compared': compared_bytes,
          'input_sha256': hashes, 'production_modified': False, 'whole_solver_complete': False}
(BASE / 'initcheck60-independent-cpu.json').write_text(json.dumps(report, indent=2) + '\n')
print('CPU checked12 actual initcheck zero-error receipts and six complete60-step state pairs')
