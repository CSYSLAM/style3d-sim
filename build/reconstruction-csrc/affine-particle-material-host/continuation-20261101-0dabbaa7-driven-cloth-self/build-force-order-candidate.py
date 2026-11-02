"""Apply only the SDK-proven self-force ordering to the preserved guard-only candidate."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
proof_path = BASE / 'force-order-proof.json'
proof = json.loads(proof_path.read_text())
assert len(proof['cases']) == 12
for name, expected in proof['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
prior_path = BASE / 'candidate-guard-only/build.json'
prior = json.loads(prior_path.read_text())
original_cpp = BASE / 'candidate-guard-only/source_solver.cpp'
old = original_cpp.read_text()
call = '                accumulate_self_particle_pairs(in, stream);\n'
anchor = '            // Contacts precede the joint forces/drives; SO(3) follows those constraint forces.\n'
assert old.count(call) == old.count(anchor) == 1
changed = old.replace(call, '', 1).replace(anchor,
    '            // Actual SDK order: self accumulation follows drive/limits; preserve the earlier stiffness scale.\n'
    '            if (self) accumulate_self_particle_pairs(in, stream);\n', 1)
out = BASE / 'candidate-force-order'
out.mkdir(exist_ok=False)
cpp = out / 'source_solver.cpp'
cpp.write_text(changed)
command = list(prior['command'])
assert command.count(str(original_cpp)) == 1
command[command.index(str(original_cpp))] = str(cpp)
image = out / Path(command[-1]).name
command[-1] = str(image)
inputs = dict(prior['input_sha256'])
inputs.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in (Path(__file__), proof_path, prior_path, cpp)})
record = {'input_sha256': inputs, 'command': command, 'prior_image_sha256': prior['image_sha256'],
          'only_self_accumulation_position_changed': True, 'production_changed': False,
          'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
with (out / 'build.log').open('w') as log:
    worker = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = worker.wait()
(out / 'build.status.json').write_text(json.dumps({'pid': worker.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(out / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Built SDK-order candidate:', record['image_sha256'], ';runtime validation pending', flush=True)
