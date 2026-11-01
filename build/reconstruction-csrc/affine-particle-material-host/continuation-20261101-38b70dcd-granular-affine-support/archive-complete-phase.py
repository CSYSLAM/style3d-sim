"""Close actual source reconstruction evidence, including all failed diagnostic revisions and fixed SDK controls."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
for filename in ('plan.json', 'candidate-run-plan.json', 'candidate2-run-plan.json',
                 'candidate2/build.json', 'first-force/plan.json'):
    plan = json.loads((BASE / filename).read_text())
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
candidate = json.loads((BASE / 'candidate2-independent-cpu-audit.json').read_text())
assert candidate['passed'] == candidate['cases'] == 4
constructor = json.loads((BASE / 'constructors2/audit.json').read_text())
assert all(constructor['checks'].values()) and constructor['allocation_event_counts'] == [85, 85]
assert constructor['typed_initializer_counts'] == [55, 55] and constructor['upload_counts'] == [26, 26]
assert constructor['kernel_timeline_counts'] == [544, 544] and constructor['owned_launches'] == 485
graph = json.loads((BASE / 'graph60-candidate2-v3/independent-cpu-audit.json').read_text())
assert graph['passed'] == graph['total'] == 16
for side in ('original', 'source'):
    assert 'ERROR SUMMARY: 0 errors' in (BASE / 'candidate2-followup-v3' / ('initcheck-' + side + '.log')).read_text()
broader = json.loads((BASE / 'broader-layouts-v3/report.json').read_text())
assert len(broader['rows']) == 6 and all(r['states']['bitwise'] and r['metadata']['equal'] for r in broader['rows'])
assert sum(r['strict_passed'] for r in broader['rows']) == 5
force = json.loads((BASE / 'first-force/independent-cpu-audit.json').read_text())
assert force['strict_passed'] == 180 and force['counts']['complete_output_arrays'] == 180
reproduced = json.loads((BASE / 'first-force/old-buffer-and-input-order-audit.json').read_text())
assert 'original1' in reproduced['old_force_and_diagonal_jointly_bitwise_reproduced']['source']
old = BASE / 'broader-layouts-v3/w3-bodies1-width3-subset0-newton-block1'
token = '15granular_kernel19accumulate_contacts'
for argument in (1, 2):
    name = 'dump_' + token + '_post_arg' + str(argument) + '.bin'
    assert (old / 'source' / name).read_bytes() == (BASE / 'first-force/original1' / name).read_bytes()
    assert (old / 'original' / name).read_bytes() == (BASE / 'first-force/original0' / name).read_bytes()
statuses = {}
for name in ('candidate.run.status.json', 'candidate2.run.status.json', 'constructors2/run.status.json',
             'candidate2-followup-v3/run.status.json', 'graph60-candidate2-v3/run.status.json',
             'broader-layouts-v3/run.status.json', 'first-force/capture.status.json', 'first-force/followup.status.json'):
    status = json.loads((BASE / name).read_text())
    assert status['complete'] and status['running'] is None and all(r['actual_exit'] == 0 for r in status['completed'])
    statuses[name] = status['completed']
for name in ('candidate2-followup/run.status.json', 'broader-layouts/run.status.json'):
    status = json.loads((BASE / name).read_text())
    assert status['running'] is None and not status['complete']
    for row in status['completed']:
        assert not Path('/proc', str(row['pid'])).exists(), row
terminal = {'successful_child_statuses': statuses,
    'actual_session_exits': {'85554': 0, '23708': 0, '24413': 0, '10867': 0, '50900': 1, '71924': 1,
                            '63949': 0, '68247': 0, '72933': 0},
    'first_constructor_CPU_actual_exit': 1, 'extended_decoder_comparison_actual_exit': 1,
    'candidate2_first_generation_actual_exit': 1,
    'all_started_own_GPU_jobs_terminal': True, 'old_strict_buffer_failures_reclassified': False,
    'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
path = BASE / 'commands-and-terminal-status.json'
assert not path.exists()
path.write_text(json.dumps(terminal, indent=2) + '\n')
manifest = BASE / 'phase-manifest.json'
assert not manifest.exists()
files = {}
for path in sorted(BASE.rglob('*')):
    if path.is_file():
        data = path.read_bytes()
        assert len(data) < 100 * 1024 * 1024, path
        files[str(path.relative_to(BASE))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
manifest.write_text(json.dumps({'files': files, 'file_count': len(files),
    'bytes': sum(row['bytes'] for row in files.values()), 'phase_open': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Closed granular/affine source evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
