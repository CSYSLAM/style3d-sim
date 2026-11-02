"""Locate the actual SDK self-force position and prove the exact call permutation before changing the candidate."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import normalize, schemas
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA

assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
status = json.loads((BASE / 'candidate-captures/status.json').read_text())
assert status['complete'] and len(status['completed']) == 12
assert all(row['actual_exit'] == 0 for row in status['completed'])
schema = schemas()[0]
self_names = {'22accumulate_vertex_face', '20accumulate_edge_edge', '20accumulate_edge_face'}
rigidity_names = {'51evaluate_affine_body_so3_augmented_lagrangian_force', '33evaluate_affine_body_spring_force'}
plan = json.loads((BASE / 'discovery/plan.json').read_text())
hashes = {str(Path(__file__)): hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), str(REFERENCE): REFERENCE_SHA}
rows = []
for case in plan['cases']:
    paths = [BASE / 'discovery' / case['name'] / 'original/launches.txt',
             BASE / 'candidate-captures' / case['name'] / 'launches.txt']
    for path in paths:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    sdk, source = [[normalize(line, schema) for line in path.read_text().splitlines()] for path in paths]
    reordered, pending, blocks = [], [], 0
    for call in source:
        if call[0] in self_names:
            pending.append(call)
            continue
        if call[0] in rigidity_names:
            assert [row[0] for row in pending] == [
                '22accumulate_vertex_face', '20accumulate_edge_edge', '20accumulate_edge_face']
            reordered.extend(pending)
            pending = []
            blocks += 1
        reordered.append(call)
    assert not pending and blocks == 9 and reordered == sdk, case['name']
    for index, call in enumerate(sdk):
        if call[0] == '35add_surface_contact_stiffness_scale':
            following = next(i for i in range(index + 1, len(sdk)) if sdk[i][0] == '26evaluate_body_spring_force')
            assert following == index + 1
    rows.append({'case': case['name'], 'owned_calls': len(sdk), 'self_force_blocks': blocks,
                 'all_normalized_parameters_equal_after_only_this_permutation': True})
assembly = []
for label, start, stop in (('before-joints', 0xfc800, 0xfcf20), ('self-call', 0xfec60, 0xfed40),
                            ('surface-scale', 0xffe20, 0xffef0)):
    command = ['objdump', '-d', '-C', f'--start-address={start:#x}', f'--stop-address={stop:#x}', str(REFERENCE)]
    text = subprocess.check_output(command, text=True)
    path = BASE / ('SDK-step-' + label + '.asm')
    path.write_text(text)
    assembly.append({'command': command, 'output': str(path), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
assert 'fed26:' in (BASE / 'SDK-step-self-call.asm').read_text()
assert 'SelfCollision::accumulate' in (BASE / 'SDK-step-self-call.asm').read_text()
record = {'cases': rows, 'assembly': assembly, 'input_sha256': hashes, 'GPU_used': False,
          'change': 'Keep stiffness copy/surface-scale before joints;move only self accumulation after drives/limits',
          'actual_second_candidate_execution_claimed': False, 'whole_solver_complete': False}
(BASE / 'force-order-proof.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:all12 actual call logs agree after only moving9 self-force blocks;surface scale stays before joints')
