"""Diagnostic capture of the processed original's launch sequence for affine-body scenes (no source code involved).

    LD_PRELOAD=build/reconstruction-csrc/bodies/cudahook.so CUDAHOOK_DIR=<dir> \
        .venv/bin/python -m reconstruction.csrc.body_capture --scene free_body --mode newton --steps 2

Runs the unchanged official style3d_sim Newton adapter on the project-internal reference binary (no login) and
records the Model's body-related fields after initialisation. cudahook.so writes launches.txt (every kernel name in
order) into CUDAHOOK_DIR. Used to recover the original host schedule before writing the C++ host; it is not part of
the delivered solver.
"""
import argparse
import json
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--scene', default='free_body', choices=('free_body', 'two_bodies', 'ground_box', 'ground_box_smooth'))
    parser.add_argument('--mode', default='newton', choices=('newton', 'pd'))
    parser.add_argument('--worlds', type=int, default=1)
    parser.add_argument('--steps', type=int, default=2)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    sys.path.insert(0, str(ROOT))
    import warp as wp
    wp.init()
    from reconstruction.csrc.host_api_probe import load_reference
    from reconstruction.csrc.host_bodies_ab import simulate
    core = load_reference()
    sys.modules['style3d_sim._core'] = core
    # Same scene and stepping as the bitwise A/B harness, so captured schedules apply to it directly.
    solver, records = simulate(args.scene, args.worlds, args.mode, args.steps)
    config = {name: str(getattr(solver.config, name)) for name in dir(solver.config) if not name.startswith('_')}
    args.output.mkdir(parents=True, exist_ok=True)
    np.savez(args.output/'states.npz', **records)
    inner = getattr(solver, '_native_solver', None)
    fields = {}
    model = getattr(solver, '_synreal_model', None)
    if model is not None:
        for name in dir(model):
            if name.endswith('_count'):
                fields[name] = getattr(model, name)
    # Pointer -> field map so captured kernel arguments can be named (Model spans and Newton contact arrays).
    pointers = {}
    if model is not None:
        for name in dir(model):
            value = getattr(model, name, None)
            if hasattr(value, 'ptr') and hasattr(value, 'size') and value.ptr:
                pointers[hex(value.ptr)] = f'model.{name}[{value.size}]'
    contacts = getattr(simulate, 'last_contacts', None)
    if contacts is not None:
        for name in dir(contacts):
            value = getattr(contacts, name, None)
            if getattr(value, 'ptr', None):
                pointers.setdefault(hex(value.ptr), f'contacts.{name}')
    (args.output/'pointers.json').write_text(json.dumps(pointers, indent=1) + '\n')
    (args.output/'model.json').write_text(json.dumps({'config': config, 'counts': fields}, indent=1) + '\n')
    print('capture_complete', args.scene, args.mode, flush=True)


if __name__ == '__main__':
    main()
