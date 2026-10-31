"""Pair identical contact features and isolate parameter sensitivity with fixed row order."""
import argparse
import copy
import json
from pathlib import Path

import numpy as np

from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.diagnostics.pd_onset_sensitivity import solve


def fields(c):
    return {'normal': c.soft_contact_normal.numpy(), 'point': c.soft_contact_body_pos.numpy(),
            'barycentric': c.surface['barycentric']}


def keys(c):
    return [(int(s), *map(int, ids)) for s, ids in zip(c.soft_contact_shape.numpy(), c.surface['indices'])]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--input', type=Path, required=True)
    p.add_argument('--contacts', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use an empty output directory')
    a = load(args.contacts/'baseline-contacts.npz')
    b = load(args.contacts/'perturbed-contacts.npz')
    ka, kb = keys(a), keys(b)
    if len(set(ka)) != len(ka) or len(set(kb)) != len(kb) or set(ka) != set(kb):
        raise RuntimeError('Feature keys must be unique and identical')
    perm = np.array([kb.index(k) for k in ka])
    fa, fb = fields(a), {k: v[perm] for k, v in fields(b).items()}
    report = {'scope': 'counterfactual response, not native-equivalence acceptance', 'count': len(ka),
              'topology_identical': True, 'pairs': [], 'variants': {}}
    for i, key in enumerate(ka):
        changed = {k: {'baseline': fa[k][i].tolist(), 'perturbed': fb[k][i].tolist(),
                       'max_abs': float(np.max(np.abs(fa[k][i].astype(float)-fb[k][i])))}
                   for k in fa if fa[k][i].tobytes() != fb[k][i].tobytes()}
        if changed:
            report['pairs'].append({'key': key, 'fields': changed})
    baseline = None
    for name, selected, single in (
            ('baseline', (), False), ('normal', ('normal',), False), ('barycentric', ('barycentric',), False),
            ('point', ('point',), False), ('all', tuple(fa), False),
            ('triangle_8_9_15', tuple(fa), True), ('triangle_8_9_15_normal', ('normal',), True)):
        r = load(args.input)
        c = copy.deepcopy(a)
        fc = fields(c)
        for field in selected:
            for i, key in enumerate(ka):
                if not single or key == (0, 8, 9, 15):
                    fc[field][i] = fb[field][i]
        r['contacts'] = c
        out = solve(r)
        if baseline is None:
            baseline = out
        np.savez_compressed(args.output/f'{name}.npz', **out)
        report['variants'][name] = {f: compare(out[f], baseline[f]) for f in ('q', 'qd')}
        print(json.dumps({'variant': name, **report['variants'][name]}), flush=True)
    # Ensure this experiment starts from exactly the previously measured source baseline.
    with np.load(args.contacts/'regenerated.npz') as old:
        report['baseline_reproduced'] = all(old[f].tobytes() == baseline[f].tobytes() for f in baseline)
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    if not report['baseline_reproduced']:
        raise SystemExit('Source baseline changed')


if __name__ == '__main__':
    main()
