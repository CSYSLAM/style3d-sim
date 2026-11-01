"""Replay authentic drive/soft forces and AL state changes, retaining every complete output and actual ABI."""
import argparse
import hashlib
from pathlib import Path

from . import g1_contact_rhs_replay as base


BASE_SHA = '96dcc89cb5a7d208d3f486afbc858df6d00feac13a9e6b4259738bf9c951111a'


def rendered_source():
    path = Path(base.__file__)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == BASE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('from .surface_atomic_operands import instrument', 'from .ptx_atomic_literal_probe import instrument')
    replace("for key in ('force', 'matrix'):", "for key in plan['kernels']:")
    replace('        for side, text in texts.items():',
            "        for side, text in texts.items():\n            if key not in ('drive', 'soft'):\n                continue")
    replace("node['geometry'] == [4, 1, 1, 256, 1, 1, 0]",
            "node['geometry'] == [73 if key == 'soft' else 1, 1, 1, 256, 1, 1, 0]")
    replace("                paths = sorted((folder / (key + '-packets')).glob('frame-*.npz'))",
            "                grid, lanes = node['geometry'][0], node['geometry'][0] * 256\n"
            "                paths = sorted((folder / (key + '-packets')).glob('frame-*.npz'))")
    old = ("                        count = int.from_bytes(bindings[0], 'little', signed=True)\n"
           '                        active = min(max(count, 0), values[1])\n'
           "                        assert values[1] == 1000 and set(outputs) == ({32, 33} if key == 'force' else {33, 34})\n"
           "                        assert key != 'matrix' or values[29] == values[30] == 0")
    new = ("                        if key == 'soft':\n"
           "                            count = int.from_bytes(bindings[0], 'little', signed=True)\n"
           "                            assert values[1] == 18480\n"
           "                            active = min(max(count, 0), values[1])\n"
           "                        else:\n"
           "                            count = values[27 if key == 'drive' else (8 if key == 'joint' else 5)]\n"
           "                            active = count\n"
           "                            assert count == (43 if key == 'drive' else (86 if key == 'joint' else 44))\n"
           "                        assert outputs == {'drive': [3, 4, 26], 'soft': [36, 37], 'joint': [7],\n"
           "                                           'so3_true': [2, 3], 'so3_false': [2, 3]}[key]")
    replace(old, new)
    replace("                                          'original_start_mod256': padding,",
            "                                          'original_start_mod256': padding,\n"
            "                                          'allocated_device_base': device.value,")
    replace('                        arrays, checks = {}, []',
            "                        arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(value), dtype='u1')\n"
            '                                  for i, value in enumerate(parameters)}\n'
            '                        checks = []')
    replace('Dim3(4, 1, 1)', 'Dim3(grid, 1, 1)')
    replace('cuLaunchKernel(function, 4, 1, 1', 'cuLaunchKernel(function, grid, 1, 1')
    replace('np.zeros((LANES, TRACE_RECORDS, 16)', 'np.zeros((lanes, TRACE_RECORDS, 16)')
    replace("np.zeros(LANES, dtype='u4')", "np.zeros(lanes, dtype='u4')")
    replace('                        operands, sequences, total_atoms = {}, {}, {}',
            "                        operands = {'original': [], 'source': []}\n"
            "                        sequences = {'original': [], 'source': []}\n"
            "                        total_atoms = {}")
    replace("                        for backend in ('original', 'source'):",
            "                        for backend in (('original', 'source') if key in ('drive', 'soft') else ()):")
    replace("(64 if key == 'force' else 144)", '36')
    replace("'reported_contact_count': count, 'active_contacts': active,",
            "'reported_lane_count': count, 'active_lanes': active, 'trace_lanes': lanes,\n"
            "                                     'atomic_probes_executed': key in ('drive', 'soft'),")
    replace('assert len(rows) == 240', 'assert len(rows) == 600')
    replace('All240 two-output packets saved', 'All600 drive/soft/AL-state packets saved')
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
    namespace = {'__name__': 'reconstruction.csrc.drive_state_replay_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
