"""Close the combined host recovery phase while preserving every numerical and sanitizer failure."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
hashes = {}


def read(path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


host = read(ROOT / 'build/reconstruction-csrc/host-particles/build.json')
candidate = read(BASE / 'candidate-force-order/build.json')
core_path = BASE / 'candidate-public-core/build.json'
core = read(core_path)
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert candidate['image_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
assert core['extension_sha256'] == 'aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830'
assert core['source_host_sha256'] == candidate['image_sha256']
for name, expected in candidate['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for name, expected in core['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
assert (ROOT / core['compiled_solver_source']).read_bytes() == (BASE / 'candidate-force-order/source_solver.cpp').read_bytes()
assert core['compiler_include_trace_verified'] and core['source_only'] and not core['solver_api_ready']
assert not core['default_package_switched'] and not core['production_changed']
assert core['kernel_count'] == host['kernel_count'] == 176 and core['cuda_source_digest'] == host['cuda_source_digest']
groups = [('force-order-captures', 12, [0] * 12), ('constructors-force-order', 16, [0] * 16),
          ('short-fixed-C8', 4, [0] * 4), ('granular-regression', 6, [0] * 6), ('sdk-heldout3', 6, [0] * 6),
          ('public-h1-probe', 2, [0, 0]), ('public-h1-fixed-C8', 9, [0] * 9),
          ('public-h1-sdk-heldout3', 3, [0] * 3), ('public-h1-graph', 2, [0, 0]),
          ('combined-initcheck', 6, [0, 0, 0, 0, 97, 97]), ('public-h1-graph-with-alloc', 2, [0, 0]),
          ('public-h1-d2h396', 2, [97, 97]), ('public-h1-d2h396-names', 2, [97, 97])]
gpu_jobs = 0
for name, count, exits in groups:
    status = read(BASE / name / 'status.json')
    assert status['complete'] and status['running'] is None and len(status['completed']) == count
    assert [row['actual_exit'] for row in status['completed']] == exits
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
    gpu_jobs += len(status['GPU_admission'])
    plan = read(BASE / name / 'plan.json')
    for path, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
assert gpu_jobs == 68
short = read(BASE / 'rebase-short-independent-cpu.json')
assert short['exact_three_hunks_reversible_to_ae'] and len(short['cases']) == 12
assert sum(row['state_strict'] for row in short['cases']) == 10
assert sum(row['owned_calls'] for row in short['cases']) == 9243
ctors = read(BASE / 'constructors-force-order/report.json')
assert len(ctors['cases']) == 4 and all(all(row['checks'].values()) for row in ctors['cases'])
assert all(row['allocation_counts'] == [107, 107] and row['upload_counts'] == [37, 37]
           and row['typed_counts'] == [61, 61] for row in ctors['cases'])
copies = read(BASE / 'constructors-force-order/frozen-original-copies.json')
assert len(copies) == 392
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/constructors-force-order'
for name, entry in copies.items():
    path = Path(name)
    raw = path.read_bytes()
    assert len(raw) == entry['bytes'] and hashlib.sha256(raw).hexdigest() == entry['sha256']
    assert (BASE / 'constructors-force-order' / path.relative_to(legacy)).read_bytes() == raw
fixed = read(BASE / 'short-fixed-C8-independent-cpu.json')
assert fixed['all_statistics_reproduced'] and all(row['source_C8_passed'] == [False] * 3 for row in fixed['cases'])
sdk = read(BASE / 'sdk-heldout3-independent-cpu.json')
assert sdk['all_statistics_reproduced'] and all(row['control_C8_passed'] == [False] * 3 for row in sdk['cases'])
granular = read(BASE / 'granular-regression-independent-cpu.json')
assert len(granular['cases']) == 6 and sum(row['strict'] for row in granular['cases']) == 4
h1 = read(BASE / 'public-h1-C8-independent-cpu.json')
assert h1['source_C8_passed'] == [True, False, False] and h1['first_source0_preserved_byte_for_byte']
h1sdk = read(BASE / 'public-h1-sdk-heldout3-independent-cpu.json')
assert h1sdk['control_C8_passed'] == [True, True, False] and not h1sdk['controls_added_to_fixed_SDK8']
graph = read(BASE / 'public-h1-graph-with-alloc/comparison.json')
assert graph['graph_structure_and_typed_parameters_equal'] and graph['nodes'] == [6120, 6120]
assert graph['edges'] == [6119, 6119] and graph['pointer_aliases'] == [270, 270]
assert graph['allocation_and_free_nodes_with_complete_typed_parameters'] == 16
for backend in ('original', 'source'):
    provenance = read(BASE / 'public-h1-graph-with-alloc' / backend / 'provenance.json')
    assert provenance['complete'] and provenance['GPU_allocations_added'] == 0 and not provenance['graph_nodes_changed']
tail = read(BASE / 'h1-inactive-tail-independent-cpu.json')
assert tail['post_simulation_host_read_does_not_write_physics_state'] and not tail['original_initcheck_errors_rejudged_as_zero']
assert all(row['active_uint32_items'] == 50 and row['total_uint32_items'] == 99 for row in tail['cases'])
elf = read(BASE / 'four-source-images-elf/report.json')
assert len(elf['images']) == 4 and all(len(row['ELF_needed']) == 6 for row in elf['images'])
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
snapshot_blob = subprocess.check_output(['git', 'rev-parse', 'HEAD:RECONSTRUCTION_SNAPSHOT.json'], text=True).strip()
assert subprocess.check_output(['git', 'hash-object', str(snapshot_path)], text=True).strip() == snapshot_blob
pyc = [name for name in snapshot['files'] if name.endswith('.pyc')]
assert len(pyc) == 360
unchanged = pyc + ['style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
                   'src/style3d_sim/__init__.py', 'reconstruction/csrc/native/source_solver.cpp']
for name in unchanged:
    raw = (ROOT / name).read_bytes()
    entry = snapshot['files'][name]
    assert len(raw) == entry['bytes'] and hashlib.sha256(raw).hexdigest() == entry['sha256']
output = BASE / 'close-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps({'candidate_host_sha256': candidate['image_sha256'],
    'candidate_core_sha256': core['extension_sha256'], 'three_SDK_proven_hunks_rebased_onto_ae': True,
    'source_short_strict': 10, 'source_short_total': 12, 'source_short_owned_calls': 9243,
    'constructor_classes_five_checks_passed': 4, 'frozen_SDK_constructor_files_reused': 392,
    'short_failed2_source_C8': [False, False, False], 'granular_regressions_strict': 4, 'granular_regressions_total': 6,
    'normal_public_H1_graph4_source_C8': [True, False, False], 'normal_public_H1_SDK_controls_C8': [True, True, False],
    'H1_complete_graph_typed_parameters_equal': True, 'H1_graph_nodes': 6120,
    'H1_post_run_inactive_uint32_tail_7_initcheck_errors_localized_both_backends': True,
    'H1_initcheck_failures_rejudged': False, 'numeric_cohorts_changed': False,
    'actual_GPU_jobs': gpu_jobs, 'input_sha256': hashes, 'source_candidate_promoted': False,
    'production_changed': False, 'SDK_and_360_frozen_pyc_unchanged': True, 'GPU_runs': 0,
    'historical_root_snapshot_git_blob': snapshot_blob,
    'historical_root_snapshot_sha256': hashlib.sha256(snapshot_path.read_bytes()).hexdigest(),
    'whole_solver_complete': False}, indent=2) + '\n')
print('Independent close: combined candidate, 68 GPU jobs, constructors/ABI/graph match; fixed failures retained')
