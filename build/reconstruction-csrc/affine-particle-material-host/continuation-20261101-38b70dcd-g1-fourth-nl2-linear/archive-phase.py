"""Close actual NL2 capture/replay/isolation evidence while retaining all strict and whole-solver failures."""
import ast
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
for plan_name in ('plan.json', 'atomic-plan.json'):
    plan = json.loads((BASE / plan_name).read_text())
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
statuses = {}
for name, expected in [('run', 2), ('followup', 3), ('atomic', 2)]:
    status = json.loads((BASE / (name + '.status.json')).read_text())
    assert status['complete'] and status['running'] is None and len(status['completed']) == expected
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    statuses[name] = status['completed']
capture = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert capture['counts'] == {'actual_copy_descriptor_bytes': 27600, 'snapshot_bytes': 843512,
                             'actual_pointer_and_complete_payload_links': 28}
replay = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert replay['counts']['actual_calls'] == 60 and replay['counts']['complete_output_arrays'] == 96
assert sum(replay['strict'].values()) == 81
for name, total in replay['total'].items():
    if not name.startswith(('precondition_first:', 'precondition_last:', 'matrix_last:')) or \
            name.rsplit(':', 1)[-1] not in ('6', '9'):
        assert replay['strict'][name] == total
atomic = json.loads((BASE / 'atomic-independent-cpu-audit.json').read_text())
assert atomic['all_passed'] and atomic['fifteen_strict_scalar_failures_retained']
assert atomic['counts']['literal_GPU_atomic_records'] == 2816
assert atomic['counts']['isolated_SDK_PTX_source_contributors'] == 8448
assert atomic['counts']['hardware_certificates'] == 21
assert atomic['counts']['hardware_F32_before_values'] == 3696
for label in ('sdk0', 'rebuilt0'):
    with np.load(BASE / label / 'trace/inverse-packets/frame-00.npz', allow_pickle=False) as packet:
        m = packet['before-arg-0'].view('<f4').reshape(176, 3, 3)
    s01, s02, s12 = [np.float32(np.float32(m[:, i, j] + m[:, j, i]) * np.float32(0.5))
                       for i, j in ((0, 1), (0, 2), (1, 2))]
    c11 = np.float32(np.float32(m[:, 0, 0] * m[:, 2, 2]) - np.float32(s02 * s02))
    c12 = np.float32(np.float32(s01 * s02) - np.float32(m[:, 0, 0] * s12))
    c22 = np.float32(np.float32(m[:, 0, 0] * m[:, 1, 1]) - np.float32(s01 * s01))
    assert np.isfinite(c11).all() and np.isfinite(c12).all() and np.isfinite(c22).all()
for path in [*BASE.glob('*.py'), ROOT / 'reconstruction/csrc/g1_nl2_linear.py',
             ROOT / 'reconstruction/csrc/g1_nl2_atomic.py']:
    if path.name.endswith(('template.py', 'as-run.py')):
        continue
    ast.parse(path.read_text())
    assert all(len(line) <= 128 for line in path.read_text().splitlines()), str(path)
terminal = {
    'CPU_preflight_before_formatting': {'session': 26272, 'actual_exit': 0},
    'CPU_preflight_after_formatting': {'session': 23707, 'actual_exit': 0},
    'capture_replay_driver': {'session': 20100, 'actual_exit': 0},
    'atomic_driver': {'session': 45158, 'actual_exit': 0}, 'children': statuses,
    'static_context_CPU': {'session': 47399, 'actual_exit': 0},
    'inverse_text_and_revision_CPU': {'actual_exit': 0}, 'linear_inputs_CPU': {'actual_exit': 0},
    'remaining_three_inverse_cofactors_finite': True,
    'all_started_own_GPU_jobs_terminal': True, 'foreign_PID_2704714_interrupted': False,
    'foreign_process_exit': None, 'whole_solver_complete': False, 'strict_failures_reclassified': False,
    'production_changed': False, 'commands': {p.name: json.loads(p.read_text()) for p in sorted(BASE.glob('*.command.json'))},
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
print('Closed NL2 linear evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
