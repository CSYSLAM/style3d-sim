"""Audit full contact/tangent PTX write origins, including nullable output modes of shared entrypoints."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.pd_contact_tangent_schema import select_stages
from reconstruction.csrc.ptx_store_origins_param import store_origins

previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-rhs-cg'
path = previous / 'rhs-captures-v2/0/rhs-graph-0/definition-before/graph.json'
stages = select_stages(linear_order(json.loads(path.read_text()))[0])
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
grouped, hashes = {}, {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), path, build_path)}
for stage in stages:
    name = stage['node']['name']
    record = grouped.setdefault(name, {'fields': set(), 'writes': set()})
    record['fields'].update((b['argument'], b['offset']) for b in stage['bindings'])
    record['fields'].update((i, 0) for i, kind in enumerate(parameter_types(name)) if '*' in kind)
    record['writes'].update((b['argument'], b['offset']) for b in stage['bindings'] if b['label'] in stage['outputs'])
proofs = []
for name, fields in grouped.items():
    texts, original = kernel_texts(build, name)
    hashes[str(original)] = hashlib.sha256(original.read_bytes()).hexdigest()
    for side, text in texts.items():
        proof = store_origins(entries(text)[name], sorted(fields['fields']))
        written = set(map(tuple, proof['potential_written_pointer_fields']))
        assert written <= fields['writes'], (name, side, written, fields['writes'])
        proofs.append({'name': name, 'side': side, 'proof': proof,
                       'allowed_output_union_across_actual_nullable_modes': sorted(fields['writes'])})
assert len(grouped) == 23 and len(proofs) == 46
(BASE / 'static-proof.json').write_text(json.dumps({'proofs': proofs, 'input_sha256': hashes,
    'GPU_used': False, 'runtime_equivalence_claimed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('CPU:23 kernel types/46 original+source entries;all writes covered by actual-mode output unions')
