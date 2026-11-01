"""Compile an isolated typed-integer cache initializer using the SDK's observed Thrust value-fill path."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
directory = BASE / 'cache-value-prototype'
directory.mkdir(exist_ok=False)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
assert build['extension_sha256'] == 'dec858e551f015374453713edc46910028cae95a210b33acd6c9e9006a1c0282'
native = ROOT / 'reconstruction/csrc/native'
source = (native / 'bvh_library.cu').read_text()
marker = 'extern "C" int source_bvh_sequence_fill('
assert source.count(marker) == 1
integer_fill = '''// SDK Granular construction uses typed int fills with both one and minus one.
extern "C" int source_cache_initialize_integer(void* data, std::size_t count, int value)
{
    if (!count) return cudaSuccess;
    initialize_cache(data, count, value);
    return cudaGetLastError();
}

'''
source = source.replace(marker, integer_fill + marker)
(directory / 'bvh_library.cu').write_text(source)
header = (native / 'bvh_library.h').read_text()
marker = 'extern "C" __attribute__((visibility("default"))) int source_bvh_sequence_fill('
assert header.count(marker) == 1
declaration = '''extern "C" __attribute__((visibility("default"))) int source_cache_initialize_integer(
    void* data, std::size_t count, int value);
'''
(directory / 'bvh_library.h').write_text(header.replace(marker, declaration + marker))
builder = (ROOT / 'reconstruction/csrc/build_bvh_library.py').read_text()
replacements = {
    "source = pc.CSRC/'native/bvh_library.cu'": "source = Path(" + repr(str(directory / 'bvh_library.cu')) + ')',
    "'-I'+str(pc.CSRC/'kernels'),": "'-I'+str(pc.CSRC/'native'), '-I'+str(pc.CSRC/'kernels'),",
    "pc.CSRC/'native/bvh_library.h'": 'Path(' + repr(str(directory / 'bvh_library.h')) + ')',
}
for before, after in replacements.items():
    assert builder.count(before) == 1, before
    builder = builder.replace(before, after)
script = directory / 'build-library-as-run.py'
script.write_text(builder)
ast.parse(builder)
inputs = {str(ROOT / name): sha for name, sha in build['sources'].items()}
paths = [Path(__file__), directory / 'bvh_library.cu', directory / 'bvh_library.h', script,
         BASE / 'bond-constructor-static-observations.json']
inputs.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
plan = {'input_sha256': inputs, 'production_host_sha256': build['extension_sha256'],
        'only_new_typed_integer_host_API': True, 'production_changed': False,
        'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(directory / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')


def verify():
    assert build_path.read_bytes() == build_bytes
    for name, sha in inputs.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


verify()
namespace = {'__name__': 'reconstruction.csrc.bond_integer_cache_prototype',
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(builder, str(script), 'exec'), namespace)
namespace['build'](directory / 'library')
verify()
library = directory / 'library/libsource_bvh_library.so'
symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(library)], text=True)
assert sum(line.split()[-1] == 'source_cache_initialize_integer' for line in symbols.splitlines()) == 1
(directory / 'defined-symbols.txt').write_text(symbols)
helper = json.loads((directory / 'library/build.json').read_text())
checks = helper['device_entries_identical_to_accepted_source']
assert len(checks) == 26 and all(checks.values())
assert (native / 'bvh_library.cu').read_text().replace(marker, marker) != source
report = {**plan, 'library_sha256': hashlib.sha256(library.read_bytes()).hexdigest(),
          'accepted_device_entries_identical': 26, 'new_integer_API_exported': True,
          'all_previous_host_APIs_retained': True, 'solver_linked_to_prototype': False}
(directory / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('Isolated integer initializer built; all26 device entries identical; no runtime equivalence claimed', flush=True)
