"""Prove planned full-input stages cover every potential write in the actual SDK and source PTX."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

path = BASE / 'planned-write-proof.json'
assert not path.exists()
plan_path = BASE / 'linear-flow-plan.json'
plan = json.loads(plan_path.read_text())
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
hashes = {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in
          (Path(__file__), plan_path, build_path, ROOT / 'reconstruction/csrc/ptx_store_origins_param.py',
           ROOT / 'reconstruction/csrc/ptx_store_origins_typed.py', ROOT / 'reconstruction/csrc/ptx_store_origins.py')}
grouped = {}
for job in plan['jobs']:
    for stage in job['stages']:
        if not stage['all_flat_nonnull_inputs']:
            continue
        allowed = grouped.setdefault(stage['symbol'], set())
        allowed.update((int(field), 0) for field in stage['outputs'])
proofs = []
for name, allowed in sorted(grouped.items()):
    pointers = [(i, 0) for i, typ in enumerate(parameter_types(name)) if '*' in typ]
    texts, original = kernel_texts(build, name)
    hashes[str(original.resolve())] = hashlib.sha256(original.read_bytes()).hexdigest()
    for side, text in texts.items():
        proof = store_origins(entries(text)[name], pointers)
        actual = set(map(tuple, proof['potential_written_pointer_fields']))
        assert actual <= allowed, (name, side, actual, allowed)
        proofs.append({'name': name, 'backend': side, 'proof': proof, 'captured_output_union': sorted(allowed)})
path.write_text(json.dumps({'proofs': proofs, 'kernel_types': len(grouped), 'actual_PTX_entries_checked': len(proofs),
    'all_potential_writes_captured': True, 'GPU_used': False, 'GPU_runtime_validation_claimed': False,
    'fixed_C8_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False,
    'input_sha256': hashes}, indent=2) + '\n')
print('Actual SDK/source PTX write scopes proved:', len(grouped), 'kernel types;', len(proofs), 'entries', flush=True)
