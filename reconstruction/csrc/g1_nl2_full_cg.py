"""Capture and replay every NL2 CG vector call from the existing controlled G1 checkpoint."""
import argparse
import hashlib
import json
from pathlib import Path
from pprint import pformat
import sys

from . import g1_nl2_linear as linear


LINEAR_SHA = '48ac231987a4175082acd8bbd46124f383822250f465ca229d0e8dfd476f0f7d'
TOKENS = {key: linear.TOKENS[key] for key in ('rhs', 'inverse')}
for iteration in range(50):
    TOKENS.update({f'{kind}_{iteration:02d}': linear.TOKENS[kind + '_first']
                   for kind in ('precondition', 'direction', 'matrix', 'update')})


def replace_once(text, old, new):
    assert text.count(old) == 1, (old, text.count(old))
    return text.replace(old, new)


def rendered_transport():
    assert hashlib.sha256(Path(linear.__file__).read_bytes()).hexdigest() == LINEAR_SHA
    text = linear.rendered_transport()
    text = replace_once(text, 'STAGES = ' + pformat(linear.TOKENS, width=112, sort_dicts=False),
                        'STAGES = ' + pformat(TOKENS, width=112, sort_dicts=False))
    selection = linear.SELECTION
    selection = replace_once(selection, "        rank = matches[-1] if key.endswith('_last') else matches[0]",
                             "        iteration = int(key.rsplit('_', 1)[1]) if '_' in key else 0\n"
                             "        rank = matches[iteration]")
    selection = replace_once(selection, "(49 if key.endswith('_last') else 0)", 'iteration')
    selection = replace_once(selection, "bool(integer(node, 5)) == key.endswith('_last')",
                             'bool(integer(node, 5)) == (iteration > 0)')
    selection = replace_once(selection, "'kernel_key': key", "'kernel_key': kind")
    selection = replace_once(selection,
                             "    assert [s['rank'] for s in result] == "
                             "[9332, 9350, 9355, 9356, 9364, 9365, 9894, 9895, 9903, 9904]",
                             "    expected = [9332, 9350] + [9355 + 11 * i + j for i in range(50) "
                             "for j in (0, 1, 9, 10)]\n"
                             "    assert [s['rank'] for s in result] == expected")
    return replace_once(text, linear.SELECTION.rstrip(), selection.rstrip())


def rendered_replay():
    assert hashlib.sha256(Path(linear.__file__).read_bytes()).hexdigest() == LINEAR_SHA
    text = linear.rendered_replay()
    for old, new in {
        "assert len(layout['stages']) == 10": "assert len(layout['stages']) == 202",
        'if len(rows) % 10 == 0:': 'if len(rows) % 202 == 0:',
        "'all10 actual NL2 linear calls'": "'all202 actual NL2 linear calls'",
        'assert len(rows) == 20': 'assert len(rows) == 404',
        "report['actual_calls'] == 60": "report['actual_calls'] == 1212",
        "counts['packets'] == 20 and counts['complete_output_arrays'] == 96":
            "counts['packets'] == 404 and counts['complete_output_arrays'] == 2112",
        "                    function = functions[stage['kernel_key']][backend]":
            "                    driver.check(driver.cu.cuCtxSynchronize())\n"
            "                    function = functions[stage['kernel_key']][backend]",
    }.items():
        text = replace_once(text, old, new)
    return text


def main():
    if '--replay' in sys.argv or '--audit' in sys.argv:
        parser = argparse.ArgumentParser(description=__doc__)
        parser.add_argument('--phase', type=Path, required=True)
        parser.add_argument('--replay', action='store_true')
        parser.add_argument('--audit', action='store_true')
        args = parser.parse_args()
        assert args.replay != args.audit
        phase, text = args.phase.resolve(), rendered_replay()
        path = phase / 'replay-as-run.py'
        if path.exists():
            assert path.read_text() == text
        else:
            assert args.replay
            path.write_text(text)
        namespace = {'__name__': 'reconstruction.csrc.nl2_full_cg_replay_as_run',
                     '__package__': 'reconstruction.csrc', '__file__': str(path)}
        exec(compile(text, str(path), 'exec'), namespace)
        namespace['audit' if args.audit else 'replay'](phase)
        return
    output = Path(sys.argv[sys.argv.index('--output') + 1]).resolve()
    linear.capture.rendered_transport = rendered_transport
    try:
        linear.capture.main()
    finally:
        path = output / 'trace-provenance.json'
        if path.exists():
            data = json.loads(path.read_text())
            data['full_cg_wrapper_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
            path.write_text(json.dumps(data, indent=2) + '\n')


if __name__ == '__main__':
    main()
