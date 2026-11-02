"""Verify real public-Core provenance and independently recompute the unchanged three-frame beef protocol."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'public-beef-fixed-C8'
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
report = json.loads((folder / 'report.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 3
assert all(row['actual_exit'] == 0 for row in status['completed'])
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/beef-fixed-C8'
for index in range(8):
    source = legacy / f'original{index}.npz'
    entry = snapshot['files'][str(source.relative_to(ROOT))]
    raw = source.read_bytes()
    assert len(raw) == entry['bytes'] and hashlib.sha256(raw).hexdigest() == entry['sha256']
    assert raw == (folder / f'original{index}.npz').read_bytes()
for index in range(3):
    runtime = json.loads((folder / f'source{index}.runtime.json').read_text())
    provenance = json.loads((folder / f'source{index}.provenance.json').read_text())
    assert runtime['exit'] == 0 and runtime['source_only'] and runtime['public_core_abi']
    assert not runtime['ab_bridge_used'] and not runtime['reference_solver_mapped']
    assert runtime['source_sha256'] == plan['source_core_sha256'] and sum(runtime['source_launch_counts'].values()) > 0
    assert provenance['actual_core_demo_return'] == 0 and not provenance['end_test_modified']
    assert all(count == 3 for count in provenance['records'].values())
    assert 'Beef checks passed:' in (folder / f'source{index}.log').read_text()
within, hashes = [True] * 3, {}
with ExitStack() as stack:
    paths = [folder / f'{backend}{i}.npz' for backend, count in [('original', 8), ('source', 3)] for i in range(count)]
    arrays = [stack.enter_context(np.load(path, allow_pickle=False)) for path in paths]
    hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
    for key in arrays[0].files:
        assert all(data[key].shape == arrays[0][key].shape and data[key].dtype == arrays[0][key].dtype for data in arrays)
        assert all(np.isfinite(data[key]).all() for data in arrays) and len(arrays[0][key]) == 3
        old = np.asarray([data[key] for data in arrays[:8]], dtype='f8').reshape(8, 3, -1)
        total = np.zeros_like(old[0])
        for data in old:
            total += data
        envelope = np.max([np.max(np.abs(data - (total - data) / 7), axis=1) for data in old], axis=0)
        for index, data in enumerate(arrays[8:]):
            errors = np.max(np.abs(data[key].astype('f8').reshape(3, -1) - total / 8), axis=1)
            with np.errstate(divide='ignore', invalid='ignore'):
                ratios = np.where(envelope > 0, errors / envelope, np.where(errors > 0, np.inf, 0.))
            saved = report['source_statistics'][index][key]
            values = {'substeps': 3, 'legacy_runs': 8, 'reconstruction_runs': 1,
                      'substeps_within_spread': int(np.count_nonzero(errors <= envelope)),
                      'legacy_spread_max': float(envelope.max()), 'reconstruction_error_max': float(errors.max()),
                      'ratio_median': float(np.median(ratios)), 'ratio_max': float(ratios.max())}
            assert all(saved[name] == value for name, value in values.items())
            for frame, checkpoint in saved['checkpoints'].items():
                i = int(frame)
                assert checkpoint == {'legacy_spread': float(envelope[i]), 'reconstruction_error': float(errors[i]),
                                      'ratio': float(ratios[i])}
            within[index] &= bool(np.all(errors <= envelope))
assert within == report['source_C8_passed']
output = BASE / 'public-beef-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps({'three_normal_public_Core_exits_zero': True, 'source_C8_passed': within,
    'all_statistics_reproduced': True, 'SDK_cohort_matches_primary_frozen_bytes': True,
    'source0_replaced': False, 'new_SDK_runs': 0, 'input_sha256': hashes, 'GPU_runs': 0,
    'unchanged_original_end_test_verified': True, 'default_or_long_cut_validated': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Normal public beef3 independent CPU: actual exits0, original end tests passed; fixed C8', within)
