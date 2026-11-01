"""Restore only constructor behavior observed in the fixed SDK, in a separate source-built candidate."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
previous = json.loads((BASE / 'candidate/build.json').read_text())
for name, digest in previous['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
directory = BASE / 'candidate2'
directory.mkdir(exist_ok=False)
source = (BASE / 'candidate/source_solver.cpp').read_text()
old = '            if (self_pp_.local) candidates(self_vf_free_, self_pp_.local, model_.collision_particle_indices.ptr);\n'
assert source.count(old) == 1
# Preserve the observed inactive VF storage without adding a query when there are no triangles.
new = ('            if (self_pp_.local) candidates(self_vf_free_, self_pp_.local, model_.collision_particle_indices.ptr);\n'
       '        } else if (self_pp_.local) {\n'
       '            self_vf_free_.counts = initialized_cache(copies * self_pp_.local, 4, SourceCacheType::Integer);\n'
       '            self_vf_free_.slots = initialized_cache(copies * self_pp_.local * 31, 4, SourceCacheType::Integer);\n')
source = source.replace(old, new)
start = source.index('        granular_head_ = allocate(', source.index('    void precompute_granular()'))
end = source.index('        auto prepare_bonds', start)
old_allocations = source[start:end]
source = source[:start] + '''        granular_head_ = initialized_cache(granular_slots_, 4, SourceCacheType::Integer);
        granular_next_ = initialized_cache(points, 4, SourceCacheType::Integer);
        granular_ids_ = initialized_cache(points, 4, SourceCacheType::Integer);
        granular_world_ = initialized_cache(points, 4, SourceCacheType::Integer);
        granular_cells_ = initialized_cache(points, 12, SourceCacheType::Index3);
        granular_positions_ = initialized_cache(points, 12, SourceCacheType::Vector3);
        granular_previous_ = initialized_cache(points, 12, SourceCacheType::Vector3);
        granular_radius_ = initialized_cache(points, 4, SourceCacheType::Scalar);
        granular_counts_ = initialized_cache(points, 4, SourceCacheType::Integer);
        granular_neighbors_ = initialized_cache(points * 32, 4, SourceCacheType::Integer);
        granular_cache_ = initialized_cache(points * 32, 16, SourceCacheType::Vector4);
        granular_diagonal_ = initialized_cache(count_, 36, SourceCacheType::Matrix3);
''' + source[end:]
source_path = directory / 'source_solver.cpp'
source_path.write_text(source)
header_path = ROOT / 'reconstruction/csrc/native/bvh_library.h'
header = header_path.read_text()
assert header.count('Box, ScalarEntry };') == 1
header = header.replace('Box, ScalarEntry };', 'Box, ScalarEntry, Index3, Vector4 };')
(directory / 'bvh_library.h').write_text(header)
library_path = ROOT / 'reconstruction/csrc/native/bvh_library.cu'
library = library_path.read_text()
old = '    default: return cudaErrorInvalidValue;'
assert library.count(old) == 1
library = library.replace(old,
    '    case SourceCacheType::Index3: initialize_cache(data, count, glm::ivec3(0)); break;\n'
    '    case SourceCacheType::Vector4: initialize_cache(data, count, glm::vec4(0.0f)); break;\n' + old)
(directory / 'bvh_library.cu').write_text(library)
builder_path = ROOT / 'reconstruction/csrc/build_bvh_library.py'
text = builder_path.read_text()
replacements = {
    "source = pc.CSRC/'native/bvh_library.cu'": "source = Path(" + repr(str(directory / 'bvh_library.cu')) + ')',
    "'-I'+str(pc.CSRC/'kernels'),": "'-I'+str(pc.CSRC/'native'), '-I'+str(pc.CSRC/'kernels'),",
    "pc.CSRC/'native/bvh_library.h'": 'Path(' + repr(str(directory / 'bvh_library.h')) + ')',
    'assert len(checks) == 24 and all(checks.values()), checks':
        'assert len(checks) == 26 and all(checks.values()), checks',
}
for old, new in replacements.items():
    assert text.count(old) == 1, old
    text = text.replace(old, new)
ast.parse(text)
script = directory / 'build-library-as-run.py'
script.write_text(text)
inputs = dict(previous['input_sha256'])
for path in (source_path, directory / 'bvh_library.h', directory / 'bvh_library.cu', script, Path(__file__),
             header_path, library_path, builder_path):
    inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(directory / 'plan.json').write_text(json.dumps({
    'input_sha256': inputs, 'original_constructor_report': str(BASE / 'constructors/audit-v2.json'),
    'replaced_granular_uninitialized_allocations': old_allocations,
    'inactive_VF_cache_additions_do_not_enable_new_queries': True,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
namespace = {'__name__': 'reconstruction.csrc.granular_candidate2_library',
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
namespace['build'](directory / 'library')
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
command = list(build['build_command'])
original_cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
command[command.index(str(original_cpp))] = str(source_path)
command.insert(1, '-I' + str(original_cpp.parent))
old_object = next(p for p in command if p.endswith('/bvh_library.o'))
command[command.index(old_object)] = str(directory / 'library/bvh_library.o')
image = directory / Path(command[-1]).name
command[-1] = str(image)
with (directory / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(directory / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
for name, digest in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
helper = json.loads((directory / 'library/build.json').read_text())
assert len(helper['device_entries_identical_to_accepted_source']) == 26
assert all(helper['device_entries_identical_to_accepted_source'].values())
for path in (directory / 'library/bvh_library.o', directory / 'library/build.json'):
    inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(directory / 'build.json').write_text(json.dumps({
    'input_sha256': inputs, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
    'command': command, 'all26_library_entries_equal_to_accepted_source': True,
    'CUDA176_bundle_unchanged': True, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Built constructor-restored candidate2', hashlib.sha256(image.read_bytes()).hexdigest(), flush=True)
