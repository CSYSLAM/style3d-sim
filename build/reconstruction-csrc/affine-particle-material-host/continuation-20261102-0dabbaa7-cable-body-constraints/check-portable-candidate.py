"""Check relocation, reject invalid metadata before GPU, and verify a real relocated candidate run."""
import copy
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.candidate_demo_worker import validated_build

original_path = BASE / 'candidate-cache-order/build.json'
original_bytes = original_path.read_bytes()
original = json.loads(original_bytes)
output = BASE / 'portable-candidate-check'
output.mkdir(exist_ok=False)
fake_root = '/home/previous-machine/style3d-sim'
relocated = copy.deepcopy(original)
relocated['image'] = fake_root + str(Path(original['image']).relative_to(ROOT)).join(('/', ''))
relocated['input_sha256'] = {fake_root + '/' + str(Path(name).relative_to(ROOT)): expected
                             for name, expected in original['input_sha256'].items()}
manifest = output / 'relocated-build.json'
manifest.write_text(json.dumps(relocated, indent=2) + '\n')
_, image, recorded_root = validated_build(manifest)
assert image == Path(original['image']) and recorded_root == fake_root
bad_cases = []
wrong = copy.deepcopy(relocated)
wrong['image_sha256'] = '0' * 64
bad_cases.append(('wrong-image-hash', wrong))
wrong = copy.deepcopy(relocated)
wrong['input_sha256'][fake_root + '/../escape'] = '0' * 64
bad_cases.append(('parent-traversal', wrong))
wrong = copy.deepcopy(relocated)
wrong['input_sha256']['/outside/the-recorded-repository'] = '0' * 64
bad_cases.append(('outside-root', wrong))
negative = []
for name, invalid in bad_cases:
    path = output / (name + '.json')
    path.write_text(json.dumps(invalid, indent=2) + '\n')
    try:
        validated_build(path)
    except ValueError as error:
        negative.append({'case': name, 'rejected_before_GPU': True, 'error': str(error)})
    else:
        raise AssertionError(name + ' was unexpectedly accepted')
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
assert free >= 4096
command = [sys.executable, '-B', '-m', 'reconstruction.csrc.candidate_demo_worker', '--backend', 'source',
           '--candidate-build', str(manifest), '--example', 'reconstruction/csrc/cable_body_constraint_scene.py',
           '--frames', '3', '--output', str(output / 'actual-source'), '--',
           '--constraint', 'spring', '--worlds', '1', '--mode', 'newton']
(output / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
with (output / 'run.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                               stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
assert code == 0
reference = BASE / 'discovery-v2-3/spring-w1-newton-b0/original/capture.npz'
actual = output / 'actual-source/capture.npz'
with np.load(reference, allow_pickle=False) as old, np.load(actual, allow_pickle=False) as new:
    assert set(old.files) == set(new.files)
    assert all(old[key].dtype == new[key].dtype and old[key].shape == new[key].shape and
               old[key].tobytes() == new[key].tobytes() for key in old.files)
provenance = json.loads((output / 'actual-source/candidate-provenance.json').read_text())
assert provenance['complete'] and not provenance['SDK_mapped']
assert provenance['recorded_root'] == fake_root and provenance['candidate_image_sha256'] == original['image_sha256']
assert original_path.read_bytes() == original_bytes
paths = [Path(__file__), original_path, manifest, reference, actual,
         ROOT / 'reconstruction/csrc/candidate_demo_worker.py']
(output / 'report.json').write_text(json.dumps({
    'actual_worker_pid': process.pid, 'actual_worker_exit': code, 'full_three_step_state_bytes_equal': True,
    'recorded_root_differs_from_actual_root': True, 'original_manifest_unchanged': True,
    'negative_controls': negative, 'free_memory_MiB': free, 'external_compute_apps': apps,
    'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
    'native_Windows_tested': False, 'WSL_tested_here': False, 'production_modified': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Relocated-source actual exit0, complete state equal; three invalid manifest controls rejected before GPU')
