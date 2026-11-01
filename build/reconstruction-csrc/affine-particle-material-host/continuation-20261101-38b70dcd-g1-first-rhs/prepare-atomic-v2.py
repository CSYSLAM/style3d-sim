"""Preserve the failed trace parser and rerun only its probes with the correct128-record lane stride."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
old, new = BASE / 'atomic', BASE / 'atomic-v2'
new.mkdir(exist_ok=False)
plan = json.loads((old / 'plan.json').read_text())
probe = ROOT / 'reconstruction/csrc/g1_first_joint_probe.py'
before = (old / 'g1_first_joint_probe-as-run-v1.py').read_text()
after = before.replace("np.zeros((256, 256, 16), dtype='u1')", "np.zeros((256, 128, 16), dtype='u1')")
after = after.replace('sizes.max() <= 256', 'sizes.max() <= 128')
assert probe.read_text() == after
hashes = {}
for name, expected in plan['input_sha256'].items():
    path = Path(name)
    if path == probe:
        hashes[name] = hashlib.sha256(probe.read_bytes()).hexdigest()
    elif path.is_relative_to(old):
        data = path.read_bytes()
        assert hashlib.sha256(data).hexdigest() == expected, name
        target = new / path.relative_to(old)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        hashes[str(target)] = expected
    else:
        assert hashlib.sha256(path.read_bytes()).hexdigest() == expected, name
        hashes[name] = expected
for old_name, new_name in [('probe-independent-cpu-audit.py', 'probe-independent-cpu-audit-v2.py'),
                           ('prepare-followup.py', 'prepare-followup-v2.py'), ('run-atomic.py', 'run-atomic-v2.py')]:
    text = (BASE / old_name).read_text()
    text = text.replace("'atomic'", "'atomic-v2'")
    if old_name == 'run-atomic.py':
        text = text.replace("'probe-independent-cpu-audit.py'", "'probe-independent-cpu-audit-v2.py'")
        text = text.replace("'prepare-followup.py'", "'prepare-followup-v2.py'")
    ast.parse(text)
    target = BASE / new_name
    assert not target.exists()
    target.write_text(text)
    hashes[str(target)] = hashlib.sha256(target.read_bytes()).hexdigest()
for path in (Path(__file__), old / 'plan.json', old / 'g1_first_joint_probe-as-run-v1.py', old / 'probe-stride-v1-error.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
plan.update({'input_sha256': hashes,
             'v1_failed_evidence_preserved': True, 'v1_trace_stride_mismatch_fixed': [256, 128],
             'first_RHS_joint_drive_capture_not_repeated': True, 'production_changed': False})
(new / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(BASE / 'atomic-revision.json').write_text(json.dumps({
    'v1_driver_session': 67817, 'v1_actual_exit': 1, 'v1_failed_CPU_audit_preserved': True,
    'probe_producer_only_changes': ['trace array lanes use128 records', 'capacity assertion uses128 records'],
    'captured_joint_inputs_byte_identical': True, 'isolation_and_certificate_mathematics_unchanged': True,
    'production_changed': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('Prepared atomic-v2; original capture and failed v1 evidence untouched; producer differs by two stride constants')
