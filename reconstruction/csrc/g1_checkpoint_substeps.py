"""Trace the six real G1 substeps from the fixed shared public checkpoint without changing solver arithmetic."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

from . import g1_contact_rhs_capture as transport
from . import g1_checkpoint_restart as checkpoint


TRANSPORT_SHA = '47f6a70d1bf2ac9aebf7dfaf4a1342265114672b49300c1603535abe825cf21e'
CHECKPOINT_SHA = 'df6e1f2893094a0349e7b06b8b1284ffd6bfd1bcbcdc96978a16f6a6a440e013'
SELECTION = '''def select_stages(nodes, body_count, dof_count):
    starts = [i for i, n in enumerate(nodes) if '15initialize_stepE' in n.get('name', '')]
    assert len(nodes) == 17467 and starts == [17 + 2910 * i for i in range(6)]
    assert body_count == 44 and dof_count == 49
    result = []
    for substep, start in enumerate(starts):
        stop = starts[substep + 1] if substep < 5 else len(nodes)
        for kind, token in STAGES.items():
            matches = [i for i in range(start, stop) if token in nodes[i].get('name', '')]
            assert len(matches) == (5 if kind == 'drive' else 1)
            rank = matches[0]
            node = nodes[rank]
            assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            if kind == 'drive':
                assert rank == start + 14 and node['parameter_widths'] == [8] * 32 + [4]
                assert [integer(node, i) for i in range(27, 32)] == [43, 43, 176, 49, 49]
                sizes = {0: 2112, 1: 2112, 2: 172, 3: 172, 4: 172, 5: 704, 6: 172, 7: 344,
                         **{i: 516 for i in (8, 9, 10)}, **{i: 688 for i in range(11, 16)},
                         16: 172, 17: 172, **{i: 196 for i in range(18, 26)}, 26: 2112}
                outputs = [3, 4, 26]
            elif kind == 'velocity':
                assert rank == start + 2895 and node['parameter_widths'] == [4, 8, 8, 8, 8]
                assert integer(node, 0) == 0x43b40000 and integer(node, 4) == 176
                sizes, outputs = {1: 2112, 2: 2112, 3: 2112}, [3]
            else:
                assert kind == 'angle' and rank == start + 2896
                assert node['parameter_widths'] == [8] * 17
                assert [integer(node, i) for i in (14, 15, 16)] == [43, 43, 176]
                sizes = {0: 2112, 1: 172, 2: 172, 3: 704, 4: 172, 5: 344,
                         **{i: 516 for i in (6, 7, 8)}, **{i: 688 for i in range(9, 14)}}
                outputs = [1, 2]
            pointers = {i for i, t in enumerate(parameter_types(node['name'])) if '*' in t and integer(node, i)}
            assert set(sizes) == pointers
            for a in outputs:
                for b in sizes:
                    if a != b:
                        assert min(integer(node, a) + sizes[a], integer(node, b) + sizes[b]) <= max(
                            integer(node, a), integer(node, b)), 'Writable output aliases another argument'
            result.append({'key': kind + str(substep), 'kernel_key': kind, 'substep': substep,
                           'rank': rank, 'node': node, 'sizes': dict(sorted(sizes.items())),
                           'outputs': outputs, 'output_overlaps': []})
    assert [s['rank'] for s in result] == sorted(s['rank'] for s in result)
    return result
'''


def rendered_transport():
    assert hashlib.sha256(Path(transport.__file__).read_bytes()).hexdigest() == TRANSPORT_SHA
    text = Path(transport.__file__).read_text()

    def replace(old, new):
        nonlocal text
        assert text.count(old) == 1, (old, text.count(old))
        text = text.replace(old, new)

    replace("STAGES = {'force': '22evaluate_contact_forceE', 'matrix': '24evaluate_contact_tangentE'}",
            "STAGES = {'drive': '25evaluate_joint_drive_loadE', 'velocity': '15update_velocityE',\n"
            "          'angle': '30update_joint_drive_angle_stateE'}")
    start, end = text.index('def select_stages('), text.index('\n\nclass Observer(')
    text = text[:start] + SELECTION.rstrip() + text[end:]
    replace('        for key in STAGES:\n',
            '        for key in [kind + str(i) for i in range(6) for kind in STAGES]:\n')
    replace('        for stage in stages:\n            rank, node = stage[\'rank\'], stage[\'node\']',
            '        last_after = {}\n        for stage in stages:\n'
            '            rank, node = stage[\'rank\'], stage[\'node\']')
    # Adjacent velocity/angle calls must share one snapshot chain, preserving a unique graph order.
    replace("            previous = ct.c_void_p(nodes[rank - 1]['handle'])",
            "            previous = last_after.get(rank - 1, ct.c_void_p(nodes[rank - 1]['handle']))")
    replace("            following = ct.c_void_p(nodes[rank + 1]['handle'])",
            "            last_after[rank] = previous\n            following = ct.c_void_p(nodes[rank + 1]['handle'])")
    return text


def rendered_worker():
    assert hashlib.sha256(Path(checkpoint.__file__).read_bytes()).hexdigest() == CHECKPOINT_SHA
    text = checkpoint.rendered_worker()
    anchor = '                    records[key].append(array.numpy().copy())\n'
    assert text.count(anchor) == 1
    return text.replace(anchor, anchor + '            checkpoint_hook.observer.record()\n')


class TraceHook(checkpoint.CheckpointHook):
    def __init__(self, plan, output, observer):
        super().__init__(plan, output)
        self.observer = observer

    def install(self, example):
        super().install(example)
        self.observer.attach(example)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--plan', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    plan = json.loads(args.plan.read_text())
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    trace = output / 'trace'
    trace.mkdir()
    code = rendered_transport()
    assert hashlib.sha256(code.encode()).hexdigest() == plan['transport_sha256']
    script = output / 'transport-as-run.py'
    script.write_text(code)
    namespace = {'__name__': 'reconstruction.csrc.substep_transport_as_run',
                 '__package__': 'reconstruction.csrc', '__file__': str(script)}
    exec(compile(code, str(script), 'exec'), namespace)
    observer = namespace['Observer'](trace, json.loads(Path(plan['abi']).read_text()))
    hook = TraceHook(plan, output, observer)
    text = rendered_worker()
    assert hashlib.sha256(text.encode()).hexdigest() == plan['patched_worker_sha256']
    script = output / 'worker-as-run.py'
    script.write_text(text)
    sys.argv = [str(script), '--backend', args.backend, '--core-build', plan['core_build'],
                '--example', str(checkpoint.ROOT / 'examples/example_robot_g1.py'), '--frames', '1',
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(text, str(script), 'exec'), {'__name__': '__main__', '__package__': 'reconstruction.csrc',
                                               '__file__': str(script), 'checkpoint_hook': hook})
        assert observer.frames == 1
    finally:
        observer.close()
        (output / 'trace-provenance.json').write_text(json.dumps({
            'frames_read': observer.frames, 'transport_sha256': hashlib.sha256(code.encode()).hexdigest(),
            'patched_worker_sha256': hashlib.sha256(text.encode()).hexdigest(),
            'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'diagnostic_snapshots_may_change_atomic_schedule': True,
            'original_demo_end_tests_unchanged_but_velocity_helper_bug_retained': True,
            'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')


if __name__ == '__main__':
    main()
