"""Freeze the eight actual reduction inputs and all existing strict scalar targets before GPU certification."""
import ast
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'followup.status.json').read_text())
assert status['complete'] and status['running'] is None
assert all(r['actual_exit'] == 0 for r in status['completed'])
strict = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert strict['counts']['complete_output_arrays'] == 96
assert sum(strict['strict'].values()) == 81
report = json.loads((BASE / 'replay-report.json').read_text())
paths = [BASE / p for p in ('plan.json', 'run.status.json', 'followup.status.json', 'replay-report.json',
                           'replay-independent-cpu-audit.json', 'independent-cpu-audit.json')]
cases = []
stages = ('precondition_first', 'matrix_first', 'precondition_last', 'matrix_last')
for run in plan['runs']:
    label = run['label']
    layout_path = BASE / label / 'trace/snapshot-layout.json'
    layout = json.loads(layout_path.read_text())
    paths.append(layout_path)
    for stage in layout['stages']:
        if stage['key'] not in stages:
            continue
        key = stage['key']
        counter = 6 if key.startswith('precondition') else 9
        packet_path = BASE / label / 'trace' / (key + '-packets/frame-00.npz')
        with np.load(packet_path, allow_pickle=False) as packet:
            initial = int.from_bytes(packet['before-arg-' + str(counter)].tobytes(), 'little')
            assert initial == 0
            targets = {int.from_bytes(packet['after-arg-' + str(counter)].tobytes(), 'little')}
        replay_path = BASE / 'replay' / (label + '-' + key + '.npz')
        with np.load(replay_path, allow_pickle=False) as saved:
            for backend in ('original-runtime', 'original-ptx', 'source-ptx'):
                targets.add(int.from_bytes(saved[backend + '-output-' + str(counter)].tobytes(), 'little'))
        paths.extend((packet_path, replay_path))
        cases.append({'label': label, 'stage': key, 'layout': stage, 'packet': str(packet_path),
                      'initial_bits': initial, 'target_bits': sorted(targets)})
paths.extend([Path(__file__), ROOT / 'reconstruction/csrc/g1_nl2_atomic.py', BASE / 'atomic-independent-cpu-audit.py',
              BASE / 'run-atomic.py', ROOT / 'reconstruction/csrc/surface_atomic_operands.py',
              ROOT / 'reconstruction/csrc/particle_reduction_certificates.py'])
for path in (ROOT / 'reconstruction/csrc/g1_nl2_atomic.py', BASE / 'atomic-independent-cpu-audit.py',
             BASE / 'run-atomic.py', Path(__file__)):
    ast.parse(path.read_text())
    assert all(len(line) <= 128 for line in path.read_text().splitlines()), str(path)
hashes = dict(plan['input_sha256'])
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
atomic_plan = {'input_sha256': hashes, 'cases': cases, 'kernels': plan['kernels'],
               'fixed_search_limit_per_case': 100000, 'full_trace_shape': [256, 128, 16],
               'real_probe_calls': 16, 'actual_SDK_PTX_source_isolation_calls': 48,
               'isolation_control': 'only world pointer NULL->unique ids and scalar output->176 guarded slots; +0/-0',
               'production_changed': False, 'strict_failures_reclassified': False, 'whole_solver_complete': False}
output = BASE / 'atomic-plan.json'
assert not output.exists() and len(cases) == 8
output.write_text(json.dumps(atomic_plan, indent=2) + '\n')
print('Frozen8 actual inputs;16 literal probes,48 SDK/PTX/source isolations; existing targets',
      sum(len(c['target_bits']) for c in cases))
