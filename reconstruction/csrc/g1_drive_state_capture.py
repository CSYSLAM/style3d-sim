"""Capture actual G1 drive/soft RHS and both forms of the AL state updates."""
import argparse
import hashlib
from pathlib import Path

from . import g1_contact_rhs_capture as base


BASE_SHA = '47f6a70d1bf2ac9aebf7dfaf4a1342265114672b49300c1603535abe825cf21e'
SELECTION = '''def select_stages(nodes, body_count, dof_count):
    starts = [i for i, n in enumerate(nodes) if '15initialize_stepE' in n.get('name', '')]
    assert len(starts) == 6 and starts[-1] == 14567 and len(nodes) == 17467
    assert body_count == 44 and dof_count == 49
    ranks = {'drive': 14581, 'soft': 14578, 'joint': 16882, 'so3_true': 15149, 'so3_false': 17459}
    result = []
    for key, token in STAGES.items():
        rank = ranks[key]
        node = nodes[rank]
        assert token in node['name']
        assert node['geometry'] == [73 if key == 'soft' else 1, 1, 1, 256, 1, 1, 0]
        if key == 'drive':
            assert node['parameter_widths'] == [8] * 32 + [4]
            assert [integer(node, i) for i in range(27, 32)] == [43, 43, 176, 49, 49]
            sizes = {0: 2112, 1: 2112, 2: 172, 3: 172, 4: 172, 5: 704, 6: 172, 7: 344,
                     **{i: 516 for i in (8, 9, 10)}, **{i: 688 for i in range(11, 16)},
                     16: 172, 17: 172, **{i: 196 for i in range(18, 26)}, 26: 2112}
            outputs = [3, 4, 26]
        elif key == 'soft':
            assert len(node['parameter_widths']) == 42
            assert [integer(node, i) for i in (1, 10, 11, 21, 22, 23, 31)] == [18480, 176, 176, 105, 105, 1, 44]
            assert all(integer(node, i) == 0 for i in (38, 39, 40, 41))
            sizes = {0: 4, 2: 73920, 3: 73920, **{i: 221760 for i in (4, 5, 6)},
                     **{i: 704 for i in (7, 8, 9)}, 12: 420, 13: 420, 14: 2940, 15: 1260,
                     **{i: 420 for i in range(16, 21)}, 28: 176, 29: 704, 30: 528,
                     **{i: 2112 for i in (32, 33, 34)}, 36: 2112, 37: 704}
            outputs = [36, 37]
        elif key == 'joint':
            assert node['parameter_widths'] == [8] * 12
            assert [integer(node, i) for i in range(8, 12)] == [86, 86, 86, 176]
            sizes = {0: 2112, 1: 704, 2: 688, 3: 1032, 4: 1032, 5: 1376, 6: 1376, 7: 1032}
            outputs = [7]
        else:
            assert key in ('so3_true', 'so3_false')
            assert node['parameter_widths'] == [8] * 4 + [1] + [8] * 3
            assert integer(node, 4) == int(key == 'so3_true')
            assert [integer(node, i) for i in (5, 6, 7)] == [44, 44, 176]
            sizes = {0: 2112, 1: 704, 2: 1584, 3: 1584}
            outputs = [2, 3]
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind and integer(node, i)}
        assert set(sizes) == pointers and all(integer(node, i) for i in sizes)
        for a in outputs:
            for b in sizes:
                if a != b:
                    assert min(integer(node, a) + sizes[a], integer(node, b) + sizes[b]) <= max(
                        integer(node, a), integer(node, b)), 'A writable output aliases another buffer'
        result.append({'key': key, 'rank': rank, 'node': node, 'sizes': dict(sorted(sizes.items())),
                       'outputs': outputs, 'output_overlaps': []})
    return result
'''


def rendered_source():
    path = Path(base.__file__)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == BASE_SHA
    text = path.read_text()
    old = "STAGES = {'force': '22evaluate_contact_forceE', 'matrix': '24evaluate_contact_tangentE'}"
    assert text.count(old) == 1
    text = text.replace(old, "STAGES = {'drive': '25evaluate_joint_drive_loadE', 'soft': '27evaluate_soft_contact_forceE',\n"
                        "          'joint': '51update_joint_body_spring_augmented_lagrangian_stateE',\n"
                        "          'so3_true': '49update_affine_body_so3_augmented_lagrangian_stateE',\n"
                        "          'so3_false': '49update_affine_body_so3_augmented_lagrangian_stateE'}")
    start = text.index('def select_stages(')
    end = text.index('\n\nclass Observer(', start)
    return text[:start] + SELECTION.rstrip() + text[end:]


def main():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('--output', type=Path, required=True)
    args, _ = parser.parse_known_args()
    output = args.output.resolve()
    assert not output.exists()
    output.parent.mkdir(parents=True, exist_ok=True)
    script = output.parent / (output.name + '-capture-as-run.py')
    assert not script.exists()
    script.write_text(rendered_source())
    namespace = {'__name__': 'reconstruction.csrc.drive_state_capture_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
