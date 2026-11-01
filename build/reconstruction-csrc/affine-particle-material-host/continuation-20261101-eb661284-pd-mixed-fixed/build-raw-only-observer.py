"""Extend the validated deferred observer with the three actual float-PCG ABIs and complete output spans."""
import hashlib
import json
from pathlib import Path
import subprocess

root = Path.cwd()
base = Path(__file__).resolve().parent
output = base / 'raw-only-observer'
output.mkdir(exist_ok=False)
original = base.parent / 'continuation-20261031-86916989-fixed-failures/deferred-observer/deferred-observer.cpp'
text = original.read_text()
(output / 'base-source.cpp').write_bytes(original.read_bytes())
build = json.loads((root / 'build/reconstruction-csrc/host-particles/build.json').read_text())
extra = []
for token in ('30prepare_inverse_preconditionerE', '23precondition_and_reduceIf',
              '26multiply_matrix_and_reduceINS_12NonZeroEntryEf'):
    matches = [spec for name, spec in build['kernels'].items() if token in name]
    assert len(matches) == 1
    extra.append('        if (!after && group_ == "' + token + '") {\n'
                 '            const std::size_t widths[] = {' + ','.join(map(str, matches[0]['parameters'])) + '};\n'
                 '            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)\n'
                 '                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);\n'
                 '        }\n')

def replace(old, new):
    global text
    assert text.count(old) == 1, old
    text = text.replace(old, new)

replace('        if (!after && group_ == "15initialize_stepE") {',
        ''.join(extra) + '        if (!after && group_ == "15initialize_stepE") {')
source = output / 'deferred-raw-only.cpp'
source.write_text(text)
observer = output / 'deferred-raw-only.so'
cuda = root / 'build/toolchains/cuda-12.4'
command = ['c++', '-std=c++17', '-O2', '-shared', '-fPIC', '-I' + str(cuda / 'include'),
           '-I' + str(root / 'reconstruction/csrc/native'), str(source), '-L' + str(cuda / 'lib/stubs'),
           '-lcuda', '-ldl', '-o', str(observer)]
(output / 'build.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (output / 'build.log').open('w') as log:
    subprocess.run(command, stdout=log, stderr=subprocess.STDOUT, check=True)
(output / 'provenance.json').write_text(json.dumps({
    'files': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
              (Path(__file__), original, source, observer, root / 'reconstruction/csrc/native/surface_view.h')},
    'source_sha256': build['extension_sha256'], 'production_changed': False,
    'per_snapshot_host_synchronization': False}, indent=2) + '\n')
print(observer)
