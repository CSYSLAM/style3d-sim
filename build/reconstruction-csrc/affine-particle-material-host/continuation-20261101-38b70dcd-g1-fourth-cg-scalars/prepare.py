"""Freeze a fourth-substep coefficient observation cohort and subsequent controlled division checks."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_cg_scalar_trace import select_events
from reconstruction.csrc.g1_checkpoint_substeps import rendered_worker
from reconstruction.csrc.graph_definition_compare import linear_order

assert not (BASE / 'plan.json').exists()
previous = BASE.with_name('continuation-20261101-38b70dcd-g1-shared-checkpoint-frame31')
old = json.loads((previous / 'plan.json').read_text())
(BASE / 'independent-cpu-audit.py').write_bytes((previous / 'independent-cpu-audit.py').read_bytes())
text = rendered_worker()
ast.parse(text)
(BASE / 'worker-template.py').write_text(text)
run = (previous / 'run.py').read_text()
assert run.count('reconstruction.csrc.g1_checkpoint_restart') == 1
run = run.replace('reconstruction.csrc.g1_checkpoint_restart', 'reconstruction.csrc.g1_cg_scalar_trace')
run += '''
followup = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': []}
followup_path = BASE / 'followup.status.json'
assert not followup_path.exists()
for label, command, gpu in [
    ('trace-independent-cpu-audit', [sys.executable, str(BASE / 'trace-independent-cpu-audit.py')], False),
    ('coefficient-prepare', [sys.executable, '-m', 'reconstruction.csrc.g1_cg_coefficient_replay',
                             '--phase', str(BASE), '--mode', 'prepare'], False),
    ('coefficient-execute', [sys.executable, '-m', 'reconstruction.csrc.g1_cg_coefficient_replay',
                             '--phase', str(BASE), '--mode', 'execute'], True),
    ('coefficient-independent-cpu-audit', [sys.executable, '-m', 'reconstruction.csrc.g1_cg_coefficient_replay',
                                           '--phase', str(BASE), '--mode', 'audit'], False),
]:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            followup['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(),
                                                      'compute_apps': live})
            followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
            if not live:
                break
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(5)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        followup['running'] = {'label': label, 'pid': process.pid}
        followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
        code = process.wait()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\\n')
    followup['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    followup['running'] = None
    followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
followup['complete'] = True
followup_path.write_text(json.dumps(followup, indent=2) + '\\n')
'''
ast.parse(run)
(BASE / 'run.py').write_text(run)
graph_base = BASE.with_name('continuation-20261101-38b70dcd-g1-checkpoint-substeps')
graphs, selected = [], {}
for side, label in [('original', 'sdk0'), ('source', 'rebuilt0')]:
    path = graph_base / label / 'trace/definition-before/graph.json'
    graphs.append(path)
    selected[side] = select_events(linear_order(json.loads(path.read_text()))[0])
nodes = linear_order(json.loads(graphs[0].read_text()))[0]
alpha = next(e['node']['name'] for e in selected['original'] if e['kind'] == 'cg')
beta = next(n['name'] for n in nodes if '19update_cg_directionE' in n.get('name', ''))
hashes = dict(old['input_sha256'])
paths = [Path(__file__), *graphs, ROOT / 'reconstruction/csrc/g1_cg_scalar_trace.py',
         ROOT / 'reconstruction/csrc/g1_cg_coefficient_replay.py',
         ROOT / 'reconstruction/csrc/g1_checkpoint_substeps.py',
         BASE / 'run.py', BASE / 'trace-independent-cpu-audit.py', BASE / 'independent-cpu-audit.py',
         BASE / 'worker-template.py']
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
plan = dict(old)
plan.update({'previous_goal_turn': 'progress: publishedd4e13608;252843 snapshot files verified with zero failures',
             'input_sha256': hashes, 'patched_worker_sha256': hashlib.sha256(text.encode()).hexdigest(),
             'abi': next(name for name in hashes if name.endswith('/abi.json')),
             'coefficient_kernels': {'alpha': alpha, 'beta': beta},
             'snapshot_bytes_per_worker': 68176, 'snapshot_nodes_per_worker': 532,
             'diagnostic_snapshots_may_change_atomic_schedule': True,
             'partial_CG_scalar_watches_not_full_vector_input_capture': True,
             'controlled_replay_uses_all_actual_alpha_and_beta_pairs': True,
             'original_velocity_helper_bug_retained': True})
(BASE / 'CPU-preflight.json').write_text(json.dumps({'selected_old_graph_events': selected,
                                                   'GPU_context_created': False, 'whole_solver_complete': False},
                                                  indent=2) + '\n')
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('Fixed8 SDK/3 source workers; each250 alpha pairs/5 nonlinear updates/6 velocity endpoints;2750+2695 replay pairs')
