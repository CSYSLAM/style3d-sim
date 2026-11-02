"""Isolate each authentic G1 AL body spring using the original SDK and both PTX implementations."""
import argparse
import hashlib
from pathlib import Path

from . import g1_drive_tangent_isolated as base


BASE_SHA = 'c5443b4975613010bda64d79e64687bdea90e66620fe2e326857d3dd7a1797ef'


def rendered_source():
    path = Path(base.__file__)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == BASE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace("    replay = json.loads(replay_path.read_text())",
            "    replay = json.loads(replay_path.read_text())\n"
            "    replay['packets'] = [row for row in replay['packets'] if row['stage'] == 'joint']\n"
            "    assert len(replay['packets']) == 120")
    replace("json.loads((capture / 'plan.json').read_text())['kernel']",
            "json.loads((capture / 'plan.json').read_text())['kernels']['joint']")
    replace("    plan = json.loads((capture / 'isolation-plan.json').read_text())",
            "    plan = json.loads((capture / 'isolation-plan.json').read_text())\n"
            "    for path, sha in plan['input_sha256'].items():\n"
            "        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path")
    start = text.index('    # A single-world drive k')
    end = text.index('    rows = []', start)
    text = text[:start] + (
        '    # Keep global spring arrays whole. count/local=1 and spring_count=k+1 select spring k in world0.\n'
        '    # Only the multiplier is indexed by the local thread, so shift its pointer by k.\n'
        '    shifted = {8: 12}\n') + text[end:]
    replace("            layout = json.loads((capture / side / 'snapshot-layout.json').read_text())",
            "            layout = next(stage for stage in json.loads(\n"
            "                (capture / side / 'snapshot-layout.json').read_text())['stages'] if stage['key'] == 'joint')")
    replace("capture / side / 'packets'", "capture / side / 'joint-packets'")
    replace('range(22)', 'range(15)')
    replace('assert values[19:] == [43, 43, 176]', 'assert values[11:] == [86, 86, 86, 176]')
    replace("                assert np.all(np.frombuffer(bindings[3], dtype='<i4') == 1)\n", '')
    replace('np.empty((3, 2, 43, 528)', 'np.empty((3, 2, 86, 528)')
    replace('np.empty((2, 43, 528)', 'np.empty((2, 86, 528)')
    replace("capture / 'replay' / f'{side}-frame-{frame:02d}.npz'",
            "capture / 'replay' / f'joint-{side}-frame-{frame:02d}.npz'")
    replace('actual_counts[:43]', 'actual_counts[:86]')
    replace("row['actual_output_replay_address']", "row['actual_output_replay_addresses']['10']")
    replace('                for lane in range(43):',
            "                parameter_bytes = {i: np.empty((86, len(value)), dtype='u1') for i, value in enumerate(raw)}\n"
            '                for lane in range(86):')
    replace('                    patched[19], patched[20] = (1).to_bytes(8, \'little\'), (1).to_bytes(8, \'little\')',
            "                    patched[11] = (1).to_bytes(8, 'little')\n"
            "                    patched[12] = (lane + 1).to_bytes(8, 'little')\n"
            "                    patched[13] = (1).to_bytes(8, 'little')")
    replace('                    holders = (ct.c_void_p * len(params))',
            '                    for i, value in enumerate(params):\n'
            "                        parameter_bytes[i][lane] = np.frombuffer(bytes(value), dtype='u1')\n"
            '                    holders = (ct.c_void_p * len(params))')
    replace('pointers[18]', 'pointers[10]', 2)
    replace('                                    expected_from_real_operands=predicted)',
            "                                    expected_from_real_operands=predicted,\n"
            "                                    **{'actual-parameter-' + str(i): value\n"
            "                                       for i, value in parameter_bytes.items()})")
    replace("                rows.append({'side': side, 'frame': frame, 'comparisons': comparisons,",
            "                rows.append({'side': side, 'frame': frame, 'comparisons': comparisons,\n"
            "                             'actual_binding_replay_addresses': {str(i): p for i, p in pointers.items()},")
    replace("'calls': 3 * 2 * 43", "'calls': 3 * 2 * 86")
    replace("'shifted_drive_local_arrays': shifted", "'shifted_multiplier_array': shifted")
    replace('isolated actual SDK drive arithmetic', 'actual SDK spring isolation')
    replace('Isolated drive calls', 'Isolated body-spring calls')
    return text


def main():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('--output', type=Path, required=True)
    args, _ = parser.parse_known_args()
    output = args.output.resolve()
    assert not output.exists()
    output.parent.mkdir(parents=True, exist_ok=True)
    script = output.parent / (output.name + '-isolation-as-run.py')
    assert not script.exists()
    script.write_text(rendered_source())
    namespace = {'__name__': 'reconstruction.csrc.joint_rhs_isolation_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    return namespace['main']()


if __name__ == '__main__':
    raise SystemExit(main())
