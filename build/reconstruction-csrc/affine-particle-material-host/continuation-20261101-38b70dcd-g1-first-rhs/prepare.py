"""Freeze first RHS/joint/drive boundaries on the existing shared public checkpoint before GPU execution."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_first_rhs import rendered_transport, rendered_replay
from reconstruction.csrc.g1_checkpoint_substeps import rendered_worker
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

assert not (BASE / 'plan.json').exists()
previous = BASE.with_name('continuation-20261101-38b70dcd-g1-checkpoint-substeps')
old = json.loads((previous / 'plan.json').read_text())
worker, transport, replay = rendered_worker(), rendered_transport(), rendered_replay()
for name, text in [('worker-template.py', worker), ('transport-template.py', transport), ('replay-template.py', replay)]:
    ast.parse(text)
    (BASE / name).write_text(text)
namespace = {'__name__': 'reconstruction.csrc.first_rhs_cpu_preflight',
             '__package__': 'reconstruction.csrc', '__file__': str(BASE / 'transport-template.py')}
exec(compile(transport, namespace['__file__'], 'exec'), namespace)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
selected, graph_paths = {}, []
for side in ('original', 'source'):
    graph = previous / ('sdk0' if side == 'original' else 'rebuilt0') / 'trace/definition-before/graph.json'
    graph_paths.append(graph)
    selected[side] = namespace['select_stages'](linear_order(json.loads(graph.read_text()))[0], 44, 49)
proofs, kernels, originals = {}, {}, []
for stage in selected['original']:
    kind, name = stage['key'], stage['node']['name']
    kernels[kind] = name
    assert build['kernels'][name]['parameters'] == stage['node']['parameter_widths']
    texts, original = kernel_texts(build, name)
    originals.append(original)
    proofs[kind] = {}
    for side, text in texts.items():
        entry = entries(text)[name]
        proof = store_origins(entry, [(i, 0) for i in stage['sizes']])
        assert set(map(tuple, proof['potential_written_pointer_fields'])) == {(i, 0) for i in stage['outputs']}
        proofs[kind][side] = proof
        (BASE / (kind + '-' + side + '-entry.ptx')).write_text(entry)
hashes = dict(old['input_sha256'])
paths = [Path(__file__), build_path, *graph_paths, *originals,
         ROOT / 'reconstruction/csrc/g1_first_rhs.py', BASE / 'run.py', BASE / 'independent-cpu-audit.py',
         previous / 'first-force-context.json',
         previous / 'sdk0/trace/drive0-packets/frame-00.npz',
         previous / 'rebuilt0/trace/drive0-packets/frame-00.npz',
         *[BASE / name for name in ('worker-template.py', 'transport-template.py', 'replay-template.py')]]
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
plan = dict(old)
plan.update({
    'previous_goal_turn': 'progress: publishededcc36ac;252673 snapshot files verified with zero failures',
    'input_sha256': hashes, 'transport_sha256': hashlib.sha256(transport.encode()).hexdigest(),
    'patched_worker_sha256': hashlib.sha256(worker.encode()).hexdigest(),
    'replay_sha256': hashlib.sha256(replay.encode()).hexdigest(), 'kernels': kernels,
    'runs': [{'label': 'sdk0', 'backend': 'original'}, {'label': 'rebuilt0', 'backend': 'source'}],
    'diagnostic_snapshots_per_worker': 50, 'real_kernel_calls_per_worker': 3,
    'local_operator_diagnostic_not_a_new_numeric_C_cohort': True,
    'old_frozen_first_force_context': str(previous / 'first-force-context.json'),
    'prefix_before_joint_contains_contact_and_rolling_not_yet_separately_captured': True,
})
(BASE / 'CPU-preflight.json').write_text(json.dumps({
    'selected_actual_old_graph_calls': selected, 'potential_write_proofs': proofs,
    'expected_snapshot_bytes_per_worker': sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs'])
                                               for s in selected['original']),
    'GPU_context_created': False, 'whole_solver_complete': False}, indent=2) + '\n')
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('Fixed first RHS25/joint30/drive31; two normal Core workers,18 same-input replay calls; no new C cohort', flush=True)
