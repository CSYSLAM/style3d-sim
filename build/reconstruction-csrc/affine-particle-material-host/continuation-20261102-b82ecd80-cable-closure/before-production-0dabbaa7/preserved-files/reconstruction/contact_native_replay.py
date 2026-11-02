"""Replay a captured cloth-on-box call through the authenticated legacy solver.

Only the stateless contact configuration captured by contact_replay is supported.
Compare the reconstructed model view before calling native code; this check does
not claim to serialize every native ABI field or hidden solver state.
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
from .contact_replay import load, save
from .validate import ANALYSIS_SHA, LEGACY, TOLERANCES, make_example, sha


def differences(a, b, path=''):
    if isinstance(a, core._Host):
        a, b = a.numpy(), b.numpy()
    if isinstance(a, np.ndarray):
        equal = a.dtype == b.dtype and a.shape == b.shape and a.tobytes() == b.tobytes()
        return [] if equal else [path]
    if isinstance(a, dict):
        if set(a) != set(b):
            return [path+'.keys']
        return [p for k in a for p in differences(a[k], b[k], path+'.'+k)]
    if isinstance(a, (tuple, list)):
        if len(a) != len(b):
            return [path+'.length']
        return [p for i, (x, y) in enumerate(zip(a, b)) for p in differences(x, y, path+f'[{i}]')]
    if hasattr(a, '__dict__'):
        return differences(vars(a), vars(b), path)
    return [] if a == b else [path]


def main():
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--repeats', type=int, default=3)
    args = parser.parse_args()
    if args.repeats < 1:
        raise ValueError('At least one replay is required')
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use a new empty output directory')
    record = load(args.input)
    if sha(LEGACY) != ANALYSIS_SHA or record['reference_sha256'] != ANALYSIS_SHA:
        raise RuntimeError('Wrong reference')
    if record['config']['rigid_contact_history'] or record['config']['rigid_contact_hard']:
        raise RuntimeError('Contact history is not captured')
    import warp as wp
    demo = 'cloth_on_box_pd' if record['config']['nonlinear_solver'] == 1 else 'cloth_on_box'
    ex = make_example(SimpleNamespace(demo=demo, width=6, reference=LEGACY), 'native')
    native = sys.modules['style3d_sim._core']
    wp.synchronize_device('cuda:0')
    current = core._newton_view(ex.solver._synreal_model)
    model_diff = differences(record['model'], current, 'model')
    config = {}
    for name, default in core._CONFIG_DEFAULTS.items():
        value = getattr(ex.solver.config, name)
        config[name] = int(value) if isinstance(default, enum.IntEnum) else value
    config_diff = differences(record['config'], config, 'config')
    checks = {'model_differences': model_diff, 'config_differences': config_diff}
    (args.output/'input-checks.json').write_text(json.dumps(checks, indent=2)+'\n')
    if model_diff or config_diff:
        save(args.output/'fresh-model.npz', current)
        raise RuntimeError(f'Fresh native model/config differs: {model_diff + config_diff}')

    keepalive = []

    def span(values):
        values = np.asarray(values)
        dtype = wp.int32 if values.dtype == np.int32 else wp.float32
        array = wp.array(values.reshape(-1), dtype=dtype, device='cuda:0')
        keepalive.append(array)
        return native.Span(ptr=array.ptr, size=len(values))

    contact = native.Contact()
    c = record['contacts']
    contact.soft_max_count = int(c.soft_contact_count.numpy()[0])
    for target, source in (('soft_count', 'count'), ('soft_particle', 'particle'), ('soft_shape', 'shape'),
                           ('soft_body_pos', 'body_pos'), ('soft_body_vel', 'body_vel'), ('soft_normal', 'normal')):
        setattr(contact, target, span(getattr(c, 'soft_contact_'+source).numpy()))
    if c.surface is not None:
        for target, source in (('soft_indices', 'indices'), ('soft_barycentric', 'barycentric'),
                               ('soft_particle_only_shapes', 'particle_only')):
            if c.surface[source] is not None:
                setattr(contact, target, span(c.surface[source]))
    contact.count = span(c.rigid_contact_count.numpy())
    contact.max_count = int(c.rigid_contact_count.numpy()[0])
    if c.rigid is not None:
        for name, value in c.rigid.items():
            if name != 'count' and value is not None:
                setattr(contact, name, span(value))
    wp.synchronize_device('cuda:0')
    contact_diff = differences(c, core._contacts_view(contact), 'contacts')
    checks['contact_differences'] = contact_diff
    (args.output/'input-checks.json').write_text(json.dumps(checks, indent=2)+'\n')
    if contact_diff:
        raise RuntimeError(f'Contact round trip differs: {contact_diff}')
    report = {'input_sha256': sha(args.input), 'reference_sha256': ANALYSIS_SHA, 'repeats': [],
              'scope': 'same initialized solver, inputs restored per call; no hidden state checkpoint'}
    for repeat in range(args.repeats):
        sin, sout = native.State(), native.State()
        for name in ('particle_q', 'particle_qd', 'particle_f'):
            setattr(sin, name, span(record[name]))
            setattr(sout, name, span(np.zeros_like(record[name])))
        wp.synchronize_device('cuda:0')
        for name in ('particle_q', 'particle_qd', 'particle_f'):
            restored = core._read(getattr(sin, name), np.float32, 3, len(record[name]))
            if restored.tobytes() != record[name].tobytes():
                raise RuntimeError(f'State round trip differs: {name}')
        ex.solver._native_solver.step(sin, sout, native.Control(), contact, record['dt'], wp.get_stream('cuda:0'))
        wp.synchronize_device('cuda:0')
        result, arrays = {'repeat': repeat}, {}
        for field, (atol, rtol) in TOLERANCES.items():
            actual = core._read(getattr(sout, 'particle_'+field), np.float32, 3, len(record['out_'+field]))
            expected = record['out_'+field]
            diff = np.abs(actual-expected)
            arrays[field] = actual
            result[field] = {'max_abs': float(diff.max()),
                             'max_tolerance_ratio': float((diff/(atol+rtol*np.abs(expected))).max()),
                             'bitwise_equal': actual.tobytes() == expected.tobytes()}
        np.savez_compressed(args.output/f'native-{repeat}.npz', **arrays)
        report['repeats'].append(result)
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(json.dumps(result), flush=True)
    (args.output/'complete.json').write_text(json.dumps({'repeats': args.repeats})+'\n')


if __name__ == '__main__':
    main()
