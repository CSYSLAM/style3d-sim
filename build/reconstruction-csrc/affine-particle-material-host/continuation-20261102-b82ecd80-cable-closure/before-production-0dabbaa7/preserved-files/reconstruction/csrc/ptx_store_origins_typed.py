"""Trace parameter bases while respecting PTX load widths; this does not prove index bounds."""
import re

from .ptx_store_origins import operands


def store_origins(entry, pointer_fields):
    header, body = entry.split('{', 1)
    assert not re.search(r'\bcall(?:\.|\s)', body), 'Non-inlined call requires a separate side-effect audit'
    parameters = re.findall(r'\.param\s+(?:\.align\s+\d+\s+)?\.\w+\s+(\w+)(?:\[\d+\])?', header)
    assert parameters
    parameter_index = {name: i for i, name in enumerate(parameters)}
    instructions = []
    for line in body.splitlines():
        line = line.split('//', 1)[0]
        match = re.fullmatch(r'\s*(?:@!?%\w+\s+)?(\w+(?:\.\w+)*)\s+(.+?);\s*', line)
        if match:
            operation, arguments = match[1], operands(match[2])
            assert not operation.startswith('call'), 'Non-inlined call requires a separate side-effect audit'
            instructions.append((operation, arguments, line.strip()))
    narrow_loads, roots = {}, {}
    for _ in range(len(instructions) + 1):
        changed = False
        for operation, arguments, line in instructions:
            if operation.startswith(('st.', 'red.', 'bra', 'trap', 'membar')):
                continue
            destination = re.findall(r'%\w+', arguments[0])
            if not destination:
                continue
            inherited = set()
            if operation.startswith('ld.param.'):
                match = re.fullmatch(r'\[(\w+)(?:\+(\d+))?\]', arguments[1])
                assert match and match[1] in parameter_index
                width = int(re.search(r'(\d+)$', operation)[1]) // 8
                assert width > 0
                for lane, register in enumerate(destination):
                    offset = int(match[2] or 0) + lane * width
                    fields = {(i, start) for i, start in pointer_fields
                              if i == parameter_index[match[1]] and start <= offset < start + 8}
                    assert not fields or operation.endswith(('.u64', '.b64', '.u32', '.b32'))
                    previous = roots.setdefault(register, set())
                    if not fields.issubset(previous):
                        previous.update(fields)
                        changed = True
                continue
            if operation.startswith(('ld.', 'ldu.')):
                bits = int(re.search(r'(\d+)$', operation)[1])
                assert bits in (8, 16, 32, 64, 128)
                wide_registers = [register for register in destination if register.startswith('%rd')]
                if wide_registers and bits >= 64:
                    inherited.add((-1, -1))
                elif wide_registers:
                    # PTX ld.s32 may sign-extend directly into a b64 register; it is still a scalar index load.
                    # Arbitrary scalar offsets remain possible: pointer-base provenance never proves bounds.
                    narrow_loads[line] = {'instruction': line, 'load_bits': bits, 'wide_registers': wide_registers}
            else:
                for source in re.findall(r'%\w+', ','.join(arguments[1:])):
                    if not source.startswith('%p'):
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
        if operation.startswith(('st.', 'red.', 'atom.')):
            assert any('.' + space + '.' in operation for space in ('global', 'local', 'shared')), line
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
    assert stores and len(stores) == len(re.findall(r'\b(?:st|red|atom)\.[\w.]*global[\w.]*', body))
    return {'parameter_count': len(parameters), 'store_instructions': stores,
            'potential_written_pointer_fields': sorted({tuple(field) for row in stores
                                                        for field in row['parameter_pointer_origins']}),
            'narrow_loads_into_wide_registers': list(narrow_loads.values()),
            'indirect_64bit_loaded_store_addresses': False, 'noninlined_calls': False,
            'bounds_proven_by_this_analysis': False,
            'source_rule': 'https://docs.nvidia.com/cuda/parallel-thread-execution/'
                           '#operand-size-exceeding-instruction-type-size'}
