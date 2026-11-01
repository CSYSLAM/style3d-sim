"""Audit that new atomic stages only reduce into outputs and never read those outputs to form operands."""
import hashlib
import inspect
import json
from pathlib import Path
import re
import sys
import types

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import ptx_store_origins_param as formal
from reconstruction.csrc import ptx_store_origins_typed as typed
from reconstruction.csrc.pd_contact_full_replay import KINDS
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.ptx_store_origins import operands

proofs = json.loads((BASE / 'static-proof.json').read_text())
previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-rhs-cg'
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.pd_contact_tangent_schema import select_stages
path = previous / 'rhs-captures-v2/0/rhs-graph-0/definition-before/graph.json'
stages = [s for s in select_stages(linear_order(json.loads(path.read_text()))[0]) if s['kind'] in KINDS]
names = {s['node']['name'] for s in stages}
code = inspect.getsource(typed.store_origins)
old = "        if not operation.startswith(('st.global.', 'red.global.', 'atom.global.')):\n"
new = "        if not operation.startswith(('ld.global.', 'ldu.global.')):\n"
assert code.count(old) == 1
code = code.replace(old, new)
old = "len(re.findall(r'\\b(?:st|red|atom)\\.[\\w.]*global[\\w.]*', body))"
new = "len(re.findall(r'\\b(?:ld|ldu)\\.[\\w.]*global[\\w.]*', body))"
assert code.count(old) == 1
code = code.replace(old, new)
namespace = {'re': re, 'operands': operands}
exec(compile(code, str(BASE / 'analysis-only-load-origins.py'), 'exec'), namespace)
read_wrapper = types.FunctionType(formal.store_origins.__code__,
                                 {**formal.store_origins.__globals__, 'typed_store_origins': namespace['store_origins']})
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
rows, skipped = [], []
for item in proofs['proofs']:
    name, side = item['name'], item['side']
    if name not in names:
        continue
    instructions = [row['instruction'] for row in item['proof']['store_instructions']]
    if not all(re.search(r'\bred\.global\.add\.f32\b', text) for text in instructions):
        skipped.append({'name': name, 'side': side, 'reason': 'Contains a non-reduction output store'})
        continue
    fields = set()
    from reconstruction.csrc.audit_cudahook import parameter_types
    for stage in stages:
        if stage['node']['name'] == name:
            fields.update((b['argument'], b['offset']) for b in stage['bindings'])
    fields.update((i, 0) for i, kind in enumerate(parameter_types(name)) if '*' in kind)
    texts, _ = kernel_texts(build, name)
    entry = entries(texts[side])[name]
    assert not re.search(r'\b(?:bar|barrier|membar)\.', entry)
    read_proof = read_wrapper(entry, sorted(fields))
    read_fields = set(map(tuple, read_proof['potential_written_pointer_fields']))
    written = set(map(tuple, item['allowed_output_union_across_actual_nullable_modes']))
    assert read_fields.isdisjoint(written), (name, side, read_fields & written)
    rows.append({'name': name, 'side': side, 'global_load_pointer_fields': sorted(read_fields),
                 'output_fields': sorted(written), 'only_F32_reductions_write_outputs': True,
                 'output_values_not_loaded_by_the_kernel': True, 'read_proof': read_proof})
assert len(rows) == 20 and len(skipped) == 6
record = {'proofs': rows, 'non_atomic_entries': skipped, 'analysis_only_generated_load_checker': code,
          'checker_inputs_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest()
                                    for p in (Path(__file__), Path(typed.__file__), Path(formal.__file__))},
          'GPU_used': False, 'index_bounds_not_proven': True, 'whole_solver_complete': False}
(BASE / 'atomic-access-proof.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:20 atomic original/source entries have no output loads and no barriers;operands use read-only inputs')
