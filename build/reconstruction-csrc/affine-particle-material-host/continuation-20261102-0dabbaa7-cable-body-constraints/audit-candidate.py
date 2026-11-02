"""Independently compare complete short-trajectory bytes, recorded force buffers and actual image provenance."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--candidate', choices=('scope-only', 'cache-order'), required=True)
args = parser.parse_args()
suffix = 'candidate-v2-3' if args.candidate == 'scope-only' else 'candidate-cache-order-v2-3'
output = BASE / suffix
build_path = BASE / ('candidate-' + args.candidate) / 'build.json'
build = json.loads(build_path.read_text())
plan = json.loads((output / 'plan.json').read_text())
status = json.loads((output / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == len(plan['cases']) == 24
hashes = dict(plan['input_sha256'])
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
for path, expected in build['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
assert hashlib.sha256(Path(build['image']).read_bytes()).hexdigest() == build['image_sha256']
layout = schemas()[0]
rows, trajectory_bytes, force_bytes, launches = [], 0, 0, 0
for case, terminal in zip(plan['cases'], status['completed']):
    assert case['name'] == terminal['case'] and terminal['actual_exit'] == 0
    original = BASE / 'discovery-v2-3' / case['name'] / 'original'
    source = output / case['name'] / 'source'
    for folder in (original, source):
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        provenance = json.loads((folder / 'wrapper-provenance.json').read_text())
        assert runtime['frames'] == 3 and runtime['extra'] == case['extra']
        assert provenance['complete'] and provenance['error'] is None
        assert provenance['original_SDK_mapped'] == (folder == original)
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                    if folder == original else build['image_sha256'])
        assert runtime['image_sha256'] == expected
        for path in folder.iterdir():
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    fields = {}
    with np.load(original / 'capture.npz', allow_pickle=False) as old, \
            np.load(source / 'capture.npz', allow_pickle=False) as new:
        assert set(old.files) == set(new.files) == {'body_q', 'body_qd', 'particle_q', 'particle_qd'}
        for key in old.files:
            assert old[key].shape == new[key].shape and old[key].dtype == new[key].dtype
            assert old[key].shape[0] == 3 and np.isfinite(old[key]).all() and np.isfinite(new[key]).all()
            assert old[key].tobytes() == new[key].tobytes(), (case['name'], key)
            fields[key] = old[key].nbytes
            trajectory_bytes += old[key].nbytes
    captured = {}
    for path in sorted(original.glob('dump_*.bin')):
        other = source / path.name
        assert path.read_bytes() == other.read_bytes(), (case['name'], path.name)
        captured[path.name] = path.stat().st_size
        force_bytes += path.stat().st_size
    assert len(captured) == 4
    metadata = compare_launches(original / 'launches.txt', source / 'launches.txt', layout)
    assert metadata == terminal['metadata'] and metadata['equal']
    assert sum(json.loads((source / 'capture.launches.json').read_text()).values()) == metadata['right_launches']
    launches += metadata['right_launches']
    rows.append({'case': case['name'], 'complete_trajectory_field_bytes': fields,
                 'captured_force_before_after_bytes': captured, 'owned_calls': metadata['right_launches']})
assert launches == 10680
for path in (Path(__file__), build_path, output / 'plan.json', output / 'status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
report = {'candidate': args.candidate, 'image_sha256': build['image_sha256'], 'cases': rows, 'strict_cases': 24,
          'complete_trajectory_bytes_CPU_compared': trajectory_bytes,
          'captured_force_buffer_bytes_CPU_compared': force_bytes, 'owned_launches': launches,
          'launch_comparison_does_not_prove_pointer_identity_or_pointee_contents': True,
          'source_workers_SDK_unmapped': True, 'input_sha256': hashes,
          'production_modified': False, 'old_fixed_failures_retained': True, 'whole_solver_complete': False}
(BASE / ('independent-' + args.candidate + '-short.json')).write_text(json.dumps(report, indent=2) + '\n')
print('CPU verified24 complete short trajectories and96 force buffers for', args.candidate, ';10680 launches match')
