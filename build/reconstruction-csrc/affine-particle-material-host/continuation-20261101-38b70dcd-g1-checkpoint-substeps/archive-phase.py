"""Close the real substep evidence and exact early force difference, retaining the full-solver failures."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 11
assert all(row['actual_exit'] == 0 for row in status['completed'])
followup = json.loads((BASE / 'followup.status.json').read_text())
assert followup['complete'] and followup['running'] is None
assert all(row['actual_exit'] == 0 for row in followup['completed'])
audit = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert audit['counts']['actual_calls'] == 594 and audit['counts']['complete_output_arrays'] == 1188
assert audit['strict'] == audit['total']
assert sum(audit['strict'].values()) == 1188
trace = json.loads((BASE / 'trace-cpu-audit.json').read_text())
assert trace['counts'] == {'snapshot_bytes': 2302344, 'snapshot_nodes': 3300,
                           'captured_ABI_bytes': 28512, 'captured_calls': 198}
early = json.loads((BASE / 'first-force-context.json').read_text())
assert early['all_first26_inputs_bitwise_equal'] and early['all8_SDK_initial_force_buffers_bitwise_equal']
assert all(row['bitwise_components_different'] == 11 and row['max_abs_difference'] == 4.76837158203125e-07
           for row in early['force_before_first_drive_differences'].values())
commands = {path.name: json.loads(path.read_text()) for path in sorted(BASE.glob('*.command.json'))}
terminal = {
    'CPU_preflight': {'session': 29012, 'actual_exit': 0},
    'driver': {'session': 31954, 'actual_exit': 0}, 'workers': status['completed'],
    'independent_public_CPU': json.loads((BASE / 'independent-cpu-audit.status.json').read_text()),
    'followup': followup['completed'],
    'additional_CPU': [
        {'script': name, 'actual_exit': 0}
        for name in ('host-guard-inventory.py', 'compare-substep-inputs.py', 'first-force-context.py')
    ],
    'commands': commands, 'all_started_GPU_jobs_terminal': True,
    'all_own_terminal_exit_codes_observed': True,
    'foreign_PIDs_observed_without_interruption': [2630247, 2646250, 2648023, 2651917],
    'foreign_process_exit_codes': None,
    'normal_demo_test_passed_flags_mean_actual_CLI_exit_only': True,
    'original_velocity_bound_not_enforced_by_translated_helper': True,
    'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False,
}
output = BASE / 'commands-and-terminal-status.json'
assert not output.exists()
output.write_text(json.dumps(terminal, indent=2) + '\n')
manifest = BASE / 'phase-manifest.json'
assert not manifest.exists()
files = {}
for path in sorted(BASE.rglob('*')):
    if path.is_file():
        data = path.read_bytes()
        assert len(data) < 100 * 1024 * 1024, path
        files[str(path.relative_to(BASE))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
manifest.write_text(json.dumps({'files': files, 'file_count': len(files),
                               'bytes': sum(row['bytes'] for row in files.values()),
                               'whole_solver_complete': False}, indent=2) + '\n')
print('Closed substep evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
