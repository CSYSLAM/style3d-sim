"""Freeze all 1000 actual reduction inputs and existing scalar targets before GPU certification."""
import ast
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_fourth_full_cg_atomic import rendered_worker

template = rendered_worker()
ast.parse(template)
assert not (BASE / 'atomic-template.py').exists()
(BASE / 'atomic-template.py').write_text(template)
plan = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'followup.status.json').read_text())
assert status['complete'] and status['running'] is None
assert all(r['actual_exit'] == 0 for r in status['completed'])
strict = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert strict['counts']['complete_output_arrays'] == 10620
assert all(strict['strict'][key] == count for key, count in strict['total'].items()
           if not (key.startswith('precondition:') and key.endswith(':6')
                   or key.startswith('matrix:') and key.endswith(':9')))
report = json.loads((BASE / 'replay-report.json').read_text())
paths = [BASE / p for p in ('plan.json', 'run.status.json', 'followup.status.json', 'replay-report.json',
                           'replay-independent-cpu-audit.json', 'independent-cpu-audit.json')]
cases = []
stages = ('precondition', 'matrix')
for run in plan['runs']:
    label = run['label']
    layout_path = BASE / label / 'trace/snapshot-layout.json'
    layout = json.loads(layout_path.read_text())
    paths.append(layout_path)
    for stage in layout['stages']:
        if stage['kernel_key'] not in stages:
            continue
        key = stage['key']
        counter = 6 if stage['kernel_key'] == 'precondition' else 9
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
paths.extend([BASE / 'atomic-template.py', Path(__file__), ROOT / 'reconstruction/csrc/g1_fourth_full_cg_atomic.py',
              BASE / 'atomic-independent-cpu-audit.py',
              BASE / 'run-atomic.py', ROOT / 'reconstruction/csrc/surface_atomic_operands.py',
              ROOT / 'reconstruction/csrc/particle_reduction_certificates.py'])
for path in (ROOT / 'reconstruction/csrc/g1_fourth_full_cg_atomic.py', BASE / 'atomic-independent-cpu-audit.py',
             BASE / 'run-atomic.py', Path(__file__)):
    ast.parse(path.read_text())
    assert all(len(line) <= 128 for line in path.read_text().splitlines()), str(path)
hashes = dict(plan['input_sha256'])
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
atomic_plan = {'input_sha256': hashes, 'cases': cases, 'kernels': plan['kernels'],
               'fixed_search_limit_per_case': 100000, 'full_trace_shape': [256, 128, 16],
               'real_probe_calls': 2000, 'actual_SDK_PTX_source_isolation_calls': 6000,
               'isolation_control': 'only world pointer NULL->unique ids and scalar output->176 guarded slots; +0/-0',
               'production_changed': False, 'strict_failures_reclassified': False, 'whole_solver_complete': False}
output = BASE / 'atomic-plan.json'
assert not output.exists() and len(cases) == 1000
output.write_text(json.dumps(atomic_plan, indent=2) + '\n')
print('Frozen1000 actual inputs;2000 literal probes,6000 SDK/PTX/source isolations; existing targets',
      sum(len(c['target_bits']) for c in cases))
