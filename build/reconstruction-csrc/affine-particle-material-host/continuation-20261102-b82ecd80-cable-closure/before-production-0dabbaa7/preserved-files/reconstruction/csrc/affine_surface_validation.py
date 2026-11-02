"""Serial validation of one pinned body/full-surface source image, preserving every strict failure."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--kernel-inputs', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    assert metadata['kernel_count'] == 176
    assert metadata['cuda_source_digest'] == 'f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a'
    (args.output / 'build.json').write_bytes(saved)
    jobs = []

    def job(name, module, options, timeout=7200):
        command = [sys.executable, '-m', 'reconstruction.csrc.' + module, *map(str, options)]
        jobs.append((name, command, timeout))

    for operation in ('force', 'stiffness', 'preconditioner', 'tangent'):
        job('kernel-' + operation, 'surface_common_input_replay', [
            '--operation', operation, '--capture', args.kernel_inputs, '--output', args.output / ('kernel-' + operation)])
    job('source8', 'affine_surface_ab', ['--backend', 'source', '--frames', 3, '--references', args.reference,
                                       '--output', args.output / 'source8'])
    job('surface-graph60', 'affine_surface_graph_ab', ['--frames', 60, '--output', args.output / 'surface-graph60'])
    job('legacy-cloth-graph60', 'affine_cloth_graph_ab', ['--frames', 60,
                                                      '--output', args.output / 'legacy-cloth-graph60'])
    # Keep the tested diagnostic version portable without depending on the previous machine's CUDA installation.
    sanitizer = ROOT / 'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
    assert sanitizer.is_file(), 'Pinned Compute Sanitizer is missing; verify the reconstruction snapshot'
    init_output = args.output / 'surface-initcheck3'
    init_output.mkdir()
    job('surface-initcheck3', 'affine_surface_graph_ab', ['--worker', 'source', '--frames', 3, '--output', init_output])
    name, command, timeout = jobs.pop()
    jobs.append((name, [str(sanitizer), '--tool', 'initcheck', '--error-exitcode', '91', *command], timeout))
    job('self-contract246', 'self_collision_contract_ab', ['--output', args.output / 'self-contract246'])
    job('regression74', 'joint_continuation_regression', ['--output', args.output / 'regression74'], 14400)
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    state = {'source_sha256': metadata['extension_sha256'], 'jobs': [], 'running': None, 'complete': False}
    (args.output / 'runner-sha256.txt').write_text(hashlib.sha256(Path(__file__).read_bytes()).hexdigest() + '\n')

    def save():
        (args.output / 'status.json').write_text(json.dumps(state, indent=2) + '\n')

    for name, command, timeout in jobs:
        assert build.read_bytes() == saved, 'Production image changed during GPU validation'
        for path, expected in metadata['sources'].items():
            assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, path
        state['running'] = name
        save()
        (args.output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        start = time.monotonic()
        with (args.output / (name + '.log')).open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                  timeout=timeout).returncode
        state['jobs'].append({'name': name, 'exit': code, 'seconds': time.monotonic() - start})
        state['running'] = None
        save()
        print(name, code, flush=True)
        if name == 'source8':
            rows = json.loads((args.output / 'source8/report.json').read_text())['cases']
            assert len(rows) == 8
            assert all(not row['worker_exit'] and row['finite'] and row['metadata']['equal'] and row['coverage']
                       for row in rows), 'Worker/ABI/coverage failure cannot be classified as an atomic state difference'
        if code and (name.startswith('kernel-') or name in ('surface-initcheck3', 'self-contract246') or code != 1):
            raise RuntimeError(f'Validation stopped at {name}: {code}')
    state['complete'] = True
    save()


if __name__ == '__main__':
    main()
