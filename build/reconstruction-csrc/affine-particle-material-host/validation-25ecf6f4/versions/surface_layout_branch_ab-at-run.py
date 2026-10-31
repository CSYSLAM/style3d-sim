"""Compare frozen original, active source and experimental surface PTX with serialized atomic writes."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .surface_contact_cases import cases


SUFFIXES = ('30evaluate_surface_contact_force', '34add_surface_contact_preconditioner',
            '32multiply_surface_contact_tangent', '35add_surface_contact_stiffness_scale')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trial', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seeds', type=int, nargs='+', default=[1, 2, 3])
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
    image = native_source()
    source = image._KernelDriver()
    trial_text = args.trial.read_text()
    trial_entries = entries(trial_text)
    original_modules = [(path, path.read_text()) for path in
                        sorted((ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx'))]
    d = k.Driver()
    functions, modules = {}, {}
    for suffix in SUFFIXES:
        symbol = next(name for name in trial_entries if suffix in name)
        path, text = next((path, text) for path, text in original_modules if symbol in entries(text))
        functions[suffix] = {'original': d.function(text, symbol),
                             'source': k.ctypes.c_void_p(source.function(symbol)),
                             'trial': d.function(trial_text, symbol)}
        modules[suffix] = {'symbol': symbol, 'original_ptx': str(path),
                           'original_ptx_sha256': hashlib.sha256(text.encode()).hexdigest()}
    report = {'reference_sha256': REFERENCE_SHA, 'source_sha256': image.extension_sha256
              if hasattr(image, 'extension_sha256') else hashlib.sha256(Path(image.__file__).read_bytes()).hexdigest(),
              'trial_sha256': hashlib.sha256(args.trial.read_bytes()).hexdigest(), 'modules': modules,
              'seeds': args.seeds, 'serialized_one_thread': True, 'production_changed': False, 'cases': []}
    try:
        for seed in args.seeds:
            rng = np.random.default_rng(seed)
            for label, c, transform, options in cases(rng):
                for suffix in SUFFIXES:
                    n = len(c.x)
                    initial = rng.uniform(-1, 1, (n, 3, 3) if 'preconditioner' in suffix else
                                          (n,) if 'stiffness_scale' in suffix else (n, 3)).astype('f4')
                    direction = rng.uniform(-1, 1, (n, 3)).astype('f4')
                    raw = bytearray(bytes(k.surface_view(d, c, transform)))
                    if 'count' in options:
                        pointer = d.upload(np.array([options['count']], dtype='i4'))
                        struct.pack_into('<Q', raw, 0, pointer.value)
                    for key, offset in (('capacity', 8), ('particles_per_world', 112), ('shapes_per_world', 208),
                                        ('worlds', 216), ('body_count', 264)):
                        if key in options:
                            struct.pack_into('<Q', raw, offset, options[key])
                    output, p_direction = d.upload(initial), d.upload(direction)
                    parameters = [(k.ctypes.c_char * 296).from_buffer_copy(raw)]
                    if 'tangent' in suffix:
                        parameters.append(p_direction)
                    parameters.append(output)
                    values = {}
                    for backend, function in functions[suffix].items():
                        d.check(d.cu.cuMemcpyHtoD_v2(output, k.ctypes.c_void_p(initial.ctypes.data), initial.nbytes))
                        # One actual CUDA thread processes the entire list; this excludes cross-thread atomic order.
                        d.launch(function, 1, parameters, block=1)
                        values[backend] = d.download(output, initial)
                    checks = {backend: k.compare(suffix, values['original'], value)
                              for backend, value in values.items() if backend != 'original'}
                    row = {'seed': seed, 'fixture': label, 'operation': suffix, 'checks': checks}
                    report['cases'].append(row)
                    if any(not check['bitwise_equal'] for check in checks.values()):
                        filename = f'seed{seed}-{label}-{suffix}.npz'
                        np.savez_compressed(args.output / filename, initial=initial, direction=direction, **values)
                        row['outputs'] = filename
                        print(json.dumps(row), flush=True)
                    d.free()
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
        report['original_solver_mapped'] = False
        report['passed'] = all(check['bitwise_equal'] for row in report['cases'] for check in row['checks'].values())
        report['harness_sha256'] = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
                                    (Path(__file__), ROOT / 'reconstruction/csrc/surface_contact_cases.py',
                                     ROOT / 'reconstruction/kernel_ab.py')}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print('serialized branch comparisons', len(report['cases']), 'passed', report['passed'], flush=True)
        return int(not report['passed'])
    finally:
        d.free()


if __name__ == '__main__':
    raise SystemExit(main())
