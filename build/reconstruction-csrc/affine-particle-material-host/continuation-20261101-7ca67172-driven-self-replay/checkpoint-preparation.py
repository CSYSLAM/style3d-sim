"""Freeze actual raw-ABI evidence and a pending complete-input replay request without claiming GPU completion."""
import gzip
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'preparation-manifest.json'
assert not OUTPUT.exists()
audit = json.loads((BASE / 'raw-ABI/report.json').read_text())
assert audit['all_actual_parameter_bytes_equal'] and not audit['failures']
assert (audit['owned_calls'], audit['parameter_count'], audit['parameter_bytes']) == (6272, 68440, 737758)
calls, parameters, size = 0, 0, 0
for worker in audit['workers']:
    path = Path(worker['packets'])
    assert hashlib.sha256(path.read_bytes()).hexdigest() == worker['packets_sha256']
    packets = json.loads(gzip.decompress(path.read_bytes()))
    assert len(packets) == worker['owned_calls']
    for packet in packets:
        node = packet['node']
        assert node['parameter_hex'] == packet['CUPTI_actual_parameter_hex']
        assert [len(bytes.fromhex(value)) for value in node['parameter_hex']] == node['parameter_widths']
        calls += 1
        parameters += len(node['parameter_hex'])
        size += sum(node['parameter_widths'])
assert (calls, parameters, size) == (6272, 68440, 737758)
for name, expected in audit['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
request = json.loads((BASE / 'replay-request.json').read_text())
assert request['planned_complete_input_packets'] == 1188 and request['planned_actual_calls'] == 3564
for name, expected in request['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
identity = json.loads((BASE / 'pipeline/runner-identity.json').read_text())
proc = Path('/proc') / str(identity['pid'])
stat = (proc / 'stat').read_text().split(') ', 1)[1].split()
assert int(stat[19]) == identity['start_ticks'] and stat[0] != 'Z'
assert Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id']
assert 'driven-self-replay/run-pipeline.py' in (proc / 'cmdline').read_bytes().decode()
status = json.loads((BASE / 'pipeline/status.json').read_text())
assert not status['completed'] and status['running'] is None
paths = []
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or '__pycache__' in path.parts or path.suffix == '.pyc':
        continue
    relative = path.relative_to(BASE)
    if str(relative) == 'pipeline-driver.log' or relative.parts[0] == 'complete-input-replays':
        continue
    if relative.parts[0] == 'pipeline' and (
            len(relative.parts) != 2 or relative.name not in ('runner-inputs.json', 'runner-identity.json')):
        continue
    paths.append(path)
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(row['bytes'] < 100 * 1024 * 1024 for row in files.values())
OUTPUT.write_text(json.dumps({'files': files, 'phase_open': True, 'actual_raw_ABI_calls_equal': calls,
    'actual_raw_ABI_parameters_equal': parameters, 'actual_raw_ABI_bytes_equal': size,
    'planned_complete_input_packets': 1188, 'planned_actual_calls': 3564, 'queue_tool_session': 97272,
    'GPU_used_for_this_checkpoint': False, 'GPU_runtime_validation_claimed': False,
    'live_status_logs_and_pending_GPU_outputs_excluded': True, 'fixed_failures_reclassified': False,
    'candidate_promoted': False, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Frozen', len(files), 'files;6272 actual raw-ABI matches;1188 packet replay still pending', flush=True)
