"""Compare optional/global tetrahedron activation against current original PTX and the actual source extension."""
import ctypes as c
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import OUT, native_source
from .library_entries import entries


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--seed', type=int, default=1)
    args = parser.parse_args()
    rng = np.random.default_rng(args.seed)
    current = OUT.parents[1]/'reconstruction-ptx/64a0be7f7a3c03cb'
    original = next((p.read_text(), name) for p in current.glob('*.ptx')
                    for name in entries(p.read_text()) if 'kernel26evaluate_tetrahedron_forceE' in name)
    old_header = (OUT.parent/'native/source_ptx_bundle.h').read_text()
    old = next(text for _, _, text in re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', old_header, re.S)
               if original[1] in entries(text))
    driver = k.Driver()
    core = native_source()
    source = core._KernelDriver()
    functions = {'original': driver.function(*original), 'source': c.c_void_p(source.function(original[1])),
                 'historical': driver.function(old, original[1])}
    checks, old_failures = {}, {}
    try:
        for local in (1, 3):
            for worlds in (1, 2, 129):
                for activated in (False, True):
                    t = k.tetrahedron_case(rng, local)
                    n, total = 4*local*worlds, local*worlds
                    x = rng.normal(size=(n, 3)).astype('f4')
                    previous = (x+rng.normal(scale=.01, size=(n, 3))).astype('f4')
                    initial = rng.normal(size=(n, 3)).astype('f4')
                    activation = np.linspace(-.25, .375, total, dtype='f4') if activated else None
                    params = [driver.upload(a) for a in (x, previous, t['indices'], t['inverse'], t['materials'], t['volume'])]
                    params += [driver.upload(activation) if activated else k.null(), k.f32(t['inv_dt']),
                               driver.upload(initial), k.u64(total), k.u64(local), k.u64(4*local)]
                    values = {}
                    for tag in ('original', 'source', 'historical') if activated else ('original', 'source'):
                        driver.check(driver.cu.cuMemcpyHtoD_v2(params[8], initial.ctypes.data_as(c.c_void_p),
                                                              c.c_size_t(initial.nbytes)))
                        driver.launch(functions[tag], total, params)
                        values[tag] = driver.download(params[8], initial)
                    label = f'local{local}_worlds{worlds}_activation{int(activated)}'
                    checks[label] = bool(np.array_equal(values['original'].view('u4'), values['source'].view('u4')))
                    assert checks[label], label
                    if activated:
                        old_failures[label] = int(np.count_nonzero(values['original'].view('u4') !=
                                                                  values['historical'].view('u4')))
                        assert (old_failures[label] > 0) == (worlds > 1), (label, old_failures[label])
                    driver.free()
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
        report = {'seed': args.seed, 'checks': checks, 'historical_mismatch_words': old_failures,
                  'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256'],
                  'source_engine': 'actual_compiled_cpp_so_function', 'original_solver_mapped': False}
        (OUT/f'tetrahedron-activation-seed{args.seed}.json').write_text(json.dumps(report, indent=2)+'\n')
        print('Corrected tetrahedron activation cases', len(checks), 'all bitwise equal; historical wrong-index cases',
              sum(value > 0 for value in old_failures.values()))
    finally:
        driver.free()


if __name__ == '__main__':
    main()
