"""Extend the accepted typed graph normalizer only with the already audited kernel-read Model fields."""
from reconstruction.csrc.audit_cudahook import MODEL_FIELDS, SCALAR_WORDS


def normalize(ordered, warp_schema, owned_schema):
    aliases = {}
    parameters = []
    scalar_parameters = []
    padding_bytes = 0

    def pointer(value, domain='device'):
        if not value:
            return None
        key = (domain, value)
        if key not in aliases:
            aliases[key] = len(aliases)
        return aliases[key]

    def scalar_view(kind, raw, with_pointers):
        result = []
        for offset in range(0, len(raw), 8):
            assert len(raw[offset:offset + 8]) == 8
            word = int.from_bytes(raw[offset:offset + 8], 'little')
            mask = 0xffffffffffffffff
            if (kind, offset) in (('U', 288), ('W', 112)):
                mask = 0xffffffff
            if (kind, offset) == ('H', 248):
                mask = 0x00ffffffffffffff
            if offset in SCALAR_WORDS[kind]:
                result.append([offset, 'scalar', word & mask])
            elif with_pointers:
                result.append([offset, 'pointer', pointer(word)])
        return [kind, result]

    def warp_parameter(raw, description, with_pointers):
        assert len(raw) == description['width']
        fields = []
        for field in description['fields']:
            offset, size = field['offset'], field['size']
            bits = raw[offset:offset + size]
            assert len(bits) == size
            if field['kind'] == 'pointer':
                if with_pointers:
                    fields.append([field['name'], 'pointer', pointer(int.from_bytes(bits, 'little'))])
            else:
                fields.append([field['name'], 'scalar', bits.hex()])
        return fields

    for node in ordered:
        kind = node['type']
        normalized, scalars = [], []
        if kind == 0:
            raw = [bytes.fromhex(value) for value in node['parameter_hex']]
            assert [len(value) for value in raw] == node['parameter_widths']
            if node['owned_kernel']:
                layout = owned_schema[node['name']]
                assert len(layout) == len(raw)
                for field_kind, value in zip(layout, raw):
                    if field_kind == 'pointer':
                        assert len(value) == 8
                        normalized.append(['pointer', pointer(int.from_bytes(value, 'little'))])
                        scalars.append(['pointer'])
                    elif field_kind in SCALAR_WORDS:
                        normalized.append(scalar_view(field_kind, value, True))
                        scalars.append(scalar_view(field_kind, value, False))
                    elif field_kind == 'M':
                        fields = next(fields for token, fields in MODEL_FIELDS.items() if token in node['name'])
                        values, scalar_values = [], []
                        for kind, offsets in fields.items():
                            for offset in offsets:
                                width = 4 if kind == 'u32' else 8
                                word = int.from_bytes(value[offset:offset + width], 'little')
                                values.append([offset, kind, pointer(word) if kind == 'pointer' else word])
                                scalar_values.append([offset, kind] if kind == 'pointer' else [offset, kind, word])
                        normalized.append(['M-kernel-read-fields', values])
                        scalars.append(['M-kernel-read-fields', scalar_values])
                    else:
                        normalized.append([field_kind, value.hex()])
                        scalars.append([field_kind, value.hex()])
            else:
                layout = warp_schema['kernels'][node['name']]
                assert len(layout) == len(raw)
                for value, description in zip(raw, layout):
                    normalized.append(warp_parameter(value, description, True))
                    scalars.append(warp_parameter(value, description, False))
                    padding_bytes += len(value) - sum(field['size'] for field in description['fields'])
        elif kind in (1, 2):
            for name, value in node['parameters'].items():
                domain = None
                if kind == 1 and name.endswith(('Host', 'Device', 'Array')):
                    domain = {'Host': 'host', 'Device': 'device', 'Array': 'array'}[name[3:]]
                elif kind == 2 and name == 'dst':
                    domain = 'device'
                if domain:
                    normalized.append([name, 'pointer', pointer(value, domain)])
                    scalars.append([name, 'pointer'])
                else:
                    normalized.append([name, 'scalar', value])
                    scalars.append([name, 'scalar', value])
        elif kind != 5:
            raise ValueError(f'Node type {kind} has not been normalized')
        parameters.append(normalized)
        scalar_parameters.append(scalars)
    return parameters, scalar_parameters, len(aliases), padding_bytes
