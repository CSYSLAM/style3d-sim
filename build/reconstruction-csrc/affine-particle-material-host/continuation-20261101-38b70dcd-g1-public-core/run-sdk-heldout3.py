"""Calibrate the fixed C8 rule on three new SDK controls; never add them to its frozen eight baselines."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import spread_report

base = Path(__file__).resolve().parent
initcheck = json.loads((base / 'initcheck60/status.json').read_text())
origin = json.loads((base / 'initcheck-origin-audit.json').read_text())
assert initcheck['complete'] and origin['array_field_exactly_identified_on_both_backends']
assert origin['unused_capacity_read_by_post_run_model_nan_scanner']
assert origin['prefix_control_no_reports_between_markers']
cohort = base / 'graph60-fixed-original-C8'
report_path = cohort / 'report.json'
original_report_bytes = report_path.read_bytes()
report = json.loads(original_report_bytes)
paths = {tag: Path(name) for tag, name in report['input_npz_paths'].items()}
locked = {str(path): report['input_npz_sha256'][tag] for tag, path in paths.items()}
runner = base.parent / ('continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                        'official-g1-public-core-graph60/worker-as-run.py')
assets = json.loads((base.parent / 'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                     'official-g1-asset-manifest.json').read_text())
for name, entry in assets['files'].items():
    locked[str(Path(assets['cache_root']) / name)] = entry['sha256']
core_build = root / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'
output = base / 'sdk-heldout3'
output.mkdir(exist_ok=False)
(output / 'plan.json').write_text(json.dumps({
    'SDK_control_runs': 3, 'fixed_baseline_runs': 8, 'new_controls_added_to_baseline': False,
    'fixed_source_C8_report_sha256': hashlib.sha256(original_report_bytes).hexdigest(),
    'input_sha256': locked, 'purpose': 'Check whether the same fixed rule also rejects identical SDK code',
    'whole_solver_complete': False}, indent=2) + '\n')
execute = ("import sys;from pathlib import Path;p=Path(sys.argv.pop(1));"
           "exec(compile(p.read_bytes(),str(p),'exec'),"
           "{'__name__':'__main__','__package__':'reconstruction.csrc','__file__':str(p)})")
expected_runtime = json.loads((cohort / 'original0/runtime.json').read_text())
status = {'complete': False, 'running': None, 'completed': [], 'whole_solver_complete': False}
controls = []
for index in range(3):
    assert report_path.read_bytes() == original_report_bytes
    for name, digest in locked.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    tag = 'SDK-control' + str(index)
    folder = output / tag
    command = [sys.executable, '-c', execute, str(runner), '--backend', 'original', '--core-build', str(core_build),
               '--example', 'examples/example_robot_g1.py', '--frames', '60', '--output', str(folder),
               '--', '--solver', 'synreal', '--world-count', '1']
    (output / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    status['running'] = tag
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    with (output / (tag + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
    assert code == 0, (tag, code)
    runtime = json.loads((folder / 'runtime.json').read_text())
    assert runtime == expected_runtime
    controls.append(folder / 'states.npz')
    status['completed'].append({'tag': tag, 'exit': code})
    status['running'] = None
    print(tag, 'completed; baseline and failed source cohort unchanged', flush=True)
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(paths[f'original{i}'])) for i in range(8)]
    heldout = [stack.enter_context(np.load(path)) for path in controls]
    statistics = {f'SDK-control{i}': spread_report(originals, [run]) for i, run in enumerate(heldout)}
    within = {tag: {key: row['substeps_within_spread'] == row['substeps'] for key, row in values.items()}
              for tag, values in statistics.items()}
    result = {'statistics': statistics, 'all_frames_within': within,
              'all_SDK_controls_pass_fixed_rule': all(all(values.values()) for values in within.values()),
              'new_controls_added_to_baseline': False, 'source_C8_failure_reclassified': False,
              'fixed_source_C8_report_sha256': hashlib.sha256(original_report_bytes).hexdigest(),
              'control_npz_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in controls},
              'whole_solver_complete': False}
    (output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
assert report_path.read_bytes() == original_report_bytes
status['complete'] = True
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
print('Identical SDK controls satisfy the fixed rule:', result['all_SDK_controls_pass_fixed_rule'], within, flush=True)
