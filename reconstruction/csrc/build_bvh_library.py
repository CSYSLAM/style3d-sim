"""Build the CUDA 12.4 cache/BVH bridge and pin its 26 already accepted device entries.

CUDA 12.4 misprints two explicitly named _GLOBAL__N__ functor types as its current anonymous namespace in
generated host registration code. Correct only these host type references; device PTX/fatbin remain untouched.
This build does not link the bridge into the source Solver.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

from . import ptx_compare as pc
from .library_entries import entries


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def build(output):
    output = output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    toolchain = pc.ROOT/'build/toolchains/cuda-12.4'
    source = pc.CSRC/'native/bvh_library.cu'
    commands = []

    def run(command, log_name):
        commands.append(command)
        with (output/log_name).open('w') as log:
            subprocess.run(command, cwd=pc.ROOT, stdout=log, stderr=subprocess.STDOUT, check=True)

    run([str(pc.DEFAULT_NVCC), '--cuda', '--keep', '--keep-dir', str(output), '-Xcompiler=-fPIC',
         '-arch=sm_52', '-std=c++17', '-O3', '-DNDEBUG', '-diag-suppress=20012',
         '-I'+str(pc.CSRC/'kernels'), '-I'+str(pc.ROOT/'build/third_party/glm-1.0.1'),
         str(source), '-o', str(output/'bvh_library.host.cpp')], 'generation.log')
    inventory = json.loads((pc.ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    ptx = output/'bvh_library.ptx'
    checks = {}
    for name, body in entries(ptx.read_text()).items():
        actual = hashlib.sha256(pc.normalise(body).encode()).hexdigest()
        checks[name] = name in inventory['kernels'] and actual == inventory['kernels'][name]['digest']
    assert len(checks) == 26 and all(checks.values()), checks
    stub = output/'bvh_library.cudafe1.stub.c'
    original = stub.read_bytes()
    (output/'bvh_library.cudafe1.stub.c.original').write_bytes(original)
    patched, replacements = original.decode(), {}
    for symbol in ('MergeAabbs', 'PrimitiveCentroidAabb'):
        before = '_NV_ANON_NAMESPACE::'+symbol
        after = '_GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f::'+symbol
        replacements[symbol] = patched.count(before)
        assert replacements[symbol] > 0, 'Unexpected CUDA 12.4 host stub: '+symbol
        patched = patched.replace(before, after)
    stub.write_text(patched)
    obj = output/'bvh_library.o'
    run(['c++', '-std=c++17', '-O3', '-DNDEBUG', '-D__NV_LEGACY_LAUNCH', '-fPIC', '-fvisibility=hidden',
         '-I'+str(toolchain/'include'), '-I'+str(output), '-c', str(output/'bvh_library.cudafe1.cpp'),
         '-o', str(obj)], 'compilation.log')
    library = output/'libsource_bvh_library.so'
    run(['c++', '-shared', str(obj), '-L'+str(toolchain/'lib'), '-l:libcudart.so.12',
         '-Wl,-rpath,'+str(toolchain/'lib'), '-o', str(library)], 'link.log')
    inputs = [source, pc.CSRC/'native/bvh_library.h', pc.CSRC/'library/reduction_functors.cuh',
              pc.CSRC/'kernels/types.cuh', pc.CSRC/'kernels/common.cuh', Path(__file__)]
    report = {'provisional_not_integrated': True, 'source_solver_image_at_build': inventory['extension_sha256'],
              'commands': commands, 'inputs': {str(path.relative_to(pc.ROOT)): digest(path) for path in inputs},
              'host_type_reference_replacements': replacements, 'host_stub_before_sha256':
              hashlib.sha256(original).hexdigest(), 'host_stub_after_sha256': digest(stub),
              'embedded_ptx_sha256': digest(ptx), 'embedded_fatbin_sha256': digest(output/'bvh_library.fatbin'),
              'device_entries_identical_to_accepted_source': checks, 'object_sha256': digest(obj),
              'library_sha256': digest(library)}
    (output/'build.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({'output': str(library), 'accepted_ptx_entries_identical': len(checks),
                      'provisional_not_integrated': True}))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    build(args.output)


if __name__ == '__main__':
    main()
