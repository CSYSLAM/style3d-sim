"""Reproduce a saved fixed graph cohort on CPU and retain the exact earliest outside-C coordinates."""
import argparse
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction.demo_ab import spread_report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    saved = json.loads((args.cohort / 'report.json').read_text())
    assert saved['originals'] == 8 and saved['sources'] == 3 and saved['source0_replaced'] is False
    rows = []
    for case, entry in saved['cases'].items():
        with ExitStack() as stack:
            paths = [args.cohort / f'original{i}' / f'original-{case}.npz' for i in range(8)]
            originals = [stack.enter_context(np.load(p)) for p in paths]
            for index in range(3):
                path = args.cohort / f'source{index}' / f'source-{case}.npz'
                source = stack.enter_context(np.load(path))
                actual = json.loads(json.dumps(spread_report(originals, [source], checkpoints=60)))
                expected = entry['sources'][f'source{index}']['statistics']
                assert actual == expected, (case, index)
                outside = []
                for key, stats in actual.items():
                    bad = [int(step) for step, row in stats['checkpoints'].items()
                           if row['reconstruction_error'] > row['legacy_spread']]
                    if not bad:
                        continue
                    step = min(bad)
                    old = np.stack([o[key][step] for o in originals])
                    value = source[key][step]
                    error = abs(value.astype('f8') - old.astype('f8').mean(0))
                    coordinate = np.unravel_index(error.argmax(), error.shape)
                    selected = tuple(coordinate)
                    outside.append({'array': key, 'first_outside_step': step, 'coordinate': list(map(int, coordinate)),
                                    'source_bits': int(value[selected].view('u4')),
                                    'original_bits': [int(x[selected].view('u4')) for x in old],
                                    'original_array_step_bitwise_identical': all(x.tobytes() == old[0].tobytes()
                                                                               for x in old),
                                    'statistics_at_first_step': stats['checkpoints'][str(step)]})
                rows.append({'case': case, 'source': index, 'saved_statistics_reproduced': True,
                             'source_npz_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                             'outside': outside})
    report = {'source_sha256': saved['source_sha256'], 'checks': rows,
              'all_saved_statistics_reproduced': True, 'saved_primary_c_passed': saved['primary_c_passed'],
              'GPU_used': False, 'additional_originals_collected': 0, 'frozen_candidate_replaced': False,
              'whole_solver_complete': False,
              'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('saved source/case statistics reproduced', len(rows), 'saved primary C', saved['primary_c_passed'], flush=True)


if __name__ == '__main__':
    main()
