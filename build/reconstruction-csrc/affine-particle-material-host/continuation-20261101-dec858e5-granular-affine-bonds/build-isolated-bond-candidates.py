"""Build guard-only and statically restored constructor candidates without changing the active production image."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
native = ROOT / 'reconstruction/csrc/native'
original_cpp = native / 'source_solver.cpp'
root_cpp = original_cpp.read_text()
prototype = BASE / 'cache-value-prototype'
cpu = json.loads((prototype / 'independent-cpu-audit.json').read_text())
assert cpu['accepted_device_entry_checks_identical'] == 26
bindings = json.loads((BASE / 'host-bond-argument-binding/static-field-bindings.json').read_text())
assert bindings['direct_instruction_loads_checked'] == 50 and len(bindings['reviewed_call_sites']) == 7
assert build['extension_sha256'] == 'dec858e551f015374453713edc46910028cae95a210b33acd6c9e9006a1c0282'
base_inputs = {str(ROOT / name): sha for name, sha in build['sources'].items()}
proofs = [Path(__file__), prototype / 'independent-cpu-audit.json',
          BASE / 'host-bond-argument-binding/static-field-bindings.json',
          BASE / 'host-bond-argument-binding/matrix-construction-manifest.json',
          BASE / 'host-bond-argument-binding/mat3-resize.asm', BASE / 'host-bond-argument-binding/mat3-append.asm']
base_inputs.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in proofs})
old_guard = 'model.cable_count || model.granular_bond_count || model.granular_adhesion > 0.0f))'
assert root_cpp.count(old_guard) == 1
guard_cpp = root_cpp.replace(old_guard, 'model.cable_count))')
comment = '// Only unconstrained, unbonded granular/SO3 body layouts have been compared against the SDK.'
assert guard_cpp.count(comment) == 1
guard_cpp = guard_cpp.replace(comment, '// Provisional bonded-granular/body diagnostics; runtime acceptance is pending.')
restored = guard_cpp
marker = '    std::uint64_t template_row_counts() const'
assert restored.count(marker) == 1
integer_method = '''    std::uint64_t initialized_integer_cache(std::size_t count, int value)
    {
        if (!count) return 0;
        const auto pointer = driver_->allocate(count * sizeof(int));
        check_bvh_library(source_cache_initialize_integer(reinterpret_cast<void*>(pointer), count, value),
                          "Integer cache value initialization");
        return pointer;
    }

'''
restored = restored.replace(marker, integer_method + marker)
old_active = '            group.active = upload(std::vector<int>(bonds.size(), active));'
old_tangent = '            group.tangent = allocate(bonds.size() * 36);'
assert restored.count(old_active) == restored.count(old_tangent) == 1
restored = restored.replace(old_active, '            group.active = initialized_integer_cache(bonds.size(), active);')
restored = restored.replace(old_tangent,
                            '            group.tangent = initialized_cache(bonds.size(), 36, SourceCacheType::Matrix3);')
before = '''        if (dynamic) {
            prepare_bonds(granular_dynamic_, std::vector<std::array<int, 2>>(dynamic, {0, 0}),
                          std::vector<float>(dynamic, 0.0f), 0);
            granular_partner_ = upload(std::vector<int>(dynamic, -1));
            std::vector<int> offsets{0}, columns;
            for (auto& row : adjacency) {
                std::sort(row.begin(), row.end());
                columns.insert(columns.end(), row.begin(), row.end());
                offsets.push_back(static_cast<int>(columns.size()));
            }
            granular_offsets_ = upload(offsets);
            granular_columns_ = columns.empty() ? 0 : upload(columns);
        }
'''
after = '''        if (dynamic) {
            std::vector<int> offsets{0}, columns;
            for (auto& row : adjacency) {
                std::sort(row.begin(), row.end());
                columns.insert(columns.end(), row.begin(), row.end());
                offsets.push_back(static_cast<int>(columns.size()));
            }
            // SDK 0x1293d7..0x1294c7 uploads CSR before allocating its dynamic bond caches.
            granular_offsets_ = upload(offsets);
            granular_columns_ = columns.empty() ? 0 : upload(columns);
            granular_partner_ = initialized_integer_cache(dynamic, -1);
            granular_dynamic_.count = static_cast<int>(dynamic);
            granular_dynamic_.pairs = initialized_cache(dynamic, 8, SourceCacheType::Index2);
            granular_dynamic_.rest = initialized_cache(dynamic, 4, SourceCacheType::Scalar);
            granular_dynamic_.history = initialized_cache(dynamic, 4, SourceCacheType::Scalar);
            granular_dynamic_.active = initialized_cache(dynamic, 4, SourceCacheType::Integer);
            granular_dynamic_.tangent = initialized_cache(dynamic, 36, SourceCacheType::Matrix3);
        }
'''
assert restored.count(before) == 1
restored = restored.replace(before, after)
# Every device operation and iterative force/PCG/state-update method retains its original source text.
compute_start = '    void build_granular_grid('
assert root_cpp[root_cpp.index(compute_start):] == restored[restored.index(compute_start):]
for label, text, cache in [('guard-only', guard_cpp, False), ('static-cache', restored, True)]:
    directory = BASE / ('candidate-' + label)
    directory.mkdir(exist_ok=False)
    cpp = directory / 'source_solver.cpp'
    cpp.write_text(text)
    inputs = dict(base_inputs)
    inputs[str(cpp)] = hashlib.sha256(cpp.read_bytes()).hexdigest()
    command = list(build['build_command'])
    assert command.count(str(original_cpp)) == 1
    command[command.index(str(original_cpp))] = str(cpp)
    command.insert(1, '-I' + str(native))
    if cache:
        for name in ('bvh_library.h', 'bvh_library.cu'):
            p = prototype / name
            (directory / name).write_bytes(p.read_bytes())
            inputs[str(directory / name)] = hashlib.sha256(p.read_bytes()).hexdigest()
        old_object = next(p for p in command if p.endswith('/bvh_library.o'))
        command[command.index(old_object)] = str(prototype / 'library/bvh_library.o')
        for name in ('bvh_library.o', 'build.json'):
            p = prototype / 'library' / name
            inputs[str(p)] = hashlib.sha256(p.read_bytes()).hexdigest()
    image = directory / Path(command[-1]).name
    command[-1] = str(image)
    plan = {'input_sha256': inputs, 'command': command, 'constructor_restored_from_static_SDK': cache,
            'GPU_runtime_validation_claimed': False, 'SDK_combination_support_not_yet_verified': True,
            'iterative_math_source_unchanged': True, 'production_changed': False, 'whole_solver_complete': False}
    (directory / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')

    def verify():
        assert build_path.read_bytes() == build_bytes
        for name, sha in inputs.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name

    verify()
    with (directory / 'build.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        code = process.wait()
    (directory / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
    assert code == 0
    verify()
    report = {**plan, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest()}
    (directory / 'build.json').write_text(json.dumps(report, indent=2) + '\n')
    print(label, report['image_sha256'], 'built; production unchanged; runtime acceptance pending', flush=True)
