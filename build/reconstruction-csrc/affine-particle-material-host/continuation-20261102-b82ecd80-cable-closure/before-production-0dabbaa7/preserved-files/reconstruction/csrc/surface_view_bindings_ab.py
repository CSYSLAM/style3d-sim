"""Capture actual native State/Contact span bindings without changing math or adding GPU operations."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

from .affine_tetrahedron_contact_ab import clean_env
from .demo_source_ab import ROOT


def worker(args):
    from . import demo_source_ab, host_api_probe, host_particles_ab
    owner = host_api_probe if args.worker == 'original' else host_particles_ab
    factory_name = 'load_reference' if args.worker == 'original' else 'native_source'
    factory = getattr(owner, factory_name)
    fixture = ROOT / 'reconstruction/csrc/affine_tetrahedron_contact_scene.py'
    marker = ctypes.CDLL(None).solver_memory_trace_mark
    marker.argtypes = [ctypes.c_char_p]
    records = []

    def selected():
        core = factory()
        native_step = core.Solver.step

        def step(solver, *values, **keywords):
            assert len(values) == 6 and not keywords
            spans = {}
            for label, instance in zip(('state_in', 'state_out', 'control', 'contact'), values[:4]):
                spans[label] = {}
                for name in dir(instance):
                    value = getattr(instance, name)
                    if isinstance(value, core.Span):
                        spans[label][name] = {'ptr': value.ptr, 'size': value.size}
            index = len(records)
            row = {'step': index, 'spans': spans}
            records.append(row)
            with (args.output / 'step-bindings.jsonl').open('a') as stream:
                stream.write(json.dumps(row) + '\n')
            # Host-only markers associate each kernel with these actual native arguments.
            marker(f'surface_binding_step_{index:03d}'.encode())
            return native_step(solver, *values)

        core.Solver.step = step
        return core

    setattr(owner, factory_name, selected)
    (args.output / 'binding-runtime.json').write_text(json.dumps({
        'classification': 'diagnostic binding capture; does not replace fixed first source',
        'added_gpu_operations': False, 'sha256': {
            str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), fixture)}}, indent=2) + '\n')
    demo_source_ab.worker(argparse.Namespace(worker=args.worker, output=args.output, tag='capture',
        example=str(fixture), frames=3, extra=['--worlds', '3', '--mode', 'newton', '--body-block']))
    assert len(records) == 3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    args.output = args.output.resolve()
    if args.worker:
        return worker(args)
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    observer = ROOT / 'build/reconstruction-csrc/self-host/memory-observer/memory_trace_full.so'
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    paths = (Path(__file__), observer, hook, ROOT / 'reconstruction/csrc/surface_view_pointer_audit.py',
             ROOT / 'reconstruction/csrc/demo_source_ab.py', ROOT / 'reconstruction/csrc/affine_tetrahedron_contact_scene.py')
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    (args.output / 'provenance.json').write_text(json.dumps(hashes, indent=2) + '\n')
    group = args.output / 'full-memory'
    group.mkdir()
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
        folder = group / backend
        folder.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.surface_view_bindings_ab', '--worker', backend,
                   '--output', str(folder)]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env={**clean_env(), 'LD_PRELOAD': str(observer) + ':' + str(hook),
                'CUDAHOOK_DIR': str(folder), 'DEMO_MEMORY_TRACE_DIR': str(folder), 'DEMO_POINTERS': '1'},
                stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    command = [sys.executable, '-m', 'reconstruction.csrc.surface_view_pointer_audit', '--step-bindings',
               '--capture', str(group), '--build', str(args.output / 'build.json'),
               '--output', str(args.output / 'audit.json')]
    (args.output / 'audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
    subprocess.run(command, cwd=ROOT, check=True)
    report = json.loads((args.output / 'audit.json').read_text())
    assert report['all_captured_view_records_equal'] and report['external_semantic_identity_proved']
    with np.load(group / 'original/capture.npz') as a, np.load(group / 'source/capture.npz') as b:
        states_equal = set(a.files) == set(b.files) and all(a[k].shape == b[k].shape and
            a[k].dtype == b[k].dtype and a[k].tobytes() == b[k].tobytes() for k in a.files)
    (args.output / 'diagnostic-states.json').write_text(json.dumps({
        'states_equal': states_equal, 'fixed_first_candidates_replaced': False, 'whole_solver_complete': False},
        indent=2) + '\n')
    print('binding diagnostic states equal', states_equal, flush=True)


if __name__ == '__main__':
    main()
