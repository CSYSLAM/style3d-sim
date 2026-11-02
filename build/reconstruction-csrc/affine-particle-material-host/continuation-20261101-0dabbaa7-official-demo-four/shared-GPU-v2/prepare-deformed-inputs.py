"""Prepare common-input kernel diagnostics from real public positions;these are not captured private solver histories."""
from copy import deepcopy
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'particles-full-inputs'
OUTPUT = BASE / 'particles-deformed-common-inputs'
OUTPUT.mkdir(exist_ok=False)
plan_path = PHASE / 'full-input-replays/plan.json'
plan = json.loads(plan_path.read_text())
packets, provenance, hashes = [], [], {}


def pin(path):
    path = Path(path)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()


for path in (Path(__file__), plan_path, PHASE / 'atomic-operands/independent-cpu.json'):
    pin(path)
with np.load(PHASE / 'full-input-replays/worker-0.npz', allow_pickle=False) as captured:
    pin(PHASE / 'full-input-replays/worker-0.npz')
    for side in ('original', 'source'):
        trajectory = BASE / 'long60/cloth-particles' / (side + '.npz')
        pin(trajectory)
        with np.load(trajectory, allow_pickle=False) as states:
            q = states['particle_q']
            assert q.dtype == np.dtype('<f4') and q.shape == (600, 8625, 3) and np.isfinite(q).all()
            for step in (9, 299, 599):
                arrays = {}
                tag = f'{side}-substep{step:03d}'
                output = OUTPUT / (tag + '.npz')
                for index, original in enumerate(plan['packets'][:3]):
                    packet = deepcopy(original)
                    packet['input'] = str(output)
                    packet['worker'] = len(provenance)
                    packet['frame'] = step // 10
                    stage = packet['stage']
                    old_key = stage['key']
                    stage['key'] = tag + '-' + old_key
                    for binding in stage['bindings']:
                        label = binding['label']
                        value = captured[old_key + '/before/' + label].copy()
                        if label == 'arg-0':
                            value = q[step].reshape(-1).view('u1').copy()
                        elif index == 1 and label == 'arg-1':
                            value = q[step - 1].reshape(-1).view('u1').copy()
                        assert value.nbytes == binding['bytes']
                        arrays[stage['key'] + '/before/' + label] = value
                    packets.append(packet)
                np.savez_compressed(output, **arrays)
                pin(output)
                provenance.append({'tag': tag, 'trajectory': str(trajectory), 'public_substep': step,
                                   'position_sha256': hashlib.sha256(q[step].tobytes()).hexdigest(),
                                   'bending_previous_public_substep': step - 1,
                                   'private_solver_history_reproduced': False})
assert len(packets) == 18
result = {'packets': packets, 'input_sha256': hashes, 'geometry_provenance': provenance,
          'only_changes_from_captured_inputs': ['particle positions', 'previous public positions for bending'],
          'public_substeps_are_zero_based': True, 'material_topology_initial_accumulators_unchanged': True,
          'actual_unmodified_calls_planned': 54, 'actual_instrumented_calls_planned': 36,
          'complete_trajectory_acceptance_claimed': False, 'production_changed': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared18 complete common-input diagnostics from6 real deformed geometries;54 raw and36 trace calls planned')
