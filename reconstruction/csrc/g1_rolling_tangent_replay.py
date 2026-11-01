"""Replay the late G1 rolling tangent on the fixed SDK, PTX and independent source."""
import argparse
import hashlib
from pathlib import Path

from .g1_rolling_replay import rendered_source as rolling_source


BASE_SHA = 'ae5cbc92c763078ee8253f078a845d9d3debaafba0ed273c18ffa7ea29485e13'


def rendered_source():
    text = rolling_source()
    assert hashlib.sha256(text.encode()).hexdigest() == BASE_SHA

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('G1 rolling force and preconditioner', 'late G1 rolling tangent')
    replace("for key in ('force', 'matrix'):", 'for key in plan[\'kernels\']:')
    replace('assert list(map(len, raw)) == [248, 8]', 'assert list(map(len, raw)) == [248, 8, 8]')
    replace('outputs == [1]', 'outputs == [2]')
    replace("(18 if key == 'force' else 54)", '18')
    replace('assert len(rows) == 240', 'assert len(rows) == 120')
    replace('All240 single-output rolling packets', 'All120 late rolling-tangent packets')
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
    namespace = {'__name__': 'reconstruction.csrc.rolling_tangent_replay_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
