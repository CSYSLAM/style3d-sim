"""Check the corrected audit adapter against real frozen trajectories and their unchanged A/B reports."""
import ast
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import compare

SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
script = BASE / 'audit-linear-flow-v2.py'
tree = ast.parse(script.read_text())
classes = [node for node in tree.body if isinstance(node, ast.ClassDef) and node.name == 'CapturedState']
assert len(classes) == 1
namespace = {}
exec(compile(ast.Module(body=classes, type_ignores=[]), str(script), 'exec'), namespace)
adapter = namespace['CapturedState']
metadata = SELF / 'force-order-captures/report.json'
reports = json.loads(metadata.read_text())['cases']
paths = [Path(__file__), script, metadata, ROOT / 'reconstruction/demo_ab.py']
rows = []
for case in ('so3-w3-pd-b0-surface-d0', 'six-springs-w3-pd-b1-surface-d0'):
    original_path = SELF / 'discovery' / case / 'original/capture.npz'
    source_path = SELF / 'force-order-captures' / case / 'capture.npz'
    with np.load(original_path, allow_pickle=False) as original, np.load(source_path, allow_pickle=False) as source:
        a = adapter({name: original[name].copy() for name in original.files})
        b = adapter({name: source[name].copy() for name in source.files})
        actual = compare(a, b)
        assert actual == compare(original, source) == next(row['state'] for row in reports if row['case'] == case)
        assert not actual['bitwise']
    paths.extend([original_path, source_path])
    rows.append({'case': case, 'adapter_result_matches_real_NPZ_and_frozen_report': True,
                 'original_fixed_strict_failure_retained': True})
output = BASE / 'audit-interface-preflight.json'
assert not output.exists()
output.write_text(json.dumps({'cases': rows, 'GPU_used': False, 'capture_runtime_validation_claimed': False,
    'input_sha256': {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}},
    indent=2) + '\n')
print('Corrected state adapter agrees with both real frozen failed A/B reports;no GPU used', flush=True)
