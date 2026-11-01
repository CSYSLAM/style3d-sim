"""Derive Warp parameter fields from the exact logged modules, generated signatures and installed ctypes layouts."""
import ast
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from warp._src.types import array_t, launch_bounds_t
from newton._src.sim.collide import ContactWriterData

base = Path(__file__).resolve().parent
graphs = [json.loads((base / backend / 'worker/definition-0/graph.json').read_text())
          for backend in ('original', 'source')]
names = {node['name'] for node in graphs[0]['nodes'] if node['type'] == 0 and not node['owned_kernel']}
cache = Path('/home/oem/.cache/warp/1.16.0')
found = {}
modules = [re.findall(r'^Module (\S+) ([0-9a-f]+) load ', (base / (tag + '.log')).read_text(), re.M)
           for tag in ('original', 'source')]
# Post-run test module names differ; no such kernel is in either captured graph.
assert [item for item in modules[0] if not item[0].startswith('test_body_state__locals__')] == [
    item for item in modules[1] if not item[0].startswith('test_body_state__locals__')]
directory = base / 'warp-as-run'
directory.mkdir(exist_ok=False)
artifacts = {}
for module, digest in modules[0]:
    prefix = f'wp_{module}_{digest}'
    path = cache / prefix / (prefix + '.cu')
    if not path.exists():
        continue
    text = path.read_text()
    matched = False
    for name in names:
        match = re.search(r'extern "C" __global__ void ' + re.escape(name) + r'\((.*?)\)\s*\{', text, re.S)
        if match:
            assert name not in found, (name, path)
            found[name] = {'path': str(path), 'signature': match[1]}
            matched = True
    if matched:
        for artifact in path.parent.iterdir():
            if artifact.is_file():
                target = directory / artifact.name
                assert not target.exists()
                target.write_bytes(artifact.read_bytes())
                artifacts[str(artifact)] = {'file': str(target.relative_to(base)),
                                            'sha256': hashlib.sha256(target.read_bytes()).hexdigest()}
assert set(found) == names


def fields(structure, base_offset=0, prefix=''):
    result = []
    for name, kind in structure._fields_:
        offset = base_offset + getattr(structure, name).offset
        field_name = prefix + name
        if kind is array_t:
            result.extend(fields(array_t, offset, field_name + '.'))
        else:
            result.append({'name': field_name, 'offset': offset, 'size': ct.sizeof(kind),
                           'kind': 'pointer' if structure is array_t and name in ('data', 'grad') else 'scalar'})
    return result


def parameter_list(signature):
    depth, start, result = 0, 0, []
    for index, char in enumerate(signature):
        depth += (char == '<') - (char == '>')
        if char == ',' and depth == 0:
            result.append(signature[start:index].strip())
            start = index + 1
    result.append(signature[start:].strip())
    assert depth == 0
    return [part.rsplit(None, 1) for part in result]


kernels = {}
for name, item in found.items():
    parameters = []
    for kind, parameter in parameter_list(item['signature']):
        if kind.startswith('wp::array_t<'):
            structure = array_t
        elif kind == 'wp::launch_bounds_t<1>':
            structure = type(launch_bounds_t(1))
        elif kind == 'ContactWriterData_6ba3bf0a':
            structure = ContactWriterData.ctype
            declaration = re.search(r'struct ' + kind + r'\s*\{(.*?)\n\n', Path(item['path']).read_text(), re.S)
            assert declaration
            members = re.findall(r'\s*(.*?)\s+(\w+);', declaration[1])
            assert [member[1] for member in members] == [field[0] for field in structure._fields_]
            assert members[0][0] == 'wp::int32'
            assert all(member[0].startswith('wp::array_t<') for member in members[1:])
        else:
            width = {'wp::int32': 4, 'wp::float32': 4, 'bool': 1}[kind]
            parameters.append({'cpp_type': kind, 'parameter': parameter, 'width': width,
                               'fields': [{'name': parameter, 'offset': 0, 'size': width, 'kind': 'scalar'}]})
            continue
        parameters.append({'cpp_type': kind, 'parameter': parameter, 'width': ct.sizeof(structure),
                           'fields': fields(structure)})
    kernels[name] = parameters
for graph in graphs:
    for node in graph['nodes']:
        if node['type'] == 0 and not node['owned_kernel']:
            assert node['parameter_widths'] == [entry['width'] for entry in kernels[node['name']]]
for source in (root / '.venv/lib/python3.12/site-packages/warp/_src/types.py',
               root / '.venv/lib/python3.12/site-packages/warp/native/array.h',
               root / '.venv/lib/python3.12/site-packages/newton/_src/sim/collide.py'):
    target = directory / (source.parent.name + '-' + source.name)
    target.write_bytes(source.read_bytes())
    artifacts[str(source)] = {'file': str(target.relative_to(base)),
                              'sha256': hashlib.sha256(target.read_bytes()).hexdigest()}
for path in (root / 'reconstruction/csrc').glob('graph_definition*.py'):
    ast.parse(path.read_text())
    assert all(len(line) <= 128 for line in path.read_text().splitlines()), path
result = {'kernels': kernels, 'generated': found, 'artifacts': artifacts, 'logged_modules': modules,
          'parameter_widths_checked_against_actual_driver': True, 'pointer_fields_selected_by_declared_type': True,
          'padding_not_compared_as_data': True, 'whole_solver_complete': False}
(base / 'warp-schema.json').write_text(json.dumps(result, indent=2) + '\n')
print('Warp kernels with typed, runtime-width-checked schemas:', len(kernels), 'artifacts:', len(artifacts))
