"""Close this measured phase while retaining strict failures and the unchanged full-solver failure."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
status = json.loads((BASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert status['completed'] == [{'backend': side, 'exit': 0} for side in ('original', 'source')]
assert json.loads((BASE / 'replay.status.json').read_text()) == {
    'exit': 0, 'complete': True, 'whole_solver_complete': False,
}
audit = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert not audit['all_complete_outputs_strict']
assert sum(row['complete_vectors_rechecked'] for row in audit['counts'].values()) == 1560
assert json.loads((BASE / 'cross-backend-constructor-cache-fields.json').read_text())[
    'all_recorded_fields_constant_and_equal']
followup = json.loads((BASE / 'atomic-followup.status.json').read_text())
assert followup['complete'] and followup['running'] is None
assert all(row['actual_exit'] == 0 for row in followup['completed'])
proof = json.loads((BASE / 'atomic-followup-cpu-audit.json').read_text())
assert proof['counts']['GPU_scalar_certificates'] == 64867
assert proof['counts']['actual_SDK_PTX_source_isolated_calls'] == 61920
terminal = {
    'CPU_preflight_refusal': {'session': 6252, 'actual_exit': 1, 'GPU_started': False, 'preserved': True},
    'literal_CPU_regression': {'actual_exit': 0, 'cases': 6},
    'CPU_preflight': {'session': 57528, 'actual_exit': 0},
    'capture': {'session': 15273, 'actual_exit': 0},
    'replay': {'session': 88332, 'actual_exit': 0},
    'independent_CPU': {'session': 87392, 'actual_exit': 0},
    'atomic_preparation': {'session': 10095, 'actual_exit': 0, 'earlier_CPU_width_refusal_preserved': True},
    'atomic_followup': {'session': 17282, 'actual_exit': 0, 'steps': followup['completed']},
    'next_stage_inventory': {'actual_exit': 0, 'earlier_CPU_symbol_refusal_preserved': True, 'GPU_started': False},
    'all_started_GPU_jobs_terminal': True, 'normal_source_core_has_no_SDK_mapping': True,
    'strict_joint_failures_retained': True, 'full_C8_failure_retained': True,
    'production_changed': False, 'whole_solver_complete': False,
}
terminal['commands'] = {path.name: json.loads(path.read_text()) for path in sorted(BASE.glob('*.command.json'))}
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
print('Closed inertial/joint/SO3 phase', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
