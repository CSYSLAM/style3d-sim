"""Verify actual bundle parser defaults and unchanged bend defaults on CPU with CUDA devices hidden."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
assert os.environ.get('CUDA_VISIBLE_DEVICES') == ''
core_path = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(core_path.read_bytes()).hexdigest() == (
    '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7')
spec = importlib.util.spec_from_file_location('style3d_sim._core', core_path)
core = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = core
spec.loader.exec_module(core)
assert core.source_only
from reconstruction import demo_ab


def load(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


previous = BASE / 'demo_ab-before-parser-priority.py'
old = load(previous, 'old_demo_parser')
bundle_path = ROOT / 'examples/cable/example_cable_bundle_hysteresis.py'
sys.path.insert(0, str(bundle_path.parent))
bundle = load(bundle_path, 'actual_bundle_parser_test')
before = old._parser_for(bundle, bundle_path).parse_args([])
after = demo_ab._parser_for(bundle, bundle_path).parse_args([])
required = {'segments': 40, 'eps_max': 2.0, 'tau': 0.1, 'no_dahl': False}
assert all(not hasattr(before, key) for key in required)
assert all(getattr(after, key) == value for key, value in required.items())
assert after.solver == 'synreal' and after.cable_example_name == bundle_path.stem
explicit = demo_ab._parser_for(bundle, bundle_path).parse_args(
    ['--segments', '54', '--eps-max', '1.3', '--tau', '0.2', '--no-dahl'])
assert explicit.segments == 54 and explicit.eps_max == 1.3 and explicit.tau == 0.2 and explicit.no_dahl
bend_path = ROOT / 'examples/cable/example_cable_bend_stiffness.py'
bend = load(bend_path, 'actual_bend_parser_test')
assert vars(old._parser_for(bend, bend_path).parse_args([])) == vars(demo_ab._parser_for(bend, bend_path).parse_args([]))
import warp as wp
assert not wp.get_cuda_devices()
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert str(reference.resolve()) not in Path('/proc/self/maps').read_text()
paths = [Path(__file__), previous, bundle_path, bend_path, ROOT / 'reconstruction/demo_ab.py',
         ROOT / 'examples/cable/cable_utils.py', core_path]
report = {'bundle_original_missing_required_fields': list(required), 'bundle_new_defaults': required,
          'actual_bundle_override_flags_verified': True, 'bend_defaults_identical_to_previous': True,
          'source_public_core_used': True, 'reference_SDK_mapped': False, 'CUDA_devices_visible': 0,
          'solver_constructed_or_stepped': False, 'GPU_numerics_validated': False,
          'input_sha256': {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
          'whole_solver_complete': False}
output = BASE / 'parser-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print('Actual bundle parser defaults/overrides verified;prior bend defaults unchanged;no CUDA or SDK', flush=True)
