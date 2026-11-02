"""Run frozen kernel fixtures through literal current-reference PTX and the exact active compiled source .so."""
import argparse
import ctypes as c
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_particles_ab import native_source
from .ptx_compare import entries, normalise
from reconstruction import kernel_ab as k


class RecordedDriver(k.Driver):
    def __init__(self, backend, inventory):
        super().__init__()
        self.backend, self.inventory = backend, inventory
        self.native = native_source()._KernelDriver() if backend == 'source' else None
        self.outputs, self.used = {}, set()
        if backend == 'original':
            # ctypes resolves a libcuda handle directly, bypassing LD_PRELOAD. Route the unchanged launch
            # through the global shim so the literal-reference calls are observed as well.
            self.cu.cuLaunchKernel = c.CDLL(None).cuLaunchKernel

    def function(self, text, name):
        self.used.add(name)
        if self.native is None:
            return super().function(text, name)
        assert hashlib.sha256(normalise(entries(text)[name]).encode()).hexdigest() == self.inventory[name]['digest']
        return c.c_void_p(self.native.function(name))

    def launch(self, function, threads, params, block=256):
        if self.native is None:
            return super().launch(function, threads, params, block)
        payload = [c.string_at(c.byref(value), c.sizeof(value)) for value in params]
        self.native.launch(function.value, max(1, (threads+block-1)//block), block, payload)
        self.native.synchronize()

    def download(self, pointer, like):
        value = super().download(pointer, like)
        self.outputs[str(len(self.outputs))] = value.copy()
        return value


def residuals(driver, rng):
    for local in (1, 17, 257):
        for worlds in (1, 3):
            count = local*worlds
            for template in ('INS_12NonZeroEntryEfEE', 'INS_12NonZeroEntryEN3glm', 'INS_17BlockNonZeroEntryEN3glm'):
                scalar, block = template.endswith('EfEE'), '17Block' in template
                dtype = np.dtype([('column', 'i4'), ('value', 'f4', (9,))] if block else
                                 [('column', 'i4'), ('value', 'f4')])
                row_count = rng.integers(-1, 6, local, dtype='i4')
                ell = np.zeros((3, local), dtype=dtype)
                ell['column'] = rng.integers(-1, local+1, ell['column'].shape)
                ell['value'] = rng.normal(size=ell['value'].shape).astype('f4')
                diagonal = rng.normal(size=(count+5,) if scalar else (count+5, 9)).astype('f4')
                x, b, extra, initial = [rng.normal(size=(count+5, 3)).astype('f4') for _ in range(4)]
                for use_extra in (False, True):
                    output = driver.upload(initial)
                    driver.launch(driver.function(*k.legacy_ptx('17evaluate_residual'+template)), count,
                                  [driver.upload(row_count), driver.upload(ell), k.u64(3), driver.upload(diagonal),
                                   driver.upload(x), driver.upload(b), driver.upload(extra) if use_extra else k.null(),
                                   output, k.u64(count), k.u64(local)])
                    driver.download(output, initial)
                    driver.free()
    return {}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seeds', nargs='+', type=int, default=[1, 2, 3])
    parser.add_argument('--groups', nargs='+',
                        default=['springs', 'affine', 'lbvh', 'joint_drives', 'point_lines', 'residuals'])
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--group')
    parser.add_argument('--seed', type=int, default=1)
    args = parser.parse_args()
    hook = Path(os.environ['LD_PRELOAD']).resolve(strict=True)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest_path = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest_path.read_bytes()
    manifest = json.loads(saved)
    (args.output/'build.json').write_bytes(saved)
    source_text = (ROOT/'build/reconstruction-csrc/host-particles/source_ptx_bundle.h').read_text()
    source_modules = [m[2] for m in re.findall(r'\{"([^"]+)", R"(\w+)\((.*?)\)\2"\}', source_text, re.S)]
    assert len(source_modules) == 1+max(v['module'] for v in manifest['kernels'].values())
    reference = {}
    for path in (ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        text = path.read_text()
        for name in entries(text):
            reference[name] = text
    assert all(name in reference for name in manifest['kernels'] if name.startswith('_ZN7synreal'))
    groups = {'springs': k.run_springs, 'affine': k.run_affine, 'lbvh': lambda d, r: k.run_lbvh(d, r, 257),
              'joint_drives': k.run_joint_drives, 'point_lines': k.run_point_lines, 'residuals': residuals}
    assert all(name in groups for name in args.groups)
    if args.worker:
        assert args.group in groups
        os.environ['CUDAHOOK_DIR'] = str(args.output)

        def lookup(kernel):
            prefix = kernel if kernel.startswith('_ZN') else '_ZN7synreal6kernel'+kernel
            matches = [name for name in manifest['kernels'] if name.startswith(prefix)]
            assert len(matches) == 1, (kernel, matches)
            name = matches[0]
            return (reference[name] if args.worker == 'original' else
                    source_modules[manifest['kernels'][name]['module']]), name

        k.legacy_ptx = lookup
        driver = RecordedDriver(args.worker, manifest['kernels'])
        try:
            checks = groups[args.group](driver, np.random.default_rng(args.seed))
            np.savez_compressed(args.output/'outputs.npz', **driver.outputs)
            report = {'source_entries': sorted(driver.used), 'downloaded_arrays': len(driver.outputs),
                      'spec_failures': [key for key, value in checks.items() if not value['bitwise_equal']]}
            (args.output/'worker-report.json').write_text(json.dumps(report, indent=2)+'\n')
        finally:
            driver.free()
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
        return int(bool(report['spec_failures']))
    reports = []
    env = {key: value for key, value in os.environ.items() if key not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    for seed in args.seeds:
        for group in args.groups:
            folder = args.output/f'seed{seed}'/group
            folder.mkdir(parents=True)
            outputs, worker_reports = {}, {}
            for backend in ('original', 'source'):
                assert manifest_path.read_bytes() == saved
                command = [sys.executable, '-m', 'reconstruction.csrc.current_kernel_audit', '--worker', backend,
                           '--seed', str(seed), '--group', group, '--output', str(folder/backend)]
                (folder/(backend+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
                with (folder/(backend+'.log')).open('w') as log:
                    code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                          timeout=900).returncode
                if code:
                    print(seed, group, backend, 'worker exit', code, flush=True)
                    return 2
                worker_reports[backend] = json.loads((folder/backend/'worker-report.json').read_text())
                with np.load(folder/backend/'outputs.npz') as data:
                    outputs[backend] = {key: data[key].copy() for key in data.files}
            assert worker_reports['original']['source_entries'] == worker_reports['source']['source_entries']
            assert worker_reports['source']['source_entries']
            a, b = outputs['original'], outputs['source']
            assert set(a) == set(b) and a
            failures = [key for key in a if a[key].dtype != b[key].dtype or a[key].shape != b[key].shape or
                        a[key].tobytes() != b[key].tobytes()]
            metadata = compare_launches(folder/'original/launches.txt', folder/'source/launches.txt', schemas()[0])
            row = {'seed': seed, 'group': group, 'source_entries': worker_reports['source']['source_entries'],
                   'downloaded_arrays': len(a), 'strict_array_failures': failures,
                   'spec_failures': {backend: r['spec_failures'] for backend, r in worker_reports.items()},
                   'metadata': metadata}
            reports.append(row)
            (args.output/'report.json').write_text(json.dumps({'source_sha256': manifest['extension_sha256'],
                'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest(),
                'original_solver_mapped': False, 'groups': reports}, indent=2)+'\n')
            print(seed, group, 'arrays', len(a), 'failures', failures, 'metadata', metadata['equal'], flush=True)
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    return int(any(row['strict_array_failures'] or any(row['spec_failures'].values()) or not row['metadata']['equal']
                   for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
