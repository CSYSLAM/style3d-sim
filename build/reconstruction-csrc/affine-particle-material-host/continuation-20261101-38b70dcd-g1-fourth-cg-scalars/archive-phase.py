"""Close the coefficient observation and controlled checks without promoting them to whole-solver acceptance."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 11
assert all(row['actual_exit'] == 0 for row in status['completed'])
followup = json.loads((BASE / 'followup.status.json').read_text())
assert followup['complete'] and followup['running'] is None
assert all(row['actual_exit'] == 0 for row in followup['completed'])
trace = json.loads((BASE / 'trace-independent-cpu-audit.json').read_text())
assert trace['counts'] == {
    'actual_memcpy_descriptor_bytes': 1170400, 'actual_apply_outputs_checked': 110,
    'actual_apply_output_words_checked': 58080, 'captured_alpha_pairs': 2750,
    'captured_beta_pairs': 2695, 'blob_bytes_checked': 749936,
}
proof = json.loads((BASE / 'coefficient-replay-independent-cpu-audit.json').read_text())
assert proof['counts'] == {'actual_ABI_bytes': 372, 'full_after_bytes': 736080, 'complete_output_words': 73755}
for kind, metric in proof['metrics'].items():
    assert all(metric['complete_output_checks'].values())
    assert metric['guarded_to_zero'] == metric['negative_denominator'] == metric['CPU_RN_division_mismatched_words'] == 0
links = json.loads((BASE / 'coefficient-link-and-range-audit.json').read_text())
assert links['observed_pairs_linked_to_real_graph_producers_and_consumers']
assert links['counts']['actual_beta_previous_num_links'] == 2695
terminal = {
    'CPU_preflight': {'actual_exit': 0}, 'driver': {'session': 77594, 'actual_exit': 0},
    'workers': status['completed'],
    'independent_public_CPU': json.loads((BASE / 'independent-cpu-audit.status.json').read_text()),
    'followup': followup['completed'],
    'coefficient_links_and_ranges_CPU': {'session': 7986, 'actual_exit': 0},
    'commands': {p.name: json.loads(p.read_text()) for p in sorted(BASE.glob('*.command.json'))},
    'all_started_own_GPU_jobs_terminal': True, 'foreign_PID_2687317_interrupted': False,
    'foreign_process_exit': None, 'normal_demo_test_passed_flags_mean_actual_CLI_exit_only': True,
    'controlled_coefficient_replay_not_full_CG_vector_replay': True,
    'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False,
}
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
                               'bytes': sum(row['bytes'] for row in files.values()),
                               'whole_solver_complete': False}, indent=2) + '\n')
print('Closed fourth-CG evidence', len(files), 'files', sum(row['bytes'] for row in files.values()), 'bytes')
