"""Joint E verdict over two independent closure rounds (closure/ and closure_rep2/), 5+5 each -> 10+10.

    .venv/bin/python -m reconstruction.csrc.closure_pool example_fluid

All 10 originals form one shared reference, with the same statistic as demo_closure: original i is scored against the
other 9 (its error vs their mean, their own leave-one-out envelope), each source against all 10. Concatenating per-round
statistics instead lets a round whose 5 originals all fall on one discrete atomic-order branch collapse that round's
envelope (fluid round 1: all 5 originals took the quiet branch at substeps 16-18). Fail only if p < 0.05, as before.
Arrays are processed in substep chunks: fluid particle histories are ~1 GB per run in float64.
"""
import json
import sys
from pathlib import Path

import numpy as np

from reconstruction.csrc.demo_closure import p_worse

ROOT = Path(__file__).resolve().parents[2]
ROUNDS = ('closure', 'closure_rep2')


def scores(originals, sources, chunk=50):
    n, steps = len(originals), min(len(x) for x in originals + sources)
    envelope = np.zeros((n, steps))            # leave-one-out spread of each original among all 10
    error = np.zeros((len(sources), steps))    # each source vs the mean of all 10
    control_error, control_envelope = np.zeros((n, steps)), np.zeros((n, n - 1, steps))
    for a in range(0, steps, chunk):
        b = min(steps, a + chunk)
        o = np.stack([x[a:b] for x in originals]).astype(np.float64)
        s = np.stack([x[a:b] for x in sources]).astype(np.float64)
        total, axes = o.sum(0), tuple(range(1, o.ndim - 1))
        for i in range(n):
            envelope[i, a:b] = np.abs(o[i] - (total - o[i]) / (n - 1)).max(axis=axes)
            rest = total - o[i]
            control_error[i, a:b] = np.abs(o[i] - rest / (n - 1)).max(axis=axes)
            for m, k in enumerate(k for k in range(n) if k != i):
                control_envelope[i, m, a:b] = np.abs(o[k] - (rest - o[k]) / (n - 2)).max(axis=axes)
        for j in range(len(sources)):
            error[j, a:b] = np.abs(s[j] - total / n).max(axis=axes)

    def stat(e, env):
        with np.errstate(divide='ignore', invalid='ignore'):
            ratio = np.where(env > 0, e / env, np.where(e > 0, np.inf, 0.0))
        return int((e <= env).sum()), round(float(ratio.max()), 4)
    control = [stat(control_error[i], control_envelope[i].max(0)) for i in range(n)]
    candidate = [stat(error[j], envelope.max(0)) for j in range(len(sources))]
    return control, candidate, steps


def main(name):
    base = ROOT/'build/reconstruction-demos-source'/name
    rounds = [json.loads((base/d/'closure.json').read_text()) for d in ROUNDS]
    abcd = all(r['A_launch_sequence']['identical'] and r['B_uploads']['identical'] and r['C_arguments']['identical']
               and all(x['pass'] for x in r['D_bitwise_prefix'].values()) for r in rounds)
    joint = {}
    for key in rounds[0]['E_distribution']:
        originals = [np.load(base/d/f'original{i}.npz')[key] for d in ROUNDS for i in range(5)]
        sources = [np.load(base/d/f'source{i}.npz')[key] for d in ROUNDS for i in range(5)]
        control, candidate, steps = scores(originals, sources)
        e = {'original_within': [c[0] for c in control], 'source_within': [c[0] for c in candidate],
             'original_ratio_max': [c[1] for c in control], 'source_ratio_max': [c[1] for c in candidate],
             'substeps': steps}
        e['p_within_worse'] = p_worse(e['original_within'], e['source_within'], False)
        e['p_ratio_worse'] = p_worse(e['original_ratio_max'], e['source_ratio_max'], True)
        e['pass'] = min(e['p_within_worse'], e['p_ratio_worse']) >= 0.05
        e['rounds'] = [{k: r['E_distribution'][key][k] for k in ('p_within_worse', 'p_ratio_worse')} for r in rounds]
        joint[key] = e
    report = {'example': name, 'abcd_both_rounds': abcd, 'joint_E': joint,
              'closed': abcd and all(x['pass'] for x in joint.values())}
    (base/'closure_joint.json').write_text(json.dumps(report, indent=1)+'\n')
    print(json.dumps({'example': name, 'closed': report['closed'], 'abcd_both_rounds': abcd,
                      'E': {k: [round(v['p_within_worse'], 3), round(v['p_ratio_worse'], 3)] for k, v in joint.items()}}))


if __name__ == '__main__':
    main(sys.argv[1])
