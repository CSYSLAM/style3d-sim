"""Isolate actual G1 revolute drive loads while retaining the original global DOF and target arrays."""
import argparse
import hashlib
from pathlib import Path

from .g1_joint_rhs_isolated import rendered_source as previous_source


BASE_SHA = 'a36c002a7d0ee429bb93b979fef4763dfbdc922ddbf858670acbbdf40fbfcac5'


def rendered_source():
    text = previous_source()
    assert hashlib.sha256(text.encode()).hexdigest() == BASE_SHA

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace("row['stage'] == 'joint'", "row['stage'] == 'drive'")
    replace("['kernels']['joint']", "['kernels']['drive']")
    start = text.index('    # Keep global spring arrays whole.')
    end = text.index('    rows = []', start)
    text = text[:start] + (
        '    # Shift only drive-local inputs to k; keep full body, particle, DOF and target arrays.\n'
        '    shifted = {2: 4, 3: 4, 4: 4, 6: 4, 7: 8, 8: 12, 9: 12, 10: 12,\n'
        '               11: 16, 12: 16, 13: 16, 14: 16, 15: 16, 16: 4, 17: 4}\n') + text[end:]
    replace("stage['key'] == 'joint'", "stage['key'] == 'drive'")
    replace("capture / side / 'joint-packets'", "capture / side / 'drive-packets'")
    replace('range(15)', 'range(33)')
    replace('assert values[11:] == [86, 86, 86, 176]', 'assert values[27:32] == [43, 43, 176, 49, 49]')
    replace('                groups = span_groups(values, bindings)',
            "                assert np.all(np.frombuffer(bindings[6], dtype='<i4') == 1)\n"
            "                assert np.all(np.frombuffer(bindings[4], dtype='<i4') == 1)\n"
            '                groups = span_groups(values, bindings)')
    replace('np.empty((3, 2, 86, 528)', 'np.empty((3, 2, 43, 528)')
    replace('np.empty((2, 86, 528)', 'np.empty((2, 43, 528)')
    replace("f'joint-{side}-frame-{frame:02d}.npz'", "f'drive-{side}-frame-{frame:02d}.npz'")
    replace('actual_counts[:86]', 'actual_counts[:43]')
    replace("['actual_output_replay_addresses']['10']", "['actual_output_replay_addresses']['26']")
    replace('np.empty((86, len(value))', 'np.empty((43, len(value))')
    replace('for lane in range(86):', 'for lane in range(43):')
    replace("                    patched[11] = (1).to_bytes(8, 'little')\n"
            "                    patched[12] = (lane + 1).to_bytes(8, 'little')\n"
            "                    patched[13] = (1).to_bytes(8, 'little')",
            "                    patched[27] = (1).to_bytes(8, 'little')\n"
            "                    patched[28] = (1).to_bytes(8, 'little')")
    replace('pointers[10]', 'pointers[26]', 2)
    replace("'calls': 3 * 2 * 86", "'calls': 3 * 2 * 43")
    replace("'shifted_multiplier_array': shifted", "'shifted_drive_local_arrays': shifted")
    replace('actual SDK spring isolation', 'actual SDK drive load isolation')
    replace('Isolated body-spring calls', 'Isolated drive load calls')
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
    namespace = {'__name__': 'reconstruction.csrc.drive_load_isolation_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    return namespace['main']()


if __name__ == '__main__':
    raise SystemExit(main())
