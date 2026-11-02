"""Load one verified historical source image without replacing the active solver or its build inputs."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sysconfig


def load(checkpoint, expected_build=None):
    checkpoint = Path(checkpoint).resolve(strict=True)
    metadata = json.loads((checkpoint / 'checkpoint.json').read_text())
    preserved = checkpoint / 'preserved-files'
    for name, sha in metadata['files'].items():
        path = (preserved / name).resolve(strict=True)
        assert path.is_relative_to(preserved.resolve())
        assert hashlib.sha256(path.read_bytes()).hexdigest() == sha, name
    folder = preserved / 'build/reconstruction-csrc/host-particles'
    build = json.loads((folder / 'build.json').read_text())
    for name, sha in build['sources'].items():
        assert metadata['files'][name] == sha
    if expected_build is not None:
        assert build == expected_build, 'Captured inputs and checkpoint must identify exactly the same source image'
    image = folder / ('_source_solver' + sysconfig.get_config_var('EXT_SUFFIX'))
    sha = hashlib.sha256(image.read_bytes()).hexdigest()
    assert sha == metadata['source_sha256'] == build['extension_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.source_only and module.source_digest == build['cuda_source_digest']
    return module, build, preserved
