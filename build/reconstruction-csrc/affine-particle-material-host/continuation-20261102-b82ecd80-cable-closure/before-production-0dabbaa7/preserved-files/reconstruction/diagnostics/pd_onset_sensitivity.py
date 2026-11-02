"""Measure response to previous-step cloth rounding with contacts and body proxies held fixed.

Perturbed outputs are counterfactuals, not equivalence tests against the unperturbed native output.
"""
import argparse
import json
from pathlib import Path
from types import SimpleNamespace

import numpy as np

from reconstruction import core
from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.solver import ReconstructedSolver
from reconstruction.validate import sha


def solve(record):
    """Evaluate a fresh source solver; caller must provide an independent model/contact snapshot."""
    adapter = core.Solver()
    adapter.config.__dict__.update(record['config'])
    adapter._model = SimpleNamespace(joint_body_spring_count=0, joint_body_point_line_count=0, body_count=1)
    adapter._impl = ReconstructedSolver(record['model'])
    impl = adapter._solver()
    sin, sout = core._Namespace(), core._Namespace()
    for field in ('q', 'qd', 'f'):
        setattr(sin, 'particle_'+field, core._Host(record['particle_'+field].copy()))
    for field in ('q', 'qd'):
        setattr(sout, 'particle_'+field, core._Host(np.zeros_like(record['out_'+field])))
    impl.step(sin, sout, None, record['contacts'], record['dt'])
    return {f: getattr(sout, 'particle_'+f).numpy().copy() for f in ('q', 'qd')}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use an empty output directory')
    prior = load(args.capture/'step-0035.npz')
    current = load(args.capture/'step-0036.npz')
    cloth = current['model'].affine_bodies.kind == 0
    with np.load(args.capture/'replayed-step-0035.npz') as data:
        source_previous = {f: data[f].copy() for f in ('q', 'qd')}
    for f in ('q', 'qd'):
        if current['particle_'+f][cloth].tobytes() != prior['out_'+f][cloth].tobytes():
            raise RuntimeError('Captured cloth states are not consecutive')
    report = {'scope': 'sensitivity, not native equivalence; contacts and body proxies fixed',
              'input_sha256': {p.name: sha(p) for p in (args.capture/'step-0035.npz', args.capture/'step-0036.npz',
                                                      args.capture/'replayed-step-0035.npz')},
              'input_differences': {f: compare(source_previous[f][cloth], prior['out_'+f][cloth]) for f in ('q', 'qd')},
              'variants': {}}
    outputs = {}
    for name, changed in [('baseline', ()), ('position_only', ('q',)), ('velocity_only', ('qd',)), ('both', ('q', 'qd'))]:
        record = load(args.capture/'step-0036.npz')
        for field in changed:
            record['particle_'+field][cloth] = source_previous[field][cloth]
        outputs[name] = solve(record)
        np.savez_compressed(args.output/f'{name}.npz', **outputs[name])
        report['variants'][name] = {f: compare(outputs[name][f], outputs['baseline'][f]) for f in ('q', 'qd')}
        print(json.dumps({'variant': name, **report['variants'][name]}), flush=True)
    with np.load(args.capture/'replayed-step-0036.npz') as saved:
        report['baseline_reproduced'] = all(saved[f].tobytes() == outputs['baseline'][f].tobytes() for f in ('q', 'qd'))
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    if not report['baseline_reproduced']:
        raise SystemExit('Baseline reconstruction changed; sensitivity is not interpretable')


if __name__ == '__main__':
    main()
