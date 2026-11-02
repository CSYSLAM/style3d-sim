"""Audit that the actual surface entry only reduces into RHS and never reads RHS to compute later operands."""
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
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins import operands

sample = BASE / 'first-surface-inputs/so3-w3-pd-b0-surface-d0/original'
line = next(s for s in (sample / 'launches.txt').read_text().splitlines() if '30evaluate_surface_contact_force ' in s)
name = line.split(' symbol:', 1)[1].split()[0]
fields = [(0, int(off)) for off in json.loads((sample / 'fields.json').read_text())] + [(0, 64), (1, 0)]
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
exec(compile(code, str(BASE / 'analysis-only-surface-load-checker.py'), 'exec'), namespace)
read = types.FunctionType(formal.store_origins.__code__,
                          {**formal.store_origins.__globals__, 'typed_store_origins': namespace['store_origins']})
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
texts, original = kernel_texts(json.loads(build_path.read_text()), name)
proofs = []
for side, text in texts.items():
    entry = entries(text)[name]
    assert not re.search(r'\b(?:bar|barrier|membar)\.', entry)
    stores, loads = formal.store_origins(entry, fields), read(entry, fields)
    assert set(map(tuple, stores['potential_written_pointer_fields'])) == {(1, 0)}
    assert (1, 0) not in set(map(tuple, loads['potential_written_pointer_fields']))
    assert all('red.global.add.f32' in row['instruction'] for row in stores['store_instructions'])
    proofs.append({'side': side, 'store_proof': stores, 'global_read_base_proof': loads})
paths = [Path(__file__), Path(formal.__file__), Path(typed.__file__), original, build_path,
         ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h', sample / 'fields.json']
record = {'proofs': proofs, 'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
          'analysis_only_load_checker': code, 'RHS_is_not_read_to_form_operands': True,
          'index_bounds_proven': False, 'GPU_used': False, 'whole_solver_complete': False}
(BASE / 'surface-pointer-effects.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:original/source surface entry only F32-reduces into RHS;no RHS reads or inter-thread barriers')
