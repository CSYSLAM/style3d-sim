"""Close both public-checkpoint experiments without inferring a lost process exit code."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
INIT = BASE.with_name('continuation-20261101-38b70dcd-g1-frozen-so3-init')
for folder in (INIT, BASE):
    status = json.loads((folder / 'run.status.json').read_text())
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert json.loads((folder / 'independent-cpu-audit.status.json').read_text())['actual_exit'] == 0
init = json.loads((INIT / 'independent-cpu-audit.json').read_text())
assert init['counts']['packets'] == 660 and init['counts']['actual_calls'] == 3960
assert init['counts']['complete_output_arrays'] == 7920
restart = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert all(row['all_fields_within'] for row in restart['diagnostic_numeric_comparison'].values())
assert all(not flag for label, row in restart['strict_vs_first_SDK'].items()
           if label != 'sdk0' for flag in row.values())
negative = json.loads((BASE / 'end-test-independent-cpu-audit.json').read_text())
assert negative['sentinels_rechecked'] == 8 and len(negative['recorded_outputs_rechecked']) == 11
assert negative['actual_GPU_process_exit_not_observed_after_context_truncation']
terminal = [
    {'CPU_preflight': {'session': 93675, 'actual_exit': 0},
     'driver': {'session': 8072, 'actual_exit': 0},
     'steps': json.loads((INIT / 'run.status.json').read_text())['completed'],
     'foreign_PID_2594139_interrupted': False, 'foreign_process_exit': None,
     'GPU_jobs_terminal_with_recorded_exit': True},
    {'driver': {'session': 95836, 'actual_exit': 0},
     'workers': json.loads((BASE / 'run.status.json').read_text())['completed'],
     'independent_CPU': {'actual_exit': 0},
     'end_test_negative_control': {
         'pid': 2621017, 'process_no_longer_running': True, 'complete_output_saved': True,
         'actual_exit': None, 'reason': 'tool return truncated at context boundary; exit not recovered',
         'not_restarted_to_hide_missing_terminal': True,
     },
     'end_test_independent_CPU': {'actual_exit': 0},
     'normal_demo_test_passed_flags_mean_actual_CLI_exit_only': True,
     'original_velocity_bound_not_enforced_by_translated_helper': True,
     'all_GPU_terminal_exit_codes_observed': False,
     'documentation_patch_first_attempt_refused_atomically_then_corrected': True},
]
for folder, entry in zip((INIT, BASE), terminal, strict=True):
    output = folder / 'commands-and-terminal-status.json'
    assert not output.exists(), output
    entry.update({
        'commands': {path.name: json.loads(path.read_text()) for path in sorted(folder.glob('*.command.json'))},
        'old_fixed_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False,
    })
    output.write_text(json.dumps(entry, indent=2) + '\n')
    manifest = folder / 'phase-manifest.json'
    assert not manifest.exists(), manifest
    files = {}
    for path in sorted(folder.rglob('*')):
        if path.is_file():
            data = path.read_bytes()
            assert len(data) < 100 * 1024 * 1024, path
            files[str(path.relative_to(folder))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
    manifest.write_text(json.dumps({'files': files, 'file_count': len(files),
                                    'bytes': sum(row['bytes'] for row in files.values()),
                                    'whole_solver_complete': False}, indent=2) + '\n')
    print(folder.name, len(files), 'closed files', sum(row['bytes'] for row in files.values()), 'bytes')
