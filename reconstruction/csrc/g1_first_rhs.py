"""Locate the real common-start force difference before G1's first drive, using the frozen capture and replay engines."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

from . import g1_checkpoint_substeps as capture
from . import g1_checkpoint_substeps_replay as replay


CAPTURE_SHA = 'b1d4abbd575245959ef31d2a0f752f691bf1d3f1460afadb51522f2ccb116bc1'
REPLAY_SHA = '94f812ade28ebf9ed5a19eb54576735131e4c95835471fafa27f65551c49739f'
BASE_TRANSPORT = capture.rendered_transport
SELECTION = '''def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 17467 and body_count == 44 and dof_count == 49
    result = []
    for kind, token in STAGES.items():
        rank = {'rhs': 25, 'joint': 30, 'drive': 31}[kind]
        node = nodes[rank]
        assert token in node['name'] and node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        if kind == 'rhs':
            assert node['parameter_widths'] == [4] + [8] * 11
            assert integer(node, 6) == 19 and integer(node, 10) == integer(node, 11) == 176
            sizes = {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112}
            outputs = [9]
        elif kind == 'joint':
            assert node['parameter_widths'] == [8] * 9 + [4] + [8] * 5
            assert [integer(node, i) for i in (11, 12, 13, 14)] == [86, 86, 86, 176]
            sizes = {0: 2112, 1: 704, 2: 688, 3: 1032, 4: 1032, 5: 1376, 6: 1376,
                     7: 344, 8: 1032, 10: 2112}
            outputs = [10]
        else:
            assert kind == 'drive' and node['parameter_widths'] == [8] * 32 + [4]
            assert [integer(node, i) for i in range(27, 32)] == [43, 43, 176, 49, 49]
            sizes = {0: 2112, 1: 2112, 2: 172, 3: 172, 4: 172, 5: 704, 6: 172, 7: 344,
                     **{i: 516 for i in (8, 9, 10)}, **{i: 688 for i in range(11, 16)},
                     16: 172, 17: 172, **{i: 196 for i in range(18, 26)}, 26: 2112}
            outputs = [3, 4, 26]
        pointers = {i for i, t in enumerate(parameter_types(node['name'])) if '*' in t and integer(node, i)}
        assert set(sizes) == pointers
        for a in outputs:
            for b in sizes:
                if a != b:
                    assert min(integer(node, a) + sizes[a], integer(node, b) + sizes[b]) <= max(
                        integer(node, a), integer(node, b)), 'Output aliases another captured argument'
        result.append({'key': kind, 'kernel_key': kind, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': []})
    assert [stage['rank'] for stage in result] == [25, 30, 31]
    return result
'''


def rendered_transport():
    assert hashlib.sha256(Path(capture.__file__).read_bytes()).hexdigest() == CAPTURE_SHA
    text = BASE_TRANSPORT()
    old = ("STAGES = {'drive': '25evaluate_joint_drive_loadE', 'velocity': '15update_velocityE',\n"
           "          'angle': '30update_joint_drive_angle_stateE'}")
    assert text.count(old) == 1
    text = text.replace(old, "STAGES = {'rhs': '14initialize_rhsE',\n"
                        "          'joint': '53evaluate_joint_body_spring_augmented_lagrangian_forceE',\n"
                        "          'drive': '25evaluate_joint_drive_loadE'}")
    start, end = text.index('def select_stages('), text.index('\n\nclass Observer(')
    text = text[:start] + SELECTION.rstrip() + text[end:]
    old = '        for key in [kind + str(i) for i in range(6) for kind in STAGES]:\n'
    assert text.count(old) == 1
    return text.replace(old, '        for key in STAGES:\n')


def rendered_replay():
    assert hashlib.sha256(Path(replay.__file__).read_bytes()).hexdigest() == REPLAY_SHA
    text = Path(replay.__file__).read_text()
    replacements = {
        "assert len(layout['stages']) == 18": "assert len(layout['stages']) == 3",
        'if len(rows) % 18 == 0:': 'if len(rows) % 3 == 0:',
        "'all18 real substep calls'": "'all3 real first-force calls'",
        'assert len(rows) == 198': 'assert len(rows) == 6',
        "report['actual_calls'] == 594": "report['actual_calls'] == 18",
        "counts['packets'] == 198 and counts['complete_output_arrays'] == 1188":
            "counts['packets'] == 6 and counts['complete_output_arrays'] == 30",
    }
    for old, new in replacements.items():
        assert text.count(old) == 1, (old, text.count(old))
        text = text.replace(old, new)
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
        script = phase / 'replay-as-run.py'
        if script.exists():
            assert script.read_text() == text
        else:
            assert args.replay
            script.write_text(text)
        namespace = {'__name__': 'reconstruction.csrc.first_rhs_replay_as_run',
                     '__package__': 'reconstruction.csrc', '__file__': str(script)}
        exec(compile(text, str(script), 'exec'), namespace)
        namespace['audit' if args.audit else 'replay'](phase)
        return
    output = Path(sys.argv[sys.argv.index('--output') + 1]).resolve()
    capture.rendered_transport = rendered_transport
    try:
        capture.main()
    finally:
        path = output / 'trace-provenance.json'
        if path.exists():
            data = json.loads(path.read_text())
            data['outer_first_rhs_wrapper_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
            path.write_text(json.dumps(data, indent=2) + '\n')


if __name__ == '__main__':
    main()
