"""Certify actual G1 drive-force scalars using authentic initial bits and GPU global F32 atomics."""
import argparse
import hashlib
from pathlib import Path

from .g1_joint_rhs_certificates import rendered_source as previous_source


BASE_SHA = 'a1374b737ed7b69d0e855936b5a09405bf063a6db6b9e66200e1adbd481fdd13'


def rendered_source():
    text = previous_source()
    assert hashlib.sha256(text.encode()).hexdigest() == BASE_SHA

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace("row['stage'] == 'joint'", "row['stage'] == 'drive'")
    replace("capture / side / 'joint-packets'", "capture / side / 'drive-packets'")
    replace("f'joint-{side}-frame-{frame:02d}.npz'", "f'drive-{side}-frame-{frame:02d}.npz'")
    replace("packet['before-arg-10']", "packet['before-arg-26']")
    replace("['actual_output_replay_addresses']['10']", "['actual_output_replay_addresses']['26']")
    replace('joint RHS scalar GPU certificates', 'drive load GPU scalar certificates')
    replace('Joint RHS scalar certificates:', 'Drive load scalar certificates:')
    return text


def main():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('--output', type=Path, required=True)
    args, _ = parser.parse_known_args()
    output = args.output.resolve()
    assert not output.exists()
    output.parent.mkdir(parents=True, exist_ok=True)
    script = output.parent / (output.name + '-certificates-as-run.py')
    assert not script.exists()
    script.write_text(rendered_source())
    namespace = {'__name__': 'reconstruction.csrc.drive_load_certificates_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    return namespace['main']()


if __name__ == '__main__':
    raise SystemExit(main())
