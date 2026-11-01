"""Audit actual allocation, payload, initializer and pointer use for contacting SO3/tetrahedra."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from .affine_tetrahedron_contact_ab import clean_env, fixture_path
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--contact-kind', choices=('surface', 'legacy'), default='surface')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    (args.output / 'build.json').write_bytes(saved)
    layout = args.output / 'kernel-layout.tsv'
    layout.write_text(''.join(name + '\t' + ','.join(map(str, spec['parameters'])) + '\n'
                              for name, spec in sorted(metadata['kernels'].items())))
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    fixture = fixture_path(args.contact_kind)
    observers = {
        'full-memory': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/memory_trace_full.so',
        'payload': ROOT / 'build/reconstruction-csrc/self-host/payload-observer-v2/payload_trace.so',
        'initializers': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/cupti_param_trace.so',
    }
    for name, observer in observers.items():
        group = args.output / ('body-tet-contact-w3-' + name)
        group.mkdir()
        paths = (Path(__file__), hook, fixture, observer, layout)
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
        (group / 'provenance.json').write_text(json.dumps({'sha256': hashes, 'whole_solver_complete': False},
                                                                      indent=2) + '\n')
        for backend in ('original', 'source'):
            assert build.read_bytes() == saved
            assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
            folder = group / backend
            (folder / 'uploads').mkdir(parents=True)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                       '--tag', 'capture', '--example', str(fixture), '--frames', '3', '--output', str(folder),
                       '--', '--worlds', '3', '--mode', 'newton', '--body-block']
            (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
            extra = {'CUPTI_KERNEL_LAYOUT_FILE': str(layout)} if name == 'initializers' else {}
            with (folder / 'run.log').open('w') as log:
                subprocess.run(command, cwd=ROOT, timeout=900, check=True, stdout=log, stderr=subprocess.STDOUT,
                               env={**clean_env(), 'LD_PRELOAD': str(observer) + ':' + str(hook),
                                    'CUDAHOOK_DIR': str(folder), 'DEMO_MEMORY_TRACE_DIR': str(folder),
                                    'DEMO_POINTERS': '1', **extra})
            print(name, backend, 'complete', flush=True)
    command = [sys.executable, '-m', 'reconstruction.csrc.affine_constructor_audit', '--prefix', 'body-tet-contact-w3',
               '--capture', str(args.output), '--output', str(args.output / 'audit.json')]
    (args.output / 'audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
    subprocess.run(command, cwd=ROOT, check=True)


if __name__ == '__main__':
    main()
