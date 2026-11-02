"""Freeze completed driven-self evidence while excluding all still-live isolated-worker outputs and logs."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
output = BASE / 'checkpoint-manifest.json'
assert not output.exists()
candidate = json.loads((BASE / 'candidate-force-order/build.json').read_text())
assert candidate['image_sha256'] == '7ca67172b329b643102560c83bf3c21a2f7c661e78321ddd5cf83977657c0220'
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == candidate['image_sha256']
short = json.loads((BASE / 'candidate-short-independent-cpu-v2.json').read_text())
assert len(short['short_cases']) == 12 and sum(row['strict'] for row in short['short_cases']) == 10
assert sum(row['owned_calls'] for row in short['short_cases']) == 9243
assert all(row['sources_within_C8'] == [False, False, False] for row in short['fixed_C8_cases'])
constructors = json.loads((BASE / 'constructors-force-order/report.json').read_text())
assert len(constructors['cases']) == 4 and all(all(row['checks'].values()) for row in constructors['cases'])
surface = json.loads((BASE / 'first-surface-independent-cpu.json').read_text())
assert surface['isolated_three_backend_calls'] == 792
assert surface['original_source_equal_recorded_operands_per_side'] == 8496
assert json.loads((BASE / 'surface-pointer-effects-v2.json').read_text())['RHS_is_not_read_to_form_operands']
scalar = json.loads((BASE / 'surface-scalar-certificates/independent-cpu-audit.json').read_text())
assert scalar['metrics']['actual_GPU_calls'] == 593 and not scalar['isolated_gate_satisfied']
for name in ('candidate-short-independent-cpu-v2.json', 'first-surface-independent-cpu.json',
             'surface-pointer-effects-v2.json', 'surface-scalar-certificates/independent-cpu-audit.json'):
    data = json.loads((BASE / name).read_text())
    for path, expected in data['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
identity = json.loads((BASE / 'surface-scalar-certificates-isolated/waiter-identity.json').read_text())
proc = Path('/proc') / str(identity['pid'])
stat = (proc / 'stat').read_text().split(') ', 1)[1].split()
assert int(stat[19]) == identity['start_ticks'] and stat[0] != 'Z'
assert 'certify-surface-scalars-isolated.py' in (proc / 'cmdline').read_bytes().decode()
assert Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id']
excluded = {'surface-scalar-isolated-driver.log', 'isolated-followup-status.json', 'isolated-followup.log',
            'isolated-followup-cpu.log'}
isolated_fixed = {'plan.json', 'serial-atomic.ptx', 'waiter-identity.json'}
paths = []
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or '__pycache__' in path.parts or path.suffix == '.pyc':
        continue
    relative = path.relative_to(BASE)
    if str(relative) in excluded:
        continue
    if relative.parts[0] == 'surface-scalar-certificates-isolated' and (
            len(relative.parts) != 2 or relative.name not in isolated_fixed):
        continue
    paths.append(path)
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(entry['bytes'] < 100 * 1024 * 1024 for entry in files.values())
record = {'files': files, 'phase_open': True, 'candidate_sha256': candidate['image_sha256'],
          'short_strict_cases': 10, 'short_total_cases': 12, 'owned_calls_equal': 9243,
          'short_fixed_C8_passed_cases': 0, 'constructor_classes_all5_equal': 4,
          'surface_isolated_three_backend_calls': 792, 'equal_operand_words_per_side': 8496,
          'first593_batch_used_for_isolated_acceptance': False, 'isolation_recheck_pending': True,
          'mutable_status_logs_and_pending_GPU_outputs_not_included': True,
          'old_failures_reclassified': False, 'candidate_promoted': False,
          'production_changed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen completed evidence:', len(files), 'files;phase OPEN;isolated593 acceptance still pending')
