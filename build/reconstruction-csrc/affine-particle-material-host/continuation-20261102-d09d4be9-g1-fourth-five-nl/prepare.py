"""Freeze the current Core, existing public checkpoint and all 1015 actual fourth-substep call layouts before GPU work."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import g1_fourth_full_cg as full
from reconstruction.csrc.graph_definition_compare import linear_order

old = BASE.parent / 'continuation-20261102-d09d4be9-g1-current-core/full-nl2-cg'
plan = json.loads((old / 'plan.json').read_text())
old_inputs = plan['input_sha256']
plan['input_sha256'], differences = {}, {}
for name, previous in old_inputs.items():
    actual = hashlib.sha256(Path(name).read_bytes()).hexdigest()
    plan['input_sha256'][name] = actual
    if actual != previous:
        differences[name] = {'old_phase_sha256': previous, 'current_phase_sha256': actual}
assert not differences
core_path = ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json'
core = json.loads(core_path.read_text())
assert core['extension_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
assert core['source_host_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
for name, expected in core['sources'].items():
    path = ROOT / name
    assert hashlib.sha256(path.read_bytes()).hexdigest() == expected, name
    plan['input_sha256'][str(path)] = expected
transport, replay = full.rendered_transport(), full.rendered_replay()
worker = full.linear.capture.rendered_worker()
for name, text in [('transport-template.py', transport), ('replay-template.py', replay), ('worker-template.py', worker)]:
    ast.parse(text)
    path = BASE / name
    assert not path.exists()
    path.write_text(text)
namespace = {'__name__': 'reconstruction.csrc.full_cg_preflight', '__package__': 'reconstruction.csrc',
             '__file__': str(BASE / 'transport-template.py')}
exec(compile(transport, namespace['__file__'], 'exec'), namespace)
layouts = {}
for label in ('sdk0', 'rebuilt0'):
    path = old / label / 'trace/definition-before/graph.json'
    nodes = linear_order(json.loads(path.read_text()))[0]
    layouts[label] = namespace['select_stages'](nodes, 44, 49)
    assert len(layouts[label]) == 1015
plan['kernels'] = {stage['kernel_key']: stage['node']['name'] for stage in layouts['sdk0']}
assert len(plan['kernels']) == 7
assert plan['kernels'] == {s['kernel_key']: s['node']['name'] for s in layouts['rebuilt0']}
stages = layouts['sdk0']
plan.update({
    'core_build': str(core_path), 'source_host_sha256': core['source_host_sha256'],
    'public_core_sha256': core['extension_sha256'],
    'transport_sha256': hashlib.sha256(transport.encode()).hexdigest(),
    'replay_sha256': hashlib.sha256(replay.encode()).hexdigest(),
    'patched_worker_sha256': hashlib.sha256(worker.encode()).hexdigest(),
    'diagnostic_snapshots_per_worker': sum(len(s['sizes']) + len(s['outputs']) for s in stages),
    'snapshot_bytes_per_worker': sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages),
    'snapshot_nodes_per_worker': sum(len(s['sizes']) + len(s['outputs']) for s in stages),
    'real_kernel_calls_per_worker': 1015, 'replay_calls': 6090, 'complete_replay_outputs': 10620,
    'scope': 'fourth substep all five NL solves, complete 250 CG iterations and all five nonlinear apply calls',
    'partial_CG_scalar_watches_not_full_vector_input_capture': False,
    'all_five_NL_250_CG_vectors_captured': True, 'original_public_checkpoint_sha256': old_inputs[plan['input_checkpoint']],
    'changed_version_inputs': differences, 'own_GPU_workers_serial': True, 'external_apps_allowed': True,
    'minimum_free_memory_MiB': 4096, 'replay_H2D_reset_fenced_before_nonblocking_launch': True,
    'previous_goal_turn': 'cable integrated as d09/Core55; current G1 fixed C8 false and failures retained',
})
for path in [Path(__file__), BASE / 'run.py', BASE / 'independent-cpu-audit.py', Path(full.__file__), core_path,
             core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so',
             ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so',
             BASE / 'transport-template.py', BASE / 'replay-template.py', BASE / 'worker-template.py']:
    plan['input_sha256'][str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    if path.suffix == '.py' and path.name not in ('transport-template.py', 'replay-template.py', 'worker-template.py'):
        text = path.read_text()
        ast.parse(text)
        assert all(len(line) <= 128 for line in text.splitlines()), path
assert not (BASE / 'plan.json').exists()
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(BASE / 'cpu-preflight.json').write_text(json.dumps({
    'actual_graph_layouts_checked': len(layouts), 'stages_per_graph': len(stages),
    'snapshot_bytes_per_worker': plan['snapshot_bytes_per_worker'],
    'snapshot_nodes_per_worker': plan['snapshot_nodes_per_worker'], 'GPU_context_created': False,
    'plan_sha256': hashlib.sha256((BASE / 'plan.json').read_bytes()).hexdigest(),
    'whole_solver_complete': False}, indent=2) + '\n')
print('Preflight: two actual graphs, 1015 calls each, 5 NL and 250 CG iterations, current d09/Core55, GPU not initialized')
