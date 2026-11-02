"""Freeze the completed official cable bend runs, controls and first-PCG evidence without accepting source failures."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'evidence-manifest.json'
assert not OUTPUT.exists()
for filename in ('cohort8/independent-cpu.json', 'native-controls/independent-cpu.json', 'first-CG/independent-cpu.json'):
    report = json.loads((BASE / filename).read_text())
    for name, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
cohort = json.loads((BASE / 'cohort8/independent-cpu.json').read_text())
assert not cohort['all_modes_C8_passed'] and len(cohort['rows']) == 6
assert all(not row['within_C8'] for row in cohort['rows'])
controls = json.loads((BASE / 'native-controls/independent-cpu.json').read_text())
assert controls['original_control_runs'] == controls['original_control_runs_outside_fixed_C8'] == 6
first = json.loads((BASE / 'first-CG/independent-cpu.json').read_text())
assert first['metadata_equal'] and first['lane_operands'] == 192 and first['GPU_atomic_target_certificates'] == 2
assert first['strict_replay_packets'] == 8 and first['complete_replay_calls'] == 30
assert all(not row['original_frozen_first_substep_reproduced'] for row in first['workers'])
for name, expected_count in [('status.json', 4), ('cohort8/status.json', 18),
                             ('native-controls/status.json', 6), ('first-CG/status.json', 2)]:
    status = json.loads((BASE / name).read_text())
    assert status['complete'] and len(status['completed']) == expected_count
    assert all(row['actual_exit'] == 0 for row in status['completed'])
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or '__pycache__' in path.parts or path.suffix in ('.pyc', '.tmp'):
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
record = {'files': files, 'GPU_demo_workers': 30, 'complete_C8_trajectories': 22, 'held_out_SDK_trajectories': 6,
          'frames_per_full_trajectory': 60, 'substeps_per_full_trajectory': 600,
          'source_C8_passed': 0, 'source_C8_total': 6, 'held_out_SDK_C8_passed': 0, 'held_out_SDK_C8_total': 6,
          'first_CG_replay_packets': 10, 'first_CG_replay_calls': 30, 'first_CG_strict_packets': 8,
          'first_CG_only_scalar_sum_differs': True, 'first_CG_actual_operands_equal': 192,
          'GPU_scalar_target_certificates': 2, 'independent_CPU_reports_actual_exit_zero': True,
          'first_CG_original_frozen_trajectory_reproduced': False,
          'fixed_samples_replaced': False, 'old_failures_reclassified': False,
          'production_changed': False, 'full_settling_test_run': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen official cable bend evidence:', len(files), 'files;all source C8 failures retained', flush=True)
