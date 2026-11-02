"""Freeze CPU host-flow evidence and the new plan while keeping all live status/log/GPU outputs outside acceptance."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'preparation-manifest.json'
assert not OUTPUT.exists()
view = json.loads((BASE / 'surface-view-pointer-audit.json').read_text())
assert view['all_captured_surface_views_equal'] and view['original_source_view_pairs'] == 144
proof = json.loads((BASE / 'planned-write-proof.json').read_text())
assert proof['all_potential_writes_captured'] and proof['actual_PTX_entries_checked'] == 28
memory = [json.loads(path.read_text()) for path in sorted(BASE.glob('device-memory-*.json'))]
assert len(memory) == 4 and all(row['all_captured_sequences_equal'] for row in memory)
for report in (view, proof, *memory):
    for path, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
plan = json.loads((BASE / 'linear-flow-plan.json').read_text())
assert len(plan['jobs']) == 4
assert sum(len(job['stages']) for job in plan['jobs']) == 2376
assert sum(job['expected_snapshot_files'] for job in plan['jobs']) == 29844
for path, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
identity = json.loads((BASE / 'linear-captures/runner-identity.json').read_text())
proc = Path('/proc') / str(identity['pid'])
stat = (proc / 'stat').read_text().split(') ', 1)[1].split()
assert int(stat[19]) == identity['start_ticks'] and stat[0] != 'Z'
assert 'run-linear-flow.py' in (proc / 'cmdline').read_bytes().decode()
assert Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id']
previous = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/surface-scalar-certificates-isolated'
old_identity = json.loads((previous / 'waiter-identity.json').read_text())
old_proc = Path('/proc') / str(old_identity['pid'])
old_stat = (old_proc / 'stat').read_text().split(') ', 1)[1].split()
assert int(old_stat[19]) == old_identity['start_ticks'] and old_stat[0] != 'Z'
assert not (previous / 'report.json').exists()
excluded = {'linear-driver.log', 'linear-independent-cpu.log'}
paths = []
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or '__pycache__' in path.parts or path.suffix == '.pyc':
        continue
    relative = path.relative_to(BASE)
    if str(relative) in excluded:
        continue
    if relative.parts[0] == 'linear-captures' and (
            len(relative.parts) != 2 or relative.name not in ('runner-inputs.json', 'runner-identity.json')):
        continue
    paths.append(path)
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(row['bytes'] < 100 * 1024 * 1024 for row in files.values())
OUTPUT.write_text(json.dumps({'files': files, 'phase_open': True, 'view_pointer_pairs_equal': 144,
    'memory_operation_pairs_equal': 654, 'planned_full_input_kernel_types': 14, 'static_PTX_write_entries_checked': 28,
    'planned_trajectory_workers': 4, 'planned_stages': 2376, 'planned_snapshot_files': 29844,
    'GPU_used_for_this_checkpoint': False, 'GPU_runtime_validation_claimed': False,
    'first_isolated_scalar_recheck_still_pending': True, 'mutable_outputs_and_logs_excluded': True,
    'fixed_C8_failures_reclassified': False, 'candidate_promoted': False, 'production_changed': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Frozen', len(files), 'completed CPU/plan files;four diagnostic GPU workers still pending', flush=True)
