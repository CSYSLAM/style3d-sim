"""Build a separate diagnostic hook that dumps selected owned ranks and leaves production and logging intact."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
original = ROOT / 'reconstruction/diagnostics/cudahook.c'
previous = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/build.json'
metadata = json.loads(previous.read_text())
assert hashlib.sha256(original.read_bytes()).hexdigest() == metadata['source_sha256']
source, image = BASE / 'cudahook-selected-owned.c', BASE / 'cudahook-selected-owned.so'
assert not source.exists() and not image.exists()
text = original.read_text()
helper = '''// Select copies by the already logged owned rank; counters still include every matching launch.
static int selected_owned_dump(void) {
    const char *cursor = getenv("CUDAHOOK_DUMP_OWNED");
    if (!cursor || !*cursor) return 1;
    while (*cursor) {
        char *end = NULL;
        long value = strtol(cursor, &end, 10);
        if (end == cursor || value < 0) return 0;
        if (value == (long)launches_logged - 1) return 1;
        if (!*end) return 0;
        if (*end != ',') return 0;
        cursor = end + 1;
    }
    return 0;
}

'''
anchor = 'cudaError_t cudaLaunchKernel(const void *func, dim3 grid, dim3 block, void **args, size_t shm, cudaStream_t s) {'
assert text.count(anchor) == 1
text = text.replace(anchor, helper + anchor)
anchor = '    if (dump_slot >= 0) {\n        if (dump_limit > 1)'
assert text.count(anchor) == 2
text = text.replace(anchor, '    int record_this_call = dump_slot >= 0 && selected_owned_dump();\n'
                           '    if (record_this_call) {\n        if (dump_limit > 1)')
for function, args in [('dump_buffers', 'args'), ('driver_dump', 'params')]:
    anchor = f'    if (dump_slot >= 0) {{ {function}(dump_key, {args}, spec, "post"); dumped[dump_slot]++; }}'
    assert text.count(anchor) == 1
    text = text.replace(anchor, '    if (dump_slot >= 0) {\n'
                        f'        if (record_this_call) {function}(dump_key, {args}, spec, "post");\n'
                        '        dumped[dump_slot]++;\n    }')
# The four inherited long formatter lines contain no semicolon-space inside string literals.
wrapped = []
for line in text.splitlines():
    if len(line) > 128:
        indent = ' ' * (len(line) - len(line.lstrip()) + 4)
        wrapped.extend(line.replace('; ', ';\n' + indent).splitlines())
    else:
        wrapped.append(line)
result = '\n'.join(wrapped) + '\n'
assert ''.join(result.split()) == ''.join(text.split())
assert all(len(line) <= 128 for line in result.splitlines())
source.write_text(result)
command = ['cc', '-shared', '-fPIC', '-O2', '-Ibuild/toolchains/cuda-12.4/include', str(source),
           '-o', str(image), '-ldl']
completed = subprocess.run(command, capture_output=True, text=True)
(BASE / 'build-hook.log').write_text(completed.stdout + completed.stderr)
assert completed.returncode == 0, completed.stderr
assert hashlib.sha256(original.read_bytes()).hexdigest() == metadata['source_sha256']
report = {'command': command, 'actual_exit': completed.returncode,
          'original_hook_source_sha256': metadata['source_sha256'],
          'selected_hook_source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
          'selected_hook_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
          'only_dump_copy_selection_and_formatter_whitespace_changed': True,
          'production_or_original_hook_modified': False, 'GPU_used_for_build': False}
(BASE / 'build-hook.json').write_text(json.dumps(report, indent=2) + '\n')
print('Built separate owned-rank selection hook; original hook and production unchanged')
