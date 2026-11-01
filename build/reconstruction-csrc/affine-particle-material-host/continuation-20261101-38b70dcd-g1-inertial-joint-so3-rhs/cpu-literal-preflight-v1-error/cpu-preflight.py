"""Freeze three authentic RHS stages, including the actual G1 mass/ELL and constraint cache inputs."""
import ast
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_al_rhs_capture import rendered_source as capture_source
from reconstruction.csrc.g1_al_rhs_replay import rendered_source as replay_source
from reconstruction.csrc.g1_contact_rhs_replay import instrument256, kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

BASE = Path(__file__).resolve().parent
OLD = BASE.parent / 'continuation-20261101-38b70dcd-g1-rolling-tangent'
assert not (BASE / 'plan.json').exists(), 'Never overwrite a frozen plan'
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
assert build['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
templates = {'capture': capture_source(), 'replay': replay_source()}
for key, text in templates.items():
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), key
    (BASE / (key + '-template.py')).write_text(text)
namespace = {'__name__': 'reconstruction.csrc.al_rhs_preflight', '__package__': 'reconstruction.csrc',
             '__file__': str(BASE / 'capture-template.py')}
exec(compile(templates['capture'], str(BASE / 'capture-template.py'), 'exec'), namespace)
records = {}
kernels = {}
originals = []
for side in ('original', 'source'):
    nodes = linear_order(json.loads((OLD / side / 'definition-before/graph.json').read_text()))[0]
    stages = namespace['select_stages'](nodes, 44, 49)
    assert len(stages) == 3
    records[side] = stages
    names = {stage['key']: stage['node']['name'] for stage in stages}
    assert not kernels or names == kernels
    kernels = names
proofs = {}
for stage in records['original']:
    key, name = stage['key'], stage['node']['name']
    texts, original = kernel_texts(build, name)
    originals.append(original)
    proofs[key] = {}
    for side, text in texts.items():
        entry = entries(text)[name]
        proof = store_origins(entry, [(i, 0) for i in stage['sizes']])
        assert proof['potential_written_pointer_fields'] == [(stage['outputs'][0], 0)]
        (BASE / (key + '-' + side + '-entry.ptx')).write_text(entry)
        sites = len(re.findall(r'\bred\.global\.add\.f32\b', entry))
        if key == 'rhs':
            assert sites == 0 and not re.search(r'\b(?:red|atom)\.', entry)
        else:
            changed, observed = instrument256(text, name)
            assert observed == sites
            (BASE / (key + '-' + side + '-instrumented-preflight.ptx')).write_text(changed)
        proofs[key][side] = {'store_origins': proof, 'static_atomic_sites': sites}
snapshots = sum(len(s['sizes']) + len(s['outputs']) for s in records['original'])
size = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in records['original'])
assert snapshots == 27 and size == 63728
for filename, old_module, new_module in (
    ('run-captures.py', 'g1_rolling_tangent_capture', 'g1_al_rhs_capture'),
    ('run-replay.py', 'g1_rolling_tangent_replay', 'g1_al_rhs_replay'),
):
    script = (OLD / filename).read_text()
    assert script.count(old_module) == 1
    script = script.replace(old_module, new_module)
    script = script.replace('60 late rolling-tangent packets', '60 packets for each inertial/joint/SO3 stage')
    (BASE / filename).write_text(script)
hashes = dict(json.loads((OLD / 'plan.json').read_text())['input_sha256'])
paths = [Path(__file__), ROOT / 'reconstruction/csrc/g1_al_rhs_capture.py',
         ROOT / 'reconstruction/csrc/g1_al_rhs_replay.py', *originals]
paths += [BASE / name for name in ('capture-template.py', 'replay-template.py',
                                   'independent-cpu-audit.py', 'run-captures.py', 'run-replay.py')]
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
plan = {
    'previous_goal_turn': 'status answer: no progress; revalidated and continuing from closed tangent evidence',
    'frames': 60, 'backends': ['original', 'source'], 'kernels': kernels, 'input_sha256': hashes,
    'actual_before_and_after_required': True, 'full_outputs_and_readonly_after_required': True,
    'rhs_no_atomic_probe': True, 'joint_so3_real_operand_probes': True,
    'strict_first_additional_isolation_only_if_needed': True,
    'frozen_cohort_extended': False, 'production_changed': False, 'whole_solver_complete': False,
}
(BASE / 'CPU-layout-preflight.json').write_text(json.dumps({
    'stages': records, 'proofs': proofs, 'snapshot_count': snapshots, 'snapshot_bytes': size,
    'expected_graph_nodes': 17494, 'expected_graph_edges': 17499,
    'GPU_context_created': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('RHS preflight passed: 3 kernels, 27 snapshots, 63728 bytes; no GPU context created', flush=True)
