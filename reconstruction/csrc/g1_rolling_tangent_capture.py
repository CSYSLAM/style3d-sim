"""Capture the late rolling tangent with actual view, direction and accumulator bytes."""
import argparse
import hashlib
from pathlib import Path

from .g1_rolling_capture import rendered_source as rolling_source


BASE_SHA = '6a8fdc02fc5436036611578a6f9da51c7011fcc13d158fae258f149f728af93c'


def rendered_source():
    text = rolling_source()
    assert hashlib.sha256(text.encode()).hexdigest() == BASE_SHA

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('Capture authentic G1 rolling force and matrix branches', 'Capture authentic late G1 rolling tangent')
    replace("STAGES = {'force': '30evaluate_rolling_contact_forceE', 'matrix': '34add_rolling_contact_preconditionerE'}",
            "STAGES = {'tangent': '32multiply_rolling_contact_tangentE'}")
    replace('if binding == 1:', 'if binding in (1, 2):')
    replace("bytes.fromhex(node['parameter_hex'][1])", "bytes.fromhex(node['parameter_hex'][binding])")
    replace("rank = next(i for i in range(starts[-1], len(nodes)) if token in nodes[i].get('name', ''))",
            "rank = max(i for i in range(starts[-1], len(nodes)) if token in nodes[i].get('name', ''))")
    replace("assert rank == {'force': 14577, 'matrix': 14592}[key]", 'assert rank == 17455')
    replace("assert node['parameter_widths'] == [248, 8]", "assert node['parameter_widths'] == [248, 8, 8]")
    replace("sizes, bindings = {1: 2112 if key == 'force' else 6336}, {1: {'parameter': 1, 'offset': 0}}",
            "sizes = {1: 2112, 2: 2112}\n"
            "        bindings = {i: {'parameter': i, 'offset': 0} for i in (1, 2)}")
    replace('output = integer(node, 1)', 'output = integer(node, 2)')
    replace('assert output and len(sizes) == 25',
            'assert output and len(sizes) == 26\n        assert all(integer(node, binding) for binding in sizes)')
    replace('if binding != 1:', 'if binding != 2:')
    replace('output + sizes[1]', 'output + sizes[2]')
    replace("'outputs': [1]", "'outputs': [2]")
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
    namespace = {'__name__': 'reconstruction.csrc.rolling_tangent_capture_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
