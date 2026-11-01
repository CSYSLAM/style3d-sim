"""Build an isolated contact-scope candidate; preserve every production allocation and arithmetic statement."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
discovery = BASE / 'discovery-v2'
status = json.loads((discovery / 'status.json').read_text())
assert status['complete'] and len(status['completed']) == 12
report = json.loads((discovery / 'report.json').read_text())
assert all(row['actual_exit'] == 0 for row in report['rows'] if row['backend'] == 'original')
assert all(row['actual_external_contact_guard'] for row in report['rows'] if row['backend'] == 'source')
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
original_cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
original = original_cpp.read_text()
old = '(!so3 || config.enable_self_collision || contact.max_count || contact.soft_max_count))'
new = '(!so3 || config.enable_self_collision))'
assert original.count(old) == 1
candidate = original.replace(old, new, 1)
assert candidate.replace(new, old, 1) == original
directory = BASE / 'candidate-guard-only'
directory.mkdir(exist_ok=False)
cpp = directory / 'source_solver.cpp'
cpp.write_text(candidate)
command = list(build['build_command'])
assert command.count(str(original_cpp)) == 1
command[command.index(str(original_cpp))] = str(cpp)
command.insert(1, '-I' + str(original_cpp.parent))
image = directory / Path(command[-1]).name
command[-1] = str(image)
inputs = {str(ROOT / name): sha for name, sha in build['sources'].items()}
for path in (Path(__file__), cpp, discovery / 'plan.json', discovery / 'report.json', discovery / 'status.json'):
    inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
plan = {'input_sha256': inputs, 'command': command, 'only_contact_scope_condition_changed': True,
        'iterative_math_and_constructor_source_unchanged': True, 'production_changed': False,
        'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(directory / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
for name, sha in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
with (directory / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(directory / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0 and build_path.read_bytes() == saved
for name, sha in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
report = {**plan, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest()}
(directory / 'build.json').write_text(json.dumps(report, indent=2) + '\n')
print('Isolated candidate built:', report['image_sha256'], '; runtime validation pending')
