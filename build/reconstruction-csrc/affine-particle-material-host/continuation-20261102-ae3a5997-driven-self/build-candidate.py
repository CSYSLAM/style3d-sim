"""Rebase the three SDK-proven driven-self patches onto the exact current granular contact candidate."""
import difflib
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
parent = BASE.parent / 'continuation-20261102-d09d4be9-granular-contacts/candidate-guard-only'
parent_path = parent / 'build.json'
parent_bytes = parent_path.read_bytes()
prior = json.loads(parent_bytes)
assert prior['image_sha256'] == 'ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8'
assert hashlib.sha256(Path(prior['image']).read_bytes()).hexdigest() == prior['image_sha256']
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
proof_path = legacy / 'force-order-proof.json'
proof = json.loads(proof_path.read_text())
assert len(proof['cases']) == 12
inputs = dict(prior['input_sha256'])
for name, expected in proof['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    assert name not in inputs or inputs[name] == expected
    inputs[name] = expected
baseline = BASE.parent / ('continuation-20261102-b82ecd80-cable-closure/before-production-0dabbaa7/'
                          'preserved-files/reconstruction/csrc/native/source_solver.cpp')
validated = legacy / 'candidate-force-order/source_solver.cpp'
original_cpp = parent / 'source_solver.cpp'
original = original_cpp.read_text()
before_lines, after_lines = baseline.read_text().splitlines(keepends=True), validated.read_text().splitlines(keepends=True)
patches, changed = [], original
groups = list(difflib.SequenceMatcher(a=before_lines, b=after_lines, autojunk=False).get_grouped_opcodes(3))
assert len(groups) == 3
for group in groups:
    left, right = group[0][1], group[-1][2]
    new_left, new_right = group[0][3], group[-1][4]
    before, after = ''.join(before_lines[left:right]), ''.join(after_lines[new_left:new_right])
    assert changed.count(before) == 1
    changed = changed.replace(before, after, 1)
    patches.append({'old_baseline_start_line': left + 1, 'before': before, 'after': after})
reverse = changed
for patch in reversed(patches):
    assert reverse.count(patch['after']) == 1
    reverse = reverse.replace(patch['after'], patch['before'], 1)
assert reverse == original
assert hashlib.sha256(changed.encode()).hexdigest() == '01ce801480362f1273be35ee3ae18cf1b63b888435a51e477f0abc957e337744'
output = BASE / 'candidate-force-order'
output.mkdir(exist_ok=False)
cpp = output / 'source_solver.cpp'
cpp.write_text(changed)
command = list(prior['command'])
assert command.count(str(original_cpp)) == 1
command[command.index(str(original_cpp))] = str(cpp)
image = output / Path(command[-1]).name
command[-1] = str(image)
for path in (Path(__file__), parent_path, proof_path, baseline, validated, cpp):
    inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
record = {'input_sha256': inputs, 'command': command, 'parent_host_sha256': prior['image_sha256'],
          'SDK_proven_patches': patches, 'two_scope_changes_and_self_force_position_only': True,
          'granular_external_contact_guard_delta_preserved': True, 'production_changed': False,
          'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
with (output / 'build.log').open('w') as log:
    worker = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = worker.wait()
(output / 'build.status.json').write_text(json.dumps({'pid': worker.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0 and parent_path.read_bytes() == parent_bytes
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(output / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Current combined candidate built:', record['image_sha256'], '; runtime acceptance pending', flush=True)
