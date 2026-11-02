"""Extend the observed plain distance-before-line upload order to the newly captured cable combination."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
prior = BASE.parent / 'continuation-20261102-0dabbaa7-cable-body-constraints'
previous_path = prior / 'candidate-cache-order/build.json'
previous = json.loads(previous_path.read_text())
audit_path = BASE / 'weight-order-independent-cpu.json'
audit = json.loads(audit_path.read_text())
assert audit['all_flat_targets_equal_after_exact5_identity_mapping'] and audit['complete_upload_buffers'] == 32
for name, expected in {**previous['input_sha256'], **audit['input_sha256']}.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
before_path = prior / 'candidate-cache-order/source_solver.cpp'
before = before_path.read_text()
old = '            !model_.joint_drive_count && !model_.cable_count && !model_.fluid_particle_count;'
new = '            !model_.joint_drive_count && !model_.fluid_particle_count;'
assert before.count(old) == 1
candidate = before.replace(old, new)
output = BASE / 'candidate-weight-order'
output.mkdir(exist_ok=False)
cpp = output / 'source_solver.cpp'
cpp.write_text(candidate)
command = list(previous['command'])
assert command.count(str(before_path)) == 1
command[command.index(str(before_path))] = str(cpp)
image = output / Path(previous['image']).name
command[-1] = str(image)
inputs = dict(previous['input_sha256'])
inputs.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in (Path(__file__), previous_path, audit_path, cpp)})
record = {'input_sha256': inputs, 'command': command, 'change_from_b82': [old, new],
          'only_upload_order_scope_condition_changed': True, 'solver_arithmetic_changed': False,
          'production_modified': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
with (output / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(output / 'status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(output / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Built one-condition weight-order candidate', record['image_sha256'], flush=True)
