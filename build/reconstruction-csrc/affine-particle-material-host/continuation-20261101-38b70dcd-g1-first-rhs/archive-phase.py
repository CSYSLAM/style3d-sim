"""Close the first-joint proof with both rejected diagnostics and every observed process exit preserved."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
for name in ('run.status.json', 'followup.status.json'):
    status = json.loads((BASE / name).read_text())
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
strict = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert strict['counts']['actual_calls'] == 18 and sum(strict['strict'].values()) == 26
assert sum(strict['total'].values()) == 30
boundary = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert all(boundary['old_first_force_before_bitwise_reproduced'].values())
assert boundary['force_boundaries']['joint']['before']['different_words'] == 0
assert boundary['force_boundaries']['joint']['after']['different_words'] == 11
old = json.loads((BASE / 'atomic/run.status.json').read_text())
v2 = json.loads((BASE / 'atomic-v2/run.status.json').read_text())
v3 = json.loads((BASE / 'atomic-v2/continuation-v3.status.json').read_text())
assert old['completed'][-1]['actual_exit'] == v2['completed'][-1]['actual_exit'] == 1
assert v3['complete'] and all(row['actual_exit'] == 0 for row in v3['completed'])
proof = json.loads((BASE / 'atomic-v2/atomic-followup-cpu-audit.json').read_text())
assert proof['counts'] == {
    'complete_isolated_output_words': 544896, 'actual_SDK_PTX_source_isolated_calls': 1032,
    'actual_isolated_ABI_bytes_rechecked': 19952, 'GPU_scalar_certificates': 1086,
    'GPU_F32_atomic_histories_rechecked': 4292, 'packets': 2,
}
assert json.loads((BASE / 'revision-independent-cpu-audit.json').read_text())['all_original_joint_capture_bytes_unchanged']
terminal = {
    'CPU_preflight': {'session': 10279, 'actual_exit': 0},
    'capture_and_direct_replay': {'session': 56089, 'actual_exit': 0},
    'worker_steps': json.loads((BASE / 'run.status.json').read_text())['completed'],
    'direct_followup_steps': json.loads((BASE / 'followup.status.json').read_text())['completed'],
    'failed_stride_diagnostic': {'session': 67817, 'actual_exit': 1, 'steps': old['completed'],
                                 'preliminary_probe_boolean_rejected_by_independent_CPU': True},
    'corrected_probe_wrapper_bootstrap_failure': {'session': 23608, 'actual_exit': 1, 'steps': v2['completed']},
    'corrected_wrapper_continuation': {'session': 43265, 'actual_exit': 0, 'steps': v3['completed']},
    'revision_independent_CPU': {'actual_exit': 0},
    'all_started_own_GPU_jobs_terminal': True,
    'all_own_terminal_exit_codes_observed': True,
    'commands': {str(p.relative_to(BASE)): json.loads(p.read_text()) for p in sorted(BASE.rglob('*.command.json'))},
    'strict_failures_retained': 4, 'old_C8_reclassified': False,
    'production_changed': False, 'whole_solver_complete': False,
}
path = BASE / 'commands-and-terminal-status.json'
assert not path.exists()
path.write_text(json.dumps(terminal, indent=2) + '\n')
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
print('Closed first-RHS/joint evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
