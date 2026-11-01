"""Complete actual PD contact/tangent pointer spans for the fixed flattened three-body fixture."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer
from .pd_contact_rhs_capture import select_stages as rhs_stages


def select_stages(nodes):
    selected = {stage['rank']: stage for stage in rhs_stages(nodes)}
    for rank, node in enumerate(nodes):
        name = node.get('name', '')
        bindings, outputs, kind = [], [], None

        def bind(label, argument, size, offset=0, writable=False):
            raw = bytes.fromhex(node['parameter_hex'][argument])
            address = int.from_bytes(raw[offset:offset + 8], 'little')
            assert len(raw[offset:offset + 8]) == 8 and address and size > 0
            bindings.append({'label': label, 'argument': argument, 'offset': offset, 'bytes': size, 'address': address})
            if writable:
                outputs.append(label)

        def flat(sizes, writes):
            for argument, size in sorted(sizes.items()):
                bind('arg-' + str(argument), argument, size, writable=argument in writes)

        if '22evaluate_contact_forceE' in name or '24evaluate_contact_tangentE' in name:
            force = '22evaluate_contact_forceE' in name
            assert [integer(node, i) for i in (1, 20, 21, 22, 26)] == [1000, 6, 6, 1, 3]
            sizes = {0: 4, 2: 4000, 3: 4000, 9: 4000, 10: 4000,
                     11: 24, 12: 24, 13: 168, 14: 72, 15: 24, 16: 24, 17: 24, 18: 24,
                     23: 12, 24: 48, 25: 36, **{i: 12000 for i in (4, 5, 6, 7, 8)}}
            if force:
                kind, writes = 'rigid-force', [32, 33]
                assert integer(node, 27) == 36
                sizes.update({28: 432, 29: 432, 30: 432, 32: 432, 33: 144})
            else:
                assert integer(node, 32) == 36
                sizes.update({27: 432, 28: 432})
                matrix = integer(node, 29) == 0
                assert (integer(node, 30) == 0) == matrix
                if matrix:
                    kind, writes = 'rigid-matrix', [33, 34]
                    sizes.update({33: 1296, 34: 1296})
                else:
                    kind, writes = 'rigid-tangent', [30]
                    assert integer(node, 33) == integer(node, 34) == 0
                    sizes.update({29: 432, 30: 432})
            flat(sizes, writes)
        elif any(token in name for token in ('30evaluate_rolling_contact_forceE',
                                             '34add_rolling_contact_preconditionerE', '32multiply_rolling_contact_tangentE')):
            view = bytes.fromhex(node['parameter_hex'][0])
            assert len(view) == 248
            scalars = {off: int.from_bytes(view[off:off + 8], 'little') for off in (8, 152, 160, 168, 208, 216)}
            assert scalars == {8: 1000, 152: 6, 160: 6, 168: 1, 208: 3, 216: 36}
            field_sizes = {0: 4, 16: 4000, 24: 4000, 72: 4000, 80: 4000, 88: 24, 96: 24,
                           104: 168, 112: 72, 120: 24, 128: 24, 136: 24, 144: 24,
                           176: 12, 184: 48, 192: 36, 200: 108, 224: 432, 232: 432,
                           **{off: 12000 for off in (32, 40, 48, 56, 64)}}
            assert set(field_sizes) == set(range(0, 240, 8)) - {8, 152, 160, 168, 208, 216}
            for offset, size in sorted(field_sizes.items()):
                bind('view-' + str(offset), 0, size, offset)
            if '32multiply_' in name:
                kind = 'rolling-tangent'
                flat({1: 432, 2: 432}, [2])
            elif '34add_' in name:
                kind = 'rolling-preconditioner'
                flat({1: 1296}, [1])
            else:
                kind = 'rolling-force'
                flat({1: 432}, [1])
        elif '27evaluate_soft_contact_forceE' in name:
            assert [integer(node, i) for i in (1, 10, 11, 21, 22, 23, 31)] == [72, 36, 36, 6, 6, 1, 3]
            assert integer(node, 38) == integer(node, 39) == 0
            sizes = {0: 4, 2: 288, 3: 288, 4: 864, 5: 864, 6: 864, 7: 144, 8: 144, 9: 144,
                     12: 24, 13: 24, 14: 168, 15: 72, **{i: 24 for i in range(16, 21)},
                     28: 12, 29: 48, 30: 36, 32: 432, 33: 432, 34: 432}
            if integer(node, 36):
                kind, writes = 'soft-force', [36, 37]
                assert integer(node, 40) == integer(node, 41) == 0
                sizes.update({36: 432, 37: 144})
            else:
                kind, writes = 'soft-matrix', [40, 41]
                assert integer(node, 37) == 0
                sizes.update({40: 1296, 41: 1296})
            flat(sizes, writes)
        elif '42multiply_soft_contact_hessian_off_diagonalE' in name:
            kind = 'soft-tangent'
            assert [integer(node, i) for i in (1, 16, 17, 18, 22, 27, 30, 32)] == [72, 6, 6, 1, 3, 36, 36, 0]
            assert integer(node, 31) == 0
            flat({0: 4, 2: 288, 3: 288, 4: 864, 5: 864, 6: 144, 7: 24, 8: 24, 9: 168, 10: 72,
                  11: 144, 12: 144, 13: 24, 14: 24, 15: 24, 19: 12, 20: 48, 21: 36,
                  23: 432, 24: 432, 25: 432, 33: 24, 34: 24, 37: 864, 38: 432}, [25])
        elif '53multiply_affine_body_so3_augmented_lagrangian_tangentE' in name:
            kind = 'SO3-tangent'
            assert [integer(node, i) for i in (6, 7, 8)] == [3, 3, 36]
            flat({0: 432, 1: 48, 2: 12, 3: 108, 5: 432}, [5])
        elif '55add_affine_body_so3_augmented_lagrangian_preconditionerE' in name:
            kind = 'SO3-preconditioner'
            assert [integer(node, i) for i in (5, 6, 7)] == [3, 3, 36]
            flat({0: 48, 1: 12, 2: 108, 4: 1296}, [4])
        elif '15granular_kernel17multiply_contactsE' in name:
            kind = 'grain-tangent'
            view = bytes.fromhex(node['parameter_hex'][0])
            assert len(view) == 120 and int.from_bytes(view[88:92], 'little') == 12
            assert int.from_bytes(view[92:96], 'little') == 32
            for offset, size in {0: 128, 8: 48, 16: 48, 24: 48, 32: 144, 40: 144,
                                 48: 144, 56: 48, 64: 48, 72: 1536, 80: 6144}.items():
                bind('view-' + str(offset), 0, size, offset)
            flat({1: 432, 2: 432}, [2])
        elif '15granular_kernel14multiply_bondsE' in name:
            count = integer(node, 3)
            assert count in (6, 36)
            kind = 'authored-tangent' if count == 6 else 'dynamic-tangent'
            flat({0: count * 8, 1: count * 4, 2: count * 36, 4: 432, 5: 432}, [5])
        elif '25initialize_block_diagonalE' in name:
            kind = 'block-initialize'
            assert integer(node, 3) == 36
            flat({0: 144, 1: 1296, 2: 1296}, [1, 2])
        elif '15granular_kernel12add_diagonalE' in name:
            kind = 'grain-diagonal'
            assert integer(node, 2) == 36
            flat({0: 1296, 1: 1296}, [1])
        if kind is None:
            continue
        pointers = {i for i, typ in enumerate(parameter_types(name)) if '*' in typ and integer(node, i)}
        assert pointers == {b['argument'] for b in bindings if b['label'].startswith('arg-')}
        selected[rank] = {'key': f'{rank:03d}-{kind}', 'rank': rank, 'kind': kind, 'node': node,
                          'bindings': bindings, 'outputs': outputs, 'all_flat_pointer_inputs_captured': True,
                          'opaque_Model_only_previously_audited_read_scalars_relevant': False}
    result = [selected[rank] for rank in sorted(selected)]
    assert len(nodes) == 276 and len(result) == 213
    assert all(stage['all_flat_pointer_inputs_captured'] for stage in result)
    return result
