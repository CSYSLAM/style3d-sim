"""Close complete actual cloth producer and self-diagonal consumer evidence without changing old acceptance results."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
hashes = {}


def read(path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


groups = [('run.status.json', 2), ('replay.status.json', 1), ('producer-operands.status.json', 1),
          ('cloth-native-isolation.status.json', 4)]
GPU_jobs, CPU_jobs = 0, 0
for name, planned in groups:
    status = read(BASE / name)
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert len(status['GPU_admission']) == planned
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
    GPU_jobs += planned
    CPU_jobs += len(status['completed']) - planned
assert (GPU_jobs, CPU_jobs) == (8, 1)
for path in BASE.rglob('*.json'):
    if 'plan' in path.name or 'independent-cpu' in path.name:
        document = read(path)
        for name, expected in document.get('input_sha256', {}).items():
            actual = hashlib.sha256(Path(name).read_bytes()).hexdigest()
            assert actual == expected, name
            hashes[name] = actual
capture = read(BASE / 'captures-independent-cpu.json')
assert capture['counts']['actual_copy_descriptors'] == 36
assert capture['counts']['complete_snapshot_bytes'] == 27758240
assert capture['original_nodes_and_edges_preserved'] and not capture['first_C8_samples_replaced']
replay = read(BASE / 'replay-independent-cpu-audit.json')
assert replay['counts']['packets'] == 6 and replay['counts']['actual_calls'] == 18
assert replay['counts']['complete_output_arrays'] == 18
assert sum(replay['strict'].values()) == 6 and sum(replay['total'].values()) == 18
assert all(total == replay['strict'][key] for key, total in replay['total'].items() if key.startswith('self-add:'))
operands = read(BASE / 'producer-operands-independent-cpu.json')
assert operands['all_packet_PTX_operands_equal'] and operands['total_actual_records_checked'] == 7216968
assert all(row['corresponding_actual_operands_equal'] for row in operands['cross_endpoint'])
native = read(BASE / 'cloth-native-isolation-independent-cpu.json')
assert native['counts']['primitives'] == 335128 and native['counts']['actual_native_PTX_source_calls'] == 1005384
assert native['counts']['independent_integer_F32_steps'] == 3608484
assert native['counts']['actual_valid_target_words_recorded'] == 10825452
assert native['counts']['full_RHS_guard_and_dummy_words_GPU_compared'] == 102465721128
assert len(native['cases']) == 4 and all(row['all_three_backends_full_outputs_strict'] for row in native['cases'])
assert all(row['all_negative_controls_CPU_verified'] for row in native['cases'])
assert not native['original_aggregate_or_C8_failures_rejudged'] and not native['joint_global_schedule_proven']
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
pyc = [name for name in snapshot['files'] if name.endswith('.pyc')]
assert len(pyc) == 360
for name in pyc + ['style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
                   'reconstruction/csrc/native/source_solver.cpp', 'src/style3d_sim/__init__.py']:
    raw = (ROOT / name).read_bytes()
    assert len(raw) == snapshot['files'][name]['bytes']
    assert hashlib.sha256(raw).hexdigest() == snapshot['files'][name]['sha256']
for path in BASE.glob('*.py'):
    text = path.read_text()
    ast.parse(text)
    assert max(map(len, text.splitlines()), default=0) <= 128, path
old = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
assert read(old / 'public-h1-C8-independent-cpu.json')['source_C8_passed'] == [True, False, False]
target = BASE / 'close-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'actual_GPU_jobs': GPU_jobs, 'driver_independent_CPU_children': CPU_jobs,
    'actual_capture_copy_descriptors': 36, 'complete_capture_bytes': 27758240,
    'self_add_same_input_outputs_strict': 6, 'cloth_force_aggregate_outputs_strict': 0,
    'cloth_force_aggregate_outputs_total': 12, 'real_PTX_atomic_records_checked': 7216968,
    'actual_native_PTX_source_primitive_calls_strict': 1005384,
    'independent_integer_F32_steps': 3608484, 'actual_all_word_GPU_comparisons': 102465721128,
    'both_endpoint_actual_RHS_seeds_checked': True, 'normal_H1_source_C8_retained': [True, False, False],
    'source_candidate_promoted': False, 'production_changed': False, 'SDK_and_360_frozen_pyc_unchanged': True,
    'numeric_failures_rejudged': False, 'joint_global_schedule_proven': False,
    'whole_solver_complete': False, 'GPU_runs': 0, 'input_sha256': hashes}, indent=2) + '\n')
print('Cloth phase independently closed: 8 GPU jobs, 1005384 strict native primitive calls, aggregate failures retained')
