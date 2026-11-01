"""Freeze one controlled full-frame restart: the old source1 public state after frame30, eight SDK and three source runs."""
import ast
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_checkpoint_restart import WORKER, WORKER_SHA, rendered_worker

BASE = Path(__file__).resolve().parent
assert not (BASE / 'plan.json').exists()
frozen_phase = BASE.parent / 'continuation-20261101-38b70dcd-g1-frozen-so3-init'
fixed = BASE.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest() == '32b6e2a7337aaa80442fa3fd6232896410eb8163e875d35d845d4a8ae82d4e42'
cohort = json.loads(fixed.read_text())
checkpoint = Path(cohort['input_npz_paths']['source1'])
assert hashlib.sha256(checkpoint.read_bytes()).hexdigest() == cohort['input_npz_sha256']['source1']
with np.load(checkpoint, allow_pickle=False) as data:
    shapes = {'body_q': (60, 44, 7), 'body_qd': (60, 44, 6),
              'particle_q': (60, 176, 3), 'particle_qd': (60, 176, 3)}
    assert all(data[field].shape == shape and data[field].dtype == np.dtype('<f4') for field, shape in shapes.items())
    assert all(np.isfinite(data[field][30]).all() for field in shapes)
text = rendered_worker()
ast.parse(text)
(BASE / 'worker-template.py').write_text(text)
hashes = dict(json.loads((frozen_phase / 'plan.json').read_text())['input_sha256'])
paths = [Path(__file__), ROOT / 'reconstruction/csrc/g1_checkpoint_restart.py',
         BASE / 'worker-template.py', BASE / 'independent-cpu-audit.py', BASE / 'run.py', WORKER, fixed, checkpoint,
         ROOT / 'examples/example_robot_g1.py', ROOT / 'src/style3d_sim/newton_solver.py']
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
plan = {
    'input_checkpoint': str(checkpoint), 'input_label': 'source1', 'input_frame': 30, 'old_target_frame': 31,
    'core_build': str(ROOT / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'),
    'input_sha256': hashes, 'base_worker_sha256': WORKER_SHA,
    'patched_worker_sha256': hashlib.sha256(text.encode()).hexdigest(),
    'frames': 1, 'substeps_per_frame': 6,
    'runs': [{'label': 'sdk' + str(i), 'backend': 'original'} for i in range(8)] +
            [{'label': 'rebuilt' + str(i), 'backend': 'source'} for i in range(3)],
    'both_public_state_buffers_initialized_to_same_checkpoint': True,
    'native_drive_flags_and_python_feedback_flags_reset': True,
    'original_example_and_test_final_unchanged': True,
    'completed_frame_preserved_even_when_demo_end_test_raises': True,
    'end_test_failures_remain_failures_not_counted_as_normal_demo_pass': True,
    'controlled_restart_not_old_internal_state_replay': True,
    'new_diagnostic_cohort_does_not_extend_or_replace_old_C8': True,
    'old_fixed_report_sha256': hashlib.sha256(fixed.read_bytes()).hexdigest(),
    'production_changed': False, 'whole_solver_complete': False,
}
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('Controlled checkpoint fixed before GPU: source1 after frame30, one full frame,8 SDK/3 source', flush=True)
