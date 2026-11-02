"""Specialize the verified graph-snapshot transport for the last G1 rigid-contact tangent."""
import argparse
import hashlib
from pathlib import Path

from .demo_source_ab import ROOT


TOKEN = '24evaluate_contact_tangentE'
TEMPLATE_SHA = '7d47fbdee7be80f4d8095e613ca1fcccc8821749e8f22752d12973233a9e7726'

SIZES = '''def sizes_for(node, body_count, dof_count):
    capacity, shapes, worlds = (integer(node, index) for index in (1, 20, 22))
    assert capacity == 1000 and shapes == integer(node, 21) == 105 and worlds == 1
    assert body_count == integer(node, 26) == 44 and integer(node, 32) == 176
    assert integer(node, 33) == integer(node, 34) == 0
    result = {0: 4, 2: capacity * 4, 3: capacity * 4, 9: capacity * 4, 10: capacity * 4,
              11: shapes * 4, 12: shapes * 4, 13: shapes * 28, 14: shapes * 12,
              23: body_count * 4, 24: body_count * 16, 25: body_count * 12}
    result.update({index: capacity * 12 for index in (4, 5, 6, 7, 8)})
    result.update({index: shapes * 4 for index in (15, 16, 17, 18)})
    result.update({index: 176 * 12 for index in (27, 28, 29, 30)})
    pointers = {index for index, kind in enumerate(parameter_types(node['name'])) if '*' in kind}
    assert set(result) == {index for index in pointers if integer(node, index)}
    return dict(sorted(result.items()))
'''


def rendered_source():
    path = ROOT / 'reconstruction/csrc/g1_drive_tangent_capture.py'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == TEMPLATE_SHA
    text = path.read_text()

    def replace(old, new):
        nonlocal text
        assert text.count(old) == 1, old
        text = text.replace(old, new)

    replace('Diagnostic-only snapshots around the last G1 drive tangent;',
            'Diagnostic-only snapshots around the last G1 rigid tangent;')
    replace("TOKEN = '28multiply_joint_drive_tangentE'", "TOKEN = '24evaluate_contact_tangentE'")
    start = text.index('def sizes_for(')
    end = text.index('\n\nclass Observer', start)
    text = text[:start] + SIZES.rstrip() + text[end:]
    replace('assert rank == 17453 and len(nodes) == 17467', 'assert rank == 17451 and len(nodes) == 17467')
    replace('sum(sizes.values()) + sizes[18]', 'sum(sizes.values()) + sizes[30]')
    replace("snapshot(target, 18, 'after')", "snapshot(target, 30, 'after')")
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
    namespace = {'__name__': 'reconstruction.csrc.rigid_capture_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
