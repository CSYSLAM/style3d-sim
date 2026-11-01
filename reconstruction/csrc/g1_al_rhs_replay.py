"""Replay G1 inertial, joint and SO3 RHS kernels on their authentic captured buffers."""
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
            "        for side, text in texts.items():\n            if key == 'rhs':\n                continue")
    replace("node['geometry'] == [4, 1, 1, 256, 1, 1, 0]", "node['geometry'] == [1, 1, 1, 256, 1, 1, 0]")
    replace("                        count = int.from_bytes(bindings[0], 'little', signed=True)\n"
            '                        active = min(max(count, 0), values[1])\n'
            "                        assert values[1] == 1000 and set(outputs) == ({32, 33} if key == 'force' else {33, 34})\n"
            "                        assert key != 'matrix' or values[29] == values[30] == 0",
            "                        count = values[{'rhs': 10, 'joint': 11, 'so3': 7}[key]]\n"
            "                        active = count\n"
            "                        assert active == {'rhs': 176, 'joint': 86, 'so3': 44}[key]\n"
            "                        assert outputs == [{'rhs': 9, 'joint': 10, 'so3': 6}[key]]")
    replace("                                          'original_start_mod256': padding,",
            "                                          'original_start_mod256': padding,\n"
            "                                          'allocated_device_base': device.value,")
    replace('                        arrays, checks = {}, []',
            '                        arrays = {\'actual-parameter-\' + str(i): np.frombuffer(bytes(value), dtype=\'u1\')\n'
            '                                  for i, value in enumerate(parameters)}\n'
            '                        checks = []')
    replace('Dim3(4, 1, 1)', 'Dim3(1, 1, 1)')
    replace('cuLaunchKernel(function, 4, 1, 1', 'cuLaunchKernel(function, 1, 1, 1')
    replace('                        operands, sequences, total_atoms = {}, {}, {}',
            "                        operands = {'original': [], 'source': []}\n"
            "                        sequences = {'original': [], 'source': []}\n"
            "                        total_atoms = {}")
    replace("                        for backend in ('original', 'source'):",
            "                        for backend in (() if key == 'rhs' else ('original', 'source')):")
    replace("(64 if key == 'force' else 144)", "(24 if key == 'joint' else 12)")
    replace("'reported_contact_count': count, 'active_contacts': active,",
            "'actual_lane_count': count, 'active_lanes': active,\n"
            "                                     'atomic_probes_executed': key != 'rhs',")
    replace("assert len(rows) == 240", "assert len(rows) == 360")
    replace('All240 two-output packets saved', 'All360 inertial/joint/SO3 packets saved')
    replace('replayed complete two-output packet', 'replayed complete RHS packet')
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
    namespace = {'__name__': 'reconstruction.csrc.al_rhs_replay_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
