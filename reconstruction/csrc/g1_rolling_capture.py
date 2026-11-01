"""Specialize verified graph snapshots for G1 rolling force and preconditioner with embedded view pointers."""
import argparse
import hashlib
from pathlib import Path

from .demo_source_ab import ROOT


TEMPLATE_SHA = '47f6a70d1bf2ac9aebf7dfaf4a1342265114672b49300c1603535abe825cf21e'
STAGES = {'force': '30evaluate_rolling_contact_forceE', 'matrix': '34add_rolling_contact_preconditionerE'}
BODY = '''BINDING_BASE = 256
POINTER_OFFSETS = tuple(i for i in range(0, 240, 8) if i not in (8, 152, 160, 168, 208, 216))


def integer(node, binding):
    if binding == 1:
        return int.from_bytes(bytes.fromhex(node['parameter_hex'][1]), 'little')
    offset = (binding - BINDING_BASE) * 8
    assert offset in POINTER_OFFSETS
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][0])[offset:offset + 8], 'little')


def select_stages(nodes, body_count, dof_count):
    starts = [i for i, node in enumerate(nodes) if '15initialize_stepE' in node.get('name', '')]
    assert len(starts) == 6 and starts[-1] == 14567 and len(nodes) == 17467
    assert body_count == 44 and dof_count == 49
    result = []
    for key, token in STAGES.items():
        rank = next(i for i in range(starts[-1], len(nodes)) if token in nodes[i].get('name', ''))
        assert rank == {'force': 14577, 'matrix': 14592}[key]
        node = nodes[rank]
        assert node['geometry'] == [4, 1, 1, 256, 1, 1, 0]
        assert node['parameter_widths'] == [248, 8]
        raw = bytes.fromhex(node['parameter_hex'][0])
        assert len(raw) == 248
        scalars = {offset: int.from_bytes(raw[offset:offset + 8], 'little')
                   for offset in (8, 152, 160, 168, 208, 216)}
        assert scalars == {8: 1000, 152: 105, 160: 105, 168: 1, 208: 44, 216: 176}
        assert int.from_bytes(raw[240:244], 'little') == 0x43b40000
        assert int.from_bytes(raw[244:248], 'little') == 0x3dcccccd
        field_sizes = {0: 4, 16: 4000, 24: 4000, 72: 4000, 80: 4000,
                       88: 420, 96: 420, 104: 2940, 112: 1260,
                       120: 420, 128: 420, 136: 420, 144: 420,
                       176: 176, 184: 704, 192: 528, 200: 1584, 224: 2112, 232: 2112}
        field_sizes.update({offset: 12000 for offset in (32, 40, 48, 56, 64)})
        assert set(field_sizes) == set(POINTER_OFFSETS)
        sizes, bindings = {1: 2112 if key == 'force' else 6336}, {1: {'parameter': 1, 'offset': 0}}
        for offset, size in field_sizes.items():
            binding = BINDING_BASE + offset // 8
            assert integer(node, binding), 'This fixed capture expects every rolling pointer to be non-null'
            sizes[binding] = size
            bindings[binding] = {'parameter': 0, 'offset': offset}
        output = integer(node, 1)
        assert output and len(sizes) == 25
        for binding, size in sizes.items():
            if binding != 1:
                address = integer(node, binding)
                assert min(output + sizes[1], address + size) <= max(output, address), 'Output aliases a read input'
        result.append({'key': key, 'rank': rank, 'node': node, 'sizes': dict(sorted(sizes.items())),
                       'outputs': [1], 'bindings': bindings, 'view_pointer_offsets': list(POINTER_OFFSETS),
                       'view_scalar_word_offsets': [8, 152, 160, 168, 208, 216, 240]})
    return result
'''


def rendered_source():
    path = ROOT / 'reconstruction/csrc/g1_contact_rhs_capture.py'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == TEMPLATE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('Capture authentic G1 contact RHS and matrix branches', 'Capture authentic G1 rolling force and matrix branches')
    replace('from .g1_drive_tangent_capture import Observer as Transport, integer',
            'from .g1_drive_tangent_capture import Observer as Transport')
    replace("STAGES = {'force': '22evaluate_contact_forceE', 'matrix': '24evaluate_contact_tangentE'}", f'STAGES = {STAGES!r}')
    start, end = text.index('def select_stages('), text.index('\n\nclass Observer(')
    text = text[:start] + BODY.rstrip() + text[end:]
    replace("'argument': argument", "'binding': argument")
    replace("row['argument']", "row['binding']")
    replace("'-arg-'", "'-binding-'")
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
    namespace = {'__name__': 'reconstruction.csrc.rolling_capture_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
