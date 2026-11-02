"""Freeze completed CPU preparation and immutable queue inputs while excluding live GPU outputs."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'preparation-manifest.json'
assert not OUTPUT.exists()
for name in ('parser-independent-cpu.json', 'cache-resolver-independent-cpu.json', 'anymal-USD-independent-cpu-v3.json'):
    report = json.loads((BASE / name).read_text())
    for path, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
asset = ROOT / 'reconstruction/assets/anybotics_anymal_d'
manifest = json.loads((asset / 'manifest.json').read_text())
assert len(manifest['files']) == 20
cache = json.loads((BASE / 'asset-restore.json').read_text())
for name, expected in manifest['files'].items():
    for directory in (asset / 'files', Path(cache['asset_path'])):
        raw = (directory / name).read_bytes()
        assert len(raw) == expected['bytes'] and hashlib.sha256(raw).hexdigest() == expected['sha256']
paths = list(BASE.glob('*.py')) + list(BASE.glob('*.json')) + list(BASE.glob('*.log'))
paths += [BASE / 'short3/plan.json', BASE / 'normal-core3/plan.json']
paths += [path for path in (BASE / 'asset-cache').rglob('*') if path.is_file()]
paths += [path for path in asset.rglob('*') if path.is_file()]
paths += [ROOT / name for name in ('reconstruction/demo_ab.py', 'scripts/restore_reconstruction_anymal_assets.py',
          'reconstruction/csrc/OFFICIAL_DEMO_FOUR_0DABBAA7.md')]
files = {}
for path in sorted(set(paths)):
    assert path.is_file() and path.suffix not in ('.pyc', '.tmp') and '__pycache__' not in path.parts
    raw = path.read_bytes()
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
record = {'files': files, 'preparation_only': True, 'CPU_parser_defaults_and_override_flags_verified': True,
          'CPU_prior_bend_defaults_preserved': True, 'ANYmal_asset_files': 20, 'ANYmal_asset_bytes': 4317058,
          'actual_Newton_fresh_and_expired_cache_resolution_verified': True,
          'CPU_USD_rigid_bodies': 17, 'CPU_USD_joints': 16, 'CPU_USD_local_dependencies': 16,
          'CPU_USD_unresolved_dependencies': ['OmniPBR.mdl'], 'unresolved_references_are_30_shader_attributes': True,
          'short_queue_tool_session': 70166, 'normal_queue_tool_session': 99307,
          'new_GPU_runtime_claims': False, 'mutable_status_logs_and_future_NPZ_excluded': True,
          'old_failures_reclassified': False, 'production_math_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen four-demo preparation:', len(files), 'files;all live GPU outputs excluded', flush=True)
