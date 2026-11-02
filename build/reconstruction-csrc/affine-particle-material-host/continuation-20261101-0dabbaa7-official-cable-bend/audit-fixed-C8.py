"""Independently recompute all fixed cable bend cohort substeps on CPU and freeze every raw input hash."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'cohort8/independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((BASE / 'cohort8/plan.json').read_text())
report = json.loads((BASE / 'cohort8/report.json').read_text())
status = json.loads((BASE / 'cohort8/status.json').read_text())
assert status['complete'] and len(status['completed']) == 18
assert all(row['actual_exit'] == 0 for row in status['completed'])
hashes = dict(plan['input_sha256'])


def read(path):
    raw = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
    return raw


rows, arrays_checked, finite_values = [], 0, 0
for mode, result in report['modes'].items():
    paths = {side: [Path(p) for p in value] for side, value in result['paths'].items()}
    assert paths['source'][0] == BASE / mode / 'source.npz'
    assert paths['original'][0] == BASE / mode / 'original.npz'
    assert len(paths['original']) == 8 and len(paths['source']) == 3
    originals, sources = [], []
    for side, targets in paths.items():
        for path in targets:
            read(path)
            runtime = json.loads(read(path.with_suffix('.runtime.json')))
            expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                        if side == 'original' else '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e')
            assert runtime['image_sha256'] == expected and runtime['extra'] == ['--solver', mode]
            assert runtime['frames'] == 60 and runtime['backend'] == side
            if side == 'source':
                counts = json.loads(read(path.with_suffix('.launches.json')))
                assert counts and sum(counts.values()) > 0
            with np.load(path, allow_pickle=False) as data:
                assert set(data.files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
                state = {key: data[key].copy() for key in data.files}
            assert all(value.dtype == np.dtype('<f4') and len(value) == 600 for value in state.values())
            assert all(np.isfinite(value).all() for value in state.values())
            finite_values += sum(value.size for value in state.values())
            (originals if side == 'original' else sources).append(state)
    all_ok = []
    for number, source in enumerate(sources):
        target = result['sources'][number]
        assert target['source'] == number
        fields = {}
        for key in sorted(source):
            original = np.stack([state[key].astype('f8') for state in originals])
            actual = source[key].astype('f8')
            total = original.sum(0)
            axes = tuple(range(1, actual.ndim))
            spread = np.stack([np.abs(original[i] - (total - original[i]) / 7).max(axis=axes)
                               for i in range(8)]).max(0)
            error = np.abs(actual - total / 8).max(axis=axes)
            within = error <= spread
            stats = target['spread'][key]
            assert stats['substeps'] == 600 and stats['substeps_within_spread'] == int(within.sum())
            assert stats['legacy_spread_max'] == float(spread.max())
            assert stats['reconstruction_error_max'] == float(error.max())
            for step in range(600):
                point = stats['checkpoints'][str(step)]
                assert point['legacy_spread'] == float(spread[step])
                assert point['reconstruction_error'] == float(error[step])
            equal = np.all(originals[0][key].view('<u4') == source[key].view('<u4'), axis=axes)
            strict = target['strict'][key]
            different = np.flatnonzero(~equal)
            assert strict['bitwise_substeps'] == int(equal.sum())
            assert strict['first_diff_substep'] == (int(different[0]) if len(different) else None)
            fields[key] = {'within_steps': int(within.sum()), 'total_steps': 600,
                           'first_outside_step': int(np.flatnonzero(~within)[0]) if not within.all() else None,
                           'strict_substeps': int(equal.sum())}
            arrays_checked += 1
        outside = [key for key in fields if fields[key]['within_steps'] != 600]
        assert sorted(outside) == sorted(target['outside'])
        passed = not outside
        assert passed == target['all_steps_within_C8']
        all_ok.append(passed)
        rows.append({'mode': mode, 'source': number, 'within_C8': passed, 'arrays': fields})
    assert all(all_ok) == result['all_three_sources_within_C8']
for path in (Path(__file__), BASE / 'cohort8/plan.json', BASE / 'cohort8/report.json', BASE / 'cohort8/status.json'):
    read(path)
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'rows': rows, 'arrays_checked': arrays_checked, 'finite_F32_values_checked': finite_values,
          'input_sha256': hashes, 'GPU_used': False, 'initial_fixed_sources_replaced': False,
          'all_modes_C8_passed': all(row['within_C8'] for row in rows),
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent cable bend CPU:', arrays_checked, 'arrays;',
      [(row['mode'], row['source'], row['within_C8']) for row in rows], flush=True)
