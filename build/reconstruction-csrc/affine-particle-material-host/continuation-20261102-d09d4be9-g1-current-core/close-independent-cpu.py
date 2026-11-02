"""Check current image identities, immutable cohorts, actual exits and the full-CG evidence before freezing."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order

hashes = {}


def read(path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


host = read(ROOT / 'build/reconstruction-csrc/host-particles/build.json')
core_path = ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json'
core = read(core_path)
assert host['extension_sha256'] == core['source_host_sha256']
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert core['extension_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
build_root = ROOT / 'build/reconstruction-csrc'
for metadata, image in [(host, build_root / 'host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'),
                        (core, core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so')]:
    assert hashlib.sha256(image.read_bytes()).hexdigest() == metadata['extension_sha256']
    for name, expected in metadata['sources'].items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected
g1 = BASE / 'graph60-fixed-original-C8'
full = BASE / 'full-nl2-cg'
for path in (g1 / 'plan.json', full / 'plan.json', full / 'atomic-plan.json'):
    plan = read(path)
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for path in (g1 / 'status.json', full / 'run.status.json', full / 'followup.status.json', full / 'atomic.status.json'):
    status = read(path)
    assert status['complete'] and status['running'] is None
    assert all(row.get('actual_exit', row.get('exit')) == 0 for row in status['completed'])
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
report = read(g1 / 'report.json')
old = read(BASE.parent / 'continuation-20261101-688f9633-driven-cloth-rigid-soft' /
           'official-g1-public-core-graph60-fixed-C8/report.json')
assert report['original_runs'] == 8 and report['source_runs'] == 3 and report['new_original_runs'] == 0
assert not report['primary_c_passed'] and not report['old_failure_replaced'] and not report['cohorts_resampled']
for tag, name in report['input_npz_paths'].items():
    digest = hashlib.sha256(Path(name).read_bytes()).hexdigest()
    assert digest == report['input_npz_sha256'][tag]
    if tag.startswith('original'):
        assert digest == old['input_npz_sha256'][tag]
    else:
        runtime = read(Path(name).with_name('runtime.json'))
        assert runtime['exit'] == 0 and runtime['public_core_abi'] and runtime['real_graph_observed']
        assert runtime['image_sha256'] == core['extension_sha256']
        assert not runtime['reference_solver_mapped'] and not runtime['ab_bridge_used']
cpu = read(BASE / 'current-fixed-C8-cpu-audit.json')
outside = read(BASE / 'current-outside-frames.json')
assert cpu['all_statistics_reproduced'] and not cpu['checks'][0]['primary_c_passed']
assert outside['outside_field_frames'] == len(outside['outside']) == 123
capture = read(full / 'independent-cpu-audit.json')
replay = read(full / 'replay-independent-cpu-audit.json')
scalar = lambda key: key.startswith('precondition:') and key.endswith(':6') or key.startswith('matrix:') and key.endswith(':9')
non_reduction = {key: value for key, value in replay['total'].items() if not scalar(key)}
assert sum(non_reduction.values()) == 1512
assert all(replay['strict'][key] == count for key, count in non_reduction.items())
assert sum(replay['total'].values()) == 2112 and sum(replay['strict'].values()) == 1734
atomic = read(full / 'atomic/report.json')
atomic_cpu = read(full / 'atomic-independent-cpu-audit.json')
assert atomic['complete'] and len(atomic['rows']) == 200 and atomic['all_certificates_passed']
assert atomic['actual_calls'] == {'probe': 400, 'SDK_isolation': 1200, 'certificate': 511}
assert all(not row['unexplained_bits'] and all(c['passed'] for c in row['certificates']) for row in atomic['rows'])
assert atomic_cpu['all_passed'] and atomic_cpu['counts']['hardware_certificates'] == 511
for run, original in [('sdk0', True), ('rebuilt0', False)]:
    runtime = read(full / run / 'worker/runtime.json')
    assert runtime['exit'] == 0 and runtime['reference_solver_mapped'] == original
    assert runtime['image_sha256'] == ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                                       if original else core['extension_sha256'])
graph = read(full / 'current-graph-definition-comparison.json')
assert graph['graph_structure_and_typed_parameters_equal'] and graph['nodes'] == [17467, 17467]
nodes = [linear_order(read(full / label / 'trace/definition-before/graph.json'))[0] for label in ('sdk0', 'rebuilt0')]
attributes = Counter(a['name'] for a, b in zip(*nodes, strict=True) if a.get('attributes') != b.get('attributes'))
assert sum(attributes.values()) == graph['function_attributes']['different_nodes'] == 7812 and len(attributes) == 14
result = {'host_sha256': host['extension_sha256'], 'core_sha256': core['extension_sha256'],
          'current_fixed_C8_passed': False, 'current_C8_outside_field_frames': 123,
          'all_50_NL2_CG_vector_outputs_strict': True, 'non_reduction_outputs': 1512,
          'strict_scalar_failures_retained': 378, 'actual_replay_calls': 1212,
          'atomic_actual_calls': atomic['actual_calls'], 'atomic_CPU_counts': atomic_cpu['counts'],
          'graph_parameters_equal': True, 'resource_attributes_differ_nodes': 7812,
          'resource_attributes_differ_kernel_kinds': 14, 'input_sha256': hashes,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'GPU_runs': 0,
          'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'close-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('Current C8 false retained; 1512 complete vectors strict; 378 scalar failures retained; all511 F32 certificates pass')
