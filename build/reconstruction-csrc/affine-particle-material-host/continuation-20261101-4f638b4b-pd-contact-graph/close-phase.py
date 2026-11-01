"""Close the completed graph and SO3 diagnostics while preserving the failed full-trajectory gates."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
assert not (BASE / 'phase-manifest.json').exists()
definitions = json.loads((BASE / 'definitions4-v2/status.json').read_text())
captures = json.loads((BASE / 'so3-captures/status.json').read_text())
for status in (definitions, captures):
    assert status['complete'] and status['running'] is None and len(status['completed']) == 4
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert all(not row['source0_whole_trajectory_bitwise'] and not row['original0_whole_trajectory_bitwise']
               for row in status['completed'])
graph = json.loads((BASE / 'definition-comparison.json').read_text())
assert len(graph['cases']) == 3 and all(row['topology_equal'] and
    row['complete_typed_parameters_and_cross_graph_pointer_patterns_equal'] for row in graph['cases'])
assert graph['function_resource_difference_count'] == 10 and not graph['device_pointees_read']
replays = json.loads((BASE / 'so3-replays/report.json').read_text())
cpu = json.loads((BASE / 'so3-independent-cpu-audit.json').read_text())
assert replays['complete'] and replays['actual_calls'] == cpu['actual_calls_independently_checked'] == 5760
assert replays['all_complete_outputs_equal'] and replays['all_unwritten_and_guards_equal']
assert cpu['last_SO3_q_public_q_byte_checks'] == 240 and cpu['eight_graph_snapshot_orders_checked']
assert [r['within_existing_fixed_C8'] for r in cpu['diagnostic_trajectory_fixed_C8_checks']] == [False, False, True, False]
plan = json.loads((BASE / 'so3-replays/plan.json').read_text())
for path, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
next_step = json.loads((BASE / 'next-step.json').read_text())
for path, expected in next_step['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
assert not next_step['source0_replaced'] and not next_step['candidate_promoted']
paths = [p for p in sorted(BASE.rglob('*')) if p.is_file() and '__pycache__' not in p.relative_to(BASE).parts]
for path in [*paths, ROOT / 'reconstruction/csrc/affine_so3_graph_capture.py',
             ROOT / 'reconstruction/csrc/affine_so3_graph_replay.py']:
    if path.suffix == '.py':
        ast.parse(path.read_text())
        assert all(len(line) <= 128 for line in path.read_text().splitlines()), path
files = {str(p.relative_to(ROOT)): {'bytes': p.stat().st_size, 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()}
         for p in paths}
assert all(item['bytes'] < 100 * 1024 * 1024 for item in files.values())
record = {'files': files, 'phase_open': False, 'actual_sessions': {'definition_v1': 1, 'definitions_v2_3377': 0,
          'so3_captures11027': 0, 'so3_prepare88307': 0, 'so3_replays76134': 0, 'so3_independent_CPU54821': 0},
          'three_source_pair_graph_parameter_checks_passed': True, 'SO3_real_packets': 960, 'SO3_actual_calls': 5760,
          'all_observed_SO3_complete_outputs_strict': True, 'independent_CPU_audit_passed': True,
          'old_fixed_full_trajectory_failures_reclassified': False, 'candidate_promoted': False,
          'production_changed': False, 'whole_solver_complete': False}
(BASE / 'phase-manifest.json').write_text(json.dumps(record, indent=2) + '\n')
print('Closed graph/SO3 phase:', len(files), 'files;5760 calls strict; full-trajectory failure retained')
