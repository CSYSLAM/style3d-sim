"""Persist exact frozen targets and the next upstream investigation without changing any acceptance cohort."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
old = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
target = 'w3-b1-n2-s1-mixed-pd-b0-both-hit0'
cohort = old / 'graph-fixed-C8/cohorts' / (target + '-g1')
paths = [cohort / 'source0.npz', *(cohort / f'original{i}.npz' for i in range(8)),
         old / 'graph-fixed-C8-cpu-audit.json', BASE / 'so3-independent-cpu-audit.json',
         BASE / 'so3-observed-differences.json', BASE / 'definition-comparison.json']
record = {'fixed_source0': str(cohort / 'source0.npz'),
          'fixed_original_cohort': [str(cohort / f'original{i}.npz') for i in range(8)],
          'fixed_source0_first_C8_outside': {'frame': 32, 'world': 2, 'array': 'body_q', 'index': [2, 3]},
          'candidate_sha256': '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326',
          'source0_replaced': False, 'candidate_promoted': False, 'whole_solver_complete': False,
          'actual_SO3_inputs_verified': 960, 'actual_SO3_replay_calls': 5760,
          'new_observed_first_q_differences': [{'source_run': s, 'frame': 4, 'stage': 'update-1', 'particle': [28, 2]}
                                             for s in (1, 2)] + [
                                                 {'source_run': 3, 'frame': 7, 'stage': 'update-1', 'particle': [24, 2]}],
          'new_observed_paths_not_original_frozen_path': True,
          'next_action': 'Capture authentic RHS formation, particle/rigid contacts, granular caches and CG inputs '
                         'upstream of SO3',
          'native_flattened_SO3_counts': {'count': 3, 'bodies_per_world': 3, 'particles_per_world': 36},
          'rigid_contact_actual_shape_counts': {'capacity': 1000, 'local_shapes': 6, 'shapes_per_world': 6,
                                                'worlds': 1, 'body_count': 3, 'particles_per_world': 36},
          'rigid_force_arg33_bytes': 144,
          'invariants': ['Do not rebuild private dynamic bond/AL state from public positions',
                         'Do not feed SDK checkpoints to claim an independent source trajectory',
                         'Do not tune math, sorting, resources, tolerances or fixed cohorts to fit observations',
                         'Preserve the first failed sample and classify diagnostic perturbation explicitly',
                         'SO3 replay pass does not certify unobserved inputs or complete trajectories'],
          'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}}
(BASE / 'next-step.json').write_text(json.dumps(record, indent=2) + '\n')
print('Saved immutable source0/original8 paths and upstream RHS/contact investigation')
