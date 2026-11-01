"""Verify the integrated decoder on immutable real SDK/source constructor captures, preserving both outcomes."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import initialization_trace_audit as parser

old = BASE.parent / 'continuation-20261101-38b70dcd-granular-affine-support'
checks, input_hashes = [], {}
for folder, report_name, expected_code in [('constructors', 'audit-v2.json', 1), ('constructors2', 'audit.json', 0)]:
    capture = old / folder
    expected = json.loads((capture / report_name).read_text())
    output = BASE / (folder + '.json')
    command = [sys.executable, '-m', 'reconstruction.csrc.affine_constructor_audit', '--capture', str(capture),
               '--prefix', 'granular-affine-w1', '--output', str(output)]
    (BASE / (folder + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (folder + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        actual_code = process.wait()
    assert actual_code == expected_code, (folder, actual_code)
    actual = json.loads(output.read_text())
    assert actual == expected, 'Decoder promotion changed the independently recorded constructor audit'
    typed = {}
    for side in ('original', 'source'):
        directory = capture / 'granular-affine-w1-initializers' / side
        rows = parser.capture(directory, 2)
        assert len(rows) == expected['typed_initializer_counts'][0 if side == 'original' else 1]
        assert all(row['grid_matches_thrust_256x2'] for row in rows)
        typed[side] = {kind: sum(row['type'] == kind for row in rows) for kind in ('ivec3', 'vec4')}
        for name in ('launches.txt', 'memory.jsonl'):
            path = directory / name
            input_hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    checks.append({'capture': folder, 'pid': process.pid, 'actual_exit': actual_code,
                   'previous_audit_identical_in_full': True, 'new_types_calls': typed,
                   'allocation_counts': expected['allocation_event_counts'],
                   'typed_counts': expected['typed_initializer_counts'], 'checks': expected['checks']})
for path in [Path(__file__), Path(parser.__file__), BASE / 'initialization_trace_audit.before.py']:
    input_hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
with (BASE / 'report.json').open('x') as out:
    out.write(json.dumps({'checks': checks, 'input_sha256': input_hashes, 'GPU_executed': False,
                          'previous_failure_preserved': True, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps(checks, indent=2))
