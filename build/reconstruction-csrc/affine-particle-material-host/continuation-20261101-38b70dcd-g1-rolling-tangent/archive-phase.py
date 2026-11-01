"""Close the completed rolling-tangent phase without rerunning GPU work or changing earlier failures."""
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
assert audit['counts']['tangent']['complete_vectors_rechecked'] == 600
assert all(value == 120 for value in audit['strict_vectors_of120']['tangent'].values())
assert json.loads((BASE / 'cross-backend-model-fields-reproduced.json').read_text())[
    'first_report_independently_reproduced']
commands = {
    'CPU_preflight': {'script': 'cpu-preflight.py', 'session': 75177, 'actual_exit': 0},
    'capture': {'script': 'run-captures.py', 'session': 16873, 'actual_exit': 0,
                'commands': {side: json.loads((BASE / (side + '.command.json')).read_text())
                             for side in ('original', 'source')}},
    'replay': {'script': 'run-replay.py', 'session': 12520, 'actual_exit': 0,
               'command': json.loads((BASE / 'replay.command.json').read_text())},
    'independent_CPU': {'script': 'independent-cpu-audit.py', 'session': 63230, 'actual_exit': 0},
    'control_CPU': {'script': 'control-form-audit.py', 'actual_exit': 0},
    'model_fields_CPU': {'script': 'cross-backend-model-fields.py', 'actual_exit': 0},
    'foreign_job_observation': {'pid': 2535766, 'initially_live': True, 'interrupted': False,
                                'missing_and_compute_list_empty_before_replay': True},
    'all_started_jobs_terminal': True, 'production_changed': False, 'frozen_failure_reclassified': False,
    'whole_solver_complete': False,
}
output = BASE / 'commands-and-terminal-status.json'
assert not output.exists()
output.write_text(json.dumps(commands, indent=2) + '\n')
manifest = BASE / 'phase-manifest.json'
assert not manifest.exists()
files = {}
for path in sorted(BASE.rglob('*')):
    if path.is_file():
        data = path.read_bytes()
        files[str(path.relative_to(BASE))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
manifest.write_text(json.dumps({'files': files, 'file_count': len(files),
                               'bytes': sum(item['bytes'] for item in files.values()),
                               'whole_solver_complete': False}, indent=2) + '\n')
print('Closed rolling-tangent evidence', len(files), 'files', sum(item['bytes'] for item in files.values()), 'bytes')
