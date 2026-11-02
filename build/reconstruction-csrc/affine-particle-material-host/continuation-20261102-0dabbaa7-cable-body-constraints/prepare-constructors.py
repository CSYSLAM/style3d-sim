"""Version the established five-part constructor audit for six actual cable/constraint classes on shared GPU."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
previous = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/check-constructors.py'
before = previous.read_text()
text = before
changes = [
    ('Capture actual coupled cloth/self constructors, including template and flattened soft-contact layouts.',
     'Capture actual cable/plain-constraint constructors with the established five independent checks.'),
    ("BASE / 'discovery/plan.json'", "BASE / 'discovery-v2-3/plan.json'"),
    ("BASE / 'candidate-force-order/build.json'", "BASE / 'candidate-scope-only/build.json'"),
    ("BASE / 'force-order-captures/report.json'", "BASE / 'candidate-v2-3/status.json'"),
    (".read_text())['cases']\nassert len(reports) == 12", ".read_text())['completed']\nassert len(reports) == 24"),
    ("BASE / 'force-order-captures/status.json'", "BASE / 'candidate-v2-3/status.json'"),
    ("BASE / 'constructors-force-order'", "BASE / 'constructors-scope-only'"),
    ("ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py'", "ROOT / 'reconstruction/csrc/cable_body_constraint_scene.py'"),
    ("(0, 2, 7, 11)", "(0, 7, 8, 15, 16, 23)"),
    ("[sys.executable, str(BASE / 'worker.py')", "[sys.executable, '-B', str(BASE / 'worker.py')"),
    ("[sys.executable, '-m', 'reconstruction.csrc.affine_constructor_audit'",
     "[sys.executable, '-B', '-m', 'reconstruction.csrc.affine_constructor_audit'"),
    ("Four actual driven-self constructor classes passed all five checks",
     "Six actual cable/constraint constructor classes passed all five checks"),
]
for old, new in changes:
    assert text.count(old) == 1, old
    text = text.replace(old, new)
old = '''    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            dump()
            if not live:
                break
            time.sleep(5)
'''
new = '''    if gpu:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live,
                                    'free_memory_MiB': free, 'external_apps_allowed': True})
        dump()
        assert free >= 4096
'''
assert text.count(old) == 1
text = text.replace(old, new)
compile(text, 'check-constructors.py', 'exec')
assert max(map(len, text.splitlines())) <= 128
target = BASE / 'check-constructors.py'
assert not target.exists()
target.write_text(text)
(BASE / 'constructor-driver-origin.json').write_text(json.dumps({
    'previous': str(previous), 'previous_sha256': hashlib.sha256(before.encode()).hexdigest(),
    'new': str(target), 'new_sha256': hashlib.sha256(text.encode()).hexdigest(),
    'generator_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'own_GPU_workers_serial': True, 'external_apps_allowed': True,
    'production_modified': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Prepared versioned six-class constructor capture with shared GPU memory admission')
