"""Resolve the actual entry-prefix parameter-plus-eight alias before the unchanged typed pointer-effects checks."""
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


def parameter_offset_alias(entry):
    header, body = entry.split('{', 1)
    specifications = re.findall(r'\.param\s+(?:\.align\s+\d+\s+)?\.(\w+)\s+(\w+)(?:\[(\d+)\])?', header)
    assert len(specifications) == 2 and int(specifications[0][2]) == 296
    parameter = specifications[0][1]
    lines, instructions, definitions = body.splitlines(), [], {}
    for number, line in enumerate(lines):
        match = re.fullmatch(r'\s*(@!?%\w+\s+)?(\w+(?:\.\w+)*)\s+(.+?);\s*', line.split('//', 1)[0])
        if not match:
            continue
        predicate, operation, args = bool(match[1]), match[2], operands(match[3])
        row = {'line': number, 'predicated': predicate, 'operation': operation, 'args': args}
        instructions.append(row)
        if not operation.startswith(('st.', 'red.', 'bra', 'ret', 'trap', 'membar')):
            for register in re.findall(r'%\w+', args[0]):
                definitions.setdefault(register, []).append(row)
    first_control = min(row['line'] for row in instructions if row['operation'].startswith(('bra', 'ret', 'call', 'exit')))
    used = set(re.findall(r'ld\.param\.[^;\n]*?\[(%\w+)', body))
    assert len(used) == 1
    alias = used.pop()
    chain = definitions[alias]
    assert len(chain) == 1
    addition = chain[0]
    assert not addition['predicated'] and addition['operation'] in ('add.u64', 'add.s64')
    assert addition['line'] < first_control and len(addition['args']) == 3 and addition['args'][2] == '8'
    base = addition['args'][1]
    assert len(definitions[base]) == 1
    move = definitions[base][0]
    assert not move['predicated'] and move['operation'] in ('mov.u64', 'mov.b64')
    assert move['line'] < addition['line'] and move['args'][1] == parameter
    rewrites = []
    for row in instructions:
        if not row['operation'].startswith('ld.param.'):
            continue
        address = re.fullmatch(r'\[(' + re.escape(alias) + r')(?:\+(\d+))?\]', row['args'][1])
        if not address:
            continue
        offset = 8 + int(address[2] or 0)
        bits = int(re.search(r'(\d+)$', row['operation'])[1])
        vector = re.search(r'\.v(\d+)\.', row['operation'])
        size = bits // 8 * (int(vector[1]) if vector else 1)
        assert row['line'] > addition['line'] and offset >= 0 and offset + size <= 296
        before = lines[row['line']]
        lines[row['line']] = before.replace(row['args'][1], '[' + parameter + '+' + str(offset) + ']')
        rewrites.append({'actual': before.strip(), 'analysis': lines[row['line']].strip(), 'offset': offset, 'bytes': size})
    assert rewrites
    return header + '{' + '\n'.join(lines), {'definition': lines[addition['line']].strip(),
        'base_definition': lines[move['line']].strip(), 'unpredicated_entry_prefix_dominates_all_uses': True,
        'rewrites': rewrites, 'actual_entry_sha256': hashlib.sha256(entry.encode()).hexdigest()}


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
exec(compile(code, str(BASE / 'analysis-only-surface-load-checker-v2.py'), 'exec'), namespace)
read = types.FunctionType(formal.store_origins.__code__,
                          {**formal.store_origins.__globals__, 'typed_store_origins': namespace['store_origins']})
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
texts, original = kernel_texts(json.loads(build_path.read_text()), name)
proofs = []
for side, text in texts.items():
    entry = entries(text)[name]
    assert not re.search(r'\b(?:bar|barrier|membar)\.', entry)
    canonical, alias = parameter_offset_alias(entry)
    stores, loads = formal.store_origins(canonical, fields), read(canonical, fields)
    assert set(map(tuple, stores['potential_written_pointer_fields'])) == {(1, 0)}
    assert (1, 0) not in set(map(tuple, loads['potential_written_pointer_fields']))
    assert all('red.global.add.f32' in row['instruction'] for row in stores['store_instructions'])
    proofs.append({'side': side, 'actual_parameter_alias_proof': alias,
                   'store_proof': stores, 'global_read_base_proof': loads})
paths = [Path(__file__), Path(formal.__file__), Path(typed.__file__), original, build_path,
         ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h', sample / 'fields.json']
record = {'proofs': proofs, 'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
          'analysis_only_load_checker': code, 'RHS_is_not_read_to_form_operands': True,
          'index_bounds_proven': False, 'executed_PTX_changed': False, 'GPU_used': False, 'whole_solver_complete': False}
(BASE / 'surface-pointer-effects-v2.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:actual parameter+8 aliases proven;both surface entries only F32-reduce into RHS and never read RHS')
