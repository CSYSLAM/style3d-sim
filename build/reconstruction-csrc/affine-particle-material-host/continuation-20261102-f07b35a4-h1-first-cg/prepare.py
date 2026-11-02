"""Freeze actual H1 first-NL layouts and render a bounded complete-input observer before starting GPU work."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.h1_first_cg_layout import select_stages

previous = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
historical = BASE.parent / 'continuation-20261102-d09d4be9-g1-fourth-five-nl'
transport_path = historical / 'transport-template.py'
manifest = json.loads((historical / 'completion-manifest.json').read_text())
assert hashlib.sha256(transport_path.read_bytes()).hexdigest() == \
    manifest['files'][str(transport_path.relative_to(ROOT))]['sha256']
text = transport_path.read_text()
text = text[text.index('class Observer('):text.index('\n\ndef main():')]
old = "            'cuCtxGetCurrent': [ct.POINTER(ct.c_void_p)],"
new = old + "\n            'cuMemGetAddressRange_v2': [ct.POINTER(ct.c_uint64), ct.POINTER(ct.c_size_t), ct.c_uint64],"
assert text.count(old) == 1
text = text.replace(old, new, 1)
old = "        assert '32initialize_affine_body_so3_stateE' in nodes[8750]['name']"
start, end = text.index(old), text.index('        offset, snapshots = 0, []', text.index(old))
text = text[:start] + text[end:]
old = '        self.checked(\'cuMemAlloc_v2\', ct.byref(self.device), self.bytes)'
assert text.count(old) == 1
text = text.replace(old, '        backing_ranges = validate_backing_ranges(self, example, stages)\n' + old, 1)
old = "self.layout = {'device_base': self.device.value, 'model_map_source': model_map_source,"
assert text.count(old) == 1
text = text.replace(old, "self.layout = {'device_base': self.device.value, 'backing_ranges': backing_ranges,", 1)
old = '        for stage in self.layout[\'stages\']:\n'
assert text.count(old) == 1
text = text.replace(old, '        raw = payload.raw\n' + old, 1)
text = text.replace("value = payload.raw[row['offset']:row['offset'] + row['bytes']]",
                    "value = raw[row['offset']:row['offset'] + row['bytes']]", 1)
prefix = '''"""Observe the real first H1 nonlinear solve; snapshots can change atomic scheduling."""
import ctypes as ct
import json
import numpy as np
from reconstruction.csrc.g1_drive_tangent_capture import Observer as Transport, integer
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import Copy3D, dump_graph
from reconstruction.csrc.h1_first_cg_layout import TOKENS as STAGES, select_stages


def validate_backing_ranges(observer, example, stages):
    import warp as wp
    from warp._src.types import type_size_in_bytes
    logical, result = [], {}
    objects = [('model', example.model), ('state', example.state), ('state1', example.state1),
               ('solver', example.solver), ('control', example.control), ('contacts', example.contacts)]
    for owner, obj in objects:
        for name, array in getattr(obj, '__dict__', {}).items():
            if isinstance(array, wp.array) and array.device.is_cuda and array.ptr and array.is_contiguous:
                logical.append({'base': int(array.ptr), 'bytes': array.size * type_size_in_bytes(array.dtype),
                                'provider': 'declared Warp array', 'label': owner + '.' + name})
    for stage in stages:
        for index, size in stage['sizes'].items():
            address = integer(stage['node'], index)
            key = str(address) + ':' + str(size)
            if key in result:
                continue
            matches = [span for span in logical if span['base'] <= address
                       and address + size <= span['base'] + span['bytes']]
            if matches:
                backing = min(matches, key=lambda span: span['bytes'])
            else:
                base, capacity = ct.c_uint64(), ct.c_size_t()
                observer.checked('cuMemGetAddressRange_v2', ct.byref(base), ct.byref(capacity), address)
                backing = {'base': base.value, 'bytes': capacity.value, 'provider': 'CUDA allocation query'}
            assert backing['base'] <= address and address + size <= backing['base'] + backing['bytes']
            result[key] = {'address': address, 'captured_bytes': size, **backing}
    return list(result.values())


'''
rendered = prefix + text
ast.parse(rendered)
assert all(len(line) <= 128 for line in rendered.splitlines())
target = BASE / 'transport-as-run.py'
assert not target.exists()
target.write_text(rendered)
core_path = previous / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
assert core['extension_sha256'] == 'aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830'
hashes = {str(ROOT / name): sha for name, sha in core['sources'].items()}
paths = [Path(__file__), BASE / 'run.py', BASE / 'capture-worker.py', target, transport_path,
         historical / 'completion-manifest.json', core_path, previous / 'h1-asset-manifest.json',
         previous / 'public-h1-worker.py', previous / 'public-h1-graph/abi.json',
         ROOT / 'reconstruction/csrc/h1_first_cg_layout.py',
         ROOT / 'reconstruction/csrc/graph_definition_dump.py',
         ROOT / 'build/reconstruction-csrc/host-particles/build.json',
         ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h']
layouts = {}
for label in ('original', 'source'):
    path = previous / 'public-h1-graph-with-alloc' / label / 'definition-before-first-replay/graph.json'
    paths.append(path)
    layouts[label] = select_stages(linear_order(json.loads(path.read_text()))[0], 46, 51)
stages = layouts['original']
assert len(stages) == len(layouts['source']) == 83
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, sha in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
kernels = {stage['kernel_key']: stage['node']['name'] for stage in stages}
assert kernels == {stage['kernel_key']: stage['node']['name'] for stage in layouts['source']}
plan = {'input_sha256': hashes, 'kernels': kernels, 'core_build': str(core_path),
        'source_host_build': str(previous / 'candidate-force-order/build.json'),
        'source_host_sha256': core['source_host_sha256'], 'source_core_sha256': core['extension_sha256'],
        'abi': str(previous / 'public-h1-graph/abi.json'), 'frames': 2,
        'runs': [{'label': 'sdk0', 'backend': 'original'}, {'label': 'rebuilt0', 'backend': 'source'}],
        'actual_calls_per_endpoint': 83, 'CG_iterations': 20, 'scope': 'first NL of first actual H1 native substep',
        'snapshot_nodes_per_endpoint': sum(len(s['sizes']) + len(s['outputs']) for s in stages),
        'snapshot_bytes_per_endpoint': sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs'])
                                           for s in stages),
        'replay_H2D_resets_require_context_fence': True, 'fixed_C8_source0_replaced': False,
        'full_first_substep_all_10_NL_or_extra_operators_claimed': False, 'production_changed': False,
        'GPU_context_created': False, 'whole_solver_complete': False}
assert not (BASE / 'plan.json').exists()
(BASE / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('CPU preflight: actual two graphs, 83 calls/20 CG, 578 complete snapshots, 929317724 bytes per endpoint')
