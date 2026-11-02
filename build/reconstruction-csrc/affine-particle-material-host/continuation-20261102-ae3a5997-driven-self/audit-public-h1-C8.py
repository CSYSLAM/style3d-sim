"""Independently recompute every H1 fixed-C8 field and preserve the first source sample."""
import argparse
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--controls', action='store_true')
args = parser.parse_args()
cohort = BASE / 'public-h1-fixed-C8'
cohort_plan = json.loads((cohort / 'plan.json').read_text())
folder = BASE / 'public-h1-sdk-heldout3' if args.controls else cohort
prefix = 'control' if args.controls else 'source'
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
report = json.loads((folder / 'report.json').read_text())
assert status['complete'] and status['running'] is None
assert len(status['completed']) == (3 if args.controls else 9)
assert all(row['actual_exit'] == 0 for row in status['completed'])
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for backend in ('original', 'source'):
    first = BASE / 'public-h1-probe' / backend
    assert (cohort / f'{backend}0.npz').read_bytes() == (first / 'states.npz').read_bytes()
    for name in ('states.npz', 'before.npz', 'runtime.json', 'model-counts.json'):
        assert (cohort / f'{backend}0' / name).read_bytes() == (first / name).read_bytes()
hashes, within, first_outside = {}, [True] * 3, [None] * 3
workers = [cohort / f'original{i}' for i in range(8)] + [
    folder / f'{prefix}{i}' for i in range(3)]
counts = (cohort / 'original0/model-counts.json').read_bytes()
with np.load(cohort / 'original0/before.npz', allow_pickle=False) as initial:
    for worker in workers:
        runtime = json.loads((worker / 'runtime.json').read_text())
        native = worker.name.startswith(('original', 'control'))
        assert runtime['exit'] == 0 and runtime['frames'] == 4
        assert runtime['public_core_abi'] and not runtime['ab_bridge_used']
        assert runtime['reference_solver_mapped'] == native
        assert runtime['image_sha256'] == cohort_plan['reference_sha256' if native else 'source_core_sha256']
        assert not runtime['original_physics_and_test_final_modified']
        assert runtime['graph_steps'][0] == {'graph_before': False, 'graph_after': True}
        assert runtime['graph_steps'][1:] == [{'graph_before': True, 'graph_after': True}] * 3
        assert (worker / 'model-counts.json').read_bytes() == counts
        with np.load(worker / 'before.npz', allow_pickle=False) as before:
            assert set(before.files) == set(initial.files)
            assert all(before[key].tobytes() == initial[key].tobytes() for key in initial.files)
        for name in ('runtime.json', 'states.npz', 'before.npz', 'model-counts.json'):
            path = worker / name
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(cohort / f'original{i}.npz', allow_pickle=False)) for i in range(8)]
    paths = [folder / f'control{i}/states.npz' if args.controls else folder / f'source{i}.npz' for i in range(3)]
    candidates = [stack.enter_context(np.load(path, allow_pickle=False)) for path in paths]
    for key in originals[0].files:
        arrays = originals + candidates
        assert all(data[key].shape == originals[0][key].shape and data[key].dtype == np.float32 for data in arrays)
        assert all(np.isfinite(data[key]).all() for data in arrays) and len(originals[0][key]) == 4
        old = np.asarray([data[key] for data in originals], dtype='f8').reshape(8, 4, -1)
        total = np.zeros_like(old[0])
        for data in old:
            total += data
        envelope = np.max([np.max(np.abs(data - (total - data) / 7), axis=1) for data in old], axis=0)
        for index, data in enumerate(candidates):
            error = np.max(np.abs(data[key].astype('f8').reshape(4, -1) - total / 8), axis=1)
            with np.errstate(divide='ignore', invalid='ignore'):
                ratio = np.where(envelope > 0, error / envelope, np.where(error > 0, np.inf, 0.))
            saved = report[prefix + '_statistics'][index][key]
            expected = {'substeps': 4, 'legacy_runs': 8, 'reconstruction_runs': 1,
                        'substeps_within_spread': int(np.count_nonzero(error <= envelope)),
                        'legacy_spread_max': float(envelope.max()), 'reconstruction_error_max': float(error.max()),
                        'ratio_median': float(np.median(ratio)), 'ratio_max': float(ratio.max())}
            assert all(saved[name] == value for name, value in expected.items())
            for frame, checkpoint in saved['checkpoints'].items():
                i = int(frame)
                assert checkpoint == {'legacy_spread': float(envelope[i]), 'reconstruction_error': float(error[i]),
                                      'ratio': float(ratio[i])}
            for frame in np.flatnonzero(error > envelope):
                value = {'field': key, 'frame': int(frame), 'error': float(error[frame]), 'spread': float(envelope[frame])}
                if first_outside[index] is None or frame < first_outside[index]['frame']:
                    first_outside[index] = value
            within[index] &= bool(np.all(error <= envelope))
assert within == report[prefix + '_C8_passed']
target = BASE / ('public-h1-sdk-heldout3-independent-cpu.json' if args.controls else 'public-h1-C8-independent-cpu.json')
assert not target.exists()
target.write_text(json.dumps({'input_sha256': hashes, prefix + '_C8_passed': within, 'first_outside': first_outside,
    'all_initial_states_bitwise_equal': True, 'all_statistics_reproduced': True,
    'first_source0_preserved_byte_for_byte': True, 'controls_added_to_fixed_SDK8': False,
    'source_failures_rejudged': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Independent H1 fixed C8:', prefix, within, first_outside)
