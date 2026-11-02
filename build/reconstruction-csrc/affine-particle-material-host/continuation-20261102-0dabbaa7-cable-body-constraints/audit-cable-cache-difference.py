"""Locate the six missing typed cable initializers against actual captured allocations and fixed SDK assembly."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import initialization_trace_audit as typed

directory = BASE / 'constructors-scope-only/spring-w1-newton-b0'
inputs = {}


def read(path):
    raw = path.read_bytes()
    inputs[str(path)] = hashlib.sha256(raw).hexdigest()
    return raw.decode()


original = directory / 'external-initializers/original'
source = directory / 'external-initializers/source'
before = typed.capture(original, 2)
after = typed.capture(source, 2)
assert len(before) == 33 and len(after) == 27
expected = [('mat3', 8, 36), ('mat3', 8, 36), ('int', 8, 4), ('int', 1, 4), ('vec4', 1, 16), ('int', 1, 4)]
selected = before[5:11]
for row, (kind, count, width) in zip(selected, expected):
    assert row['type'] == kind and row['count'] == count and row['value_hex'] == bytes(width).hex()
    assert row['grid_x'] == 1 and row['block_x'] == 256
assert list(map(typed.signature, before[:5] + before[11:])) == list(map(typed.signature, after))
for side in ('original', 'source'):
    for name in ('memory.jsonl', 'launches.txt', 'capture.runtime.json'):
        read(directory / 'external-initializers' / side / name)
full = directory / 'external-full-memory/original'
allocations = [row for line in read(full / 'memory.jsonl').splitlines()
               if (row := json.loads(line)).get('api') in ('cudaMalloc', 'cuMemAlloc_v2')]
assert [row['bytes'] for row in allocations[5:11]] == [288, 288, 32, 4, 16, 4]
lines = read(full / 'launches.txt').splitlines()
first = next(line for line in lines if 'prepare_cable_tangents' in line)
view = first.split(' symbol:')[0].split()[5]
words = {int(offset): int(value, 16) for offset, value in re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', view)}
assert set(words) == set(range(0, 160, 8))
for offset, allocation in zip((104, 112, 120, 128), allocations[5:9]):
    assert words[offset] == int(allocation['dst'], 16)
assert [words[offset] for offset in (136, 144, 152)] == [1, 1, 8]
image = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(image.read_bytes()).hexdigest() == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
command = ['objdump', '-d', '-C', '--start-address=0xfac30', '--stop-address=0xfaf00', str(image)]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False)
assert result.returncode == 0 and not result.stderr
target = BASE / 'SDK-cable-reset-copy.asm'
assert not target.exists()
target.write_bytes(result.stdout)
for path in (Path(__file__), directory / 'audit.json', target, BASE / 'SDK-initialize.asm'):
    read(path)
report = {'SDK_typed_initializers': 33, 'scope_only_candidate_typed_initializers': 27,
          'six_missing_initializers': selected, 'first_four_CableView_fields_tied_to_actual_allocations': [104, 112, 120, 128],
          'SDK_cable_allocation_bytes': [288, 288, 32, 4, 16, 4],
          'remaining_typed_initializers_and_order_equal_after_removing_six': True,
          'SDK_reset_copy_disassembly_actual_exit': result.returncode, 'SDK_reset_copy_command': command,
          'input_sha256': inputs, 'production_modified': False, 'whole_solver_complete': False}
(BASE / 'cable-cache-difference.json').write_text(json.dumps(report, indent=2) + '\n')
print('Actual SDK: six typed zero cable caches before matrix templates; old candidate allocated them late and untyped')
