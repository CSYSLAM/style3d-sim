"""Read final G1 matrix inputs/output after the existing frame downloads; never change graph nodes or allocate GPU data."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

from .capture_cloth_graph_parameters import KernelParams
from .demo_source_ab import ROOT
from .graph_definition_compare import linear_order
from .graph_definition_dump import dump_graph


TOKEN = '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry'


def integer(node, index):
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][index]), 'little')


class Observer:
    def __init__(self, output, abi, proof, warp_schema):
        self.output, self.abi, self.proof, self.warp_schema = output, abi, proof, warp_schema
        self.frame = 0
        self.driver = None
        self.packet_directory = output / 'packets'
        self.packet_directory.mkdir(exist_ok=False)

    def checked(self, name, *arguments):
        result = getattr(self.driver, name)(*arguments)
        if result:
            raise RuntimeError(f'{name} returned CUDA status {result}')

    def configure(self, graph):
        dump_graph(graph, self.output / 'definition', self.abi)
        definition = json.loads((self.output / 'definition/graph.json').read_text())
        self.prepare(definition)

    def prepare(self, definition):
        nodes = linear_order(definition)[0]
        rank = max(index for index, node in enumerate(nodes) if TOKEN in node.get('name', ''))
        matrix = nodes[rank]
        self.matrix = matrix
        n, rows, maximum = integer(matrix, 10), integer(matrix, 11), integer(matrix, 2)
        per_world = integer(matrix, 8)
        assert 0 < n <= 1000000 and rows == n and per_world == n and maximum > 0
        assert integer(matrix, 7) == 0, 'The selected G1 case uses one implicit coefficient world'
        self.sizes = {0: rows * 4, 1: rows * maximum * 40, 3: n * 36, 4: n * 12,
                      5: n * 12, 6: n * 12, 9: 4}
        assert all(integer(matrix, index) for index in self.sizes)
        spans = {index: (integer(matrix, index), integer(matrix, index) + size)
                 for index, size in self.sizes.items()}
        for output in (6, 9):
            for index in spans:
                if index == output:
                    continue
                assert min(spans[output][1], spans[index][1]) <= max(spans[output][0], spans[index][0]), (output, index)
        self.driver = ct.CDLL('libcuda.so.1')
        for name, arguments in {
                'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
                'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)]}.items():
            getattr(self.driver, name).argtypes = arguments
            getattr(self.driver, name).restype = ct.c_int
        writers = []

        def add_writer(node_rank, node, index, offset, size):
            raw = bytes.fromhex(node['parameter_hex'][index])
            address = int.from_bytes(raw[offset:offset + 8], 'little')
            if address and size:
                writers.append({'rank': node_rank, 'name': node['name'], 'argument': index, 'field_offset': offset,
                                'address': address, 'bytes': size})

        for node_rank, node in enumerate(nodes[rank + 1:], rank + 1):
            if node['type'] == 1:
                value = node['parameters']
                assert value['Height'] == value['Depth'] == 1 and value['dstMemoryType'] == 2
                assert value['dstXInBytes'] == value['dstY'] == value['dstZ'] == 0
                writers.append({'rank': node_rank, 'name': 'D2D', 'address': value['dstDevice'],
                                'bytes': value['WidthInBytes']})
                continue
            if node['type'] == 2:
                value = node['parameters']
                assert value['height'] == 1
                writers.append({'rank': node_rank, 'name': 'fill', 'address': value['dst'],
                                'bytes': value['elementSize'] * value['width']})
                continue
            assert node['type'] == 0
            proof = self.proof['kernels'][node['name']]
            roots = proof['original']['potential_written_pointer_fields']
            if node['owned_kernel']:
                assert roots == proof['source']['potential_written_pointer_fields']
                if '28update_solution_and_residual' in node['name']:
                    assert integer(node, 8) == n
                    sizes = {6: n * 12, 7: n * 12}
                elif '20apply_nonlinear_step' in node['name']:
                    assert integer(node, 3) == n
                    sizes = {1: n * 12, 2: n * 12}
                elif '49update_affine_body_so3' in node['name']:
                    count = integer(node, 5)
                    sizes = {2: count * 36, 3: count * 36}
                elif '15update_velocity' in node['name']:
                    assert integer(node, 4) == n
                    sizes = {3: n * 12}
                elif '30update_joint_drive_angle_state' in node['name']:
                    count = integer(node, 14)
                    sizes = {1: count * 4, 2: count * 4}
                else:
                    raise ValueError('Unrecognized tail kernel ' + node['name'])
                assert roots == [[index, 0] for index in sorted(sizes)]
                for index, size in sizes.items():
                    add_writer(node_rank, node, index, 0, size)
            else:
                for index, offset in roots:
                    spec = self.warp_schema['kernels'][node['name']][index]
                    assert spec['cpp_type'].startswith('wp::array_t<') and offset == 0 and spec['width'] == 56
                    raw = bytes.fromhex(node['parameter_hex'][index])
                    ndim = int.from_bytes(raw[48:50], 'little')
                    assert ndim == 1
                    count = int.from_bytes(raw[16:20], 'little', signed=True)
                    stride = int.from_bytes(raw[32:36], 'little', signed=True)
                    assert count >= 0 and stride > 0
                    add_writer(node_rank, node, index, offset, count * stride)
        for writer in writers:
            start, end = writer['address'], writer['address'] + writer['bytes']
            for index, (left, right) in spans.items():
                assert min(end, right) <= max(start, left), ('Later writer overlaps saved matrix field', writer, index)
        matrix_writes = self.proof['kernels'][matrix['name']]
        assert matrix_writes['original']['potential_written_pointer_fields'] == [[6, 0], [9, 0]]
        assert matrix_writes['source']['potential_written_pointer_fields'] == [[6, 0], [9, 0]]
        self.layout = {'matrix_rank': rank, 'matrix': matrix, 'sizes': self.sizes,
                       'tail_potential_writers': writers, 'post_frame_inputs_and_outputs_not_overwritten_by_tail': True,
                       'matrix_outputs_do_not_overlap_read_inputs': True,
                       'input_indices': [0, 1, 3, 4, 5], 'output_indices': [6, 9],
                       'actual_pre_call_output_bytes_captured': False,
                       'replay_denominator_seed': 'controlled zero; not an observed pre-call value',
                       'GPU_allocations_added': 0, 'graph_nodes_changed': False,
                       'whole_solver_complete': False}
        (self.output / 'readback-layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')

    def record(self, graph):
        if self.driver is None:
            self.configure(graph)
        params = KernelParams()
        self.checked('cuGraphKernelNodeGetParams', self.matrix['handle'], ct.byref(params))
        widths = self.matrix['parameter_widths']
        raw = [ct.string_at(params.params[index], size) for index, size in enumerate(widths)]
        assert [value.hex() for value in raw] == self.matrix['parameter_hex']
        assert [params.gx, params.gy, params.gz, params.bx, params.by, params.bz, params.shared] == self.matrix['geometry']
        arrays = {'parameter-' + str(index): np.frombuffer(value, dtype='u1') for index, value in enumerate(raw)}
        for index, size in self.sizes.items():
            payload = ct.create_string_buffer(size)
            self.checked('cuMemcpyDtoH_v2', payload, integer(self.matrix, index), size)
            arrays['post-frame-arg-' + str(index)] = np.frombuffer(payload.raw, dtype='u1').copy()
        np.savez_compressed(self.packet_directory / ('frame-' + str(self.frame).zfill(2) + '.npz'), **arrays)
        self.frame += 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--proof', type=Path, required=True)
    parser.add_argument('--abi', type=Path, required=True)
    parser.add_argument('--warp-schema', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    proof = json.loads(args.proof.read_text())
    analysis = ROOT / 'reconstruction/csrc/ptx_store_origins.py'
    assert proof['analysis_sha256'] == hashlib.sha256(analysis.read_bytes()).hexdigest()
    bundle = ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h'
    assert proof['source_ptx_bundle_sha256'] == hashlib.sha256(bundle.read_bytes()).hexdigest()
    observer = Observer(output, json.loads(args.abi.read_text()), proof, json.loads(args.warp_schema.read_text()))
    runner = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                     'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                     'official-g1-public-core-graph60/worker-as-run.py')
    text = runner.read_text()
    anchor = '                    records[key].append(array.numpy().copy())\n'
    assert text.count(anchor) == 1
    text = text.replace(anchor, anchor + '            matrix_observer.record(example.graph)\n')
    patched = output / 'worker-as-run.py'
    patched.write_text(text)
    provenance = {'base_worker_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
                  'patched_worker_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
                  'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  'proof_sha256': hashlib.sha256(args.proof.read_bytes()).hexdigest(),
                  'frames': args.frames, 'frames_read': 0, 'complete': False,
                  'queries_only_after_existing_frame_state_downloads': True,
                  'readbacks_can_affect_later_atomic_schedule': True,
                  'replaces_frozen_candidate': False, 'whole_solver_complete': False}
    sys.argv = [str(patched), '--backend', args.backend, '--core-build',
                str(ROOT / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'),
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', str(args.frames),
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(text, str(patched), 'exec'),
             {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(patched),
              'matrix_observer': observer})
        assert observer.frame == args.frames
        provenance['complete'] = True
    finally:
        provenance['frames_read'] = observer.frame
        (output / 'provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')


if __name__ == '__main__':
    main()
