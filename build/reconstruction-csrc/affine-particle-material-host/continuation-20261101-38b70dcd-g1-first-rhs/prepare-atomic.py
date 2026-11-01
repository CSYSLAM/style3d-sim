"""Adapt the already validated joint isolation/certificate engines to the two actual first-use packets."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_joint_rhs_isolated import rendered_source as isolation_source
from reconstruction.csrc.g1_joint_rhs_certificates import rendered_source as certificate_source

parent_plan = json.loads((BASE / 'plan.json').read_text())
strict = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert sum(strict['strict'].values()) < sum(strict['total'].values())
audit = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert all(audit['old_first_force_before_bitwise_reproduced'].values())
assert audit['force_boundaries']['joint']['before']['different_words'] == 0
atomic = BASE / 'atomic'
atomic.mkdir(exist_ok=False)
for side, label in [('original', 'sdk0'), ('source', 'rebuilt0')]:
    folder = atomic / side
    (folder / 'joint-packets').mkdir(parents=True)
    source = BASE / label / 'trace'
    stage = next(s for s in json.loads((source / 'snapshot-layout.json').read_text())['stages'] if s['key'] == 'joint')
    (folder / 'snapshot-layout.json').write_text(json.dumps({'stages': [stage]}, indent=2) + '\n')
    (folder / 'joint-packets/frame-00.npz').write_bytes((source / 'joint-packets/frame-00.npz').read_bytes())
for name, text in [('isolation', isolation_source()), ('certificates', certificate_source())]:
    old = "assert len(replay['packets']) == 120"
    assert text.count(old) == 1
    text = text.replace(old, "assert len(replay['packets']) == 2")
    ast.parse(text)
    (atomic / (name + '-template.py')).write_text(text)
    wrapper = '''"""Execute the frozen first-joint diagnostic template without changing production code."""
from pathlib import Path
BASE = Path(__file__).resolve().parent
NAME = %r
text = (BASE / (NAME + '-template.py')).read_text()
script = BASE / (NAME + '-' + NAME + '-as-run.py')
assert not script.exists()
script.write_text(text)
namespace = {'__name__': 'reconstruction.csrc.first_joint_' + NAME,
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
raise SystemExit(namespace['main']())
''' % name
    (atomic / (name + '-wrapper.py')).write_text(wrapper)
previous_cpu = (BASE.with_name('continuation-20261101-38b70dcd-g1-inertial-joint-so3-rhs') /
                'atomic-followup-cpu-audit.py')
text = previous_cpu.read_text()
for old, new in [('== 120', '== 2'), ('== 61920', '== 1032')]:
    assert text.count(old) == 1
    text = text.replace(old, new)
ast.parse(text)
(atomic / 'atomic-followup-cpu-audit.py').write_text(text)
hashes = dict(parent_plan['input_sha256'])
paths = [Path(__file__), BASE / 'replay-report.json', BASE / 'replay-independent-cpu-audit.json',
         BASE / 'independent-cpu-audit.json', previous_cpu,
         ROOT / 'reconstruction/csrc/g1_first_joint_probe.py',
         ROOT / 'reconstruction/csrc/g1_joint_rhs_isolated.py',
         ROOT / 'reconstruction/csrc/g1_joint_rhs_certificates.py',
         ROOT / 'reconstruction/csrc/g1_drive_tangent_isolated.py',
         ROOT / 'reconstruction/csrc/g1_drive_tangent_certificates.py',
         ROOT / 'reconstruction/csrc/ptx_atomic_literal_probe.py',
         BASE / 'run-atomic.py', BASE / 'probe-independent-cpu-audit.py', BASE / 'prepare-followup.py']
paths.extend(path for path in atomic.rglob('*') if path.is_file())
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(atomic / 'plan.json').write_text(json.dumps({
    'kernels': {'joint': parent_plan['kernels']['joint']}, 'input_sha256': hashes,
    'parent_phase': str(BASE), 'packet_labels': ['original', 'source'],
    'joint_multiplier_zero_branch': True, 'strict_first_failure_preserved': True,
    'production_changed': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('Two byte-identical copied packets; old isolation/certificate/CPU templates adapted only for120→2 and61920→1032')
