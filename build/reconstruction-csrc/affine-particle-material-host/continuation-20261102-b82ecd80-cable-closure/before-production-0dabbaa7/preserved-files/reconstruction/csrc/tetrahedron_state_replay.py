"""Diagnostic: replay a frozen third-step public state on the actual SDK/source, preserving full worker order."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path

import numpy as np

from . import affine_tetrahedron_graph_ab as worker
from . import host_api_probe, host_particles_ab
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    frozen_bytes = args.candidate.read_bytes()
    with np.load(args.candidate) as data:
        frozen = {name: data[name][:3].copy() for name in data.files}
    assert set(frozen) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
    target, current, target_calls = 'w3-pd-b1', None, 0
    cases, checks, arrays = worker.cases, {}, {}
    observer = ctypes.CDLL(None)
    observer.solver_trace_begin.argtypes = [ctypes.c_char_p]

    def ordered_cases():
        nonlocal current
        for name, worlds, extra in cases():
            current = name
            yield name, worlds, extra

    worker.cases = ordered_cases
    owner = host_api_probe if args.backend == 'original' else host_particles_ab
    factory_name = 'load_reference' if args.backend == 'original' else 'native_source'
    factory = getattr(owner, factory_name)

    def install():
        core = factory()
        if args.backend == 'source':
            from .host_bodies_ab import bridge
            bridge(core)
        import style3d_sim as s3d
        original_step = s3d.NewtonSolver.step

        def step(solver, *values, **keywords):
            nonlocal target_calls
            active = current == target and target_calls == 2
            if active:
                state_in = values[0]
                before, copied = {}, {}
                for name, data in frozen.items():
                    array = getattr(state_in, name)
                    before[name] = array.numpy().copy()
                    assert before[name].shape == data[1].shape and before[name].dtype == data.dtype
                    array.assign(data[1])
                    copied[name] = array.numpy().copy()
                    assert copied[name].tobytes() == data[1].tobytes()
                arrays.update({'pre_injection_' + name: value for name, value in before.items()})
                arrays.update({'injected_' + name: value for name, value in copied.items()})
                checks['incoming_state_matched_frozen'] = {name: value.tobytes() == frozen[name][1].tobytes()
                                                         for name, value in before.items()}
                observer.solver_trace_begin(str(args.output / 'native').encode())
            result = original_step(solver, *values, **keywords)
            if active:
                observer.solver_trace_end()
                state_out = values[1]
                outputs = {name: getattr(state_out, name).numpy().copy() for name in frozen}
                arrays.update({'actual_output_' + name: value for name, value in outputs.items()})
                checks['third_step_equals_frozen_source0'] = {
                    name: value.tobytes() == frozen[name][2].tobytes() for name, value in outputs.items()}
                checks['third_step_max_abs_to_frozen'] = {
                    name: float(abs(value.astype('f8') - frozen[name][2].astype('f8')).max())
                    for name, value in outputs.items()}
            if current == target:
                target_calls += 1
            return result

        s3d.NewtonSolver.step = step
        return core

    setattr(owner, factory_name, install)
    saved = (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
    worker.worker(argparse.Namespace(worker=args.backend, frames=60, output=args.output,
        fixture=ROOT / 'reconstruction/csrc/affine_tetrahedron_self_scene.py',
        particles_per_world=24, diagonal_only=False))
    assert checks and args.candidate.read_bytes() == frozen_bytes
    assert (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    report = {'backend': args.backend, 'checks': checks, 'public_state_intentionally_overridden': True,
              'private_persistent_state_restored_from_frozen_candidate': False, 'frozen_candidate_replaced': False,
              'cohort_expanded': False, 'whole_solver_complete': False, 'target_step': 2,
              'candidate_sha256': hashlib.sha256(frozen_bytes).hexdigest(),
              'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    np.savez_compressed(args.output / 'state-replay.npz', **arrays)
    (args.output / 'probe.json').write_text(json.dumps(report, indent=2) + '\n')
    print(args.backend, checks, flush=True)


if __name__ == '__main__':
    main()
