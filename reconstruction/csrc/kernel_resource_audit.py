"""Read actual loaded-kernel resource attributes; do not change cache, launch, register or math settings."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .ptx_compare import normalise


class RuntimeAttributesPrefix(ct.Structure):
    # The stable prefix is checked against the bundled CUDA 12.4 driver_types.h; reserve ample writable tail space.
    _fields_ = [(name, ct.c_size_t) for name in ('shared_bytes', 'constant_bytes', 'local_bytes')] + [
        (name, ct.c_int) for name in ('max_threads', 'registers', 'ptx_version', 'binary_version', 'cache_mode_ca',
                                    'max_dynamic_shared_bytes', 'preferred_shared_carveout')]


NAMES = ('max_threads', 'shared_bytes', 'constant_bytes', 'local_bytes', 'registers', 'ptx_version',
         'binary_version', 'cache_mode_ca', 'max_dynamic_shared_bytes', 'preferred_shared_carveout')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build_path.read_bytes()
    build = json.loads(saved)
    original_entries, original_paths = {}, []
    for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx'):
        original_entries.update(entries(path.read_text()))
        original_paths.append(path)
    bundle = build_path.parent / 'source_ptx_bundle.h'
    modules = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\}', bundle.read_text(), re.S)
    source_entries = {}
    for _, _, text in modules:
        source_entries.update(entries(text))
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime.cudaFuncGetAttributes.argtypes = [ct.c_void_p, ct.c_void_p]
    runtime.cudaFuncGetAttributes.restype = ct.c_int
    driver.cu.cuFuncGetAttribute.argtypes = [ct.POINTER(ct.c_int), ct.c_int, ct.c_void_p]
    driver.cu.cuFuncGetAttribute.restype = ct.c_int
    source = native_source()
    assert hashlib.sha256(Path(source.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    native = source._KernelDriver()
    results = []
    for name in sorted(build['kernels']):
        assert build_path.read_bytes() == saved
        if not name.startswith('_ZN7synreal'):
            continue
        function = ct.cast(getattr(runtime, name), ct.c_void_p)
        raw = ct.create_string_buffer(512)
        code = runtime.cudaFuncGetAttributes(raw, function)
        assert code == 0, (name, code)
        old = RuntimeAttributesPrefix.from_buffer(raw)
        original = {field: int(getattr(old, field)) for field in NAMES}
        new_function = ct.c_void_p(native.function(name))
        current = {}
        for index, field in enumerate(NAMES):
            value = ct.c_int()
            driver.check(driver.cu.cuFuncGetAttribute(ct.byref(value), index, new_function))
            current[field] = value.value
        differences = {field: [original[field], current[field]] for field in NAMES if original[field] != current[field]}
        results.append({'symbol': name, 'original': original, 'source': current, 'differences': differences,
                        'normalized_ptx_entry_equal': normalise(original_entries[name]) ==
                                                      normalise(source_entries[name])})
    assert len(results) == 129
    headers = [ROOT / 'build/toolchains/cuda-12.4/include' / name for name in ('driver_types.h', 'cuda.h')]
    report = {'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
              'kernels': results, 'different_kernels': sum(bool(row['differences']) for row in results),
              'cuda_kernel_launches': 0, 'kernel_resource_settings_modified': False,
              'resource_equality_implies_numeric_equality': False, 'whole_solver_complete': False,
              'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in
                               [Path(__file__), build_path, bundle, *headers, *original_paths]}}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('Kernel resource attributes:', len(results), 'owned entries;', report['different_kernels'], 'different')


if __name__ == '__main__':
    main()
