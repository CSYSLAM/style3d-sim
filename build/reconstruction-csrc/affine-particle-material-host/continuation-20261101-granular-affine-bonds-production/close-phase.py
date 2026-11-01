"""Freeze the finished production-image checks while preserving their failed acceptance results."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
HOST = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
CORE = '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
validation = BASE / 'validation-0dabbaa7-v2'
constructors = BASE / 'constructors-0dabbaa7'
host = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
core = json.loads((validation / 'core-build.json').read_text())
assert host['extension_sha256'] == HOST
assert core['extension_sha256'] == CORE and core['source_host_sha256'] == HOST
for metadata in (host, core):
    for name, sha in metadata['sources'].items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == sha, name
terminal = json.loads((validation / 'status.json').read_text())
constructor_terminal = json.loads((constructors / 'status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert constructor_terminal['complete'] and constructor_terminal['running'] is None
assert len(constructor_terminal['completed']) == 12
assert all(row['actual_exit'] == 0 for row in constructor_terminal['completed'])
regression = json.loads((validation / 'regression74/status.json').read_text())
assert regression['complete'] and len(regression['completed']) == 74
failures = [row['name'] for row in regression['completed'] if row['exit']]
assert failures == ['particles-seed1', 'particles-seed2', 'particles-seed3',
                    'mixed_cloth-seed3', 'pd_mixed_cloth-seed3']
spread = json.loads((validation / 'regression-fixed-C10/report.json').read_text())
cpu = json.loads((validation / 'regression-fixed-C10/cpu-audit.json').read_text())
expected = {name: name != 'mixed_cloth-seed3' for name in failures}
assert {row['case']: row['every_array_and_step_within'] for row in spread['cases']} == expected
assert {row['case']: row['every_array_and_step_within'] for row in cpu['cases']} == expected
assert all(row['saved_report_reproduced'] for row in cpu['cases'])
assert not cpu['source0_replaced'] and cpu['additional_originals_collected'] == 0
audits = {}
for path in sorted(constructors.glob('*/audit.json')):
    report = json.loads(path.read_text())
    assert report['source_sha256'] == HOST and report['all_captured_checks_passed']
    assert len(report['checks']) == 5 and all(report['checks'].values())
    audits[path.parent.name] = {key: report[key] for key in ('checks', 'allocation_event_counts',
        'upload_counts', 'typed_initializer_counts', 'owned_launches', 'kernel_timeline_counts')}
assert len(audits) == 3
short_counts = {}
for name in ('short-report.json', 'broader-report.json', 'bond-report.json'):
    reports = json.loads((validation / name).read_text())
    assert all(row['strict_passed'] for row in reports)
    short_counts[name] = len(reports)
assert sum(short_counts.values()) == 16
graph = json.loads((validation / 'graph-report.json').read_text())
assert len(graph) == 24 and all(row['bitwise'] for row in graph.values())
output = BASE / 'terminal-verification.json'
assert not output.exists(), 'Do not overwrite a closed phase record'
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
         for path in sorted(BASE.rglob('*')) if path.is_file() and path != output}
record = {'files': files, 'phase_open': False, 'production_host_sha256': HOST, 'matching_Core_sha256': CORE,
          'actual_driver_exits': {'session68428': 0, 'session29879': 0},
          'driver_zero_means_all_acceptance_passed': False, 'validation_children': terminal['completed'],
          'constructor_children': constructor_terminal['completed'], 'short_strict': short_counts,
          'graph_comparisons_bitwise': 24, 'regression74_strict': 69, 'regression74_failures': failures,
          'fixed_source0_C10_every_array_and_step_within': expected, 'independent_CPU_reproduced': True,
          'constructor_five_checks': audits, 'current_regression_acceptance_passed': False,
          'solver_api_ready': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps({key: value for key, value in record.items() if key != 'files'}, indent=2))
print('Frozen production-phase files:', len(files))
