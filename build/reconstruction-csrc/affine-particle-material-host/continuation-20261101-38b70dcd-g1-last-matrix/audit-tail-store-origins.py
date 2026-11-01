"""Audit actual reference/source PTX global-store parameter origins before admitting post-frame matrix inputs."""
import hashlib
import json
from pathlib import Path
import re
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins import store_origins

base = Path(__file__).resolve().parent
old = base.parent / 'continuation-20261101-38b70dcd-g1-graph-definition'
inventory = json.loads((base / 'tail-ptx-inventory.json').read_text())
warp = json.loads((old / 'warp-schema.json').read_text())
manifest = json.loads((root / 'build/reconstruction-csrc/host-particles/build.json').read_text())
header = root / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h'
modules = re.findall(r'\{"([^"]+)", R"([^\s(]+)\((.*?)\)\2"\}', header.read_text(), re.S)
assert len(modules) == 28
report = {}
for name, item in inventory.items():
    if name in warp['kernels']:
        fields = {(index, field['offset']) for index, spec in enumerate(warp['kernels'][name])
                  for field in spec['fields'] if field['kind'] == 'pointer'}
    else:
        fields = {(index, 0) for index, kind in enumerate(parameter_types(name)) if '*' in kind}
    versions = {'original': (root / item['entry_file']).read_text()}
    if name in manifest['kernels']:
        module = manifest['kernels'][name]['module']
        versions['source'] = entries(modules[module][2])[name]
    rows = {}
    for backend, text in versions.items():
        rows[backend] = store_origins(text, fields)
        rows[backend]['entry_sha256'] = hashlib.sha256(text.encode()).hexdigest()
        print(name[:85], backend, rows[backend]['potential_written_pointer_fields'], flush=True)
    if 'source' in rows:
        assert rows['original']['potential_written_pointer_fields'] == rows['source']['potential_written_pointer_fields']
    report[name] = rows
result = {'kernels': report, 'source_ptx_bundle_sha256': hashlib.sha256(header.read_bytes()).hexdigest(),
          'analysis_sha256': hashlib.sha256((root / 'reconstruction/csrc/ptx_store_origins.py').read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'bounds_proven': False, 'whole_solver_complete': False}
(base / 'tail-store-origins.json').write_text(json.dumps(result, indent=2) + '\n')
