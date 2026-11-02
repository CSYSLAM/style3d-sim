"""Capture all five nonlinear CG solves and their apply operations in one actual G1 substep."""
import hashlib
import json
from pathlib import Path
from pprint import pformat
import sys

from . import g1_nl2_full_cg as full


linear = full.linear
BASE_TRANSPORT, BASE_REPLAY = full.rendered_transport, full.rendered_replay
TOKENS = {}
for nonlinear in range(5):
    TOKENS.update({f'nl{nonlinear}-{key}': value for key, value in full.TOKENS.items()})
    TOKENS[f'nl{nonlinear}-apply'] = '20apply_nonlinear_stepE'

SELECTION = '''def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 17467 and body_count == 44 and dof_count == 49
    applies = [9328, 9905, 10483, 11060, 11638]
    starts = [8747] + [rank + 1 for rank in applies[:-1]]
    rhs_ranks, inverse_ranks = [8755, 9332, 9910, 10487, 11065], [8773, 9350, 9928, 10505, 11083]
    result = []
    for key, token in STAGES.items():
        prefix, local = key.split('-', 1)
        nonlinear = int(prefix[2:])
        matches = [i for i in range(starts[nonlinear], applies[nonlinear] + 1)
                   if token in nodes[i].get('name', '')]
        assert len(matches) == (1 if local in ('rhs', 'inverse', 'apply') else 50)
        iteration = int(local.rsplit('_', 1)[1]) if '_' in local else 0
        rank, kind = matches[iteration], local.split('_', 1)[0]
        node = nodes[rank]
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        if kind == 'rhs':
            assert rank == rhs_ranks[nonlinear] and node['parameter_widths'] == [4] + [8] * 11
            assert [integer(node, i) for i in (6, 10, 11)] == [19, 176, 176]
            sizes = {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112}
            outputs = [9]
        elif kind == 'inverse':
            assert rank == inverse_ranks[nonlinear] and node['parameter_widths'] == [8] * 6
            assert integer(node, 4) == integer(node, 5) == 176 and integer(node, 0) == integer(node, 3)
            sizes, outputs = {0: 6336, 1: 704, 2: 704, 3: 6336}, [3]
        elif kind == 'precondition':
            assert rank == inverse_ranks[nonlinear] + 5 + 11 * iteration
            assert node['parameter_widths'] == [8, 8, 8, 1, 8, 4, 8, 8]
            assert integer(node, 3) == integer(node, 4) == 0 and integer(node, 5) == integer(node, 7) == 176
            sizes, outputs = {0: 6336, 1: 2112, 2: 2112, 6: 4}, [2, 6]
        elif kind == 'direction':
            assert node['parameter_widths'] == [4, 8, 8, 4, 8, 8, 8, 8]
            assert integer(node, 0) == iteration
            assert integer(node, 2) == 0 and integer(node, 3) == integer(node, 7) == 176
            assert bool(integer(node, 5)) == (iteration > 0)
            sizes, outputs = {1: 2112, 4: 4, 6: 2112}, [6]
            if integer(node, 5):
                sizes[5] = 4
        elif kind == 'matrix':
            assert node['parameter_widths'] == [8] * 8 + [4] + [8] * 3
            assert integer(node, 2) == 19 and integer(node, 7) == 0
            assert [integer(node, i) for i in (8, 10, 11)] == [176, 176, 176]
            sizes, outputs = {0: 704, 1: 133760, 3: 6336, 4: 2112, 5: 2112, 6: 2112, 9: 4}, [6, 9]
        elif kind == 'apply':
            assert rank == applies[nonlinear] and node['parameter_widths'] == [8] * 4
            assert integer(node, 3) == 176
            sizes, outputs = {0: 2112, 1: 2112, 2: 2112}, [1, 2]
        else:
            assert kind == 'update' and node['parameter_widths'] == [8, 4, 8, 8, 8, 8, 8, 8, 8]
            assert integer(node, 0) == 0 and integer(node, 1) == integer(node, 8) == 176
            sizes, outputs = {2: 4, 3: 4, 4: 2112, 5: 2112, 6: 2112, 7: 2112}, [6, 7]
        pointers = {i for i, t in enumerate(parameter_types(node['name'])) if '*' in t and integer(node, i)}
        assert set(sizes) == pointers
        overlaps = []
        for a in outputs:
            for b in sizes:
                if a == b:
                    continue
                start, end = max(integer(node, a), integer(node, b)), min(
                    integer(node, a) + sizes[a], integer(node, b) + sizes[b])
                if start < end:
                    assert kind == 'inverse' and {a, b} == {0, 3} and end - start == 6336
                    overlaps.append({'arguments': [a, b], 'overlap_bytes': end - start})
        result.append({'key': key, 'kernel_key': kind, 'rank': rank, 'node': node, 'nonlinear': nonlinear,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': overlaps})
    assert len(result) == 1015 and [s['rank'] for s in result] == sorted(s['rank'] for s in result)
    return result
'''


def rendered_transport():
    text = BASE_TRANSPORT()
    text = full.replace_once(text, 'STAGES = ' + pformat(full.TOKENS, width=112, sort_dicts=False),
                             'STAGES = ' + pformat(TOKENS, width=112, sort_dicts=False))
    left, right = text.index('def select_stages('), text.index('\n\nclass Observer(')
    return text[:left] + SELECTION.rstrip() + text[right:]


def rendered_replay():
    text = BASE_REPLAY()
    for old, new in {
        "assert len(layout['stages']) == 202": "assert len(layout['stages']) == 1015",
        'if len(rows) % 202 == 0:': 'if len(rows) % 1015 == 0:',
        "'all202 actual NL2 linear calls'": "'all1015 actual fourth-substep linear and apply calls'",
        'assert len(rows) == 404': 'assert len(rows) == 2030',
        "report['actual_calls'] == 1212": "report['actual_calls'] == 6090",
        "counts['packets'] == 404 and counts['complete_output_arrays'] == 2112":
            "counts['packets'] == 2030 and counts['complete_output_arrays'] == 10620",
    }.items():
        text = full.replace_once(text, old, new)
    return text


def main():
    output = Path(sys.argv[sys.argv.index('--output') + 1]).resolve() if '--output' in sys.argv else None
    full.rendered_transport, full.rendered_replay = rendered_transport, rendered_replay
    try:
        full.main()
    finally:
        path = output / 'trace-provenance.json' if output else None
        if path and path.exists():
            data = json.loads(path.read_text())
            data['fourth_full_cg_wrapper_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
            path.write_text(json.dumps(data, indent=2) + '\n')


if __name__ == '__main__':
    main()
