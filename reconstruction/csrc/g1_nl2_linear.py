"""Capture/replay complete fourth-substep NL2 RHS, aliased inverse and first/last CG vector calls."""
import argparse
import hashlib
import json
from pathlib import Path
from pprint import pformat
import sys

from . import g1_checkpoint_substeps as capture
from . import g1_checkpoint_substeps_replay as replay


CAPTURE_SHA = 'b1d4abbd575245959ef31d2a0f752f691bf1d3f1460afadb51522f2ccb116bc1'
REPLAY_SHA = '94f812ade28ebf9ed5a19eb54576735131e4c95835471fafa27f65551c49739f'
BASE_TRANSPORT = capture.rendered_transport
TOKENS = {
    'rhs': '14initialize_rhsE', 'inverse': '27invert_block_preconditionerE',
    'precondition_first': '23precondition_and_reduceI', 'direction_first': '19update_cg_directionE',
    'matrix_first': '26multiply_matrix_and_reduceI', 'update_first': '28update_solution_and_residualE',
    'precondition_last': '23precondition_and_reduceI', 'direction_last': '19update_cg_directionE',
    'matrix_last': '26multiply_matrix_and_reduceI', 'update_last': '28update_solution_and_residualE',
}
SELECTION = '''def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 17467 and body_count == 44 and dof_count == 49
    result = []
    for key, token in STAGES.items():
        matches = [i for i in range(9329, 9905) if token in nodes[i].get('name', '')]
        assert len(matches) == (1 if key in ('rhs', 'inverse') else 50)
        rank = matches[-1] if key.endswith('_last') else matches[0]
        node = nodes[rank]
        kind = key.split('_', 1)[0]
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        if kind == 'rhs':
            assert rank == 9332 and node['parameter_widths'] == [4] + [8] * 11
            assert [integer(node, i) for i in (6, 10, 11)] == [19, 176, 176]
            sizes = {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112}
            outputs = [9]
        elif kind == 'inverse':
            assert rank == 9350 and node['parameter_widths'] == [8] * 6
            assert integer(node, 4) == integer(node, 5) == 176 and integer(node, 0) == integer(node, 3)
            sizes, outputs = {0: 6336, 1: 704, 2: 704, 3: 6336}, [3]
        elif kind == 'precondition':
            assert node['parameter_widths'] == [8, 8, 8, 1, 8, 4, 8, 8]
            assert integer(node, 3) == integer(node, 4) == 0 and integer(node, 5) == integer(node, 7) == 176
            sizes, outputs = {0: 6336, 1: 2112, 2: 2112, 6: 4}, [2, 6]
        elif kind == 'direction':
            assert node['parameter_widths'] == [4, 8, 8, 4, 8, 8, 8, 8]
            assert integer(node, 0) == (49 if key.endswith('_last') else 0)
            assert integer(node, 2) == 0 and integer(node, 3) == integer(node, 7) == 176
            assert bool(integer(node, 5)) == key.endswith('_last')
            sizes, outputs = {1: 2112, 4: 4, 6: 2112}, [6]
            if integer(node, 5):
                sizes[5] = 4
        elif kind == 'matrix':
            assert node['parameter_widths'] == [8] * 8 + [4] + [8] * 3
            assert integer(node, 2) == 19 and integer(node, 7) == 0
            assert [integer(node, i) for i in (8, 10, 11)] == [176, 176, 176]
            sizes, outputs = {0: 704, 1: 133760, 3: 6336, 4: 2112, 5: 2112, 6: 2112, 9: 4}, [6, 9]
        else:
            assert kind == 'update' and node['parameter_widths'] == [8, 4, 8, 8, 8, 8, 8, 8, 8]
            assert integer(node, 0) == 0 and integer(node, 1) == integer(node, 8) == 176
            sizes, outputs = {2: 4, 3: 4, 4: 2112, 5: 2112, 6: 2112, 7: 2112}, [6, 7]
        pointers = {i for i, t in enumerate(parameter_types(node['name'])) if '*' in t and integer(node, i)}
        assert set(sizes) == pointers
        overlaps = []
        for a in outputs:
            for b in sizes:
                if a == b:
                    continue
                start, end = max(integer(node, a), integer(node, b)), min(
                    integer(node, a) + sizes[a], integer(node, b) + sizes[b])
                if start < end:
                    assert kind == 'inverse' and {a, b} == {0, 3} and end - start == 6336
                    overlaps.append({'arguments': [a, b], 'overlap_bytes': end - start})
        result.append({'key': key, 'kernel_key': key, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': overlaps})
    assert [s['rank'] for s in result] == [9332, 9350, 9355, 9356, 9364, 9365, 9894, 9895, 9903, 9904]
    return result
'''


