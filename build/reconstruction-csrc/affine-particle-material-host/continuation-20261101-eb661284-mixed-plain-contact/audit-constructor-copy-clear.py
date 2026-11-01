"""Compare the eight already captured constructor D2D and byte-fill sequences without running GPU work."""
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
base = Path(__file__).resolve().parent
validation = base / 'validation-38b70dcd'
status = json.loads((validation / 'status.json').read_text())
completed = {row['name'] for row in status['completed'] if row['exit'] == 0}
output = validation / 'constructor8-copy-clear'
output.mkdir(exist_ok=False)
rows = []
for kind in ('spring-line', 'spring-distance', 'line-distance', 'all'):
    for mode in ('newton', 'pd'):
        name = f'{kind}-{mode}-constructor'
        assert name in completed
        constructor = validation / name
        assert json.loads((constructor / 'audit.json').read_text())['all_captured_checks_passed']
        capture = constructor / f'mixed-plain-contact-{kind}-{mode}-w3-full-memory'
        target = output / (kind + '-' + mode + '.json')
        command = [sys.executable, '-m', 'reconstruction.csrc.device_memory_sequence_audit',
                   '--capture', str(capture), '--output', str(target)]
        (output / (kind + '-' + mode + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        subprocess.run(command, cwd=root, check=True)
        report = json.loads(target.read_text())
        assert report['all_captured_sequences_equal'] and not report['differences']
        rows.append({'case': kind + '-' + mode, 'counts': [side['counts'] for side in report['captures']]})
(output / 'summary.json').write_text(json.dumps({
    'cases': rows, 'all_captured_sequences_equal': True, 'GPU_used': False,
    'external_pointee_equality_proven': False, 'all_cuda_apis_captured': False,
    'whole_solver_complete': False}, indent=2) + '\n')
