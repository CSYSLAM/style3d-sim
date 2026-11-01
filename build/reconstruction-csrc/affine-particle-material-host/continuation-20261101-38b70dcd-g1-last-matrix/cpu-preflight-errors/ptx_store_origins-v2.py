"""Conservatively trace direct parameter-pointer origins of PTX stores; reject indirect/unknown store addresses."""
import re


def operands(text):
    result, start, depth = [], 0, 0
    for index, char in enumerate(text):
        depth += (char in '{[') - (char in '}]')
        if char == ',' and not depth:
            result.append(text[start:index].strip())
            start = index + 1
    result.append(text[start:].strip())
    assert depth == 0
    return result


def store_origins(entry, pointer_fields):
    header, body = entry.split('{', 1)
    parameters = re.findall(r'\.param\s+(?:\.align\s+\d+\s+)?\.\w+\s+(\w+)(?:\[\d+\])?', header)
    assert parameters
    parameter_index = {name: index for index, name in enumerate(parameters)}
    instructions = []
    for line in body.splitlines():
        line = line.split('//', 1)[0]
        match = re.fullmatch(r'\s*(?:@!?%\w+\s+)?(\w+(?:\.\w+)*)\s+(.+?);\s*', line)
        if match:
            operation, arguments = match[1], operands(match[2])
            assert not operation.startswith('call'), 'Non-inlined call requires a separate side-effect audit'
            instructions.append((operation, arguments, line.strip()))
    roots = {}
    for _ in range(len(instructions) + 1):
        changed = False
        for operation, arguments, _ in instructions:
            if operation.startswith(('st.', 'red.', 'bra', 'trap', 'membar')):
                continue
            destination = re.findall(r'%\w+', arguments[0])
            if not destination:
                continue
            inherited = set()
            if operation.startswith('ld.param.'):
                match = re.fullmatch(r'\[(\w+)(?:\+(\d+))?\]', arguments[1])
                assert match and match[1] in parameter_index
                bits = int(re.search(r'(\d+)$', operation)[1])
                width = bits // 8
                assert width > 0
                for lane, register in enumerate(destination):
                    offset = int(match[2] or 0) + lane * width
                    fields = {(index, start) for index, start in pointer_fields
                              if index == parameter_index[match[1]] and start <= offset < start + 8}
                    assert not fields or operation.endswith(('.u64', '.b64', '.u32', '.b32'))
                    previous = roots.setdefault(register, set())
                    if not fields.issubset(previous):
                        previous.update(fields)
                        changed = True
                continue
            elif operation.startswith(('ld.global.', 'ld.volatile.global.', 'ld.shared.')) and any(
                    register.startswith('%rd') for register in destination):
                inherited.add((-1, -1))
            else:
                # Selection predicates affect control, not which pointer value an address is derived from.
                for source in re.findall(r'%\w+', ','.join(arguments[1:])):
                    if source.startswith('%p'):
                        continue
                    inherited.update(roots.get(source, set()))
            for register in destination:
                previous = roots.setdefault(register, set())
                if not inherited.issubset(previous):
                    previous.update(inherited)
                    changed = True
        if not changed:
            break
    else:
        raise RuntimeError('Pointer-origin analysis did not reach a fixed point')
    stores = []
    for operation, arguments, line in instructions:
        if not operation.startswith(('st.global.', 'red.global.', 'atom.global.')):
            continue
        addresses = [argument for argument in arguments if argument.startswith('[')]
        assert len(addresses) == 1
        origins = set()
        for register in re.findall(r'%\w+', addresses[0]):
            origins.update(roots.get(register, set()))
        assert origins and (-1, -1) not in origins, ('Unresolved or indirect store address', line, origins)
        assert origins <= set(pointer_fields)
        stores.append({'instruction': line, 'parameter_pointer_origins': sorted(origins)})
    assert stores, 'No global stores were parsed'
    return {'parameter_count': len(parameters), 'store_instructions': stores,
            'potential_written_pointer_fields': sorted({tuple(field) for row in stores
                                                        for field in row['parameter_pointer_origins']}),
            'indirect_store_addresses': False, 'noninlined_calls': False,
            'bounds_proven_by_this_analysis': False}
