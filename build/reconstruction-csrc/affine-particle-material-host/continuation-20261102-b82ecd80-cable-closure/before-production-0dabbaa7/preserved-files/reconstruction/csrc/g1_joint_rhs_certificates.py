"""Certify authentic joint RHS scalar outputs with exact operand permutations and actual GPU F32 atomics."""
import argparse
import hashlib
from pathlib import Path

from . import g1_drive_tangent_certificates as base


BASE_SHA = '0408c5bfa24ae85e27d2c10029df00504455b4ddf75894b64fa27e8646511eeb'


def rendered_source():
    path = Path(base.__file__)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == BASE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace("    plan = json.loads((capture / 'certification-plan.json').read_text())",
            "    plan = json.loads((capture / 'certification-plan.json').read_text())\n"
            "    for path, sha in plan['input_sha256'].items():\n"
            "        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path")
    replace("    replay = json.loads(replay_path.read_text())",
            "    replay = json.loads(replay_path.read_text())\n"
            "    replay['packets'] = [row for row in replay['packets'] if row['stage'] == 'joint']\n"
            "    assert len(replay['packets']) == 120")
    replace("capture / side / 'packets'", "capture / side / 'joint-packets'")
    replace("capture / 'replay' / f'{side}-frame-{frame:02d}.npz'",
            "capture / 'replay' / f'joint-{side}-frame-{frame:02d}.npz'")
    replace("packet['before-arg-18']", "packet['before-arg-10']")
    replace("row['actual_output_replay_address']", "row['actual_output_replay_addresses']['10']")
    replace('drive scalar GPU certificates', 'joint RHS scalar GPU certificates')
    replace('Drive scalar certificates:', 'Joint RHS scalar certificates:')
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
    namespace = {'__name__': 'reconstruction.csrc.joint_rhs_certificates_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    return namespace['main']()


if __name__ == '__main__':
    raise SystemExit(main())
