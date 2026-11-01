"""Check the declared full-input stages against original/source PTX write origins without creating a GPU context."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.pd_contact_rhs_capture import select_stages
from reconstruction.csrc.ptx_store_origins_param import store_origins

previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-contact-graph'
definition = previous / 'definitions4-v2/0/definition-0/graph.json'
stages = select_stages(linear_order(json.loads(definition.read_text()))[0])
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), definition, build_path)}
seen, proofs = set(), []
for stage in stages:
    name = stage['node']['name']
    if name in seen or not stage['all_flat_pointer_inputs_captured']:
        continue
    seen.add(name)
    modules, original = kernel_texts(build, name)
    hashes[str(original)] = hashlib.sha256(original.read_bytes()).hexdigest()
    for side, module in modules.items():
        entry = entries(module)[name]
        pointer_fields = [(b['argument'], b['offset']) for b in stage['bindings']]
        proof = store_origins(entry, pointer_fields)
        written = set(map(tuple, proof['potential_written_pointer_fields']))
        allowed = {(b['argument'], b['offset']) for b in stage['bindings'] if b['label'] in stage['outputs']}
        assert written <= allowed, (name, written, allowed)
        proofs.append({'kind': stage['kind'], 'kernel': name, 'side': side, 'proof': proof,
                       'declared_writable_fields': sorted(allowed)})
assert len(seen) == 10 and len(proofs) == 20
(BASE / 'static-payload-proof.json').write_text(json.dumps({'proofs': proofs, 'input_sha256': hashes,
    'GPU_used': False, 'runtime_equivalence_claimed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('CPU PTX write-origin checks passed for10 full-input kernel types,20 entries')
