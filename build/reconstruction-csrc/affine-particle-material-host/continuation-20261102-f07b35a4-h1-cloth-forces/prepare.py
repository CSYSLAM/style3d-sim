"""Guard the next three complete actual first-H1 inputs without changing production or old numeric cohorts."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.h1_first_cloth_layout import select_stages

previous = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
parent = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
core_path = previous / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
assert core['extension_sha256'] == 'aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830'
assert core['source_host_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
manifest = json.loads((parent / 'completion-manifest.json').read_text())
hashes = {str(ROOT / name): expected for name, expected in core['sources'].items()}
for name in ('run.py', 'capture-worker.py', 'transport-as-run.py', 'replay-as-run.py', 'run-replay.py',
             'audit-captures.py'):
    original = parent / 'assembly-full-inputs' / name
    expected = manifest['files'][str(original.relative_to(ROOT))]['sha256']
    assert hashlib.sha256(original.read_bytes()).hexdigest() == expected
    hashes[str(original)] = expected
paths = [Path(__file__), core_path, parent / 'completion-manifest.json', previous / 'h1-asset-manifest.json',
         previous / 'public-h1-worker.py', previous / 'public-h1-graph/abi.json',
         previous / 'candidate-force-order/build.json',
         previous / 'candidate-force-order/_source_solver.cpython-312-x86_64-linux-gnu.so',
         previous / 'candidate-public-core/_core.cpython-312-x86_64-linux-gnu.so',
         ROOT / 'reconstruction/csrc/h1_first_cloth_layout.py',
         ROOT / 'reconstruction/csrc/graph_definition_dump.py',
         ROOT / 'build/reconstruction-csrc/host-particles/build.json',
         ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h']
for path in BASE.glob('*.py'):
    text = path.read_text()
    if path.name == 'audit-captures.py':
        text = text.replace('383580120', '13879120')
        path.write_text(text)
    ast.parse(text)
    assert max(map(len, text.splitlines()), default=0) <= 128, path
    paths.append(path)
layouts = {}
for label in ('original', 'source'):
    path = previous / 'public-h1-graph-with-alloc' / label / 'definition-before-first-replay/graph.json'
    paths.append(path)
    layouts[label] = select_stages(linear_order(json.loads(path.read_text()))[0], 46, 51)
stages = layouts['original']
assert len(stages) == len(layouts['source']) == 3
assert [(s['node']['name'], s['node']['geometry'], s['sizes'], s['outputs']) for s in stages] == [
    (s['node']['name'], s['node']['geometry'], s['sizes'], s['outputs']) for s in layouts['source']]
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
nodes = sum(len(s['sizes']) + len(s['outputs']) for s in stages)
size = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages)
assert (nodes, size) == (18, 13879120)
plan = {'input_sha256': hashes, 'kernels': {s['kernel_key']: s['node']['name'] for s in stages},
        'core_build': str(core_path), 'source_host_build': str(previous / 'candidate-force-order/build.json'),
        'source_host_sha256': core['source_host_sha256'], 'source_core_sha256': core['extension_sha256'],
        'abi': str(previous / 'public-h1-graph/abi.json'), 'frames': 2,
        'runs': [{'label': 'sdk0', 'backend': 'original'}, {'label': 'rebuilt0', 'backend': 'source'}],
        'actual_calls_per_endpoint': 3, 'scope': 'first NL stretch/bend forces and self-Hessian diagonal consumer',
        'snapshot_nodes_per_endpoint': nodes, 'snapshot_bytes_per_endpoint': size,
        'replay_H2D_resets_require_context_fence': True, 'fixed_C8_source0_replaced': False,
        'full_self_contact_producers_or_first_substep_claimed': False,
        'production_changed': False, 'GPU_context_created': False, 'whole_solver_complete': False}
assert not (BASE / 'plan.json').exists()
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('CPU preflight: three complete stretch/bend/self-add inputs; 18 snapshots/13879120 bytes per endpoint')
