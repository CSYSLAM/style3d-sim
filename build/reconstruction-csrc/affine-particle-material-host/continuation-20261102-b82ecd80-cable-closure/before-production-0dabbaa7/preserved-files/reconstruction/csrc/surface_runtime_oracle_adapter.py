"""Run source host plus explicitly substituted actual SDK kernels; never emit a source-only attestation."""
import argparse
import hashlib
import json
import os
from pathlib import Path

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    assert args.output.is_dir()
    assert os.environ.get('RECON_ORACLE_RUNTIME') == str(REFERENCE)
    assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
    from . import host_api_probe
    from .host_particles_ab import native_source
    from .host_bodies_ab import bridge
    core = native_source()
    bridge(core)
    # The worker's original tag omits the source-only map assertion, which is inappropriate for this explicit oracle.
    # Its runtime hash still records the source host image, so it cannot be adopted as an original-reference sample.
    host_api_probe.load_reference = lambda: core
    from . import affine_surface_graph_ab as worker
    args.worker, args.frames = 'original', 60
    worker.worker(args)
    assert '_core.cpython-' in Path('/proc/self/maps').read_text()
    paths = list(args.output.glob('original-*.npz'))
    assert len(paths) == 16
    for path in paths:
        path.rename(path.with_name(path.name.replace('original-', 'oracle-', 1)))
    runtime = json.loads((args.output / 'original.runtime.json').read_text())
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    assert runtime['image_sha256'] == build['extension_sha256'] != REFERENCE_SHA
    (args.output / 'runtime-oracle-provenance.json').write_text(json.dumps({
        'source_host_sha256': runtime['image_sha256'], 'original_reference_sha256': REFERENCE_SHA,
        'original_solver_mapped': True, 'actual_original_kernel_stubs_used': True,
        'source_acceptance_candidate': False, 'original_reference_sample': False,
        'fixture_or_worker_code_modified': False, 'whole_solver_complete': False,
        'adapter_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
