"""Check real original runtime/PTX and compiled source on disjoint contacts crossing the 8192-thread surface cap."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.rigid_contact import Bodies
from reconstruction.surface_contact import SurfaceContacts
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_same_buffer_probe import Dim3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    d = k.Driver()
    load_reference()
    library = ct.CDLL(str(REFERENCE))
    runtime = library.cudaLaunchKernel
    runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime.restype = ct.c_int
    image = native_source()
    source = image._KernelDriver()
    modules = [(p, p.read_text()) for p in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx')]
    operations = {'force': '30evaluate_surface_contact_force', 'stiffness': '35add_surface_contact_stiffness_scale',
                  'preconditioner': '34add_surface_contact_preconditioner', 'tangent': '32multiply_surface_contact_tangent'}
    functions, ptx_sha = {}, {}
    for operation, token in operations.items():
        path, text = next((p, t) for p, t in modules if any(token in name for name in entries(t)))
        symbol = next(name for name in entries(text) if token in name)
        functions[operation] = {'original-runtime': ct.cast(getattr(library, symbol), ct.c_void_p),
                               'original-ptx': d.function(text, symbol), 'source': ct.c_void_p(source.function(symbol))}
        ptx_sha[operation] = hashlib.sha256(path.read_bytes()).hexdigest()
    rng, rows = np.random.default_rng(8193), []
    try:
        for count in (8191, 8192, 8193, 16385):
            n = 3 * count
            x = np.tile(np.array([[-.05, 0, .025], [.05, 0, .025], [0, .05, .025]], dtype='f4'), (count, 1))
            velocity = rng.uniform(-.1, .1, x.shape).astype('f4')
            previous = (x - velocity * np.float32(1 / 120)).astype('f4')
            transform = np.array([[0, 0, 0, 0, 0, 0, 1]], dtype='f4')
            f = lambda value: np.array([value], dtype='f4')
            c = SurfaceContacts(count, np.arange(n, dtype='i4').reshape(-1, 3),
                np.tile(np.array([.2, .3, .5], dtype='f4'), (count, 1)), np.zeros(count, dtype='i4'),
                np.zeros((count, 3), dtype='f4'), np.zeros((count, 3), dtype='f4'),
                np.tile(np.array([0, 0, 2], dtype='f4'), (count, 1)), np.full(n, .05, dtype='f4'),
                np.tile(np.array([0, 0, 1.5], dtype='f4'), count), np.ones(n, dtype='i4'), np.zeros(n, dtype='i4'),
                np.array([-1], dtype='i4'), np.array([1], dtype='i4'), transform[:, :3],
                np.ones((1, 3), dtype='f4'), f(.0), f(1000), f(1), f(80), f(.5), 1000, 1, 80, .5,
                Bodies(np.zeros(0, dtype='i4'), np.zeros((0, 4), dtype='i4'), np.zeros((0, 3), dtype='f4')),
                x, previous, 120.)
            packed = ct.create_string_buffer(bytes(k.surface_view(d, c, transform)))
            direction = d.upload(rng.uniform(-1, 1, (n, 3)).astype('f4'))
            for operation in operations:
                shape = (n + 5, 3, 3) if operation == 'preconditioner' else (n + 5,) if operation == 'stiffness' \
                    else (n + 5, 3)
                initial = rng.uniform(-1, 1, shape).astype('f4')
                initial[n:] = -123
                output = d.upload(initial)
                pointers = [direction, output] if operation == 'tangent' else [output]
                holders = (ct.c_void_p * (1 + len(pointers)))(ct.cast(packed, ct.c_void_p),
                    *[ct.cast(ct.byref(value), ct.c_void_p) for value in pointers])
                values = {}
                for backend, function in functions[operation].items():
                    d.check(d.cu.cuMemcpyHtoD_v2(output, ct.c_void_p(initial.ctypes.data), initial.nbytes))
                    grid = min((count + 255) // 256, 32)
                    if backend == 'original-runtime':
                        assert runtime(function, Dim3(grid, 1, 1), Dim3(256, 1, 1), holders, 0, None) == 0
                    else:
                        d.check(d.cu.cuLaunchKernel(function, grid, 1, 1, 256, 1, 1, 0, None, holders, None))
                    d.check(d.cu.cuCtxSynchronize())
                    values[backend] = d.download(output, initial)
                    assert values[backend][n:].tobytes() == initial[n:].tobytes(), 'Guard elements changed'
                    assert values[backend][n-3:n].tobytes() != initial[n-3:n].tobytes(), 'Final contact not exercised'
                checks = {backend: k.compare(operation, values['original-runtime'], value)
                          for backend, value in values.items() if backend != 'original-runtime'}
                rows.append({'contacts': count, 'operation': operation, 'grid': grid, 'block': 256,
                             'checks': checks, 'final_contact_exercised': True, 'guard_unchanged': True})
                np.savez_compressed(args.output / f'n{count}-{operation}.npz', initial=initial, **values)
            d.free()
        report = {'source_sha256': hashlib.sha256(Path(image.__file__).read_bytes()).hexdigest(),
                  'reference_sha256': REFERENCE_SHA, 'original_ptx_sha256': ptx_sha, 'comparisons': rows,
                  'same_buffers_for_all_backends': True, 'disjoint_contact_targets': True,
                  'original_intentionally_mapped_in_diagnostic': True, 'whole_solver_accepted': False,
                  'passed': all(value['bitwise_equal'] for row in rows for value in row['checks'].values()),
                  'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print('surface cap/stride', len(rows), 'operator/count cases, exact', report['passed'], flush=True)
        return int(not report['passed'])
    finally:
        d.free()


if __name__ == '__main__':
    raise SystemExit(main())
