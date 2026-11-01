"""Close the drive/state evidence, preserving failed diagnostics and the unchanged full-solver failure."""
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
assert sum(row['complete_vectors_rechecked'] for row in audit['counts'].values()) == 4800
assert sum(sum(row.values()) for row in audit['strict_vectors_of120'].values()) == 4789
cache = json.loads((BASE / 'cross-backend-constructor-cache-fields.json').read_text())
assert len(cache['fields']) == 41 and cache['all_recorded_fields_constant_and_equal']
assert sum(value for row in audit['strict_vectors_of120'].values()
           for name, value in row.items() if name.startswith('source-ptx-')) == 1200
assert json.loads((BASE / 'replay-revision.json').read_text())['all600_capture_packets_unchanged']
followup = json.loads((BASE / 'atomic-followup.status.json').read_text())
assert followup['complete'] and followup['running'] is None
assert all(row['actual_exit'] == 0 for row in followup['completed'])
proof = json.loads((BASE / 'atomic-followup-cpu-audit.json').read_text())
assert proof['counts']['GPU_scalar_certificates'] == 63367
assert proof['counts']['actual_SDK_PTX_source_isolated_calls'] == 30960
assert json.loads((BASE / 'frozen-spike-context.json').read_text())['spike']['error'] == 23.851294673979282
terminal = {
    'CPU_preflight': {'session': 44808, 'actual_exit': 0},
    'capture': {'session': 69204, 'actual_exit': 0},
    'failed_replay_preserved': {'session': 73313, 'actual_exit': 1},
    'corrected_CPU_preflight': {'session': 31949, 'actual_exit': 0},
    'corrected_replay': {'session': 90754, 'actual_exit': 0},
    'independent_CPU': {'session': 50025, 'actual_exit': 0},
    'atomic_preparation': {'session': 97771, 'actual_exit': 0, 'earlier_CPU_refusal_preserved': True},
    'atomic_followup': {'session': 29272, 'actual_exit': 0, 'steps': followup['completed']},
    'filter_domain_CPU': {'actual_exit': 0}, 'frozen_spike_CPU': {'actual_exit': 0, 'GPU_done': False},
    'all_started_GPU_jobs_terminal': True, 'strict_drive_failures_retained': True,
    'old_full_C8_failure_retained': True, 'production_changed': False, 'whole_solver_complete': False,
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
print('Closed drive/state evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
