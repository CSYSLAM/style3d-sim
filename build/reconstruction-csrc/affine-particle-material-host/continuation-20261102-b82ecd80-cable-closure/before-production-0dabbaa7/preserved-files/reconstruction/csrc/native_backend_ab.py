"""Validate C++ source-kernel launches while keeping every literal old PTX launch on the original test driver."""
import argparse
import ctypes
import hashlib
import json
import os

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import native_cuda
from reconstruction.csrc import ptx_compare as pc


class PairedDriver(k.Driver):
    def __init__(self):
        super().__init__()
        self.source = native_cuda.Driver()
        assert self.context.value == self.source.native.context
        self.reference_modules = {hashlib.sha256(path.read_bytes()).hexdigest() for path in pc.LEGACY_PTX.glob('*.ptx')}
        self.source_functions = set()

    def function(self, text, name):
        if hashlib.sha256(text.encode()).hexdigest() in self.reference_modules:
            return super().function(text, name)
        result = self.source.function(text, name)
        self.source_functions.add(result.value)
        return result

    def launch(self, fun, threads, params, block=256):
        if fun.value in self.source_functions: self.source.launch(fun, threads, params, block)
        else: super().launch(fun, threads, params, block)


def smoke():
    image = native_cuda.extension()
    assert image.source_only and not image.solver_api_ready
    driver = image.Driver()
    for name in image.kernel_digests: assert driver.function(name)
    assert len(image.kernel_digests) == 188
    payload = b'source-only CUDA memory'
    pointer = driver.upload(payload)
    assert driver.download(pointer, len(payload)) == payload
    try:
        driver.download(pointer, len(payload) + 1)
        raise AssertionError('Oversized device read was accepted')
    except ValueError: pass
    driver.release(pointer)
    empty = driver.function(next(name for name in image.kernel_digests if 'EmptyKernel' in name))
    for arguments, grid in (([b'\0'], 1), ([], 0)):
        try:
            driver.launch(empty, grid, 256, arguments)
            raise AssertionError('Invalid launch ABI was accepted')
        except ValueError: pass
    view_kernel = driver.function(next(name for name in image.kernel_digests if '25update_hard_contact_duals' in name))
    try:
        driver.launch(view_kernel, 1, 256, [b'\0'])
        raise AssertionError('Invalid structure byte size was accepted')
    except ValueError: pass
    driver.launch(empty, 1, 256, [])
    driver.synchronize()
    return {'kernel_functions_resolved': 188, 'memory_roundtrip': True, 'range_error': True,
            'argument_count_error': True, 'argument_size_error': True, 'zero_grid_error': True, 'empty_kernel': True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--output', type=str, default='native')
    parser.add_argument('--groups', nargs='+')
    args = parser.parse_args()
    out = pc.OUT/'native'/args.output
    out.mkdir(parents=True, exist_ok=True)
    report = {'seed': args.seed, 'smoke': smoke(), 'groups': {}}
    previous = os.environ.get('RECONSTRUCTION_KERNELS')
    os.environ['RECONSTRUCTION_KERNELS'] = 'csrc'
    groups = {'step': k.run_step, 'pcg': lambda d, r: k.run_pcg(d, r, 2048),
              'cable_update': k.run_cable_update, 'cable_prepare': k.run_cable_prepare,
              'cable_evaluate': k.run_cable_evaluate, 'hard_state_branches': k.run_hard_state_branches,
              'hard_evaluate_branches': k.run_hard_evaluate_branches}
    if args.groups:
        assert all(name in groups for name in args.groups)
        groups = {name: groups[name] for name in args.groups}
    try:
        for name, run in groups.items():
            driver = PairedDriver()
            try:
                checks = run(driver, np.random.default_rng(args.seed))
                used = sorted(driver.source.source_entries_used)
            finally:
                driver.free()
            bad = {key: row for key, row in checks.items() if not row['bitwise_equal']}
            assert used, 'No C++ source kernel executed: ' + name
            report['groups'][name] = {'checks': len(checks), 'failures': bad, 'cpp_source_entries': used}
            (out/f'seed{args.seed}.json').write_text(json.dumps(report, indent=2) + '\n')
            print(name, args.seed, len(checks), 'failures', len(bad), 'C++ kernels', len(used), flush=True)
    finally:
        if previous is None: os.environ.pop('RECONSTRUCTION_KERNELS', None)
        else: os.environ['RECONSTRUCTION_KERNELS'] = previous
    return int(any(row['failures'] for row in report['groups'].values()))


if __name__ == '__main__':
    raise SystemExit(main())
