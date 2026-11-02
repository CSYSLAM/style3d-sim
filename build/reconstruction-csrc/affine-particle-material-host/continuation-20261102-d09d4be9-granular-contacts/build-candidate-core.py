"""Build the exact isolated candidate behind the existing public Core wrapper without changing production inputs."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
candidate_path = BASE / 'candidate-guard-only/build.json'
candidate_bytes = candidate_path.read_bytes()
candidate = json.loads(candidate_bytes)
host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host_bytes = host_path.read_bytes()
host = json.loads(host_bytes)
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert candidate['image_sha256'] == 'ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8'
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == candidate['image_sha256']
output = BASE / 'candidate-public-core'
output.mkdir(exist_ok=False)
source = BASE / 'candidate-guard-only/source_solver.cpp'
wrapper = ROOT / 'reconstruction/csrc/native/source_core.cpp'
local_source, local_wrapper = output / 'source_solver.cpp', output / 'source_core.cpp'
local_source.write_bytes(source.read_bytes())
local_wrapper.write_bytes(wrapper.read_bytes())
sources = {str(Path(name).relative_to(ROOT)): digest for name, digest in candidate['input_sha256'].items()}
for path in (Path(__file__), wrapper, local_source, local_wrapper, candidate_path):
    sources[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
command = list(candidate['command'])
assert command.count(str(source)) == 1
command[command.index(str(source))] = str(local_wrapper)
extension = output / '_core.cpython-312-x86_64-linux-gnu.so'
assert command[-2] == '-o'
command[-1] = str(extension)
command.insert(1, '-H')
(output / 'build.command.json').write_text(json.dumps(command, indent=2) + '\n')


def verify():
    assert host_path.read_bytes() == host_bytes and candidate_path.read_bytes() == candidate_bytes
    assert local_source.read_bytes() == source.read_bytes() and local_wrapper.read_bytes() == wrapper.read_bytes()
    for name, expected in sources.items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name


verify()
with (output / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(output / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
verify()
assert str(local_source) in (output / 'build.log').read_text()
symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(extension)], text=True)
initializers = [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line]
assert initializers == ['PyInit__core']
(output / 'build.json').write_text(json.dumps({
    'module': '_core', 'source_only': True, 'solver_api_ready': False,
    'source_host_sha256': candidate['image_sha256'], 'production_host_sha256': host['extension_sha256'],
    'extension_sha256': hashlib.sha256(extension.read_bytes()).hexdigest(),
    'sources': sources, 'build_command': command, 'kernel_count': 176,
    'cuda_source_digest': host['cuda_source_digest'], 'initialization_symbols': initializers,
    'compiled_solver_source': str(local_source.relative_to(ROOT)), 'compiler_include_trace_verified': True,
    'production_changed': False, 'reference_sdk_modified': False, 'default_package_switched': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Candidate public Core built', hashlib.sha256(extension.read_bytes()).hexdigest(), flush=True)
