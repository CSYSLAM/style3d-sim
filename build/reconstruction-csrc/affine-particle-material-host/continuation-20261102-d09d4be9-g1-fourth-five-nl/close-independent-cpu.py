"""Check same-run coverage and actual exits for all five nonlinear solves without rejudging old trajectories."""
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
for metadata in (host, core):
    for name, expected in metadata['sources'].items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
for path in (BASE / 'plan.json', BASE / 'atomic-plan.json'):
    plan = read(path)
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for path in (BASE / 'run.status.json', BASE / 'followup.status.json', BASE / 'atomic.status.json'):
    status = read(path)
    assert status['complete'] and status['running'] is None
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
capture = read(BASE / 'independent-cpu-audit.json')
assert capture['counts']['actual_pointer_and_complete_payload_links'] == 6468
assert capture['counts']['observed_cross_NL_copy_payloads_equal'] == 8
assert all(field['all_finite'] for stage in capture['stage_cross_endpoint_differences'].values()
           for field in stage['after'].values())
replay = read(BASE / 'replay-independent-cpu-audit.json')
scalar = lambda key: key.startswith('precondition:') and key.endswith(':6') or key.startswith('matrix:') and key.endswith(':9')
non_reduction = {key: value for key, value in replay['total'].items() if not scalar(key)}
assert sum(non_reduction.values()) == 7620
assert all(replay['strict'][key] == count for key, count in non_reduction.items())
assert sum(replay['total'].values()) == 10620 and sum(replay['strict'].values()) == 8916
atomic = read(BASE / 'atomic/report.json')
atomic_cpu = read(BASE / 'atomic-independent-cpu-audit.json')
assert atomic['complete'] and len(atomic['rows']) == 1000 and atomic['all_certificates_passed']
certificates = atomic_cpu['counts']['hardware_certificates']
assert atomic['actual_calls'] == {'probe': 2000, 'SDK_isolation': 6000, 'certificate': certificates}
assert all(not row['unexplained_bits'] and all(c['passed'] for c in row['certificates']) for row in atomic['rows'])
assert atomic_cpu['all_passed']
for label, original in [('sdk0', True), ('rebuilt0', False)]:
    runtime = read(BASE / label / 'worker/runtime.json')
    assert runtime['exit'] == 0 and runtime['reference_solver_mapped'] == original
    assert runtime['public_core_abi'] and runtime['real_graph_observed'] and not runtime['ab_bridge_used']
    assert runtime['image_sha256'] == ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                                       if original else core['extension_sha256'])
graph = read(BASE / 'current-graph-definition-comparison.json')
assert graph['graph_structure_and_typed_parameters_equal'] and graph['nodes'] == [17467, 17467]
nodes = [linear_order(read(BASE / label / 'trace/definition-before/graph.json'))[0] for label in ('sdk0', 'rebuilt0')]
attributes = Counter(a['name'] for a, b in zip(*nodes, strict=True) if a.get('attributes') != b.get('attributes'))
assert sum(attributes.values()) == graph['function_attributes']['different_nodes'] == 7812 and len(attributes) == 14
previous = BASE.parent / 'continuation-20261102-d09d4be9-g1-current-core/graph60-fixed-original-C8/report.json'
c8 = read(previous)
assert not c8['primary_c_passed'] and c8['original_runs'] == 8 and c8['source_runs'] == 3
assert not c8['old_failure_replaced'] and not c8['cohorts_resampled']
result = {'host_sha256': host['extension_sha256'], 'core_sha256': core['extension_sha256'],
          'all_5_NL_250_CG_captured_same_run': True, 'scope': 'fourth of six G1 substeps only',
          'non_reduction_outputs_strict': 7620, 'strict_scalar_failures_retained': 1704,
          'actual_replay_calls': 6090, 'atomic_actual_calls': atomic['actual_calls'],
          'atomic_CPU_counts': atomic_cpu['counts'], 'graph_parameters_equal': True,
          'resource_attributes_differ_nodes': 7812, 'resource_attributes_differ_kernel_kinds': 14,
          'cross_NL_observed_copy_payloads_equal': 8, 'input_sha256': hashes,
          'same_numerical_C8_cohort_rejudged': False, 'new_numerical_C8_runs': 0,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'GPU_runs': 0,
          'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'close-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('All five NL / 250CG same-run checks complete; 7620 vectors strict; 1704 scalar failures retained; certificates',
      certificates)
