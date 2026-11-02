"""Build a source-only CUDA execution extension; does not read or link the proprietary solver."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sysconfig

import pybind11

from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.library_entries import entries


def parameters(entry):
    header = entry[:entry.index('{')]
    return [int(count) if count else int(width) // 8 for width, count in
            re.findall(r'\.param\s+(?:\.align\s+\d+\s+)?\.[busf](\d+)\s+\w+(?:\[(\d+)\])?', header)]


def main():
    out = pc.OUT/'native'
    out.mkdir(parents=True, exist_ok=True)
    modules, kernels, files = [], {}, {}
    for source in sorted((pc.CSRC/'kernels').glob('*.cu')) + sorted((pc.CSRC/'library').glob('*.cu')):
        text = pc.compile_ptx(source, pc.DEFAULT_NVCC)
        index = len(modules)
        modules.append((str(source.relative_to(pc.ROOT)), text))
        files[str(source.relative_to(pc.ROOT))] = hashlib.sha256(source.read_bytes()).hexdigest()
        for name, entry in entries(text).items():
            digest = hashlib.sha256(pc.normalise(entry).encode()).hexdigest()
            if name in kernels:
                assert kernels[name]['digest'] == digest, 'Conflicting duplicate source kernel: ' + name
            else: kernels[name] = {'module': index, 'digest': digest, 'parameters': parameters(entry)}
    assert len(kernels) == 188, f'Expected 188 compiled kernels, found {len(kernels)}'
    dependencies = [*(pc.CSRC/'kernels').glob('*.cuh'), *(pc.CSRC/'library').glob('*.cuh'),
                    pc.CSRC/'native/source_cuda.cpp', pc.CSRC/'build_native.py']
    for path in dependencies:
        files[str(path.relative_to(pc.ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
    digest = hashlib.sha256(json.dumps(kernels, sort_keys=True).encode()).hexdigest()
    header = ['#pragma once', '#include <vector>', '#include <cstddef>',
              'struct ModuleSpec { const char* path; const char* ptx; };',
              'struct KernelSpec { const char* name; std::size_t module; const char* digest; '
              'std::vector<std::size_t> parameters; };',
              f'static const char* source_digest = "{digest}";',
              'static const std::vector<ModuleSpec> source_modules = {']
    for index, (name, text) in enumerate(modules):
        delimiter = f'SOURCE_PTX_{index}'
        assert ')' + delimiter + '"' not in text
        header.append('{' + json.dumps(name) + ', R"' + delimiter + '(' + text + ')' + delimiter + '"},')
    header += ['};', 'static const std::vector<KernelSpec> source_kernels = {']
    for name, spec in sorted(kernels.items()):
        sizes = ','.join(map(str, spec['parameters']))
        header.append('{' + json.dumps(name) + f', {spec["module"]}, "{spec["digest"]}", {{{sizes}}}' + '},')
    header += ['};', '']
    (out/'source_ptx_bundle.h').write_text('\n'.join(header))
    target = out/('_source_cuda' + sysconfig.get_config_var('EXT_SUFFIX'))
    command = ['c++', '-std=c++17', '-O2', '-DNDEBUG', '-shared', '-fPIC',
               '-I' + pybind11.get_include(), '-I' + sysconfig.get_path('include'),
               '-I' + str(pc.ROOT/'build/toolchains/cuda-12.4/include'), '-I' + str(out),
               str(pc.CSRC/'native/source_cuda.cpp'), '-l:libcuda.so.1', '-o', str(target)]
    subprocess.run(command, check=True)
    manifest = {'source_only': True, 'solver_api_ready': False, 'modules': len(modules), 'kernel_count': len(kernels),
                'source_digest': digest, 'kernels': kernels, 'sources': files, 'build_command': command,
                'extension_sha256': hashlib.sha256(target.read_bytes()).hexdigest()}
    (out/'build.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(target)
    print('compiled source kernels', len(kernels), 'modules', len(modules), flush=True)


if __name__ == '__main__':
    main()
