"""Run unchanged auxiliary fixtures against freshly instantiated CUDA library entries; no old fallback."""
import argparse
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc import library_reduction_cases
from reconstruction.csrc import native_cuda
from reconstruction.diagnostics import cub_remaining_ab, cub_scan_ab, thrust_ab


def run(group, seed, out, engine='python'):
    out.mkdir(parents=True, exist_ok=True)
    assert hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() == k.LEGACY_SHA
    modules = {'thrust': ('thrust_kernels',), 'scans': ('cub_sort_kernels',), 'sort': ('cub_sort_kernels',),
               'reduce': ('cub_reduce_kernels',),
               'all': ('thrust_kernels', 'cub_sort_kernels', 'cub_reduce_kernels')}[group]
    source, definitions = {}, {}
    for module in modules:
        text = pc.compile_ptx(pc.CSRC/f'library/{module}.cu', pc.DEFAULT_NVCC)
        for name, entry in entries(text).items():
            source[name], definitions[name] = text, entry
    legacy, reference = {}, {}
    for path in sorted(pc.LEGACY_PTX.glob('*.ptx')):
        text = path.read_text()
        for name, entry in entries(text).items():
            legacy[name], reference[name] = entry, (text, entry)
    missing = source.keys() - legacy.keys()
    assert not missing, sorted(missing)
    if group == 'all':
        assert set(source) == {name for name in legacy if not name.startswith('_ZN7synreal')}
    comparisons = {}
    for name, entry in definitions.items():
        old, new = pc.normalise(legacy[name]), pc.normalise(entry)
        visible = lambda text: re.sub(r'^\.(?:visible|weak) ', '', text)
        comparisons[name] = {'ptx_identical': old == new,
                             'equal_after_visibility': visible(old) == visible(new)}
    tag = group if engine == 'python' else group + '-cpp'
    (out/f'{tag}-ptx.json').write_text(json.dumps(comparisons, indent=2) + '\n')
    report = {'group': group, 'seed': seed, 'engine': engine, 'legacy_sha256': k.LEGACY_SHA,
              'compiled_entries': sorted(source), 'backends': {}}
    for backend in ('legacy', 'source'):
        driver = native_cuda.Driver() if backend == 'source' and engine == 'cpp' else k.Driver()
        used = set()
        function = driver.function
        def selected_function(text, name):
            if backend == 'source':
                if name not in source: raise RuntimeError('Source entry missing: ' + name)
                text = source[name]
                used.add(name)
            return function(text, name)
        driver.function = selected_function
        try:
            rng = np.random.default_rng(seed)
            if group == 'thrust': checks = thrust_ab.run(driver, rng)
            elif group == 'scans': checks = cub_scan_ab.run(driver, rng)
            elif group == 'reduce':
                checks = cub_remaining_ab.reductions(driver, rng)
                checks.update({key + '/signed_zero': value for key, value in
                               cub_remaining_ab.reductions(driver, cub_remaining_ab.SignedZeroInputs()).items()})
            else:
                checks = thrust_ab.run(driver, rng) if group == 'all' else {}
                checks.update(cub_scan_ab.run(driver, rng))
                for fixture in (cub_remaining_ab.histogram, cub_remaining_ab.single_sort,
                                cub_remaining_ab.sweeps, cub_remaining_ab.onesweep):
                    checks.update(fixture(driver, rng))
                if group == 'all':
                    checks.update(cub_remaining_ab.reductions(driver, rng))
                    checks.update({key + '/signed_zero': value for key, value in
                                   cub_remaining_ab.reductions(driver, cub_remaining_ab.SignedZeroInputs()).items()})
        finally:
            driver.free()
        bad = {key: row for key, row in checks.items() if not row['bitwise_equal']}
        report['backends'][backend] = {'checks': len(checks), 'failures': bad, 'source_entries_used': sorted(used)}
        print(group, backend, 'seed', seed, 'checks', len(checks), 'failures', len(bad), 'source entries', len(used),
              flush=True)
    expected = set(source) if group in ('thrust', 'all') else {n for n in source if
        'EmptyKernel' not in n and (group in ('sort', 'reduce') or any(part in n for part in (
            'RadixSortScanBinsKernel', 'DeviceRadixSortExclusiveSumKernel')))}
    assert set(report['backends']['source']['source_entries_used']) == expected
    if group in ('reduce', 'all'):
        driver = k.Driver()
        native = native_cuda.Driver() if engine == 'cpp' else None
        function, launch = driver.function, driver.launch
        native_functions = set()
        if native is not None:
            def paired_function(text, name):
                if text == source.get(name):
                    result = native.function(text, name)
                    native_functions.add(result.value)
                    return result
                return function(text, name)
            def paired_launch(fun, threads, params, block=256):
                if fun.value in native_functions: native.launch(fun, threads, params, block)
                else: launch(fun, threads, params, block)
            driver.function, driver.launch = paired_function, paired_launch
        try:
            checks, used = library_reduction_cases.run(driver, np.random.default_rng(seed + 100), reference, source)
        finally:
            driver.free()
        bad = {key: row for key, row in checks.items() if not row['bitwise_equal']}
        report['exceptional'] = {'checks': len(checks), 'failures': bad, 'source_entries_used': sorted(used)}
        print('exceptional', seed, 'checks', len(checks), 'failures', len(bad), 'source entries', len(used), flush=True)
    (out/f'{tag}-seed{seed}.json').write_text(json.dumps(report, indent=2) + '\n')
    return int(any(row['failures'] for row in report['backends'].values()) or
               bool(report.get('exceptional', {}).get('failures')))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--group', choices=('thrust', 'scans', 'sort', 'reduce', 'all'), required=True)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--engine', choices=('python', 'cpp'), default='python')
    parser.add_argument('--output', type=Path, default=pc.OUT/'library-auxiliary-audit')
    args = parser.parse_args()
    return run(args.group, args.seed, args.output, args.engine)


if __name__ == '__main__':
    raise SystemExit(main())