def rendered_transport():
    assert hashlib.sha256(Path(capture.__file__).read_bytes()).hexdigest() == CAPTURE_SHA
    text = BASE_TRANSPORT()
    old = ("STAGES = {'drive': '25evaluate_joint_drive_loadE', 'velocity': '15update_velocityE',\n"
           "          'angle': '30update_joint_drive_angle_stateE'}")
    assert text.count(old) == 1
    text = text.replace(old, 'STAGES = ' + pformat(TOKENS, width=112, sort_dicts=False))
    start, end = text.index('def select_stages('), text.index('\n\nclass Observer(')
    text = text[:start] + SELECTION.rstrip() + text[end:]
    replacements = {
        '        for key in [kind + str(i) for i in range(6) for kind in STAGES]:\n': '        for key in STAGES:\n',
        "            'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.c_size_t],":
            "            'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), "
            "ct.POINTER(ct.c_void_p), ct.c_size_t],\n"
            "            'cuGraphMemcpyNodeGetParams': [ct.c_void_p, ct.POINTER(Copy3D)],",
        "            snapshots.append({'stage': stage['key'], 'phase': phase, 'argument': argument, 'source': address,":
            "            actual = Copy3D()\n"
            "            self.checked('cuGraphMemcpyNodeGetParams', handle, ct.byref(actual))\n"
            "            assert actual.srcMemoryType == actual.dstMemoryType == 2\n"
            "            assert actual.srcDevice == address and actual.dstDevice == self.device.value + offset\n"
            "            assert (actual.WidthInBytes, actual.Height, actual.Depth) == (size, 1, 1)\n"
            "            snapshots.append({'actual_copy_parameters_hex': bytes(actual).hex(),\n"
            "                              'stage': stage['key'], 'phase': phase, 'argument': argument, 'source': address,",
        "        self.layout = {'stages': stages, 'snapshots': snapshots, 'total_snapshot_bytes': self.bytes,":
            "        self.layout = {'device_base': self.device.value, 'model_map_source': model_map_source,\n"
            "                       'stages': stages,\n"
            "                       'snapshots': snapshots, 'total_snapshot_bytes': self.bytes,",
        '        assert context.value\n':
            "        assert context.value\n"
            "        assert '32initialize_affine_body_so3_stateE' in nodes[8750]['name']\n"
            "        model_map_source = integer(nodes[8750], 1)\n"
            "        model_map = ct.create_string_buffer(704)\n"
            "        self.checked('cuMemcpyDtoH_v2', model_map, ct.c_uint64(model_map_source), 704)\n"
            "        (self.output / 'model-body-indices.bin').write_bytes(model_map.raw)\n",
    }
    for old, new in replacements.items():
        assert text.count(old) == 1, (old, text.count(old))
        text = text.replace(old, new)
    return text


def rendered_replay():
    assert hashlib.sha256(Path(replay.__file__).read_bytes()).hexdigest() == REPLAY_SHA
    text = Path(replay.__file__).read_text()
    replacements = {
        "assert len(layout['stages']) == 18": "assert len(layout['stages']) == 10",
        'if len(rows) % 18 == 0:': 'if len(rows) % 10 == 0:',
        "'all18 real substep calls'": "'all10 actual NL2 linear calls'",
        'assert len(rows) == 198': 'assert len(rows) == 20',
        "report['actual_calls'] == 594": "report['actual_calls'] == 60",
        "counts['packets'] == 198 and counts['complete_output_arrays'] == 1188":
            "counts['packets'] == 20 and counts['complete_output_arrays'] == 96",
    }
    for old, new in replacements.items():
        assert text.count(old) == 1, (old, text.count(old))
        text = text.replace(old, new)
    return text


def main():
    if '--replay' in sys.argv or '--audit' in sys.argv:
        parser = argparse.ArgumentParser(description=__doc__)
        parser.add_argument('--phase', type=Path, required=True)
        parser.add_argument('--replay', action='store_true')
        parser.add_argument('--audit', action='store_true')
        args = parser.parse_args()
        assert args.replay != args.audit
        phase, text = args.phase.resolve(), rendered_replay()
        path = phase / 'replay-as-run.py'
        if path.exists():
            assert path.read_text() == text
        else:
            assert args.replay
            path.write_text(text)
        namespace = {'__name__': 'reconstruction.csrc.nl2_linear_replay_as_run',
                     '__package__': 'reconstruction.csrc', '__file__': str(path)}
        exec(compile(text, str(path), 'exec'), namespace)
        namespace['audit' if args.audit else 'replay'](phase)
        return
    output = Path(sys.argv[sys.argv.index('--output') + 1]).resolve()
    capture.rendered_transport = rendered_transport
    try:
        capture.main()
    finally:
        path = output / 'trace-provenance.json'
        if path.exists():
            data = json.loads(path.read_text())
            data['outer_nl2_linear_wrapper_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
            path.write_text(json.dumps(data, indent=2) + '\n')


if __name__ == '__main__':
    main()
