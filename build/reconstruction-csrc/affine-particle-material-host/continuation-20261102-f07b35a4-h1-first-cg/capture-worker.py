"""Attach bounded snapshots after H1 inline capture, then record the first actual replay through the normal public API."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
output = args.output.resolve()
output.mkdir(parents=True, exist_ok=False)
trace = output / 'trace'
trace.mkdir()
namespace = {'__name__': 'reconstruction.csrc.h1_first_cg_transport', '__package__': 'reconstruction.csrc',
             '__file__': str(BASE / 'transport-as-run.py')}
exec(compile((BASE / 'transport-as-run.py').read_text(), namespace['__file__'], 'exec'), namespace)
observer = namespace['Observer'](trace, json.loads(Path(plan['abi']).read_text()))
previous = BASE.parent / 'continuation-20261102-ae3a5997-driven-self'
worker = previous / 'public-h1-worker.py'
text = worker.read_text()
old = 'ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent'
assert text.count(old) == 1
text = text.replace(old, 'ROOT, BASE = Path.cwd(), asset_manifest_base', 1)
old = '        original_step()\n'
assert text.count(old) == 1
text = text.replace(old, old + '        if not old_graph:\n            cg_observer.attach(example)\n'
                    '        else:\n            cg_observer.record()\n', 1)
patched = output / 'worker-as-run.py'
patched.write_text(text)
provenance = {'base_worker_sha256': hashlib.sha256(worker.read_bytes()).hexdigest(),
              'worker_as_run_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
              'diagnostic_snapshots_can_change_atomic_scheduling': True, 'fixed_C8_source0_replaced': False,
              'ab_bridge_used': False, 'whole_solver_complete': False, 'complete': False}
sys.argv = [str(patched), '--backend', args.backend, '--core-build', plan['core_build'],
            '--output', str(output / 'worker'), '--frames', str(plan['frames'])]
try:
    exec(compile(text, str(patched), 'exec'), {'__name__': '__main__', '__file__': str(patched),
         'asset_manifest_base': previous, 'cg_observer': observer})
    assert observer.frames == 1
    provenance['complete'] = True
finally:
    provenance['frames_read'] = observer.frames
    (output / 'trace-provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')
    observer.close()
