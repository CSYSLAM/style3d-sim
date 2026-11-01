"""Load the explicitly hashed isolated source candidate through the established independent host bridge."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
build = json.loads((BASE / 'candidate2/build.json').read_text())
for name, digest in build['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
from reconstruction.csrc import host_particles_ab, demo_source_ab


def candidate():
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.source_only and not module.solver_api_ready
    return module


host_particles_ab.native_source = candidate
demo_source_ab.main()
