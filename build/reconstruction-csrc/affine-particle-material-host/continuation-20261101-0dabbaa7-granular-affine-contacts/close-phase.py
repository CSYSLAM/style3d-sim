"""Freeze this completed experimental phase, including the unaccepted long PD/mixed result."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
candidate = json.loads((BASE / 'candidate-guard-only/build.json').read_text())
assert candidate['image_sha256'] == '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326'
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == candidate['image_sha256']
for path, sha in candidate['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
discovery = json.loads((BASE / 'discovery-v2/status.json').read_text())
capture = json.loads((BASE / 'candidate-captures/status.json').read_text())
assert discovery['complete'] and len(discovery['completed']) == 12
assert capture['complete'] and len(capture['completed']) == 6
assert all(row['actual_exit'] == 0 for row in capture['completed'])
short = json.loads((BASE / 'candidate-captures/report.json').read_text())['cases']
assert sum(row['strict_passed'] for row in short) == 4
short_spread = json.loads((BASE / 'fixed-C8-cpu-audit.json').read_text())
assert len(short_spread['cases']) == 2 and all(row['all3_sources_within_C8'] for row in short_spread['cases'])
constructors = []
for name, expected in (('constructors-guard-only', 3), ('constructor-pd-mixed', 1)):
    status = json.loads((BASE / name / 'status.json').read_text())
    reports = json.loads((BASE / name / 'report.json').read_text())['cases']
    assert status['complete'] and len(reports) == expected
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert all(len(row['checks']) == 5 and all(row['checks'].values()) for row in reports)
    constructors.extend(reports)
graphs = BASE / 'graph60-and-initcheck-v2'
status = json.loads((graphs / 'status.json').read_text())
assert status['complete'] and len(status['completed']) == 8
assert all(row['actual_exit'] == 0 for row in status['completed'])
assert all('ERROR SUMMARY: 0 errors' in path.read_text() for path in graphs.glob('initcheck-*/run.log'))
strict = json.loads((graphs / 'graph-report.json').read_text())
assert strict['passed'] == 16 and strict['total'] == 24
long = json.loads((BASE / 'graph-fixed-C8-cpu-audit.json').read_text())
assert long['fixed_source0_passed_groups'] == 11 and long['all3_passed_groups'] == 10
assert long['total_groups'] == 12 and not long['all_acceptance_passed']
beef = json.loads((BASE / 'beef-fixed-C8-cpu-audit.json').read_text())
assert len(beef['cases']) == 1 and beef['cases'][0]['all3_sources_within_C8']
host = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(host.read_bytes()).hexdigest() == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
output = BASE / 'phase-manifest.json'
assert not output.exists()
paths = [path for path in sorted(BASE.rglob('*')) if path.is_file() and path != output
         and '__pycache__' not in path.relative_to(BASE).parts]
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(item['bytes'] < 100 * 1024 * 1024 for item in files.values())
record = {'files': files, 'phase_open': False, 'candidate_sha256': candidate['image_sha256'],
          'actual_sessions': {'discover9695': 1, 'no_dump_control62030': 0, 'discover_v2_16547': 0,
          'build92973': 0, 'capture5014': 1, 'short_C8_38312': 0, 'constructors46584': 0,
          'graph68324': 1, 'graph_v2_5062': 0, 'long_C8_59776': 1, 'PD_constructor28571': 0,
          'beef_demo94147': 1, 'beef_C8_22155': 0},
          'independent_CPU_audits_actual_exit': 0, 'short_strict_cases': 4, 'short_cases': 6,
          'short_failed_source0_C8_passed_cases': 2, 'constructor_five_checks': constructors,
          'graph_strict': 16, 'graph_comparisons': 24, 'dual_initcheck_zero_error_tasks': 6,
          'long_C8_source0_passed_groups': 11, 'long_C8_all3_passed_groups': 10, 'long_C8_groups': 12,
          'beef_low_resolution_three_frame_fixed_C8_passed': True,
          'failed_case': 'w3-b1-n2-s1-mixed-pd-b0-both-hit0', 'full_candidate_acceptance_passed': False,
          'production_changed': False, 'candidate_promoted': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('Closed contact evidence:', len(files), 'files; long PD/mixed failure retained; production unchanged')
