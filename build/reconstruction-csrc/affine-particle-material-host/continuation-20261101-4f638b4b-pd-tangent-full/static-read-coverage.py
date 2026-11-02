"""Trace global-read bases for every captured entry; distinguish captured pointers from nullable modes."""
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
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.pd_contact_tangent_schema import select_stages
from reconstruction.csrc.ptx_store_origins import operands

output = BASE / 'static-read-coverage.json'
assert not output.exists()
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
exec(compile(code, str(BASE / 'analysis-only-full-load-checker.py'), 'exec'), namespace)
read_origins = types.FunctionType(formal.store_origins.__code__,
                                {**formal.store_origins.__globals__, 'typed_store_origins': namespace['store_origins']})
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in
          (Path(__file__), Path(typed.__file__), Path(formal.__file__), build_path,
           ROOT / 'reconstruction/csrc/pd_contact_tangent_schema.py',
           ROOT / 'reconstruction/csrc/pd_contact_rhs_capture.py')}
grouped = {}
previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-rhs-cg/rhs-captures-v2'
stage_count = 0
for worker in range(4):
    for template in range(2):
        path = previous / str(worker) / f'rhs-graph-{template}/definition-before/graph.json'
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        stages = select_stages(linear_order(json.loads(path.read_text()))[0])
        for stage in stages:
            name, node = stage['node']['name'], stage['node']
            captured = {(b['argument'], b['offset']) for b in stage['bindings']}
            flat = {i for i, kind in enumerate(parameter_types(name)) if '*' in kind}
            null = {(i, 0) for i in flat if int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little') == 0}
            assert {(i, 0) for i in flat} <= captured | null
            for binding in stage['bindings']:
                raw = bytes.fromhex(node['parameter_hex'][binding['argument']])
                offset = binding['offset']
                assert int.from_bytes(raw[offset:offset + 8], 'little') == binding['address']
            item = grouped.setdefault(name, {'fields': set(), 'modes': {}})
            item['fields'].update(captured | null)
            key = (tuple(sorted(captured)), tuple(sorted(null)))
            mode = item['modes'].setdefault(key, {'captured': captured, 'null': null, 'occurrences': 0})
            mode['occurrences'] += 1
            stage_count += 1
assert len(grouped) == 23 and stage_count == 1704
proofs = []
for name, item in grouped.items():
    texts, original = kernel_texts(build, name)
    hashes[str(original)] = hashlib.sha256(original.read_bytes()).hexdigest()
    for side, text in texts.items():
        proof = read_origins(entries(text)[name], sorted(item['fields']))
        fields = set(map(tuple, proof['potential_written_pointer_fields']))
        modes = []
        for mode in item['modes'].values():
            assert fields <= mode['captured'] | mode['null'], (name, side, fields - mode['captured'] - mode['null'])
            modes.append({'captured_fields': sorted(mode['captured']), 'null_fields': sorted(mode['null']),
                          'potentially_read_null_fields': sorted(fields & mode['null']),
                          'occurrences': mode['occurrences']})
        proofs.append({'name': name, 'side': side, 'global_read_base_proof': proof, 'actual_ABI_modes': modes})
assert len(proofs) == 46
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'proofs': proofs, 'input_sha256': hashes, 'analysis_only_generated_load_checker': code,
          'actual_saved_graphs_checked': 8, 'stage_ABIs_checked': stage_count,
          'pointer_bases_accounted_as_captured_or_NULL': True, 'index_bounds_proven': False,
          'NULL_dereference_guards_proven': False, 'GPU_used': False,
          'runtime_equivalence_claimed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('CPU:46 original/source global-read base proofs;1704 actual stage ABIs accounted as captured or NULL')
