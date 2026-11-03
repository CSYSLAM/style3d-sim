"""Build the recovered public _core from CUDA/C++ sources without reading or linking a reference solver image.

This builder preserves existing accepted artifacts. A fresh output directory, CUDA 12.4, GLM 1.0.1, Python headers,
pybind11, and a C++17 compiler are required. Linux/WSL2 is supported; this is not a native Windows DLL builder.
The resulting image retains the current incremental solver scope and does not switch the installed package.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import sysconfig

import pybind11

from .build_host import api_header, revision_bundle
from .build_native import parameters
from .library_entries import entries
from .ptx_compare import normalise

ROOT = Path(__file__).resolve().parents[2]
CSRC = Path(__file__).resolve().parent
ACCEPTED_CUDA_DIGEST = 'f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--output', type=Path, required=True, help='Fresh directory; never reuse an existing build')
    parser.add_argument('--nvcc', type=Path, default=ROOT / 'build/toolchains/cuda-12.4/bin/nvcc')
    parser.add_argument('--glm', type=Path, default=ROOT / 'build/third_party/glm-1.0.1')
    parser.add_argument('--cxx', default='c++')
    parser.add_argument('--expected-cuda-digest', default=ACCEPTED_CUDA_DIGEST)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    nvcc, glm = args.nvcc.resolve(strict=True), args.glm.resolve(strict=True)
    assert (glm / 'glm/glm.hpp').is_file()
    cxx = shutil.which(args.cxx)
    assert cxx, args.cxx
    cuda = nvcc.parent.parent
    libraries = [path for path in (cuda / 'lib', cuda / 'lib64') if (path / 'libcudart.so.12').is_file()]
    assert libraries, 'CUDA 12.4 libcudart.so.12 is required'
    cuda_library = libraries[0]
    commands, source_hashes, generated, gpu_calls = [], {}, {}, 0
    version = subprocess.check_output([str(nvcc), '--version'], text=True)
    assert 'release 12.4' in version and 'V12.4.' in version, version
    (output / 'nvcc-version.txt').write_text(version)
    (output / 'cxx-version.txt').write_text(subprocess.check_output([cxx, '--version'], text=True))

    def run(command, log_name):
        commands.append(command)
        (output / 'commands.json').write_text(json.dumps(commands, indent=2) + '\n')
        with (output / log_name).open('w') as log:
            subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT, check=True)

    def remember(path):
        source_hashes[str(path.relative_to(ROOT)) if path.is_relative_to(ROOT) else str(path)] = sha(path)

    dependencies = [CSRC / 'native/source_cuda.cpp', CSRC / 'native/api_schema.json',
                    CSRC / 'native/source_core.cpp', CSRC / 'native/source_solver.cpp',
                    CSRC / 'native/bvh_library.cu', CSRC / 'native/bvh_library.h',
                    CSRC / 'native/surface_view.h', Path(__file__), CSRC / 'build_host.py', CSRC / 'build_native.py',
                    CSRC / 'library_entries.py', CSRC / 'ptx_compare.py', *(CSRC / 'kernels').glob('*.cuh'),
                    *(CSRC / 'library').glob('*.cuh')]
    for path in dependencies:
        remember(path)
    glm_hashes = {str(path.relative_to(glm)): sha(path) for path in sorted((glm / 'glm').rglob('*')) if path.is_file()}
    (output / 'GLM-inputs.json').write_text(json.dumps(glm_hashes, indent=2) + '\n')

    def compile_ptx(source, target):
        remember(source)
        run([str(nvcc), '-ptx', '-arch=sm_52', '-Wno-deprecated-gpu-targets', '-diag-suppress=20012',
             '-std=c++17', '-O3', '-DNDEBUG', '-I', str(glm), '-I', str(CSRC / 'kernels'),
             str(source), '-o', str(target)], target.name + '.log')
        generated[str(target.relative_to(output))] = sha(target)
        return target.read_text()

    sources = sorted((CSRC / 'kernels').glob('*.cu')) + sorted((CSRC / 'library').glob('*.cu'))
    assert len(sources) == 25
    modules, kernels = [], {}
    for index, source in enumerate(sources):
        text = compile_ptx(source, output / f'module-{index:02d}-{source.stem}.ptx')
        modules.append((str(source.relative_to(ROOT)), text))
        for name, body in entries(text).items():
            spec = {'module': index, 'digest': hashlib.sha256(normalise(body).encode()).hexdigest(),
                    'parameters': parameters(body)}
            if name in kernels:
                assert kernels[name]['digest'] == spec['digest'], name
            else:
                kernels[name] = spec
        print('Compiled source module', index + 1, '/', len(sources), source.name, flush=True)
    assert len(kernels) == 188
    compiled_header = []
    for index, (path, text) in enumerate(modules):
        delimiter = f'STANDALONE_{index}'
        assert ')' + delimiter + '"' not in text
        compiled_header.append('{' + json.dumps(path) + ', R"' + delimiter + '(' + text + ')' + delimiter + '"},')
    revisions = {}
    for name in ('pcg_23fb797', 'tetrahedra_23fb797', 'granular_grid_23fb797'):
        revisions[name] = compile_ptx(CSRC / ('revisions/' + name + '.cu'), output / (name + '.ptx'))
    inventory = CSRC / 'native/kernel_symbols_23fb797.json'
    remember(inventory)
    symbols = json.loads(inventory.read_text())
    header, cuda_digest, selected = revision_bundle('\n'.join(compiled_header), revisions['pcg_23fb797'],
        symbols, revisions['tetrahedra_23fb797'], revisions['granular_grid_23fb797'])
    (output / 'source_ptx_bundle.h').write_text(header)
    (output / 'compiled-kernel-inventory.json').write_text(json.dumps({
        'cuda_source_digest': cuda_digest, 'kernels': selected, 'kernel_count': len(selected),
        'all_entries_compiled_from_sources': True, 'reference_image_read': False}, indent=2) + '\n')
    assert len(selected) == 176 and cuda_digest == args.expected_cuda_digest, (len(selected), cuda_digest)
    runtime = CSRC / 'native/source_cuda.cpp'
    schema = CSRC / 'native/api_schema.json'
    (output / 'source_driver.h').write_text(runtime.read_text().split('PYBIND11_MODULE(')[0])
    (output / 'source_api.h').write_text(api_header(json.loads(schema.read_text())))

    # Rebuild the BVH/Thrust/CUB host bridge; compare its device entries to this build's own source registry.
    bvh = output / 'bvh'
    bvh.mkdir()
    source = CSRC / 'native/bvh_library.cu'
    run([str(nvcc), '--cuda', '--keep', '--keep-dir', str(bvh), '-Xcompiler=-fPIC', '-arch=sm_52',
         '-std=c++17', '-O3', '-DNDEBUG', '-diag-suppress=20012', '-I' + str(CSRC / 'kernels'),
         '-I' + str(glm), str(source), '-o', str(bvh / 'bvh_library.host.cpp')], 'bvh-generation.log')
    bvh_entries = {name: name in selected and hashlib.sha256(normalise(body).encode()).hexdigest() ==
                   selected[name]['digest'] for name, body in entries((bvh / 'bvh_library.ptx').read_text()).items()}
    assert len(bvh_entries) == 26 and all(bvh_entries.values()), bvh_entries
    stub = bvh / 'bvh_library.cudafe1.stub.c'
    original = stub.read_bytes()
    (bvh / 'bvh_library.cudafe1.stub.c.original').write_bytes(original)
    patched, replacements = original.decode(), {}
    for symbol in ('MergeAabbs', 'PrimitiveCentroidAabb'):
        before = '_NV_ANON_NAMESPACE::' + symbol
        after = '_GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f::' + symbol
        replacements[symbol] = patched.count(before)
        assert replacements[symbol] > 0, ('Unexpected CUDA 12.4 host stub', symbol)
        patched = patched.replace(before, after)
    stub.write_text(patched)
    obj = bvh / 'bvh_library.o'
    run([cxx, '-std=c++17', '-O3', '-DNDEBUG', '-D__NV_LEGACY_LAUNCH', '-fPIC', '-fvisibility=hidden',
         '-I' + str(cuda / 'include'), '-I' + str(bvh), '-c', str(bvh / 'bvh_library.cudafe1.cpp'),
         '-o', str(obj)], 'bvh-compilation.log')
    wrapper = CSRC / 'native/source_core.cpp'
    extension = output / ('_core' + sysconfig.get_config_var('EXT_SUFFIX'))
    run([cxx, '-std=c++17', '-O2', '-DNDEBUG', '-shared', '-fPIC', '-I' + pybind11.get_include(),
         '-I' + sysconfig.get_path('include'), '-I' + str(cuda / 'include'), '-I' + str(output),
         str(wrapper), str(obj), '-l:libcuda.so.1', '-L' + str(cuda_library), '-l:libcudart.so.12',
         '-Wl,-rpath,' + str(cuda_library), '-o', str(extension)], 'core-compilation.log')
    exported = subprocess.check_output(['nm', '-D', '--defined-only', str(extension)], text=True)
    initialization = [line.split()[-1] for line in exported.splitlines() if ' PyInit_' in line]
    assert initialization == ['PyInit__core'], initialization
    dynamic = subprocess.check_output(['readelf', '-d', str(extension)], text=True)
    (output / 'ELF-dynamic.txt').write_text(dynamic)
    needed = re.findall(r'\(NEEDED\).*?\[(.*?)\]', dynamic)
    allowed = {'libcuda.so.1', 'libcudart.so.12', 'libstdc++.so.6', 'libm.so.6', 'libgcc_s.so.1',
               'libc.so.6', 'ld-linux-x86-64.so.2'}
    assert set(needed) <= allowed, needed
    for name, digest in source_hashes.items():
        assert sha(ROOT / name) == digest, ('Source changed during build', name)
    assert all(sha(glm / name) == digest for name, digest in glm_hashes.items())
    report = {
        'module': '_core', 'source_only': True, 'solver_api_ready': False, 'kernel_count': len(selected),
        'cuda_source_digest': cuda_digest, 'expected_cuda_digest_matched': True,
        'extension': str(extension), 'extension_sha256': sha(extension), 'sources': source_hashes,
        'nvcc_sha256': sha(nvcc), 'glm_inputs_manifest_sha256': sha(output / 'GLM-inputs.json'),
        'bvh_object_sha256': sha(obj), 'bvh_device_entries_match_this_source_build': bvh_entries,
        'generated_PTX_sha256': generated,
        'bvh_host_type_reference_replacements': replacements, 'ELF_needed': needed,
        'initialization_symbols': initialization, 'commands': commands,
        'reference_solver_read_or_linked': False, 'accepted_generated_artifacts_read': False,
        'existing_build_artifacts_modified': False, 'installed_package_switched': False,
        'GPU_calls': gpu_calls, 'runtime_numeric_validation_complete': False, 'whole_solver_complete': False,
    }
    (output / 'build.json').write_text(json.dumps(report, indent=2) + '\n')
    print('Standalone source _core built:', extension, 'kernels', len(selected), 'CUDA digest', cuda_digest, flush=True)


if __name__ == '__main__':
    main()
