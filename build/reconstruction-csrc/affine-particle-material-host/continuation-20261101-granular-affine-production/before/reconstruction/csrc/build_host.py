"""Build the incremental C++ Solver API using only the accepted source PTX bundle."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sysconfig

import pybind11

from . import ptx_compare as pc
from .build_native import parameters
from .library_entries import entries


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def api_header(schema):
    lines = ['#pragma once', '#include <array>', '#include <cmath>', '#include <sstream>',
             'struct Span { std::uintptr_t ptr = 0; std::size_t size = 0; };']
    for name, members in schema['enums'].items():
        lines.append('enum class ' + name + ' { ' + ', '.join(f'{k} = {v}' for k, v in members.items()) + ' };')
    for name, fields in schema['classes'].items():
        if name == 'Span':
            continue
        lines.append('struct ' + name + ' {')
        for key, field in fields.items():
            kind, value = field['type'], field['default']
            if kind == 'Span':
                declaration = 'Span ' + key + ';'
            elif kind == 'vec3':
                declaration = 'std::array<float, 3> ' + key + ' = {0.0f, 0.0f, 0.0f};'
            elif kind in schema['enums']:
                declaration = f'{kind} {key} = static_cast<{kind}>({value});'
            else:
                cpp = field.get('cpp_type', {'bool': 'bool', 'int': 'int', 'float': 'float'}[kind])
                literal = str(value).lower() + ('f' if kind == 'float' else '')
                declaration = f'{cpp} {key} = {literal};'
            lines.append('    ' + declaration)
        lines.append('};')
    lines.append('static void bind_api(py::module_& module) {')
    lines += ['    py::class_<Span>(module, "Span")',
              '        .def(py::init([](std::uintptr_t ptr, std::size_t size) {',
              '            if (!ptr && size) throw py::value_error("Span with a null address must have zero elements");',
              '            return Span{ptr, size};',
              '        }), py::arg("ptr") = 0, py::arg("size") = 0)',
              '        .def_readonly("ptr", &Span::ptr).def_readonly("size", &Span::size)',
              '        .def("__repr__", [](const Span& s) { return "Span(ptr=" + std::to_string(s.ptr) +',
              '             ", size=" + std::to_string(s.size) + ")"; });']
    for name, members in schema['enums'].items():
        lines.append(f'    py::enum_<{name}>(module, "{name}")')
        for key in members:
            lines.append(f'        .value("{key}", {name}::{key})')
        lines[-1] += ';'
    for name, fields in schema['classes'].items():
        if name == 'Span':
            continue
        lines.append(f'    py::class_<{name}>(module, "{name}").def(py::init<>())')
        for key, field in fields.items():
            if field['type'] == 'Span':
                # The original getter returns a value: replacing a field must not mutate a previously read Span.
                lines += [f'        .def_property("{key}", [](const {name}& o) {{ return o.{key}; }},',
                          f'            []({name}& o, Span value) {{ o.{key} = value; }})']
            elif field['type'] == 'vec3':
                lines += [f'        .def_property("{key}", [](const {name}& o) {{',
                          f'            return py::make_tuple(o.{key}[0], o.{key}[1], o.{key}[2]);',
                          f'        }}, []({name}& o, py::sequence value) {{',
                          '            if (py::len(value) != 3)',
                          f'                throw py::value_error("{key} must contain three finite components");',
                          '            std::array<float, 3> parsed{value[0].cast<float>(), value[1].cast<float>(),',
                          '                                        value[2].cast<float>()};',
                          '            for (auto component : parsed) if (!std::isfinite(component))',
                          f'                throw py::value_error("{key} must contain three finite components");',
                          f'            o.{key} = parsed;', '        })']
            elif name == 'Config' and key == 'air_density':
                lines += [f'        .def_property("{key}", [](const Config& o) {{ return o.{key}; }},',
                          '            [](Config& o, float value) {',
                          '                if (!std::isfinite(value) || value < 0.0f)',
                          '                    throw py::value_error("air_density must be finite and non-negative");',
                          '                o.air_density = value;', '            })']
            else:
                lines.append(f'        .def_readwrite("{key}", &{name}::{key})')
        lines[-1] += ';'
    lines.append('}')
    return '\n'.join(lines) + '\n'


def revision_bundle(accepted_header, revision_ptx, symbols, tetrahedron_ptx, granular_ptx):
    parsed = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', accepted_header, re.S)
    assert len(parsed) == 25
    modules = [(json.loads(name), text) for name, _, text in parsed]
    modules.append(('reconstruction/csrc/revisions/pcg_23fb797.cu', revision_ptx))
    tetrahedron_module = len(modules)
    modules.append(('reconstruction/csrc/revisions/tetrahedra_23fb797.cu', tetrahedron_ptx))
    granular_module = len(modules)
    modules.append(('reconstruction/csrc/revisions/granular_grid_23fb797.cu', granular_ptx))
    kernels, selected = {}, []
    for index, (path, text) in enumerate(modules):
        for name, body in entries(text).items():
            replaced_tet = 'kernel26evaluate_tetrahedron_forceE' in name
            replaced_grid = '15granular_kernel10build_grid' in name
            if (name not in symbols or (replaced_tet and index != tetrahedron_module) or
                (replaced_grid and index != granular_module) or (index == granular_module and not replaced_grid)):
                text = text.replace(body, '')
                continue
            spec = {'module': index, 'digest': hashlib.sha256(pc.normalise(body).encode()).hexdigest(),
                    'parameters': parameters(body)}
            if name in kernels:
                assert kernels[name]['digest'] == spec['digest']
            else:
                kernels[name] = spec
        selected.append((path, text))
    assert set(kernels) == set(symbols), 'Revision source-kernel coverage differs from the pinned ABI inventory'
    revision_digest = hashlib.sha256(json.dumps(kernels, sort_keys=True).encode()).hexdigest()
    header = ['#pragma once', '#include <vector>', '#include <cstddef>',
              'struct ModuleSpec { const char* path; const char* ptx; };',
              'struct KernelSpec { const char* name; std::size_t module; const char* digest; '
              'std::vector<std::size_t> parameters; };',
              f'static const char* source_digest = "{revision_digest}";',
              'static const std::vector<ModuleSpec> source_modules = {']
    for index, (path, text) in enumerate(selected):
        delimiter = f'REVISION_PTX_{index}'
        header.append('{' + json.dumps(path) + ', R"' + delimiter + '(' + text + ')' + delimiter + '"},')
    header += ['};', 'static const std::vector<KernelSpec> source_kernels = {']
    for name, spec in sorted(kernels.items()):
        sizes = ','.join(map(str, spec['parameters']))
        header.append('{' + json.dumps(name) + f', {spec["module"]}, "{spec["digest"]}", {{{sizes}}}' + '},')
    header += ['};', '']
    return '\n'.join(header), revision_digest, kernels


def main():
    out = pc.OUT/'host-particles'
    out.mkdir(parents=True, exist_ok=True)
    native = pc.OUT/'native'
    manifest = json.loads((native/'build.json').read_text())
    proof = json.loads((native/'provenance-final.json').read_text())
    bundle = native/'source_ptx_bundle.h'
    assert digest(bundle) == proof['files'][str(bundle.relative_to(pc.ROOT))], 'Accepted PTX bundle changed'
    for name, expected in manifest['sources'].items():
        assert digest(pc.ROOT/name) == expected, 'Accepted CUDA/runtime source changed: ' + name
    revision = pc.CSRC/'revisions/pcg_23fb797.cu'
    revision_ptx = pc.compile_ptx(revision, pc.DEFAULT_NVCC)
    revision_entries = {name: body for name, body in entries(revision_ptx).items() if
                        'kernel23precondition_and_reduce' in name or 'kernel19update_cg_directionE' in name or
                        'kernel28update_solution_and_residualEP' in name or
                        ('kernel26multiply_matrix_and_reduceINS_' in name)}
    assert len(revision_entries) == 7
    inventory = pc.CSRC/'native/kernel_symbols_23fb797.json'
    tetrahedron_revision = pc.CSRC/'revisions/tetrahedra_23fb797.cu'
    tetrahedron_ptx = pc.compile_ptx(tetrahedron_revision, pc.DEFAULT_NVCC)
    granular_revision = pc.CSRC/'revisions/granular_grid_23fb797.cu'
    granular_ptx = pc.compile_ptx(granular_revision, pc.DEFAULT_NVCC)
    header, revision_digest, kernel_specs = revision_bundle(bundle.read_text(), revision_ptx,
                                                           json.loads(inventory.read_text()), tetrahedron_ptx, granular_ptx)
    (out/'source_ptx_bundle.h').write_text(header)
    runtime = pc.CSRC/'native/source_cuda.cpp'
    assert digest(runtime) == manifest['sources'][str(runtime.relative_to(pc.ROOT))]
    # Reuse the accepted driver verbatim. Its historical source/binary/proof remain untouched.
    (out/'source_driver.h').write_text(runtime.read_text().split('PYBIND11_MODULE(')[0])
    schema = pc.CSRC/'native/api_schema.json'
    (out/'source_api.h').write_text(api_header(json.loads(schema.read_text())))
    target = out/('_source_solver' + sysconfig.get_config_var('EXT_SUFFIX'))
    from .build_bvh_library import build as build_bvh_library
    bvh_inputs = [pc.CSRC/'native/bvh_library.cu', pc.CSRC/'native/bvh_library.h',
                  pc.CSRC/'library/reduction_functors.cuh', pc.CSRC/'kernels/types.cuh', pc.CSRC/'kernels/common.cuh',
                  pc.CSRC/'build_bvh_library.py']
    bvh_key = hashlib.sha256(''.join(digest(path) for path in bvh_inputs).encode()).hexdigest()[:16]
    bvh_directory = pc.OUT/'bvh-host-library'/bvh_key
    if not bvh_directory.exists():
        build_bvh_library(bvh_directory)
    bvh_proof = json.loads((bvh_directory/'build.json').read_text())
    for name, expected in bvh_proof['inputs'].items():
        assert digest(pc.ROOT/name) == expected, 'BVH bridge input changed: '+name
    bvh_object = bvh_directory/'bvh_library.o'
    assert digest(bvh_object) == bvh_proof['object_sha256'], 'BVH bridge object changed'
    assert all(bvh_proof['device_entries_identical_to_accepted_source'].values())
    cuda_library = pc.ROOT/'build/toolchains/cuda-12.4/lib'
    command = ['c++', '-std=c++17', '-O2', '-DNDEBUG', '-shared', '-fPIC',
               '-I'+pybind11.get_include(), '-I'+sysconfig.get_path('include'),
               '-I'+str(pc.ROOT/'build/toolchains/cuda-12.4/include'), '-I'+str(out), '-I'+str(native),
               str(pc.CSRC/'native/source_solver.cpp'), str(bvh_object), '-l:libcuda.so.1',
               '-L'+str(cuda_library), '-l:libcudart.so.12', '-Wl,-rpath,'+str(cuda_library), '-o', str(target)]
    subprocess.run(command, check=True)
    sources = [runtime, schema, revision, tetrahedron_revision, granular_revision, inventory,
               pc.CSRC/'native/source_solver.cpp', Path(__file__),
               native/'source_ptx_bundle.h',
               out/'source_api.h', out/'source_driver.h', out/'source_ptx_bundle.h', pc.OUT/'pcg_23fb797.ptx',
               pc.OUT/'tetrahedra_23fb797.ptx', pc.OUT/'granular_grid_23fb797.ptx',
               pc.CSRC/'native/surface_view.h', *bvh_inputs,
               bvh_object, bvh_directory/'build.json', bvh_directory/'bvh_library.ptx']
    # Keep build metadata and the extension's advertised incremental scope in one place.
    scope = re.search(r'module\.attr\("supported_physics"\) = py::make_tuple\((.*?)\);',
                      (pc.CSRC/'native/source_solver.cpp').read_text(), re.S)
    assert scope, 'Missing source solver scope declaration'
    result = {'source_only': True, 'solver_api_ready': False,
              'supported_physics': re.findall(r'"([a-z0-9_]+)"', scope.group(1)),
              'cuda_source_digest': revision_digest, 'kernel_count': len(kernel_specs), 'kernels': kernel_specs,
              'pcg_revision': '23fb797', 'build_command': command,
              'bvh_library': {'object': str(bvh_object.relative_to(pc.ROOT)),
                              'accepted_device_entries': len(bvh_proof['device_entries_identical_to_accepted_source']),
                              'library_runtime_launches_completely_observed': False},
              'source_overrides': {'evaluate_tetrahedron_force': str(tetrahedron_revision.relative_to(pc.ROOT)),
                                   'granular_build_grid': str(granular_revision.relative_to(pc.ROOT))},
              'sources': {str(path.relative_to(pc.ROOT)): digest(path) for path in sources},
              'extension_sha256': digest(target)}
    (out/'build.json').write_text(json.dumps(result, indent=2)+'\n')
    print(target)


if __name__ == '__main__':
    main()
