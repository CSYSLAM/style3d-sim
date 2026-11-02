"""Independently verify all104 active-production cable state pairs against their unchanged first SDK captures."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host = json.loads(host_path.read_text())
folder = BASE / ('production-cables-' + host['extension_sha256'][:8])
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == len(plan['jobs']) == 104
assert all(row['actual_exit'] == 0 and row['passed'] for row in status['completed'])
assert plan['source_image_sha256'] == host['extension_sha256']
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
hashes = dict(plan['input_sha256'])
state_bytes, penalty_arrays, owned_calls = 0, 0, 0
groups = {}
for index, (job, terminal) in enumerate(zip(plan['jobs'], status['completed'])):
    case = job['case']
    actual = folder / f'{index:03d}'
    reference = Path(job['reference_actual'])
    assert terminal['index'] == index and terminal['case'] == case['name']
    assert 'demo_source_ab_complete' in (actual / 'run.log').read_text()
    runtime = json.loads((actual / 'capture.runtime.json').read_text())
    assert runtime['backend'] == 'source' and runtime['image_sha256'] == host['extension_sha256']
    with np.load(reference / 'capture.npz', allow_pickle=False) as old, \
            np.load(actual / 'capture.npz', allow_pickle=False) as new:
        assert set(old.files) == set(new.files) == {'body_q', 'body_qd', 'particle_q', 'particle_qd'}
        for key in old.files:
            assert old[key].shape == new[key].shape and old[key].shape[0] == job['frames']
            assert old[key].dtype == new[key].dtype == np.dtype('<f4')
            assert np.isfinite(old[key]).all() and np.isfinite(new[key]).all()
            assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
            state_bytes += old[key].nbytes
    if case.get('actions'):
        with np.load(reference / 'penalties.npz', allow_pickle=False) as old, \
                np.load(actual / 'penalties.npz', allow_pickle=False) as new:
            assert len(old.files) == 35 and set(old.files) == set(new.files)
            for key in old.files:
                assert old[key].dtype == new[key].dtype and old[key].shape == new[key].shape
                assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
                penalty_arrays += 1
    if job['owned_hook']:
        assert terminal['metadata']['equal'] and terminal['owned_coverage']
        owned_calls += terminal['metadata']['right_launches']
    groups[job['group']] = groups.get(job['group'], 0) + 1
    for path in actual.iterdir():
        if path.is_file():
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for path in (Path(__file__), folder / 'plan.json', folder / 'status.json', host_path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
record = {'source_image_sha256': host['extension_sha256'], 'actual_source_workers': 104,
          'strict_complete_state_pairs': 104, 'complete_state_bytes_CPU_checked': state_bytes,
          'penalty_arrays_CPU_checked': penalty_arrays, 'owned_calls_checked': owned_calls, 'case_groups': groups,
          'first_SDK_captures_retained': True, 'actual_source_completion_marker_includes_no_SDK_mapping_check': True,
          'input_sha256': hashes, 'old_C8_C10_failures_reclassified': False, 'whole_solver_complete': False}
(BASE / 'production-cables-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU checked all104 active production cable state pairs;', penalty_arrays, 'penalty arrays;', owned_calls, 'owned calls')
