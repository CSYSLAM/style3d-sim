"""Query the actually loaded original CUDA-runtime and compiled-source driver function attributes."""
import ctypes as c
import json
import struct

from reconstruction import kernel_ab as k
from .host_api_probe import load_reference, REFERENCE
from .host_particles_ab import native_source, OUT


def main():
    load_reference()
    reference = c.CDLL(str(REFERENCE))
    get_runtime = reference.cudaFuncGetAttributes
    get_runtime.argtypes = [c.c_void_p, c.c_void_p]
    get_runtime.restype = c.c_int
    anchor = k.Driver()
    get_driver = anchor.cu.cuFuncGetAttribute
    get_driver.argtypes = [c.POINTER(c.c_int), c.c_int, c.c_void_p]
    get_driver.restype = c.c_int
    image = native_source()
    source = image._KernelDriver()
    names = sorted(json.loads((OUT/'new-pcg-ptx.json').read_text()))
    fields = ('max_threads', 'shared_bytes', 'constant_bytes', 'local_bytes', 'registers', 'ptx_version',
              'binary_version', 'cache_mode_ca', 'max_dynamic_shared', 'shared_carveout')
    checks = {}
    for name in names:
        # CUDA12.4 cudaFuncAttributes starts with three size_t fields and seven int fields; provide space for
        # the remaining cluster/reserved fields as well. The original library's runtime writes the full struct.
        buffer = c.create_string_buffer(256)
        original_function = c.cast(getattr(reference, name), c.c_void_p)
        assert get_runtime(buffer, original_function) == 0
        shared, constant, local = struct.unpack_from('<QQQ', buffer.raw)
        maximum, registers, ptx, binary, cache, dynamic, carveout = struct.unpack_from('<7i', buffer.raw, 24)
        old = dict(zip(fields, (maximum, shared, constant, local, registers, ptx, binary, cache, dynamic, carveout)))
        handle = c.c_void_p(source.function(name))
        new = {}
        for index, key in enumerate(fields):
            value = c.c_int()
            anchor.check(get_driver(c.byref(value), index, handle))
            new[key] = value.value
        checks[name] = {'original': old, 'source': new, 'equal': old == new}
        assert old == new, (name, old, new)
    report = {'method': 'actual loaded CUDA runtime attributes vs driver attributes', 'checks': checks,
              'all_equal': True, 'login_called': False, 'kernel_count': image.kernel_count}
    target = OUT.parent/'pcg-order-investigation/runtime-attributes.json'
    target.write_text(json.dumps(report, indent=2)+'\n')
    print('Actually loaded original/source function attributes equal', len(checks))


if __name__ == '__main__':
    main()
