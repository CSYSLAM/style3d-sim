"""Check every complete source/native trajectory and coherent failed frame, without changing the fixed C8 rule."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
report = json.loads((BASE / 'graph-fixed-C8-cpu-audit.json').read_text())
controls = json.loads((BASE / 'sdk-heldout3-independent-cpu.json').read_text())
assert controls['all_statistics_reproduced']
plan = json.loads((BASE / 'graph-fixed-C8/plan.json').read_text())
groups = {group['label']: group for group in plan['groups']}
hashes, rows, matches = {}, [], 0
for row in report['cases']:
    group = groups[row['label']]
    folder = BASE / 'graph-fixed-C8/cohorts' / row['label']
    paths = [(f'fixed{i}', folder / f'original{i}.npz') for i in range(8)]
    paths += [(f'control{i}', BASE / f'sdk-heldout3/control{i}-worker' /
               ('original-' + group['case'] + '-' + str(group['graph']) + '.npz')) for i in range(3)]
    with ExitStack() as stack:
        natives = [(tag, stack.enter_context(np.load(path, allow_pickle=False))) for tag, path in paths]
        hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for _, path in paths})
        for index in range(3):
            path = folder / f'source{index}.npz'
            source = stack.enter_context(np.load(path, allow_pickle=False))
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
            assert all(set(source.files) == set(native.files) for _, native in natives)
            assert all(source[key].shape == native[key].shape and source[key].dtype == native[key].dtype
                       for _, native in natives for key in source.files)
            whole = [tag for tag, native in natives if all(source[key].tobytes() == native[key].tobytes()
                                                         for key in source.files)]
            matches += len(whole)
            frames = sorted({item['first_frame'] for item in row['first_outside_frames'] if item['source_index'] == index})
            same_frames = []
            for frame in frames:
                frame_matches = [tag for tag, native in natives if all(
                    source[key][frame].tobytes() == native[key][frame].tobytes() for key in source.files)]
                prefix_matches = [tag for tag, native in natives if all(
                    source[key][:frame + 1].tobytes() == native[key][:frame + 1].tobytes() for key in source.files)]
                same_frames.append({'frame': frame, 'all_six_fields_same_native_frame': frame_matches,
                                    'complete_prefix_same_single_native_run': prefix_matches})
            rows.append({'label': row['label'], 'source': index, 'whole60_same_native_runs': whole,
                         'first_failed_frames': same_frames})
assert len(rows) == 36
result = {'rows': rows, 'all_pairs_checked': 396, 'complete_trajectory_equal_pairs': matches,
          'source_trajectories_with_an_entire_native_match': sum(bool(row['whole60_same_native_runs']) for row in rows),
          'source_trajectories_total': 36, 'input_sha256': hashes,
          'one_native_run_required_per_frame_or_prefix': True, 'fixed_C8_changed': False,
          'source_failures_rejudged': False, 'original_cohort_extended': False,
          'GPU_runs': 0, 'whole_solver_complete': False}
output = BASE / 'literal-native-states.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('Entire60 trajectories with native matches', result['source_trajectories_with_an_entire_native_match'], '/36')
print('Failed frames with a coherent native match', [(row['label'], row['source'], frame) for row in rows
      for frame in row['first_failed_frames'] if frame['all_six_fields_same_native_frame']])
