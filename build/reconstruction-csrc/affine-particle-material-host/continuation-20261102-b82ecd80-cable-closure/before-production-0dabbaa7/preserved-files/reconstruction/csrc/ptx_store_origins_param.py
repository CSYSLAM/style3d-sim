"""Resolve uniquely defined parameter-address aliases with a dominance witness; never modify executed PTX."""
import hashlib
import re

from .ptx_store_origins import operands
from .ptx_store_origins_typed import store_origins as typed_store_origins


def store_origins(entry, pointer_fields):
    header, body = entry.split('{', 1)
    specs = re.findall(r'\.param\s+(?:\.align\s+\d+\s+)?\.(\w+)\s+(\w+)(?:\[(\d+)\])?', header)
    parameters = {name: {'index': i, 'bytes': int(re.search(r'(\d+)$', kind)[1]) // 8 * int(count or 1)}
                  for i, (kind, name, count) in enumerate(specs)}
    assert parameters
    instructions, definitions = [], {}
    first_control = None
    lines = body.splitlines()
    for number, line in enumerate(lines):
        match = re.fullmatch(r'\s*(@!?%\w+\s+)?(\w+(?:\.\w+)*)\s+(.+?);\s*', line.split('//', 1)[0])
        if not match:
            if first_control is None and re.search(r'\bret\b', line):
                first_control = number
            continue
        predicate, operation, args = bool(match[1]), match[2], operands(match[3])
        row = {'number': number, 'predicate': predicate, 'operation': operation, 'arguments': args}
        instructions.append(row)
        if operation.startswith(('bra', 'ret', 'call', 'exit')) and first_control is None:
            first_control = number
        if not operation.startswith(('st.', 'red.', 'bra', 'ret', 'trap', 'membar')):
            for register in re.findall(r'%\w+', args[0]):
                definitions.setdefault(register, []).append(row)
    if first_control is None:
        first_control = len(lines)
    boundaries = {row['number'] for row in instructions
                  if row['operation'].startswith(('bra', 'ret', 'call', 'exit', 'trap'))}
    boundaries.update(i for i, line in enumerate(lines)
                      if re.fullmatch(r'\s*[\w$]+:\s*', line.split('//', 1)[0]) or re.search(r'\bret\s*;', line))
    aliases, rewritten = {}, []
    for row in instructions:
        operation, args, number = row['operation'], row['arguments'], row['number']
        if not operation.startswith('ld.param.'):
            continue
        address = re.fullmatch(r'\[(%?\w+)(?:\+(\d+))?\]', args[1])
        assert address, ('Unsupported parameter address', args[1])
        base, offset = address[1], int(address[2] or 0)
        if base.startswith('%'):
            sources = definitions.get(base, [])
            assert len(sources) == 1, ('Parameter alias is not uniquely defined', base, sources)
            definition = sources[0]
            assert definition['number'] < number
            assert not definition['predicate'] and definition['operation'] in ('mov.b64', 'mov.u64')
            assert len(definition['arguments']) == 2 and definition['arguments'][1] in parameters
            prefix = definition['number'] < first_control
            same_block = not any(definition['number'] < boundary <= number for boundary in boundaries)
            assert prefix or same_block, ('Parameter definition does not have a dominance witness', base)
            parameter = definition['arguments'][1]
            aliases[base] = {'parameter': parameter, 'definition_line': definition['number'],
                             'instruction': lines[definition['number']].strip(),
                             'dominance_witness': 'entry-prefix' if prefix else 'same-basic-block'}
        else:
            assert base in parameters, base
            parameter = base
        bits = int(re.search(r'(\d+)$', operation)[1])
        vector = re.search(r'\.v(\d+)\.', operation)
        width = bits // 8 * (int(vector[1]) if vector else 1)
        assert width > 0 and offset + width <= parameters[parameter]['bytes'], (operation, parameter, offset, width)
        if base.startswith('%'):
            named = '[' + parameter + ('+' + str(offset) if offset else '') + ']'
            original = lines[number]
            lines[number] = original.replace(args[1], named)
            rewritten.append({'original_instruction': original.strip(), 'canonical_instruction': lines[number].strip(),
                              'parameter': parameters[parameter]['index'], 'offset': offset, 'bytes': width})
    canonical = header + '{' + '\n'.join(lines)
    result = typed_store_origins(canonical, pointer_fields)
    result.update(parameter_address_aliases=aliases, canonicalized_parameter_loads=rewritten,
                  parameter_load_ranges_checked=True, analysis_only_canonicalization=True,
                  alias_rule='one unpredicated formal-parameter mov, in the entry prefix or same basic block as each load',
                  actual_entry_sha256=hashlib.sha256(entry.encode()).hexdigest(),
                  canonical_analysis_entry_sha256=hashlib.sha256(canonical.encode()).hexdigest())
    return result
