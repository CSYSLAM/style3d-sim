"""Resume after a wrapper import-path failure; reuse exact frozen diagnostic code and never repeat completed probes."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, PARENT = Path.cwd(), Path(__file__).resolve().parent
BASE = PARENT / 'atomic-v2'
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

old = json.loads((BASE / 'run.status.json').read_text())
assert old['completed'][-1]['label'] == 'isolation' and old['completed'][-1]['actual_exit'] == 1
assert not (BASE / 'isolation').exists() and not (BASE / 'certificates').exists()
assert 'ModuleNotFoundError' in (BASE / 'isolation.log').read_text()
for name in ('isolation', 'certificates'):
    wrapper = '''"""Run an unchanged frozen template with the project import path explicitly available."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path.cwd()))
BASE = Path(__file__).resolve().parent
NAME = %r
text = (BASE / (NAME + '-template.py')).read_text()
script = BASE / (NAME + '-' + NAME + '-as-run.py')
if script.exists():
    assert script.read_text() == text
else:
    script.write_text(text)
namespace = {'__name__': 'reconstruction.csrc.first_joint_' + NAME,
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
raise SystemExit(namespace['main']())
''' % name
    path = BASE / (name + '-wrapper-v3.py')
    assert not path.exists()
    path.write_text(wrapper)
revision = {'failed_wrapper_actual_exit': 1, 'failed_before_GPU_isolation_started': True,
            'completed_probe_data_and_templates_unchanged': True,
            'change': 'project root added to sys.path; existing identical as-run template reused',
            'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
                             [Path(__file__), BASE / 'isolation-wrapper-v3.py', BASE / 'certificates-wrapper-v3.py']},
            'production_changed': False, 'whole_solver_complete': False}
(BASE / 'wrapper-revision.json').write_text(json.dumps(revision, indent=2) + '\n')
plan = json.loads((BASE / 'isolation-plan.json').read_text())
status_path = BASE / 'continuation-v3.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}
for label, command, gpu in [
    ('isolation', [sys.executable, str(BASE / 'isolation-wrapper-v3.py'),
                   '--capture', str(BASE), '--output', str(BASE / 'isolation')], True),
    ('certificates', [sys.executable, str(BASE / 'certificates-wrapper-v3.py'),
                      '--capture', str(BASE), '--output', str(BASE / 'certificates')], True),
    ('atomic-followup-cpu-audit', [sys.executable, str(BASE / 'atomic-followup-cpu-audit.py')], False),
]:
    for name, expected in {**plan['input_sha256'], **revision['input_sha256']}.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            status_path.write_text(json.dumps(status, indent=2) + '\n')
            if not live:
                break
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(5)
    (BASE / (label + '-v3.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '-v3.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        status_path.write_text(json.dumps(status, indent=2) + '\n')
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    (BASE / (label + '-v3.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
status['complete'] = True
status_path.write_text(json.dumps(status, indent=2) + '\n')
