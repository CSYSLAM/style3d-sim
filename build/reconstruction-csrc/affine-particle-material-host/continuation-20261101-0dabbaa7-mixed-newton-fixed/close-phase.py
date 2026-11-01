"""Freeze current-path evidence without changing the failed full-trajectory acceptance result."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
capture = json.loads((BASE / 'traces4/status.json').read_text())
replays = json.loads((BASE / 'replays/status.json').read_text())
cpu = json.loads((BASE / 'independent-frozen-path-audit.json').read_text())
first = json.loads((BASE / 'target-first-difference.json').read_text())
restored = json.loads((BASE / 'archive-restoration.json').read_text())
assert capture['complete'] and len(capture['completed']) == 4
assert replays['complete'] and len(replays['completed']) == 19
assert all(row['actual_exit'] == 0 for item in (capture, replays) for row in item['completed'])
assert cpu['source_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert cpu['fixed_C10_still_failed'] and not cpu['production_changed']
assert cpu['pointwise_packets'] == 732 and cpu['actual_three_backend_calls'] == 4392
assert first['first_world85_difference']['packet'] == '000090.21evaluate_spring_forceE.json'
assert first['world85_six_actual_GPU_folds_identical']
assert len(restored['rows']) == 2 and all(row['fresh_output_all_bytes_equal_original'] for row in restored['rows'])
for path, sha in json.loads((BASE / 'traces4/plan.json').read_text())['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
output = BASE / 'phase-manifest.json'
assert not output.exists()
paths = [path for path in sorted(BASE.rglob('*')) if path.is_file() and path != output
         and 'native' not in path.relative_to(BASE).parts and 'archive-roundtrip' not in path.relative_to(BASE).parts]
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
record = {'files': files, 'phase_open': False, 'source_sha256': cpu['source_sha256'],
          'SDK_sha256': cpu['reference_sha256'], 'actual_sessions': {'capture54379': 0, 'replay16774': 0},
          'independent_CPU_actual_exit': 0, 'target_first_difference_actual_exit': 0,
          'archive_actual_exit': 0, 'fresh_archive_restoration_files': 13592,
          'pointwise_packets': 732, 'actual_three_backend_calls': 4392, 'scatter_packets': 72,
          'first_world85_packet': first['first_world85_difference']['packet'],
          'whole_target_matching_GPU_orders': first['whole_target_matching_orders'],
          'raw_files_retained_locally_and_in_lossless_archives': True,
          'fixed_C10_still_failed': True, 'production_changed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('Closed current mixed-path evidence:', len(files), 'publication files; fixed C10 still false')
