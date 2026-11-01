"""Render and parse the actual graph adapter without importing CUDA or running a solver."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
worker = BASE / 'graph-worker.py'
original = worker.read_text()
prefix = original[:original.index("script = args.output / (args.backend + '-graph-as-run.py')")]
directory = BASE / 'graph-template-preflight'
directory.mkdir(exist_ok=False)
saved_argv = sys.argv[:]
sys.argv = [str(worker), '--backend', 'original', '--output', str(directory)]
namespace = {'__file__': str(worker), '__name__': 'nl2_graph_cpu_preflight'}
try:
    exec(compile(prefix, str(worker), 'exec'), namespace)
finally:
    sys.argv = saved_argv
text = namespace['text']
tree = ast.parse(text)
selected = [n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'cases']
assert len(selected) == 1
case_namespace = {}
exec(compile(ast.Module(body=selected, type_ignores=[]), '<four_cases_only>', 'exec'), case_namespace)
cases = list(case_namespace['cases']())
assert len(cases) == 4
assert [(name, worlds, diagonal) for name, worlds, diagonal, _ in cases] == [
    ('newton-b0', 1, False), ('newton-b1', 1, False), ('pd-b0', 1, False), ('pd-b1', 1, False)]
assert 'from .granular_affine_scene import Example as BaseExample' in text
assert 'self.pipeline = self.contacts = None' in text
assert "assert '_core.cpython-' not in Path('/proc/self/maps').read_text()" in text
(directory / 'graph-template.py').write_text(text)
(directory / 'audit.json').write_text(json.dumps({
    'input_worker_sha256': hashlib.sha256(worker.read_bytes()).hexdigest(),
    'rendered_graph_sha256': hashlib.sha256(text.encode()).hexdigest(), 'cases': cases,
    'CUDA_context_created': False, 'graph_worker_executed': False, 'source_mapping_assertion_preserved': True,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Actual graph template parses; four fixed cases and source mapping assertion verified; no GPU execution')
