"""Check that both diagnostic corrections preserved every real capture and all isolation/certificate mathematics."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_joint_rhs_isolated import rendered_source as isolation_source
from reconstruction.csrc.g1_joint_rhs_certificates import rendered_source as certificate_source


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


old, current = BASE / 'atomic', BASE / 'atomic-v2'
probe = ROOT / 'reconstruction/csrc/g1_first_joint_probe.py'
backup = old / 'g1_first_joint_probe-as-run-v1.py'
hashes = {}
for folder in (BASE, old, current):
    plan = json.loads((folder / 'plan.json').read_text())
    for name, expected in plan['input_sha256'].items():
        path = backup if folder == old and Path(name) == probe else Path(name)
        assert sha(path) == expected, name
        hashes[str(path)] = expected
expected = backup.read_text().replace("np.zeros((256, 256, 16), dtype='u1')",
                                     "np.zeros((256, 128, 16), dtype='u1')")
expected = expected.replace('sizes.max() <= 256', 'sizes.max() <= 128')
assert probe.read_text() == expected
for side, label in [('original', 'sdk0'), ('source', 'rebuilt0')]:
    source = BASE / label / 'trace/joint-packets/frame-00.npz'
    assert (old / side / 'joint-packets/frame-00.npz').read_bytes() == source.read_bytes()
    assert (current / side / 'joint-packets/frame-00.npz').read_bytes() == source.read_bytes()
for side in ('original', 'source'):
    assert (old / 'replay' / (side + '-instrumented.ptx')).read_bytes() == (
        current / 'replay' / (side + '-instrumented.ptx')).read_bytes()
for kind, rendered in [('isolation', isolation_source()), ('certificates', certificate_source())]:
    text = rendered.replace("assert len(replay['packets']) == 120", "assert len(replay['packets']) == 2")
    template = current / (kind + '-template.py')
    assert template.read_text() == text
    assert template.read_bytes() == (old / (kind + '-template.py')).read_bytes()
    assert template.read_bytes() == (current / (kind + '-' + kind + '-as-run.py')).read_bytes()
    wrapper = (current / (kind + '-wrapper.py')).read_text()
    wrapper = wrapper.replace('Execute the frozen first-joint diagnostic template without changing production code.',
                              'Run an unchanged frozen template with the project import path explicitly available.')
    wrapper = wrapper.replace('from pathlib import Path\n',
                              'from pathlib import Path\nimport sys\nsys.path.insert(0, str(Path.cwd()))\n')
    wrapper = wrapper.replace('assert not script.exists()\nscript.write_text(text)',
                              'if script.exists():\n    assert script.read_text() == text\nelse:\n    script.write_text(text)')
    assert wrapper == (current / (kind + '-wrapper-v3.py')).read_text()
for name, expected in json.loads((current / 'wrapper-revision.json').read_text())['input_sha256'].items():
    assert sha(Path(name)) == expected, name
assert json.loads((old / 'run.status.json').read_text())['completed'][-1]['actual_exit'] == 1
assert json.loads((current / 'run.status.json').read_text())['completed'][-1]['actual_exit'] == 1
assert all(r['actual_exit'] == 0 for r in json.loads((current / 'continuation-v3.status.json').read_text())['completed'])
fixed = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json')
assert sha(fixed) == '32b6e2a7337aaa80442fa3fd6232896410eb8163e875d35d845d4a8ae82d4e42'
output = BASE / 'revision-independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({
    'input_sha256': hashes, 'two_producer_stride_constants_only': True,
    'all_original_joint_capture_bytes_unchanged': True,
    'instrumented_PTX_and_isolation_certificate_templates_unchanged': True,
    'outer_wrapper_only_import_path_and_identical_template_reuse_changed': True,
    'both_failed_exits_and_sources_preserved': True, 'old_C8_reclassified': False,
    'production_changed': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('All capture/producer/template/wrapper revisions independently checked; old C8 and failures unchanged')
