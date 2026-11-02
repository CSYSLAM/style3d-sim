"""Replay surface scale with the unchanged established helper and the exact candidate image."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import surface_common_input_replay as replay

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
build = json.loads(Path(plan['candidate_build']).read_text())
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == plan['candidate_sha256']


def candidate():
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.source_only and not module.solver_api_ready
    return module


replay.native_source = candidate
replay.main()
