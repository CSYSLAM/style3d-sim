"""pytest plugin: choose the solver image before tests import style3d_sim.

    SYNREAL_BACKEND=original|source .venv/bin/python -m pytest -p reconstruction.audit.pytest_backend tests

`original` is the project-internal reference image (64a0be7f, no login); `source` is the compiled _source_solver
installed as style3d_sim._core. Login credentials are removed from the environment.
"""
import hashlib
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
for key in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD'):
    os.environ.pop(key, None)
sys.path.insert(0, str(ROOT))
backend = os.environ.get('SYNREAL_BACKEND', 'original')
if backend == 'original':
    from reconstruction.csrc.host_api_probe import load_reference
    core = load_reference()
elif backend == 'source':
    from reconstruction.csrc.host_bodies_ab import bridge
    from reconstruction.csrc.host_particles_ab import native_source
    core = native_source()
    bridge(core)
else:
    raise SystemExit(f'SYNREAL_BACKEND must be original or source, not {backend!r}')
IMAGE = Path(core.__file__).resolve()


def pytest_report_header(config):
    return f'synreal backend: {backend} {IMAGE} sha256={hashlib.sha256(IMAGE.read_bytes()).hexdigest()[:16]}'
