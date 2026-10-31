"""Capture/replay legacy cloth-on-box calls after the wrapper's rigid predictor.

This is a diagnostic for this scene only, not a general history-state checkpoint.
NPZ stores numeric arrays and a JSON tree; no executable pickle data is loaded.
"""
import argparse
import enum
import json
from pathlib import Path
import resource
import sys
from types import SimpleNamespace

import numpy as np

from . import core
from .affine import AffineBodies
from .validate import ANALYSIS_SHA, LEGACY, TOLERANCES, make_example, prepare_inputs, sha


def save(path, value):
    arrays = {}

    def pack(obj):
        if isinstance(obj, AffineBodies):
            return {'affine': {k: pack(v) for k, v in vars(obj).items()}}
        if isinstance(obj, core._Host):
            return {'host': pack(obj.numpy())}
        if isinstance(obj, np.ndarray):
            key = f'a{len(arrays)}'
            arrays[key] = obj
            return {'array': key}
        if isinstance(obj, core._Namespace):
            return {'namespace': {k: pack(v) for k, v in vars(obj).items()}}
        if isinstance(obj, dict):
            return {'dict': {k: pack(v) for k, v in obj.items()}}
        if isinstance(obj, (tuple, list)):
            return [pack(v) for v in obj]
        if isinstance(obj, np.generic):
            return obj.item()
        return obj

    arrays['tree'] = np.array(json.dumps(pack(value)))
    np.savez_compressed(path, **arrays)


def load(path):
    with np.load(path, allow_pickle=False) as data:
        def unpack(obj):
            if isinstance(obj, list):
                return [unpack(v) for v in obj]
            if not isinstance(obj, dict):
                return obj
            if 'array' in obj:
                return data[obj['array']].copy()
            if 'host' in obj:
                return core._Host(unpack(obj['host']))
            if 'affine' in obj:
                result = AffineBodies.__new__(AffineBodies)
                result.__dict__.update({k: unpack(v) for k, v in obj['affine'].items()})
                return result
            if 'namespace' in obj:
                result = core._Namespace()
                result.__dict__.update({k: unpack(v) for k, v in obj['namespace'].items()})
                return result
            return {k: unpack(v) for k, v in obj['dict'].items()}
        return unpack(json.loads(str(data['tree'])))


