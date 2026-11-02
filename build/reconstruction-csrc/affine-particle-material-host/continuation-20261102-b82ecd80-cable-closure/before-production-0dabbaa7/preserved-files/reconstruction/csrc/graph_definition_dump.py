"""Query existing CUDA graphs without launching work, changing nodes or reading device pointees."""
import ctypes as ct
import hashlib
import json
from pathlib import Path

from .capture_cloth_graph_parameters import KernelParams
from .demo_source_ab import ROOT


class Copy3D(ct.Structure):
    _fields_ = []
    for prefix in ('src', 'dst'):
        for label in ('XInBytes', 'Y', 'Z', 'LOD'):
            _fields_.append((prefix + label, ct.c_size_t))
        _fields_ += [(prefix + 'MemoryType', ct.c_int), (prefix + 'Host', ct.c_void_p),
                    (prefix + 'Device', ct.c_uint64), (prefix + 'Array', ct.c_void_p),
                    ('reserved0' if prefix == 'src' else 'reserved1', ct.c_void_p),
                    (prefix + 'Pitch', ct.c_size_t), (prefix + 'Height', ct.c_size_t)]
    _fields_ += [('WidthInBytes', ct.c_size_t), ('Height', ct.c_size_t), ('Depth', ct.c_size_t)]


class Memset(ct.Structure):
    _fields_ = [('dst', ct.c_uint64), ('pitch', ct.c_size_t), ('value', ct.c_uint),
                ('elementSize', ct.c_uint), ('width', ct.c_size_t), ('height', ct.c_size_t)]


class HostParams(ct.Structure):
    _fields_ = [('function', ct.c_void_p), ('user_data', ct.c_void_p)]


