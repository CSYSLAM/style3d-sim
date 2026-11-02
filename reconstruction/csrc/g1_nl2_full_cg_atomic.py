"""Certify every actual reduction input in the complete 50-iteration G1 NL2 capture."""
import argparse
import hashlib
from pathlib import Path
import sys

from . import g1_nl2_atomic as original
from .g1_nl2_full_cg import replace_once


ORIGINAL_SHA = 'a7ef210e10007eccd0855e41804d868855916fa0e926b0bc25258a54b09f565e'


def rendered_worker():
    path = Path(original.__file__)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == ORIGINAL_SHA
    text = path.read_text()
    for old, new in {
        "STAGES = ('precondition_first', 'matrix_first', 'precondition_last', 'matrix_last')":
            "STAGES = ('precondition', 'matrix')",
        "            label, key = case['label'], case['stage']":
            "            label, key = case['label'], case['stage']\n"
            "            kind = key.split('_', 1)[0]",
        'launch(probes[key][side], actual_parameters)': 'launch(probes[kind][side], actual_parameters)',
        'launch(functions[key][backend], isolated, backend)': 'launch(functions[kind][backend], isolated, backend)',
        '    def launch(function, parameters, backend=None, block=256):':
            '    def launch(function, parameters, backend=None, block=256):\n'
            '        driver.check(driver.cu.cuCtxSynchronize())',
        "    assert complete and len(rows) == 8 and calls['probe'] == 16 and calls['SDK_isolation'] == 48":
            "    assert complete and len(rows) == len(plan['cases']) == 200\n"
            "    assert calls['probe'] == 400 and calls['SDK_isolation'] == 1200",
    }.items():
        text = replace_once(text, old, new)
    return text


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    args = parser.parse_args()
    phase = args.phase.resolve(strict=True)
    text = rendered_worker()
    assert text == (phase / 'atomic-template.py').read_text()
    path = phase / 'atomic-as-run.py'
    assert not path.exists()
    path.write_text(text)
    namespace = {'__name__': 'reconstruction.csrc.full_cg_atomic_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(path)}
    exec(compile(text, str(path), 'exec'), namespace)
    sys.argv = [str(path), '--phase', str(phase)]
    namespace['main']()


if __name__ == '__main__':
    main()
