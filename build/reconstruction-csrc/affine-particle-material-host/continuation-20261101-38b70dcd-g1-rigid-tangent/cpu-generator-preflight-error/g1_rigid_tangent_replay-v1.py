"""Specialize the verified same-buffer replay for all captured G1 rigid-contact tangent inputs."""
import argparse
import hashlib
from pathlib import Path

from .demo_source_ab import ROOT


TEMPLATE_SHA = '152e416ee5596ecd30fbbd2f208ca677d7dbb7a8d54a89e1810e756d6a9a2c7c'


def rendered_source():
    path = ROOT / 'reconstruction/csrc/g1_drive_tangent_replay.py'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == TEMPLATE_SHA
    text = path.read_text()

    def replace(old, new, count=1):
        nonlocal text
        assert text.count(old) == count, (old, text.count(old))
        text = text.replace(old, new)

    replace('authentic G1 drive-tangent packets', 'authentic G1 rigid-tangent packets')
    replace('from .g1_drive_tangent_capture import TOKEN', 'from .g1_rigid_tangent_capture import TOKEN')
    replace('assert sites == 72', 'assert sites == 75')
    replace("node['geometry'] == [1, 1, 1, 256, 1, 1, 0]", "node['geometry'] == [4, 1, 1, 256, 1, 1, 0]")
    replace('for index in range(22)', 'for index in range(35)')
    replace("packet['after-arg-18']", "packet['after-arg-30']")
    replace('index != 18', 'index != 30')
    replace('index == 18', 'index == 30')
    replace('values[18]', 'values[30]', 3)
    replace('pointers[18]', 'pointers[30]', 6)
    replace('bindings[18]', 'bindings[30]')
    replace('runtime_launch(function, Dim3(1, 1, 1)', 'runtime_launch(function, Dim3(4, 1, 1)')
    replace('cuLaunchKernel(function, 1, 1, 1, 256', 'cuLaunchKernel(function, 4, 1, 1, 256')
    replace('np.zeros((256, 128, 16)', 'np.zeros((1024, 128, 16)')
    replace("np.zeros(256, dtype='u4')", "np.zeros(1024, dtype='u4')")
    replace('not actual_counts[43:].any()', 'not actual_counts[active:].any()')
    anchor = "                    expected = packet['after-arg-30'].tobytes()\n"
    replace(anchor, anchor + "                    contact_count = int.from_bytes(bindings[0], 'little', signed=True)\n"
            "                    active = min(max(contact_count, 0), values[1])\n"
            "                    assert values[1] == 1000 and values[33] == values[34] == 0\n")
    replace("rows.append({'side': side, 'frame': frame, 'spans': spans, 'checks': checks,",
            "rows.append({'side': side, 'frame': frame, 'spans': spans, 'checks': checks,\n"
            "                                 'reported_contact_count': contact_count, 'active_contacts': active,")
    text = text.replace('drive tangent frame', 'rigid tangent frame').replace(
        'Drive tangent real per-thread/target operands', 'Rigid tangent real per-thread/target operands')
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
    namespace = {'__name__': 'reconstruction.csrc.rigid_replay_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(script.read_bytes(), str(script), 'exec'), namespace)
    namespace['main']()


if __name__ == '__main__':
    main()