def capture(args):
    import warp as wp
    if not args.steps or min(args.steps) < 0:
        raise ValueError('Capture steps must be nonnegative')
    if list(args.output.iterdir()):
        raise RuntimeError('Capture requires a new empty directory to avoid mixing runs')
    if sha(LEGACY) != ANALYSIS_SHA:
        raise RuntimeError('Legacy reference hash changed')
    demo = 'cloth_on_box_pd' if getattr(args, 'pd', False) else 'cloth_on_box'
    ex = make_example(SimpleNamespace(demo=demo, width=6, reference=LEGACY), 'native')
    original = ex.solver._native_solver
    model = ex.solver._synreal_model
    selected = set(args.steps)
    wrapper_input = None

    class Probe:
        index = 0

        def __getattr__(self, name):
            return getattr(original, name)

        def step(self, state_in, state_out, control, contact, dt, stream):
            record = None
            if self.index in selected:
                wp.synchronize_device('cuda:0')
                config = {}
                for name, default in core._CONFIG_DEFAULTS.items():
                    value = getattr(original.config, name)
                    config[name] = int(value) if isinstance(default, enum.IntEnum) else value
                # This scene has no joint drives, activations, or persistent contact multipliers.
                if model.joint_drive_count or model.tetrahedron_count or config['rigid_contact_history']:
                    raise RuntimeError('Unsupported history/control inputs')
                record = {'step': self.index, 'demo': demo, 'dt': dt, 'config': config, 'reference_sha256': ANALYSIS_SHA,
                          'model': core._newton_view(model), 'contacts': core._contacts_view(contact),
                          'wrapper_input': wrapper_input}
                for name in ('particle_q', 'particle_qd', 'particle_f'):
                    record[name] = core._read(getattr(state_in, name), np.float32, 3, model.particle_state_count)
            original.step(state_in, state_out, control, contact, dt, stream)
            if record is not None:
                wp.synchronize_device('cuda:0')
                for field in TOLERANCES:
                    record['out_'+field] = core._read(getattr(state_out, 'particle_'+field), np.float32, 3,
                                                    model.particle_state_count)
                save(args.output / f'step-{self.index:04d}.npz', record)
                print(f'captured {self.index}', flush=True)
            self.index += 1

    ex.solver._native_solver = Probe()
    for index in range(max(selected)+1):
        # Collision generation consumes body poses before the wrapper predicts affine particle states.
        wrapper_input = ({name: getattr(ex.state_0, name).numpy().copy()
                          for name in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
                         if index in selected else None)
        prepare_inputs(ex)
        ex.solver.step(ex.state_0, ex.state_1, ex.control, ex.contacts, ex.sim_dt)
        ex.state_0, ex.state_1 = ex.state_1, ex.state_0
    (args.output / 'capture-complete.json').write_text(json.dumps({'steps': sorted(selected), 'sha': ANALYSIS_SHA}))


def replay(args):
    from .solver import ReconstructedSolver
    manifest = json.loads((args.output / 'capture-complete.json').read_text())
    expected_steps = manifest['steps']
    if manifest['sha'] != ANALYSIS_SHA:
        raise RuntimeError('Wrong capture reference')
    report = {'scope': 'cloth_on_box width=6, post-wrapper native call, no persistent joint/contact history', 'steps': []}
    for index in expected_steps:
        path = args.output / f'step-{index:04d}.npz'
        record = load(path)
        if record['reference_sha256'] != ANALYSIS_SHA or record['step'] != index:
            raise RuntimeError('Wrong reference')
        adapter = core.Solver()
        adapter.config.__dict__.update(record['config'])
        adapter._model = SimpleNamespace(joint_body_spring_count=0, joint_body_point_line_count=0, body_count=1)
        adapter._impl = ReconstructedSolver(record['model'])
        impl = adapter._solver()
        sin, sout = core._Namespace(), core._Namespace()
        for name in ('particle_q', 'particle_qd', 'particle_f'):
            setattr(sin, name, core._Host(record[name].copy()))
        for field in TOLERANCES:
            setattr(sout, 'particle_'+field, core._Host(np.zeros_like(record['out_'+field])))
        impl.step(sin, sout, None, record['contacts'], record['dt'])
        # Retain actual outputs so repeated runs can be compared without relying on scalar summaries.
        np.savez_compressed(args.output / f'replayed-step-{index:04d}.npz',
                            **{field: getattr(sout, 'particle_'+field).numpy() for field in TOLERANCES})
        result = {'step': record['step'], 'input_sha256': sha(path),
                  'nonlinear_solver': record['config']['nonlinear_solver'],
                  'soft_contacts': int(record['contacts'].soft_contact_count.numpy()[0])}
        for field, (atol, rtol) in TOLERANCES.items():
            actual = getattr(sout, 'particle_'+field).numpy()
            expected = record['out_'+field]
            diff = np.abs(actual-expected)
            ratio = diff/(atol+rtol*np.abs(expected))
            result[field] = {'max_abs': float(diff.max()), 'max_tolerance_ratio': float(ratio.max()),
                             'worst_index': list(map(int, np.unravel_index(ratio.argmax(), ratio.shape))),
                             'bitwise_equal': bool(np.array_equal(actual.view(np.uint32), expected.view(np.uint32))),
                             'passed': bool(np.isfinite(actual).all() and np.all(ratio <= 1))}
        report['steps'].append(result)
        print(json.dumps(result), flush=True)
    if not report['steps']:
        raise RuntimeError('No captured calls')
    report['passed'] = all(r[f]['passed'] for r in report['steps'] for f in TOLERANCES)
    report['source_independent'] = ('style3d_sim._core' not in sys.modules
                                    and '_core.cpython' not in Path('/proc/self/maps').read_text())
    report['passed'] = report['passed'] and report['source_independent']
    report['source_sha256'] = {p.name: sha(p) for p in sorted(Path(__file__).parent.glob('*.py'))}
    (args.output / 'replay-report.json').write_text(json.dumps(report, indent=2)+'\n')
    if not report['passed']:
        raise SystemExit(1)


def main():
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['capture', 'replay'])
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--steps', type=int, nargs='+', default=[0, 40, 44, 45, 46, 50, 88, 89])
    parser.add_argument('--pd', action='store_true', help='Capture the cloth_on_box_pd fixture')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    (capture if args.mode == 'capture' else replay)(args)


if __name__ == '__main__':
    main()
