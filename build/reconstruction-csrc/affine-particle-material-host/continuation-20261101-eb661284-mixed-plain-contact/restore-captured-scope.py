"""Preserve the current host and frozen SDK32 before extending the captured plain/contact type combinations."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA

base = Path(__file__).resolve().parent
reference = base / 'original32'
proof = json.loads((reference / 'report.json').read_text())
assert proof['complete'] and len(proof['cases']) == 32
assert all(row['finite'] and row['all_forces_effective'] for row in proof['cases'])
metadata_path = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = metadata_path.read_bytes()
metadata = json.loads(saved)
assert metadata['extension_sha256'] == 'eb661284fd3852610e81857ccb7cc5731f76a843abd417e8772bdd6693a4efb7'
assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
baselines = base / 'source-eb-guard-baseline'
baselines.mkdir(exist_ok=False)
for name in ('spring-line-w1-newton-b0', 'all-w3-pd-b1'):
    folder = baselines / name
    folder.mkdir()
    runtime = json.loads((reference / name / 'capture.runtime.json').read_text())
    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
               '--example', runtime['example'], '--frames', '3', '--output', str(folder), '--', *runtime['extra']]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=1800).returncode
    assert code != 0 and 'not been captured' in (folder / 'run.log').read_text(), (name, code)
    assert metadata_path.read_bytes() == saved
    print('current source refused', name, flush=True)
checkpoint = root / 'build/reconstruction-checkpoints/mixed-plain-contact-before-eb661284'
checkpoint.mkdir(exist_ok=False)
files = [*metadata['sources'], str(metadata_path.relative_to(root)),
         'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so']
preserved = []
for name in files:
    data = (root / name).read_bytes()
    sha = hashlib.sha256(data).hexdigest()
    if name in metadata['sources']:
        assert sha == metadata['sources'][name]
    target = checkpoint / 'preserved-files' / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    preserved.append({'path': name, 'sha256': sha, 'bytes': len(data)})
references = {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
              for path in reference.rglob('*') if path.is_file()}
(checkpoint / 'checkpoint.json').write_text(json.dumps({
    'source_sha256': metadata['extension_sha256'], 'preserved_files': preserved,
    'fixed_original32_sha256': references, 'whole_solver_complete': False,
}, indent=2) + '\n')
source = root / 'reconstruction/csrc/native/source_solver.cpp'
text = source.read_text()
old = '((plain_spring_count_ > 0) + (plain_line_count_ > 0) + (distance_total_ > 0) == 1) &&'
new = '(plain_spring_count_ || plain_line_count_ || distance_total_) &&'
assert text.count(old) == 1
text = text.replace(old, new)
old_comment = '// Only the single plain-constraint, all-affine, SO3 penalty-contact combinations are captured here.'
assert text.count(old_comment) == 1
text = text.replace(old_comment, '// Captured plain-constraint type combinations use all-affine SO3 penalty contacts.')
(base / 'source-guard-preview.cpp').write_text(text)
source.write_text(text)
print('preserved', len(preserved), 'source/build files and', len(references), 'reference files', flush=True)
with (base / 'compile.log').open('w') as log:
    subprocess.run(metadata['build_command'], cwd=root, stdout=log, stderr=subprocess.STDOUT, timeout=1800, check=True)
metadata['sources'][str(source.relative_to(root))] = hashlib.sha256(source.read_bytes()).hexdigest()
extension = metadata_path.parent / '_source_solver.cpython-312-x86_64-linux-gnu.so'
metadata['extension_sha256'] = hashlib.sha256(extension.read_bytes()).hexdigest()
for name, digest in metadata['sources'].items():
    assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
metadata_path.write_text(json.dumps(metadata, indent=2) + '\n')
(base / 'build-after-guard.json').write_bytes(metadata_path.read_bytes())
print('current host', metadata['extension_sha256'], flush=True)
