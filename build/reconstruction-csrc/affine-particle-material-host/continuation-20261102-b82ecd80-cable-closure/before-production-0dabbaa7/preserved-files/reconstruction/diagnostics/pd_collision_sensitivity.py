"""Isolate collision regeneration from state rounding at the first PD contact transition."""
import argparse
import copy
import json
from pathlib import Path
from types import SimpleNamespace

import numpy as np

from reconstruction import core
from reconstruction.contact_replay import load, save
from reconstruction.contact_native_replay import differences
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.diagnostics.pd_onset_sensitivity import solve
from reconstruction.validate import LEGACY, make_example, prepare_inputs, sha


def contact_summary(a, b):
    def rows(c):
        data = {name: value.numpy() for name, value in vars(c).items()
                if isinstance(value, core._Host) and name not in ('soft_contact_count', 'rigid_contact_count')}
        if c.surface is not None:
            data.update({k: c.surface[k] for k in ('indices', 'barycentric')})
        return data
    aa, bb = rows(a), rows(b)
    result = {'differences': differences(a, b), 'fields': {}}
    for name in aa:
        if aa[name].shape != bb[name].shape:
            result['fields'][name] = {'shape_changed': True}
            continue
        x, y = aa[name], bb[name]
        neq = x != y
        row_changes = neq if neq.ndim == 1 else np.any(neq, axis=tuple(range(1, neq.ndim)))
        result['fields'][name] = {'changed_rows': int(np.count_nonzero(row_changes)),
                                  'max_abs': float(np.abs(x.astype(np.float64)-y.astype(np.float64)).max(initial=0))}
    count_a, count_b = int(a.soft_contact_count.numpy()[0]), int(b.soft_contact_count.numpy()[0])
    result['counts'] = [count_a, count_b]
    def canonical(data, count):
        return sorted(b''.join(data[k][i].tobytes() for k in sorted(data)) for i in range(count))
    result['soft_rows_equal_ignoring_order'] = canonical(aa, count_a) == canonical(bb, count_b)
    return result


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
    wrapper = current['wrapper_input']
    with np.load(args.capture/'replayed-step-0035.npz') as data:
        source35 = {f: data[f].copy() for f in ('q', 'qd')}
    for f in ('q', 'qd'):
        if wrapper['particle_'+f][cloth].tobytes() != prior['out_'+f][cloth].tobytes():
            raise RuntimeError('Wrapper input is not consecutive with captured native step35')
    ex = make_example(SimpleNamespace(demo='cloth_on_box_pd', width=6, reference=LEGACY), 'shim')
    contacts = {}
    for changed in (False, True):
        for name, values in wrapper.items():
            restored = values.copy()
            if changed and name in ('particle_q', 'particle_qd'):
                restored[cloth] = source35[name.removeprefix('particle_')][cloth]
            getattr(ex.state_0, name).assign(restored)
        prepare_inputs(ex)
        c = core._contacts_view(ex.solver._as_synreal_contact(ex.contacts))
        contacts['perturbed' if changed else 'baseline'] = c
        save(args.output/('perturbed-contacts.npz' if changed else 'baseline-contacts.npz'), c)
    report = {'scope': 'counterfactual collision sensitivity, not native-equivalence acceptance',
              'input_sha256': {p.name: sha(p) for p in (args.capture/'step-0035.npz', args.capture/'step-0036.npz')},
              'baseline_contact_regeneration': contact_summary(current['contacts'], contacts['baseline']),
              'perturbed_contact_regeneration': contact_summary(contacts['baseline'], contacts['perturbed']), 'variants': {}}
    outputs = {}
    for name, state_change, contact_mode in (
            ('original', False, None), ('regenerated', False, 'baseline'),
            ('state_only', True, None), ('contacts_only', False, 'perturbed'), ('state_and_contacts', True, 'perturbed')):
        r = load(args.capture/'step-0036.npz')
        if state_change:
            for f in ('q', 'qd'):
                r['particle_'+f][cloth] = source35[f][cloth]
        if contact_mode is not None:
            r['contacts'] = copy.deepcopy(contacts[contact_mode])
        outputs[name] = solve(r)
        np.savez_compressed(args.output/f'{name}.npz', **outputs[name])
        report['variants'][name] = {f: compare(outputs[name][f], outputs['original'][f]) for f in ('q', 'qd')}
        print(json.dumps({'variant': name, **report['variants'][name]}), flush=True)
    with np.load(args.capture/'replayed-step-0036.npz') as previous:
        report['baseline_reproduced'] = all(previous[f].tobytes() == outputs['original'][f].tobytes() for f in ('q', 'qd'))
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    if not report['baseline_reproduced']:
        raise SystemExit('Source baseline changed')


if __name__ == '__main__':
    main()
