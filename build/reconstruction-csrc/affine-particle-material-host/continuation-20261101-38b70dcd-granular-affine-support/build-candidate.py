"""Compile an isolated guard-only diagnostic variant, leaving all production inputs and outputs unchanged."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
audit = json.loads((BASE / 'independent-cpu-audit-v2.json').read_text())
assert audit['SDK_supported_count'] == audit['source_guard_count'] == 4
directory = BASE / 'candidate'
directory.mkdir(exist_ok=False)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
source = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
text = source.read_text()
old = 'model.granular_particle_count && (has_bodies || model.spring_count || model.triangle_count ||'
new = 'model.granular_particle_count && (model.spring_count || model.triangle_count ||'
assert text.count(old) == 1
changed = text.replace(old, new)
path = directory / 'source_solver.cpp'
path.write_text(changed)
command = list(build['build_command'])
assert command.count(str(source)) == 1
command[command.index(str(source))] = str(path)
command.insert(1, '-I' + str(source.parent))
assert command[-2] == '-o'
image = directory / Path(command[-1]).name
command[-1] = str(image)
inputs = {str(ROOT / name): digest for name, digest in build['sources'].items()}
inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
inputs[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
candidate_plan = {'input_sha256': inputs, 'command': command, 'old_guard_text': old, 'new_guard_text': new,
                  'only_guard_change': True, 'production_changed': False, 'whole_solver_complete': False}
(directory / 'plan.json').write_text(json.dumps(candidate_plan, indent=2) + '\n')
for name, digest in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
with (directory / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(directory / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
for name, digest in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
candidate_plan['image'] = str(image)
candidate_plan['image_sha256'] = hashlib.sha256(image.read_bytes()).hexdigest()
(directory / 'build.json').write_text(json.dumps(candidate_plan, indent=2) + '\n')
assert hashlib.sha256((ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so')
                      .read_bytes()).hexdigest() == build['extension_sha256']
print('Built isolated guard-only candidate', candidate_plan['image_sha256'], 'production unchanged', flush=True)
