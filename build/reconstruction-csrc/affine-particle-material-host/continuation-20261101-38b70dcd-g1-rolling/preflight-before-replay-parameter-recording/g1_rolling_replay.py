"""Replay G1 rolling packets, relocating only embedded view pointers and preserving actual scalar bytes."""
import argparse
import hashlib
from pathlib import Path

from .demo_source_ab import ROOT


TEMPLATE_SHA = '96dcc89cb5a7d208d3f486afbc858df6d00feac13a9e6b4259738bf9c951111a'


def rendered_source():
    path = ROOT / 'reconstruction/csrc/g1_contact_rhs_replay.py'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == TEMPLATE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('both G1 contact output branches', 'G1 rolling force and preconditioner')
    replace("values = [int.from_bytes(value, 'little') for value in raw]",
            "values = {int(i): int.from_bytes(raw[spec['parameter']][spec['offset']:spec['offset'] + 8], 'little')\n"
            "                                  for i, spec in stage['bindings'].items()}\n"
            "                        assert list(map(len, raw)) == [248, 8]")
    replace("packet['before-arg-' + str(i)]", "packet['before-binding-' + str(i)]")
    replace("packet['after-arg-' + str(i)]", "packet['after-binding-' + str(i)]")
    replace("count = int.from_bytes(bindings[0], 'little', signed=True)",
            "count = int.from_bytes(bindings[256], 'little', signed=True)")
    replace('active = min(max(count, 0), values[1])',
            "active = min(max(count, 0), int.from_bytes(raw[0][8:16], 'little'))")
    replace("assert values[1] == 1000 and set(outputs) == ({32, 33} if key == 'force' else {33, 34})",
            "assert int.from_bytes(raw[0][8:16], 'little') == 1000 and outputs == [1]")
    replace("                        assert key != 'matrix' or values[29] == values[30] == 0\n", '')
    old = '''                        parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                            pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]'''
    new = '''                        patched = [bytearray(value) for value in raw]
                        for i, address in pointers.items():
                            spec = stage['bindings'][str(i)]
                            patched[spec['parameter']][spec['offset']:spec['offset'] + 8] = address.to_bytes(8, 'little')
                        for offset in stage['view_scalar_word_offsets']:
                            assert patched[0][offset:offset + 8] == raw[0][offset:offset + 8]
                        parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in patched]'''
    replace(old, new)
    replace("(64 if key == 'force' else 144)", "(18 if key == 'force' else 54)")
    text = text.replace('two-output', 'single-output rolling')
    return text


def main():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('--output', type=Path, required=True)
    args, _ = parser.parse_known_args()
    output = args.output.resolve()
    assert not output.exists()
    output.parent.mkdir(parents=True, exist_ok=True)
    script = output.parent / (output.name + '-replay-as-run.py')
    assert not script.exists()
    script.write_text(rendered_source())
    namespace = {'__name__': 'reconstruction.csrc.rolling_replay_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
