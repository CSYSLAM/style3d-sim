"""Literal processed-reference/source GPU checks for revision 23fb797; no solver or authentication calls."""
import argparse
import ctypes as c
import hashlib
import json
import re

import numpy as np

from reconstruction import kernel_ab as k
from . import ptx_compare as pc
from .library_entries import entries
from .host_particles_ab import native_source

OUT = pc.OUT/'host-particles'
CURRENT = pc.ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb'
SOURCE_USED = set()


class RevisionDriver(k.Driver):
    """Keep original launches literal; dispatch source handles through the exact newly compiled C++ .so."""
    def __init__(self):
        super().__init__()
        self.native = native_source()._KernelDriver()
        self.specifications = json.loads((OUT/'build.json').read_text())['kernels']
        self.references = {hashlib.sha256(p.read_bytes()).hexdigest() for p in CURRENT.glob('*.ptx')}
        self.source_functions = set()

    def function(self, text, name):
        if hashlib.sha256(text.encode()).hexdigest() in self.references:
            return super().function(text, name)
        actual = hashlib.sha256(pc.normalise(entries(text)[name]).encode()).hexdigest()
        assert actual == self.specifications[name]['digest'], 'Requested source differs from compiled .so'
        function = self.native.function(name)
        self.source_functions.add(function)
        SOURCE_USED.add(name)
        return c.c_void_p(function)

    def launch(self, function, threads, args, block=256):
        if function.value not in self.source_functions:
            return super().launch(function, threads, args, block)
        payload = [c.string_at(c.byref(value), c.sizeof(value)) for value in args]
        self.native.launch(function.value, max(1, (threads + block - 1) // block), block, payload)


def modules():
    result = {}
    for path in CURRENT.glob('*.ptx'):
        text = path.read_text()
        for name in entries(text):
            result[name] = text
    return result


def pcg(seed):
    rng = np.random.default_rng(seed)
    originals = modules()
    source = (pc.OUT/'pcg_23fb797.ptx').read_text()
    names = json.loads((OUT/'reference-revision-audit.json').read_text())['added']
    report = {}
    driver = RevisionDriver()
    for name in names:
        assert pc.normalise(entries(source)[name]) == pc.normalise(entries(originals[name])[name])
        functions = [driver.function(originals[name], name), driver.function(source, name)]
        for n in (1, 17, 257):
            for explicit in (False, True):
                total = n + 5
                world = rng.permutation(n).astype('i4') if explicit else None
                q, v, z, p, ap, solution = [rng.normal(size=(total, 3)).astype('f4') for _ in range(6)]
                num, den = [rng.uniform(.1, 3, total).astype('f4') for _ in range(2)]
                den[:min(5, n)] = np.array([0, -0.0, 1e-32, np.nan, np.inf], dtype='f4')[:min(5, n)]
                per_world, zero = c.c_uint32(1), c.c_void_p(0)
                configs = (False, True) if 'precondition_and_reduce' in name else (0, 1, 11) if (
                    'update_cg_direction' in name) else (0,)
                for config in configs:
                    arrays = {'q': q, 'v': v, 'z': z, 'p': p, 'ap': ap, 'solution': solution,
                              'num': num, 'den': den, 'world': world}
                    if 'precondition_and_reduce' in name:
                        matrix = 'IN3glm' in name
                        arrays['inverse'] = rng.normal(size=(total, 9) if matrix else total).astype('f4')
                        arrays['sum'] = np.zeros(total, dtype='f4')
                        outputs = ('z', 'sum')
                    elif 'multiply_matrix_and_reduce' in name:
                        scalar = 'NonZeroEntryEf' in name
                        block = '17BlockNonZeroEntry' in name
                        arrays['diagonal'] = rng.normal(size=total if scalar else (total, 9)).astype('f4')
                        arrays['rows'] = np.array([3, 2, -1, 8, 3, 1, 0], dtype='i4')
                        ell = np.zeros((3, 7), dtype=[('column', 'i4'), ('value', 'f4', (9,))] if block else
                                       [('column', 'i4'), ('value', 'f4')])
                        ell['column'] = rng.integers(-1, 9, (3, 7))
                        ell['value'] = rng.normal(size=ell['value'].shape).astype('f4')
                        arrays['entries'], arrays['sum'] = ell, np.zeros(total, dtype='f4')
                        outputs = ('ap', 'sum')
                    elif 'update_cg_direction' in name:
                        outputs = ('p',)
                    else:
                        outputs = ('solution', 'q')
                    results = []
                    for fun in functions:
                        ptr = {key: driver.upload(value) if value is not None else zero for key, value in arrays.items()}
                        if 'precondition_and_reduce' in name:
                            args = [ptr['inverse'] if not config else zero, ptr['q'], ptr['z'], c.c_bool(config),
                                    ptr['world'], per_world, ptr['sum'], k.u64(n)]
                        elif 'multiply_matrix_and_reduce' in name:
                            args = [ptr['rows'], ptr['entries'], k.u64(3), ptr['diagonal'], ptr['p'], ptr['v'],
                                    ptr['ap'], ptr['world'], per_world, ptr['sum'], k.u64(n), k.u64(7)]
                        elif 'update_cg_direction' in name:
                            args = [c.c_int(config), ptr['z'], ptr['world'], per_world, ptr['num'], ptr['den'],
                                    ptr['p'], k.u64(n)]
                        else:
                            args = [ptr['world'], per_world, ptr['num'], ptr['den'], ptr['p'], ptr['ap'],
                                    ptr['solution'], ptr['q'], k.u64(n)]
                        driver.launch(fun, n, args)
                        results.append({key: driver.download(ptr[key], arrays[key]) for key in outputs})
                    for key in outputs:
                        tag = f'{name}/{n}/{explicit}/{config}/{key}'
                        report[tag] = bool(np.array_equal(results[0][key].view('u4'), results[1][key].view('u4')))
                        assert report[tag], tag
                    driver.free()
    return report


def affine(seed):
    from . import affine_block_cases
    bundle = (pc.OUT/'native/source_ptx_bundle.h').read_text()
    match = re.search(r'\{"reconstruction/csrc/kernels/affine_block.cu", R"(\w+)\((.*?)\)\1"\},', bundle, re.S)
    assert match
    source = match[2]
    old_lookup, old_directory = k.legacy_ptx, pc.LEGACY_PTX

    def lookup(prefix):
        name = next(name for name in entries(source) if prefix in name)
        return source, name

    k.legacy_ptx, pc.LEGACY_PTX = lookup, CURRENT
    driver = RevisionDriver()
    try:
        result = affine_block_cases.run(driver, np.random.default_rng(seed))
        assert all(row['bitwise_equal'] for row in result.values())
        return result
    finally:
        driver.free()
        k.legacy_ptx, pc.LEGACY_PTX = old_lookup, old_directory


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--seed', type=int, default=1)
    args = parser.parse_args()
    result = {'seed': args.seed, 'pcg': pcg(args.seed), 'affine': affine(args.seed), 'login_called': False,
              'source_engine': 'compiled_cpp_so', 'source_entries_used': sorted(SOURCE_USED),
              'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256']}
    assert len(SOURCE_USED) == 9, 'Seven new PCG entries and both affine variants must actually execute'
    (OUT/f'revision-kernels-seed{args.seed}.json').write_text(json.dumps(result, indent=2)+'\n')
    print('revision PCG checks', len(result['pcg']), 'affine checks', len(result['affine']), 'all bitwise passed')


if __name__ == '__main__':
    main()
