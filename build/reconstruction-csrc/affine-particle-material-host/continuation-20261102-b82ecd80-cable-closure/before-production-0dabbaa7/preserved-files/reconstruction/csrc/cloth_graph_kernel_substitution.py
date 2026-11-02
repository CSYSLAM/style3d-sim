"""Diagnostic-only substitution of selected real graph functions with current original PTX; never a source fix."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

from .capture_cloth_graph_parameters import KernelParams
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--token', action='append', default=[])
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import affine_cloth_graph_ab
    driver = ct.CDLL('libcuda.so.1')
    definitions = {
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuGraphKernelNodeSetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuModuleLoadData': [ct.POINTER(ct.c_void_p), ct.c_void_p],
        'cuModuleGetFunction': [ct.POINTER(ct.c_void_p), ct.c_void_p, ct.c_char_p],
    }
    for name, types in definitions.items():
        getattr(driver, name).argtypes = types
        getattr(driver, name).restype = ct.c_int
    inventory, files = {}, {}
    for path in sorted((ROOT/'build/reconstruction-ptx'/REFERENCE_SHA[:16]).glob('*.ptx')):
        text = path.read_text()
        files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        for name in entries(text):
            if name.startswith('_ZN7synreal'):
                assert name not in inventory
                inventory[name] = path
    assert len(inventory) == 129
    previous_exit = wp.ScopedCapture.__exit__
    modules, functions, records = {}, {}, []

    def inspected_exit(capture, *values):
        result = previous_exit(capture, *values)
        if capture.graph is None:
            return result
        assert capture.graph.graph_exec is None, 'Warp must not have instantiated the captured graph yet'
        path = args.output/f'graph-{len(records):02d}.dot'
        assert driver.cuGraphDebugDotPrint(capture.graph.graph, str(path).encode(), 1) == 0
        changes = []
        for block in path.read_text().split('\n\n'):
            if 'label="{KERNEL' not in block:
                continue
            handles = re.search(r'node handle \| func handle\}\s*\|\s*\{(0x[0-9A-Fa-f]+)', block)
            assert handles
            handle = int(handles[1], 16)
            params = KernelParams()
            assert driver.cuGraphKernelNodeGetParams(handle, ct.byref(params)) == 0
            name = ct.c_char_p()
            assert driver.cuFuncGetName(ct.byref(name), params.func) == 0
            name = name.value.decode()
            if name not in inventory:
                continue
            if name not in functions:
                reference = inventory[name]
                if reference not in modules:
                    module = ct.c_void_p()
                    assert driver.cuModuleLoadData(ct.byref(module), ct.c_char_p(reference.read_bytes()+b'\0')) == 0
                    modules[reference] = module
                function = ct.c_void_p()
                assert driver.cuModuleGetFunction(ct.byref(function), modules[reference], name.encode()) == 0
                functions[name] = function
            if any(token in name for token in args.token):
                params.func = functions[name].value
                status = driver.cuGraphKernelNodeSetParams(handle, ct.byref(params))
                assert status == 0, (name, status)
                changes.append(name)
        records.append(changes)
        return result

    wp.ScopedCapture.__exit__ = inspected_exit
    args.worker = 'source'
    affine_cloth_graph_ab.worker(args)
    assert len(records) == 16
    (args.output/'substitution.json').write_text(json.dumps({
        'diagnostic_only': True, 'production_source_unmodified': True, 'replaces_fixed_candidate': False,
        'tokens': args.token, 'replacements': records, 'reference_ptx_sha256': files,
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2)+'\n')


if __name__ == '__main__':
    main()
