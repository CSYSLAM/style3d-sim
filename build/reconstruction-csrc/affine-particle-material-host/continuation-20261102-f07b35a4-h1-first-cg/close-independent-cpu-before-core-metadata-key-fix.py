"""Close actual first-H1 CG/producer diagnostics without rejudging frozen trajectories or changing production."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OLD = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
hashes = {}


def checked(path, expected=None):
    path = Path(path)
    raw = path.read_bytes()
    actual = hashlib.sha256(raw).hexdigest()
    if expected is not None:
        assert actual == expected, path
    if str(path) in hashes:
        assert hashes[str(path)] == actual, path
    hashes[str(path)] = actual
    return raw


def read(path):
    return json.loads(checked(path))


statuses = ['run.status.json', 'replay.status.json', 'assembly-watch/run.status.json',
            'assembly-full-inputs/run.status.json', 'assembly-full-inputs/replay.status.json',
            'producer-operands.status.json', 'soft-force-isolation.status.json', 'soft-matrix-isolation.status.json',
            'soft-matrix-source-isolation.status.json', 'membrane-native-isolation.status.json']
GPU_jobs, CPU_jobs = 0, 0
for name in statuses:
    status = read(BASE / name)
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
    GPU_jobs += len(status['GPU_admission'])
    CPU_jobs += len(status['completed']) - len(status['GPU_admission'])
assert GPU_jobs == 13 and CPU_jobs == 2
for path in sorted(BASE.rglob('*.json')):
    if path.name.endswith('plan.json') or 'independent-cpu' in path.name:
        document = read(path)
        for name, expected in document.get('input_sha256', {}).items():
            checked(name, expected)
first = read(BASE / 'replay-independent-cpu-audit.json')
assert first['counts']['packets'] == 166 and first['counts']['actual_calls'] == 498
assert first['counts']['complete_output_arrays'] == 864
nonreduction, scalar_strict, scalar_total = 0, 0, 0
for key, total in first['total'].items():
    stage, _, arg = key.split(':')
    if (stage, arg) in [('precondition', '6'), ('matrix', '9')]:
        scalar_strict += first['strict'][key]
        scalar_total += total
    else:
        assert first['strict'][key] == total, key
        nonreduction += total
assert (nonreduction, scalar_strict, scalar_total) == (624, 2, 240)
full = read(BASE / 'assembly-full-inputs/replay-independent-cpu-audit.json')
assert full['counts']['packets'] == 6 and full['counts']['actual_calls'] == 18
assert sum(full['total'].values()) == 36 and sum(full['strict'].values()) == 0
operands = read(BASE / 'producer-operands-independent-cpu.json')
assert operands['all_packet_PTX_operands_equal'] and operands['total_actual_records_checked'] == 22006912
endpoint_inputs = read(BASE / 'producer-endpoint-inputs-independent-cpu.json')
assert len(endpoint_inputs['cases']) == 3
for row in endpoint_inputs['cases']:
    assert row['all_scalar_or_NULL_parameters_equal'] and row['non_record_readonly_inputs_equal']
    if row['stage'].startswith('soft'):
        assert row['complete_44byte_contact_record_multiset_equal'] and row['active_contact_records'] == 8891
        assert not row['original_contact_record_order_equal']
    else:
        assert row['all_75_changed_diagonal_words_outside_every_triangle_target']
isolation_calls, integer_steps = 0, 0
for folder, steps in [('soft-force-native-isolation', 21088), ('soft-matrix-native-isolation', 59310),
                      ('soft-matrix-source-native-isolation', 59310)]:
    audit = read(BASE / (folder + '-independent-cpu.json'))
    assert audit['all_three_backends_strict'] and audit['F32_RNE_FTZ_histories_reproduced_with_integer_arithmetic']
    assert audit['counts']['contacts'] == 8891 and audit['counts']['actual_native_PTX_source_calls'] == 26673
    assert audit['counts']['integer_F32_steps'] == steps
    isolation_calls += 26673
    integer_steps += steps
membrane = read(BASE / 'membrane-native-isolation-independent-cpu.json')
assert membrane['all_native_SDK_original_PTX_source_complete_outputs_strict']
assert membrane['GPU_comparator_negative_controls_independently_reconstructed_with_complete_CPU_readback_SHA']
assert membrane['counts']['triangles'] == 66930 and membrane['counts']['actual_native_PTX_source_calls'] == 200790
assert membrane['counts']['integer_F32_steps'] == 5421330
isolation_calls += 200790
integer_steps += 5421330
assert isolation_calls == 280809 and integer_steps == 5561038
captures = read(BASE / 'captures-independent-cpu.json')
assert captures['counts']['actual_copy_descriptors'] == 1156
assert captures['counts']['complete_snapshot_bytes'] == 1858635448
assert captures['original_nodes_and_edges_preserved'] and not captures['first_C8_samples_replaced']
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
assert subprocess.check_output(['git', 'hash-object', str(snapshot_path)], text=True).strip() == subprocess.check_output(
    ['git', 'rev-parse', 'HEAD:RECONSTRUCTION_SNAPSHOT.json'], text=True).strip()
pyc = [name for name in snapshot['files'] if name.endswith('.pyc')]
assert len(pyc) == 360
for name in pyc + ['style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
                   'src/style3d_sim/__init__.py', 'reconstruction/csrc/native/source_solver.cpp']:
    raw = checked(ROOT / name, snapshot['files'][name]['sha256'])
    assert len(raw) == snapshot['files'][name]['bytes']
host = read(ROOT / 'build/reconstruction-csrc/host-particles/build.json')
core = read(OLD / 'candidate-public-core/build.json')
candidate = read(OLD / 'candidate-force-order/build.json')
assert candidate['image_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
assert core['extension_sha256'] == 'aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830'
assert host['extension_sha256'] == snapshot['source_image_sha256']
checked(candidate['image'], candidate['image_sha256'])
checked(ROOT / core['extension'], core['extension_sha256'])
assert not core['solver_api_ready'] and not core['default_package_switched']
old_manifest = read(OLD / 'completion-manifest.json')
for name in ('public-h1-C8-independent-cpu.json', 'public-h1-sdk-heldout3-independent-cpu.json'):
    path = OLD / name
    checked(path, old_manifest['files'][str(path.relative_to(ROOT))]['sha256'])
assert read(OLD / 'public-h1-C8-independent-cpu.json')['source_C8_passed'] == [True, False, False]
assert read(OLD / 'public-h1-sdk-heldout3-independent-cpu.json')['control_C8_passed'] == [True, True, False]
for path in BASE.glob('*.py'):
    ast.parse(path.read_text())
    assert max(map(len, path.read_text().splitlines()), default=0) <= 128, path
for name in ('h1_first_assembly_layout.py', 'h1_first_cg_layout.py', 'h1_pre_cg_watch_layout.py'):
    path = ROOT / 'reconstruction/csrc' / name
    ast.parse(path.read_text())
    assert max(map(len, path.read_text().splitlines())) <= 128
target = BASE / 'close-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'actual_GPU_jobs': GPU_jobs, 'driver_independent_CPU_children': CPU_jobs,
    'first_NL_full_CG_iterations': 20, 'same_input_nonreduction_outputs_strict': nonreduction,
    'scalar_strict': scalar_strict, 'scalar_total': scalar_total,
    'full_assembly_aggregate_outputs_strict': 0, 'full_assembly_aggregate_outputs_total': 36,
    'actual_original_source_PTX_operand_records_checked': 22006912,
    'actual_native_PTX_source_isolation_calls_all_strict': isolation_calls,
    'independent_integer_F32_steps': integer_steps,
    'all_8891_soft_contacts_checked_force_and_both_matrix_seeds': True,
    'all_66930_membrane_triangles_checked_with_complete_outputs': True,
    'native_triangle_complete_GPU_checked_words': membrane['counts']['full_output_and_guard_words_GPU_compared'],
    'normal_public_H1_source_C8_retained': [True, False, False],
    'source_candidate_promoted': False, 'production_changed': False,
    'SDK_and_360_frozen_pyc_unchanged': True, 'whole_solver_complete': False,
    'joint_global_atomic_schedule_proven': False, 'numeric_failures_rejudged': False,
    'GPU_runs': 0, 'input_sha256': hashes}, indent=2) + '\n')
print('First-H1 phase independently closed: 13 GPU jobs, 280809 strict native isolation calls, old failures retained')
