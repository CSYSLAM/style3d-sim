"""Load one explicitly hashed isolated source candidate through the existing source-only A/B bridge."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
parser = argparse.ArgumentParser(add_help=False)
parser.add_argument('--candidate-build', type=Path, required=True)
args, remaining = parser.parse_known_args()
build = json.loads(args.candidate_build.read_text())
for name, sha in build['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
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
sys.argv = [str(Path(__file__)), *remaining]
raise SystemExit(demo_source_ab.main())
