"""Build a guard-only driven-cloth/self candidate after actual SDK support and activity have been verified."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
audit_path = BASE / 'discovery-independent-cpu.json'
audit = json.loads(audit_path.read_text())
assert audit['SDK_supported_cases'] == audit['production_guard_rejections'] == 12
for name, expected in audit['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
original_cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
original = original_cpp.read_text()
changes = [
    ('!cable_count_ && !fluid_rows_ && !granular_points_ && !self && !drag_count_ &&\n'
     '            !tetrahedron_count_ && !spring_count_ &&\n',
     '!cable_count_ && !fluid_rows_ && !granular_points_ && !drag_count_ &&\n'
     '            !tetrahedron_count_ && !spring_count_ &&\n'),
    ('if (self && bodies && (!so3 || body_spring_total_',
     'if (self && bodies && !driven_cloth && (!so3 || body_spring_total_'),
]
candidate = original
for old, new in changes:
    assert candidate.count(old) == 1, old
    candidate = candidate.replace(old, new, 1)
restored = candidate
for old, new in reversed(changes):
    assert restored.count(new) == 1
    restored = restored.replace(new, old, 1)
assert restored == original
out = BASE / 'candidate-guard-only'
out.mkdir(exist_ok=False)
cpp = out / 'source_solver.cpp'
cpp.write_text(candidate)
command = list(build['build_command'])
assert command.count(str(original_cpp)) == 1
command[command.index(str(original_cpp))] = str(cpp)
command.insert(1, '-I' + str(original_cpp.parent))
image = out / Path(command[-1]).name
command[-1] = str(image)
inputs = {str(ROOT / name): value for name, value in build['sources'].items()}
inputs.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), audit_path, cpp)})
record = {'input_sha256': inputs, 'command': command, 'changes': changes,
          'only_two_scope_conditions_changed': True, 'production_changed': False,
          'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
with (out / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(out / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0 and build_path.read_bytes() == saved
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(out / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Built isolated two-guard candidate:', record['image_sha256'], ';runtime validation pending', flush=True)
