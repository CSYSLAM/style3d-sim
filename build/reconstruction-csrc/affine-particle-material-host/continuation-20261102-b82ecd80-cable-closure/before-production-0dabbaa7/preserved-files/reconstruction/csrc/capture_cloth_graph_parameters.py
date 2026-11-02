"""Read owned CUDA graph node arguments after capture without changing graph nodes or execution inputs."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

from .audit_cudahook import SCALAR_WORDS, schemas
from .demo_source_ab import ROOT


class KernelParams(ct.Structure):
    # Unversioned cuGraphKernelNodeGetParams uses CUDA_KERNEL_NODE_PARAMS_v1 (56 bytes on this host).
    _fields_ = [('func', ct.c_void_p), ('gx', ct.c_uint), ('gy', ct.c_uint), ('gz', ct.c_uint),
                ('bx', ct.c_uint), ('by', ct.c_uint), ('bz', ct.c_uint), ('shared', ct.c_uint),
                ('params', ct.POINTER(ct.c_void_p)), ('extra', ct.POINTER(ct.c_void_p))]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import affine_cloth_graph_ab
    driver = ct.CDLL('libcuda.so.1')
    functions = {
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuFuncGetAttribute': [ct.POINTER(ct.c_int), ct.c_int, ct.c_void_p],
    }
    for name, types in functions.items():
        getattr(driver, name).argtypes = types
        getattr(driver, name).restype = ct.c_int
    assert ct.sizeof(KernelParams) == 56
    manifest = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    layout = schemas()[0]
    previous_exit = wp.ScopedCapture.__exit__
    records = []

    def inspected_exit(capture, *values):
        result = previous_exit(capture, *values)
        if capture.graph is None:
            return result
        path = args.output/f'graph-{len(records):02d}.dot'
        assert driver.cuGraphDebugDotPrint(capture.graph.graph, str(path).encode(), 1) == 0
        aliases = {}

        def pointer(value):
            if not value:
                return None
            if value not in aliases:
                aliases[value] = len(aliases)
            return aliases[value]

        nodes = []
        for block in path.read_text().split('\n\n'):
            if 'label="{KERNEL' not in block:
                continue
            index = int(re.search(r'\| \{ID \| (\d+)', block)[1])
            handles = re.search(r'node handle \| func handle\}\s*\|\s*\{(0x[0-9A-Fa-f]+)', block)
            assert handles, block
            params = KernelParams()
            assert driver.cuGraphKernelNodeGetParams(int(handles[1], 16), ct.byref(params)) == 0
            name = ct.c_char_p()
            assert driver.cuFuncGetName(ct.byref(name), params.func) == 0
            name = name.value.decode()
            attributes = {}
            for key, attribute in (('registers', 4), ('local_bytes', 3), ('static_shared_bytes', 1)):
                value = ct.c_int()
                assert driver.cuFuncGetAttribute(ct.byref(value), attribute, params.func) == 0
                attributes[key] = value.value
            node = {'index': index, 'name': name, 'attributes': attributes,
                    'geometry': [params.gx, params.gy, params.gz, params.bx, params.by, params.bz, params.shared]}
            if name in layout:
                assert params.params and not params.extra
                widths = manifest['kernels'][name]['parameters']
                raw = [ct.string_at(params.params[i], width) for i, width in enumerate(widths)]
                normalized = []
                for kind, value in zip(layout[name], raw):
                    if kind == 'pointer':
                        normalized.append(['pointer', pointer(int.from_bytes(value, 'little'))])
                    elif kind in SCALAR_WORDS:
                        fields = []
                        for off in range(0, len(value)//8*8, 8):
                            word = int.from_bytes(value[off:off+8], 'little')
                            if kind == 'U' and off == 288:
                                word &= 0xffffffff
                            if kind == 'H' and off == 248:
                                word &= 0x00ffffffffffffff
                            if kind == 'W' and off == 112:
                                word &= 0xffffffff
                            fields.append([off, word if off in SCALAR_WORDS[kind] else ['pointer', pointer(word)]])
                        normalized.append([kind, fields])
                    else:
                        normalized.append([kind, value.hex()])
                node.update(raw_hex=[x.hex() for x in raw], normalized=normalized)
            nodes.append(node)
        records.append({'file': path.name, 'nodes': nodes})
        return result

    wp.ScopedCapture.__exit__ = inspected_exit
    args.worker = args.backend
    affine_cloth_graph_ab.worker(args)
    assert len(records) == 16
    (args.output/'graph-parameters.json').write_text(json.dumps({
        'graphs': records, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'replaces_fixed_candidate': False, 'graph_parameters_changed': False,
        'source_sha256': manifest['extension_sha256'],
        'view_pointer_aliases_compared': True, 'allocation_offsets_compared': False,
    }, indent=2)+'\n')


if __name__ == '__main__':
    main()
