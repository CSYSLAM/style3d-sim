"""Pin eleven checkpoint traces, three pure/drive kernels and all diagnostics before any GPU work."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_checkpoint_substeps import rendered_transport, rendered_worker
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

assert not (BASE / 'plan.json').exists()
previous = BASE.with_name('continuation-20261101-38b70dcd-g1-shared-checkpoint-frame31')
old = json.loads((previous / 'plan.json').read_text())
(BASE / 'independent-cpu-audit.py').write_bytes((previous / 'independent-cpu-audit.py').read_bytes())
worker, transport = rendered_worker(), rendered_transport()
for name, text in [('worker-template.py', worker), ('transport-template.py', transport)]:
    ast.parse(text)
    (BASE / name).write_text(text)
run = (previous / 'run.py').read_text()
assert run.count('reconstruction.csrc.g1_checkpoint_restart') == 1
run = run.replace('reconstruction.csrc.g1_checkpoint_restart', 'reconstruction.csrc.g1_checkpoint_substeps')
run += '''
followup = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': []}
followup_path = BASE / 'followup.status.json'
assert not followup_path.exists()
followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
for label, command, gpu in [
    ('trace-cpu-audit', [sys.executable, str(BASE / 'trace-cpu-audit.py')], False),
    ('replay', [sys.executable, '-m', 'reconstruction.csrc.g1_checkpoint_substeps_replay',
                '--phase', str(BASE)], True),
    ('replay-independent-cpu-audit', [sys.executable, '-m', 'reconstruction.csrc.g1_checkpoint_substeps_replay',
                                    '--phase', str(BASE), '--audit'], False),
]:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            followup['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(),
                                                      'compute_apps': live})
            if not live:
                break
            followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(2)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        followup['running'] = {'step': label, 'pid': process.pid}
        followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
        code = process.wait()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\\n')
    followup['completed'].append({'step': label, 'pid': process.pid, 'actual_exit': code})
    followup['running'] = None
    followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
followup['complete'] = True
followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
'''
ast.parse(run)
(BASE / 'run.py').write_text(run)
namespace = {'__name__': 'reconstruction.csrc.substep_cpu_preflight',
             '__package__': 'reconstruction.csrc', '__file__': str(BASE / 'transport-template.py')}
exec(compile(transport, namespace['__file__'], 'exec'), namespace)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
graph_base = BASE.with_name('continuation-20261101-38b70dcd-g1-drive-and-AL-state')
graphs, selected = [], {}
for side in ('original', 'source'):
    graph = graph_base / side / 'definition-before/graph.json'
    graphs.append(graph)
    selected[side] = namespace['select_stages'](linear_order(json.loads(graph.read_text()))[0], 44, 49)
proofs, kernels, original_ptx = {}, {}, []
for stage in selected['original'][:3]:
    kind, name = stage['kernel_key'], stage['node']['name']
    kernels[kind] = name
    assert build['kernels'][name]['parameters'] == stage['node']['parameter_widths']
    texts, original = kernel_texts(build, name)
    original_ptx.append(original)
    proofs[kind] = {}
    for side, text in texts.items():
        entry = entries(text)[name]
        proof = store_origins(entry, [(i, 0) for i in stage['sizes']])
        assert set(map(tuple, proof['potential_written_pointer_fields'])) == {(i, 0) for i in stage['outputs']}
        proofs[kind][side] = proof
        (BASE / (kind + '-' + side + '-entry.ptx')).write_text(entry)
hashes = dict(old['input_sha256'])
paths = [Path(__file__), build_path, *graphs, *original_ptx,
         ROOT / 'reconstruction/csrc/g1_checkpoint_substeps.py',
         ROOT / 'reconstruction/csrc/g1_checkpoint_substeps_replay.py',
         ROOT / 'reconstruction/csrc/g1_contact_rhs_capture.py',
         ROOT / 'reconstruction/csrc/g1_contact_rhs_replay.py',
         ROOT / 'reconstruction/csrc/pcg_alias_replay.py']
paths.extend(BASE / name for name in ['trace-cpu-audit.py', 'independent-cpu-audit.py', 'worker-template.py',
                                    'transport-template.py', 'run.py'])
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
plan = dict(old)
plan.update({'previous_goal_turn': 'progress: published097542a9;252067 snapshot files verified with zero failures',
             'input_sha256': hashes, 'transport_sha256': hashlib.sha256(transport.encode()).hexdigest(),
             'patched_worker_sha256': hashlib.sha256(worker.encode()).hexdigest(), 'kernels': kernels,
             'abi': next(name for name in hashes if name.endswith('/abi.json')),
             'diagnostic_snapshots_per_worker': 300, 'real_kernel_calls_per_worker': 18,
             'diagnostic_snapshots_may_change_atomic_schedule': True,
             'original_velocity_helper_bug_retained': True})
(BASE / 'CPU-preflight.json').write_text(json.dumps({
    'selected_actual_old_graph_calls': selected, 'potential_write_proofs': proofs,
    'GPU_context_created': False, 'whole_solver_complete': False}, indent=2) + '\n')
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('Fixed8 SDK/3 source traces;6 substeps,18 calls/300 snapshots each;594 same-input replay calls', flush=True)
