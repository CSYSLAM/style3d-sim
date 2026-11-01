"""Retain the original fixed failure and identify the still-unobserved tangent/late-contact inputs."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-contact-graph/next-step.json'
old = json.loads(previous.read_text())
paths = [previous, BASE / 'rhs-independent-cpu-audit.json', BASE / 'first-CG-independent-cpu-audit.json',
         BASE / 'first-update-independent-cpu-audit.json', BASE / 'definition-comparison.json']
audit = json.loads((BASE / 'rhs-independent-cpu-audit.json').read_text())
record = {'fixed_source0': old['fixed_source0'], 'fixed_original_cohort': old['fixed_original_cohort'],
          'fixed_source0_first_C8_outside': old['fixed_source0_first_C8_outside'],
          'candidate_sha256': old['candidate_sha256'], 'source0_replaced': False, 'candidate_promoted': False,
          'new_observed_first_differences': audit['comparisons'], 'observed_stage_packets': 21600,
          'first_CG_calls': 72, 'first_CG_GPU_F32_certificates': 18, 'first_following_update_calls': 36,
          'next_action': 'Capture actual per-kernel CG extra/tangent formation and late contact/preconditioner inputs',
          'tangent_chain_first_CG_ranks': [36, 37, 38, 39, 40, 41, 42],
          'tangent_chain_repeat': 'Repeat at +12 per CG iteration and +86 per nonlinear iteration in the276-node graph',
          'reuse_actual_model_dimensions_not_G1_dimensions': True,
          'source_capture_observer': str(BASE / 'capture-observer-v2.py'),
          'root_v1_Observer_retained_for_provenance_only': True,
          'invariants': old['invariants'] + [
              'Do not infer all later arithmetic from first CG sum certificates',
              'Rigid/rolling/soft force snapshots in this phase capture only a subset of inputs',
              'Do not treat an effective-operand isolation call as an independent native trajectory'],
          'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
          'production_changed': False, 'whole_solver_complete': False}
(BASE / 'next-step.json').write_text(json.dumps(record, indent=2) + '\n')
print('Saved original fixed source0 target and remaining tangent/late-contact investigation')
