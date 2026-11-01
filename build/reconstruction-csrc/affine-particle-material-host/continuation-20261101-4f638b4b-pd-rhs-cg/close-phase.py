"""Freeze actual RHS/CG evidence without promoting the contact candidate or reclassifying old failures."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
assert not (BASE / 'phase-manifest.json').exists()
old = json.loads((BASE / 'rhs-captures/status.json').read_text())
assert not old['complete'] and old['completed'][0]['actual_exit'] == 1
status = json.loads((BASE / 'rhs-captures-v2/status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 4
assert all(r['actual_exit'] == 0 and not r['source0_whole_trajectory_bitwise'] and
           not r['original0_whole_trajectory_bitwise'] for r in status['completed'])
cpu = json.loads((BASE / 'rhs-independent-cpu-audit.json').read_text())
assert cpu['stage_packets_checked'] == 21600 and cpu['public_q_matches'] == 240 and cpu['alias_groups_checked'] == 2880
assert [r['within_existing_C8'] for r in cpu['diagnostic_trajectory_C8_checks']] == [False, False, True, False]
first = json.loads((BASE / 'first-CG-replay/report.json').read_text())
first_cpu = json.loads((BASE / 'first-CG-independent-cpu-audit.json').read_text())
assert first['complete'] and first['actual_calls'] == first_cpu['actual_calls'] == 72
assert first_cpu['real_per_lane_raw_operand_words_checked'] == 108
assert first_cpu['runtime_PTXX_source_isolated_word_checks'] == 324
assert first_cpu['hardware_F32_fold_history_words_checked'] == 216
update = json.loads((BASE / 'first-update/report.json').read_text())
update_cpu = json.loads((BASE / 'first-update-independent-cpu-audit.json').read_text())
assert update['complete'] and update['actual_calls'] == update_cpu['actual_calls_checked'] == 36
assert update_cpu['complete_output_words_checked'] == 7776
graphs = json.loads((BASE / 'definition-comparison.json').read_text())
assert all(r['topology_equal'] and r['complete_typed_parameters_and_cross_graph_pointer_patterns_equal']
           for r in graphs['cases'])
for path in (BASE / 'first-CG-replay/plan.json', BASE / 'first-update/plan.json', BASE / 'next-step.json'):
    for name, expected in json.loads(path.read_text())['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
paths = [p for p in sorted(BASE.rglob('*')) if p.is_file() and '__pycache__' not in p.relative_to(BASE).parts]
for path in [*paths, ROOT / 'reconstruction/csrc/pd_contact_rhs_capture.py',
             ROOT / 'reconstruction/csrc/pd_contact_rhs_audit.py', ROOT / 'reconstruction/csrc/pd_contact_first_cg_replay.py']:
    if path.suffix == '.py':
        ast.parse(path.read_text())
        assert all(len(line) <= 128 for line in path.read_text().splitlines()), path
files = {str(p.relative_to(ROOT)): {'bytes': p.stat().st_size, 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()}
         for p in paths}
assert all(v['bytes'] < 100 * 1024 * 1024 for v in files.values())
record = {'files': files, 'phase_open': False, 'actual_sessions': {'capture_v1_91528': 1, 'capture_v2_69473': 0,
          'static_PTX_42850': 0, 'RHS_CPU_56941': 0, 'first_CG_execute': 0, 'first_CG_CPU': 0,
          'first_update_execute': 0, 'first_update_CPU': 0}, 'observed_stage_packets': 21600,
          'first_CG_calls': 72, 'first_CG_F32_certificates': 18, 'following_update_calls': 36,
          'all_CPU_audits_passed': True, 'candidate_promoted': False, 'production_changed': False,
          'original_fixed_failure_reclassified': False, 'whole_solver_complete': False}
(BASE / 'phase-manifest.json').write_text(json.dumps(record, indent=2) + '\n')
print('Closed RHS/CG phase:', len(files), 'files;old long failure retained;production unchanged')
