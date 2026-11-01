"""Check the isolated initializer's complete source delta, exported ABI and accepted device entries."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
prototype = BASE / 'cache-value-prototype'
native = ROOT / 'reconstruction/csrc/native'
source = (prototype / 'bvh_library.cu').read_text()
start = source.index('// SDK Granular construction uses typed int fills with both one and minus one.\n')
stop = source.index('extern "C" int source_bvh_sequence_fill(', start)
added_source = source[start:stop]
assert 'initialize_cache(data, count, value);' in added_source
assert source[:start] + source[stop:] == (native / 'bvh_library.cu').read_text()
header = (prototype / 'bvh_library.h').read_text()
declaration = '''extern "C" __attribute__((visibility("default"))) int source_cache_initialize_integer(
    void* data, std::size_t count, int value);
'''
assert header.count(declaration) == 1
assert header.replace(declaration, '') == (native / 'bvh_library.h').read_text()
host = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
original_meta = next(ROOT / p for p in host['sources'] if 'bvh-host-library/' in p and p.endswith('/build.json'))
old_library = original_meta.parent / 'libsource_bvh_library.so'
new_library = prototype / 'library/libsource_bvh_library.so'


def exports(path):
    text = subprocess.check_output(['nm', '-D', '--defined-only', str(path)], text=True)
    return {line.split()[-1] for line in text.splitlines() if line.split()[-1].startswith('source_')}


old_exports, new_exports = exports(old_library), exports(new_library)
assert old_exports == {'source_cache_initialize', 'source_bvh_sequence_fill', 'source_bvh_reduce', 'source_bvh_sort'}
assert new_exports == old_exports | {'source_cache_initialize_integer'}
old_build = json.loads(original_meta.read_text())
new_build = json.loads((prototype / 'library/build.json').read_text())
old_checks, new_checks = [x['device_entries_identical_to_accepted_source'] for x in (old_build, new_build)]
assert old_checks == new_checks and len(new_checks) == 26 and all(new_checks.values())
paths = [Path(__file__), native / 'bvh_library.cu', native / 'bvh_library.h', old_library, new_library,
         original_meta, prototype / 'library/build.json', prototype / 'bvh_library.cu', prototype / 'bvh_library.h']
report = {'only_added_integer_host_function_and_declaration': True, 'original_host_APIs_retained': sorted(old_exports),
          'new_host_API': 'source_cache_initialize_integer', 'accepted_device_entry_checks_identical': 26,
          'production_host_sha256': host['extension_sha256'], 'GPU_runtime_validation_claimed': False,
          'solver_linked_to_prototype': False, 'whole_solver_complete': False,
          'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
with (prototype / 'independent-cpu-audit.json').open('x') as out:
    out.write(json.dumps(report, indent=2) + '\n')
print(json.dumps(report, indent=2))
