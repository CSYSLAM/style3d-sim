"""Close actual first-H1 self diagnostics and active EF branch evidence while keeping trajectory failures intact."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
hashes = {}


def read(path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


GPU_jobs, CPU_jobs = 0, 0
for name, count in [('run.status.json', 2), ('full-inputs/run.status.json', 2), ('full-inputs/replay.status.json', 1),
                    ('producer-operands.status.json', 1), ('native-query-isolation.status.json', 6),
                    ('active-ef-fixtures.status.json', 1)]:
    status = read(BASE / name)
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert len(status['GPU_admission']) == count and all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
    GPU_jobs += count
    CPU_jobs += len(status['completed']) - count
assert (GPU_jobs, CPU_jobs) == (13, 1)
for path in sorted(BASE.rglob('*.json')):
    if 'plan' in path.name or 'independent-cpu' in path.name:
        document = read(path)
        for name, expected in document.get('input_sha256', {}).items():
            actual = hashlib.sha256(Path(name).read_bytes()).hexdigest()
            assert actual == expected, name
            hashes[name] = actual
static = read(BASE / 'static-csr-independent-cpu.json')
assert static['all_static_arrays_byte_equal_between_endpoints']
assert static['all_static_CSR_entries_rebuilt_from_actual_model_topology']
active = read(BASE / 'active-contact-inputs-independent-cpu.json')
assert active['all_7423_contact_record_multisets_equal'] and active['all_stage_contact_prefix_links_byte_equal']
capture = read(BASE / 'full-inputs/captures-independent-cpu.json')
assert capture['counts']['actual_copy_descriptors'] == 100
assert capture['counts']['complete_snapshot_bytes'] == 210210680
replay = read(BASE / 'full-inputs/replay-independent-cpu-audit.json')
assert replay['counts']['packets'] == 8 and replay['counts']['actual_calls'] == 24
assert sum(replay['strict'].values()) == 36 and sum(replay['total'].values()) == 78
operands = read(BASE / 'producer-operands-independent-cpu.json')
assert operands['all_same_packet_ordered_operands_and_appends_equal']
assert operands['actual_F32_records_checked'] == 22112448 and operands['actual_contact_append_rows_checked'] == 29692
queries = read(BASE / 'native-query-isolation-independent-cpu.json')
assert queries['counts']['native_PTX_source_calls'] == 850560
assert queries['counts']['independent_integer_F32_steps'] == 6225792
assert queries['counts']['original_query_controls'] == 40
assert queries['counts']['complete_output_and_guard_words_GPU_compared'] == 352924666200
fixtures = read(BASE / 'active-ef-fixtures-independent-cpu.json')
assert fixtures['actual_GPU_calls'] == 76 and fixtures['complete_output_pairs_verified'] == 38
assert fixtures['EF_active_five_point_records_and_three_world_branch_fixtures_verified']
assert fixtures['four_and_five_point_tangent_grid_strides_1_7_256_verified']
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
pyc = [name for name in snapshot['files'] if name.endswith('.pyc')]
assert len(pyc) == 360
for name in pyc + ['style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
                   'src/style3d_sim/__init__.py', 'reconstruction/csrc/native/source_solver.cpp']:
    raw = (ROOT / name).read_bytes()
    assert len(raw) == snapshot['files'][name]['bytes']
    assert hashlib.sha256(raw).hexdigest() == snapshot['files'][name]['sha256']
for path in BASE.glob('*.py'):
    text = path.read_text()
    ast.parse(text)
    assert max(map(len, text.splitlines()), default=0) <= 128, path
previous = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
assert read(previous / 'public-h1-C8-independent-cpu.json')['source_C8_passed'] == [True, False, False]
target = BASE / 'close-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'actual_GPU_jobs': GPU_jobs, 'driver_independent_CPU_children': CPU_jobs,
    'complete_capture_descriptors': 100, 'complete_capture_bytes': 210210680,
    'native_self_aggregate_outputs_strict': 36, 'native_self_aggregate_outputs_total': 78,
    'actual_F32_operand_records_checked': 22112448, 'actual_append_rows_checked': 29692,
    'native_PTX_source_query_calls_strict': 850560, 'original_selected_query_controls_strict': 40,
    'independent_integer_F32_steps': 6225792, 'active_EF_EE_tangent_fixture_GPU_calls_strict': 76,
    'all_actual_7423_complete_records_correspond': True, 'EF_active_branch_covered_in_controlled_fixtures': True,
    'SDK_and_360_frozen_pyc_unchanged': True, 'normal_H1_source_C8_retained': [True, False, False],
    'production_changed': False, 'source_candidate_promoted': False, 'numeric_failures_rejudged': False,
    'GPU_runs': 0, 'whole_solver_complete': False, 'upload_requested': False, 'input_sha256': hashes}, indent=2) + '\n')
print('Self phase independently closed:13GPU jobs,850560 strict native queries,activeEF covered; old failures retained')
