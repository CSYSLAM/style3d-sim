"""Read real H1 self-contact allocation bounds and complete static CSR/topology after capture; no graph edits."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_drive_tangent_capture import integer
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import dump_graph

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
output = args.output.resolve()
output.mkdir(exist_ok=False)
calls = []


def probe_self_static(example):
    assert not calls
    assert (example.model.particle_count, example.model.body_count, example.model.joint_dof_count) == (33887, 46, 51)
    dump_graph(example.graph, output / 'graph', json.loads(Path(plan['abi']).read_text()))
    nodes = linear_order(json.loads((output / 'graph/graph.json').read_text()))[0]
    assert len(nodes) == 6120
    vf, ee, ef = (nodes[i] for i in (75, 76, 77))
    assert '22accumulate_vertex_faceE' in vf['name'] and integer(vf, 15) == integer(vf, 16) == 33703
    assert '20accumulate_edge_edgeE' in ee['name'] and integer(ee, 13) == integer(ee, 14) == 100634
    assert '20accumulate_edge_faceE' in ef['name'] and integer(ef, 14) == integer(ef, 15) == 100634
    assert integer(vf, 18) == integer(ee, 16) == integer(ef, 17) == 31
    tangent = integer(vf, 13)
    counter = integer(vf, 14)
    assert tangent == integer(ee, 11) == integer(ef, 12)
    assert counter == integer(ee, 12) == integer(ef, 13)
    driver = ct.CDLL('libcuda.so.1')
    driver.cuMemGetAddressRange_v2.argtypes = [ct.POINTER(ct.c_uint64), ct.POINTER(ct.c_size_t), ct.c_uint64]
    driver.cuMemGetAddressRange_v2.restype = ct.c_int
    driver.cuMemcpyDtoH_v2.argtypes = [ct.c_void_p, ct.c_uint64, ct.c_size_t]
    driver.cuMemcpyDtoH_v2.restype = ct.c_int
    driver.cuCtxSynchronize.argtypes = []
    driver.cuCtxSynchronize.restype = ct.c_int
    assert driver.cuCtxSynchronize() == 0
    ranges, arrays = {}, {}
    import warp as wp
    from warp._src.types import type_size_in_bytes
    logical = []
    for name, array in example.model.__dict__.items():
        if isinstance(array, wp.array) and array.device.is_cuda and array.ptr and array.is_contiguous:
            logical.append({'base': int(array.ptr), 'bytes': array.size * type_size_in_bytes(array.dtype),
                            'label': 'model.' + name})

    def bounds(name, address, size):
        matches = [row for row in logical if row['base'] <= address and address + size <= row['base'] + row['bytes']]
        if matches:
            backing = min(matches, key=lambda row: row['bytes'])
            base_value, capacity_value, provider = backing['base'], backing['bytes'], backing['label']
        else:
            base, capacity = ct.c_uint64(), ct.c_size_t()
            assert driver.cuMemGetAddressRange_v2(ct.byref(base), ct.byref(capacity), address) == 0
            base_value, capacity_value, provider = base.value, capacity.value, 'cuMemGetAddressRange_v2'
        assert base_value <= address and address + size <= base_value + capacity_value
        row = {'address': address, 'logical_bytes': size, 'backing_base': base_value,
               'backing_bytes': capacity_value, 'provider': provider, 'read_bytes': 0}
        ranges[name] = row
        return row

    def read(name, address, size):
        row = bounds(name, address, size)
        data = np.zeros(size, dtype='u1')
        assert driver.cuMemcpyDtoH_v2(ct.c_void_p(data.ctypes.data), address, size) == 0
        row['read_bytes'] = size
        arrays[name] = data
        return data

    offsets = read('opposite-offsets', integer(ee, 2), (100634 + 1) * 4).view('i4')
    assert offsets[0] == 0 and np.all(offsets[1:] >= offsets[:-1])
    opposite_count = int(offsets[-1])
    assert 0 < opposite_count <= 3 * 66930 + 2 * 100634
    read('opposite-vertices', integer(ee, 3), opposite_count * 4)
    read('mesh-vertices', integer(vf, 1), 33703 * 4)
    read('triangles', integer(vf, 3), 66930 * 12)
    read('edges', integer(ee, 1), 100634 * 16)
    actual_counter = int.from_bytes(read('initial-counter', counter, 4).tobytes(), 'little')
    expected_capacity = (33703 + 2 * 100634) * 31
    bounds('tangent-full-reachable-capacity', tangent, expected_capacity * 60)
    candidates = []
    for rank, node in enumerate(nodes[94:110], 94):
        if 'multiply_contact_tangents' in node.get('name', ''):
            assert integer(node, 0) == tangent and integer(node, 1) == counter
            candidates.append({'rank': rank, 'name': node['name'], 'geometry': node['geometry']})
    assert len(candidates) == 1
    assert actual_counter == 0
    np.savez_compressed(output / 'static-topology.npz', **arrays)
    report = {'backend': args.backend, 'opposite_vertices': opposite_count,
              'reachable_tangent_records': expected_capacity, 'reachable_tangent_bytes': expected_capacity * 60,
              'initial_counter': actual_counter, 'ranges': ranges, 'first_CG_tangent_consumer': candidates,
              'graph_nodes_added': 0, 'GPU_allocations_added': 0, 'physics_replays': 0,
              'full_dynamic_self_contact_outputs_not_read': True, 'whole_solver_complete': False}
    (output / 'span-report.json').write_text(json.dumps(report, indent=2) + '\n')
    calls.append(report)


previous = Path(plan['core_build']).parent.parent
worker = previous / 'public-h1-worker.py'
text = worker.read_text()
old = 'ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent'
assert text.count(old) == 1
text = text.replace(old, 'ROOT, BASE = Path.cwd(), asset_manifest_base', 1)
old = '        original_step()\n'
assert text.count(old) == 1
text = text.replace(old, old + '        if not old_graph:\n            probe_self_static(example)\n', 1)
patched = output / 'worker-as-run.py'
patched.write_text(text)
sys.argv = [str(patched), '--backend', args.backend, '--core-build', plan['core_build'],
            '--output', str(output / 'worker'), '--frames', '1']
exec(compile(text, str(patched), 'exec'), {'__name__': '__main__', '__file__': str(patched),
     'asset_manifest_base': previous, 'probe_self_static': probe_self_static})
assert len(calls) == 1
print('Actual bounded self CSR/tangent spans checked:', args.backend, calls[0]['opposite_vertices'], flush=True)
