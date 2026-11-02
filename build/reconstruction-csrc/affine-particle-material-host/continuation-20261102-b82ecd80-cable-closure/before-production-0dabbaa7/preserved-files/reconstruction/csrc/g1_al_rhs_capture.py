"""Capture authentic G1 inertial, joint and SO3 RHS inputs and complete accumulator outputs."""
import argparse
import hashlib
from pathlib import Path

from . import g1_contact_rhs_capture as base


BASE_SHA = '47f6a70d1bf2ac9aebf7dfaf4a1342265114672b49300c1603535abe825cf21e'
SELECTION = '''def select_stages(nodes, body_count, dof_count):
    starts = [rank for rank, node in enumerate(nodes) if '15initialize_stepE' in node.get('name', '')]
    assert len(starts) == 6 and starts[-1] == 14567 and len(nodes) == 17467
    assert body_count == 44 and dof_count == 49
    result = []
    for key, token in STAGES.items():
        rank = next(i for i in range(starts[-1], len(nodes)) if token in nodes[i].get('name', ''))
        assert rank == {'rhs': 14575, 'joint': 14580, 'so3': 14583}[key]
        node = nodes[rank]
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        if key == 'rhs':
            assert node['parameter_widths'] == [4] + [8] * 11
            assert integer(node, 6) == 19 and integer(node, 10) == integer(node, 11) == 176
            sizes = {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112}
            outputs = [9]
        elif key == 'joint':
            assert node['parameter_widths'] == [8] * 9 + [4] + [8] * 5
            assert all(integer(node, i) == 86 for i in (11, 12, 13)) and integer(node, 14) == 176
            sizes = {0: 2112, 1: 704, 2: 688, 3: 1032, 4: 1032, 5: 1376, 6: 1376,
                     7: 344, 8: 1032, 10: 2112}
            outputs = [10]
        else:
            assert key == 'so3' and node['parameter_widths'] == [8] * 5 + [4] + [8] * 4
            assert integer(node, 7) == integer(node, 8) == 44 and integer(node, 9) == 176
            sizes = {0: 2112, 1: 704, 2: 176, 3: 1584, 4: 1584, 6: 2112}
            outputs = [6]
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind}
        assert set(sizes) == pointers and all(integer(node, i) for i in sizes)
        for a in outputs:
            for b in sizes:
                if a == b:
                    continue
                assert min(integer(node, a) + sizes[a], integer(node, b) + sizes[b]) <= max(
                    integer(node, a), integer(node, b)), 'Output overlaps another binding'
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
    text = text.replace(old, "STAGES = {'rhs': '14initialize_rhsE',\n"
                        "          'joint': '53evaluate_joint_body_spring_augmented_lagrangian_forceE',\n"
                        "          'so3': '51evaluate_affine_body_so3_augmented_lagrangian_forceE'}")
    start = text.index('def select_stages(')
    end = text.index('\n\nclass Observer(', start)
    text = text[:start] + SELECTION.rstrip() + text[end:]
    return text


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
    namespace = {'__name__': 'reconstruction.csrc.al_rhs_capture_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