def dump_graph(graph, output, abi):
    output = Path(output)
    output.mkdir(parents=True, exist_ok=False)
    assert ct.sizeof(KernelParams) == abi['kernel_size'] == 56
    assert ct.sizeof(Copy3D) == abi['copy_size'] and ct.sizeof(Memset) == abi['memset_size']
    assert ct.sizeof(HostParams) == abi['host_size']
    for name, kind in (('kernel', KernelParams), ('copy', Copy3D), ('memset', Memset), ('host', HostParams)):
        for field, offset in abi[name + '_offsets'].items():
            assert getattr(kind, field).offset == offset, (name, field)
    driver = ct.CDLL('libcuda.so.1')
    api = {
        'cuGraphGetNodes': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
        'cuGraphGetEdges': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
        'cuGraphNodeGetType': [ct.c_void_p, ct.POINTER(ct.c_int)],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuGraphMemcpyNodeGetParams': [ct.c_void_p, ct.POINTER(Copy3D)],
        'cuGraphMemsetNodeGetParams': [ct.c_void_p, ct.POINTER(Memset)],
        'cuGraphHostNodeGetParams': [ct.c_void_p, ct.POINTER(HostParams)],
        'cuGraphChildGraphNodeGetGraph': [ct.c_void_p, ct.POINTER(ct.c_void_p)],
        'cuGraphEventRecordNodeGetEvent': [ct.c_void_p, ct.POINTER(ct.c_void_p)],
        'cuGraphEventWaitNodeGetEvent': [ct.c_void_p, ct.POINTER(ct.c_void_p)],
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuFuncGetAttribute': [ct.POINTER(ct.c_int), ct.c_int, ct.c_void_p],
        'cuFuncGetParamInfo': [ct.c_void_p, ct.c_size_t, ct.POINTER(ct.c_size_t), ct.POINTER(ct.c_size_t)],
    }
    for name, arguments in api.items():
        getattr(driver, name).argtypes = arguments
        getattr(driver, name).restype = ct.c_int
    build_file = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    manifest = json.loads(build_file.read_text())
    functions = {}

    def checked(name, *args):
        code = getattr(driver, name)(*args)
        if code:
            raise RuntimeError(f'{name} failed with CUDA status {code}')

    def structure(value):
        return {name: int(getattr(value, name) or 0) for name, _ in value._fields_}

    def function_info(function):
        if function not in functions:
            name = ct.c_char_p()
            checked('cuFuncGetName', ct.byref(name), function)
            offsets, sizes = [], []
            for index in range(1024):
                offset, size = ct.c_size_t(), ct.c_size_t()
                code = driver.cuFuncGetParamInfo(function, index, ct.byref(offset), ct.byref(size))
                if code == 1:
                    break
                if code:
                    raise RuntimeError(f'cuFuncGetParamInfo failed with CUDA status {code}')
                assert size.value and (not offsets or offset.value >= offsets[-1] + sizes[-1])
                offsets.append(offset.value)
                sizes.append(size.value)
            else:
                raise RuntimeError('No terminating invalid parameter index was observed')
            name = name.value.decode()
            if name in manifest['kernels']:
                assert sizes == manifest['kernels'][name]['parameters'], name
            attributes = {}
            for field, attribute in (('max_threads', 0), ('registers', 4), ('local_bytes', 3), ('shared_bytes', 1)):
                value = ct.c_int()
                checked('cuFuncGetAttribute', ct.byref(value), attribute, function)
                attributes[field] = value.value
            functions[function] = (name, offsets, sizes, attributes)
        return functions[function]

    def inspect(handle, directory):
        directory.mkdir(parents=True, exist_ok=True)
        checked('cuGraphDebugDotPrint', handle, str(directory / 'graph.dot').encode(), 1)
        count = ct.c_size_t()
        checked('cuGraphGetNodes', handle, None, ct.byref(count))
        handles = (ct.c_void_p * count.value)()
        checked('cuGraphGetNodes', handle, handles, ct.byref(count))
        edge_count = ct.c_size_t()
        checked('cuGraphGetEdges', handle, None, None, ct.byref(edge_count))
        left, right = (ct.c_void_p * edge_count.value)(), (ct.c_void_p * edge_count.value)()
        checked('cuGraphGetEdges', handle, left, right, ct.byref(edge_count))
        nodes = []
        unknown = []
        for index, node_handle in enumerate(handles):
            kind = ct.c_int()
            checked('cuGraphNodeGetType', node_handle, ct.byref(kind))
            node = {'handle': int(node_handle), 'type': kind.value}
            if kind.value == 0:
                params = KernelParams()
                checked('cuGraphKernelNodeGetParams', node_handle, ct.byref(params))
                name, offsets, widths, attributes = function_info(params.func)
                node.update(name=name, geometry=[params.gx, params.gy, params.gz, params.bx, params.by,
                                                params.bz, params.shared], attributes=attributes)
                assert (params.params or not widths) and not params.extra
                node['parameter_offsets'] = offsets
                node['parameter_widths'] = widths
                node['parameter_hex'] = [ct.string_at(params.params[i], width).hex()
                                         for i, width in enumerate(widths)]
                node['owned_kernel'] = name in manifest['kernels']
            elif kind.value in (1, 2, 3):
                params = {1: Copy3D, 2: Memset, 3: HostParams}[kind.value]()
                checked({1: 'cuGraphMemcpyNodeGetParams', 2: 'cuGraphMemsetNodeGetParams',
                         3: 'cuGraphHostNodeGetParams'}[kind.value], node_handle, ct.byref(params))
                node['parameters'] = structure(params)
            elif kind.value == 4:
                child = ct.c_void_p()
                checked('cuGraphChildGraphNodeGetGraph', node_handle, ct.byref(child))
                node['child'] = inspect(child, directory / ('child-' + str(index)))
            elif kind.value in (6, 7):
                event = ct.c_void_p()
                checked('cuGraphEventWaitNodeGetEvent' if kind.value == 6 else 'cuGraphEventRecordNodeGetEvent',
                        node_handle, ct.byref(event))
                node['event'] = event.value
            elif kind.value != 5:
                unknown.append({'handle': int(node_handle), 'type': kind.value})
            nodes.append(node)
        edges = [[int(a), int(b)] for a, b in zip(left, right)]
        known = {node['handle'] for node in nodes}
        assert len(known) == len(nodes) and all(a in known and b in known for a, b in edges)
        return {'nodes': nodes, 'edges': edges, 'unknown_node_details': unknown}

    result = inspect(graph.graph, output)
    result.update(source_host_sha256=manifest['extension_sha256'],
                  build_sha256=hashlib.sha256(build_file.read_bytes()).hexdigest(),
                  runner_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  GPU_allocations_added=0, graph_nodes_changed=False, device_pointees_read=False,
                  nonowned_kernel_parameters_captured=True, whole_solver_complete=False)
    (output / 'graph.json').write_text(json.dumps(result, indent=2) + '\n')
    return {'nodes': len(result['nodes']), 'edges': len(result['edges']),
            'unknown_node_details': len(result['unknown_node_details'])}
