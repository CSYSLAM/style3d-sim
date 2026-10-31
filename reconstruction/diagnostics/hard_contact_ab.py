"""A/B hard-contact initialization against the legacy full kernel, including geometry."""
import argparse
import ctypes
import json
from pathlib import Path
import struct

import numpy as np
from reconstruction import hard_contacts as hard, rigid_contact
from reconstruction.kernel_ab import Driver, legacy_ptx, compare, rigid_contact_scene, LEGACY_SHA
from reconstruction.numerics import F


def run(d, rng):
    count = 80
    q, indices, com, sb, st, transform, scale, mat, c0 = rigid_contact_scene(rng, count)
    bodies = rigid_contact.Bodies(np.arange(len(indices), dtype=np.int32), indices, com)
    shapes = {'body': sb, 'type': st, 'position': transform[:, :3], 'scale': scale, **mat}
    previous = (q+rng.normal(scale=.01, size=q.shape)).astype(F)
    fun = d.function(*legacy_ptx('24initialize_hard_contacts'))
    update = d.function(*legacy_ptx('25update_hard_contact_duals'))
    evaluate = d.function(*legacy_ptx('22evaluate_hard_contacts'))
    ptx, symbol = legacy_ptx('25update_hard_contact_duals')
    # This register-level geometry probe is tied to the original PTX labels. The actual update launch above
    # still uses the selected backend; do not inject original register names into reconstructed CUDA PTX.
    from reconstruction.csrc import ptx_compare
    ptx = next(path.read_text() for path in sorted(ptx_compare.LEGACY_PTX.glob('*.ptx'))
               if symbol in ptx_compare.entries(path.read_text()))
    pos = ptx.index('$L__BB79_122:', ptx.index('.entry '+symbol))+len('$L__BB79_122:')
    code = f"""
ld.param.u64 %rd400, [{symbol}_param_0+264];
ld.param.u64 %rd401, [{symbol}_param_0+272];
mul.lo.s64 %rd402, %rd1, 12;
add.s64 %rd400, %rd400, %rd402;
add.s64 %rd401, %rd401, %rd402;
st.global.u32 [%rd400], %r629;
st.global.u32 [%rd400+4], %r628;
st.global.u32 [%rd400+8], %r627;
st.global.u32 [%rd401], %r626;
st.global.u32 [%rd401+4], %r625;
st.global.u32 [%rd401+8], %r624;
ret;
"""
    probe = d.function(ptx[:pos]+code+ptx[pos:], symbol)
    result = {}
    q_base, previous_base = q, previous
    for case in range(48):
        q, previous = q_base, previous_base
        worlds, particle_stride = 1, len(q_base)
        history, reset, offsets = bool(case & 1), bool(case & 2), bool(case & 4)
        beta, gamma, alpha, start = F(0 if case & 8 else .2), F(.8), F(.95), F(100)
        c = dict(c0)
        previous_count = count
        if 16 <= case < 32:
            c['count'] = None if case % 4 == 0 else (-2 if case % 4 == 1 else count-5)
            previous_count = 0 if case & 8 else count
            for field in ('shape0', 'shape1', 'normal'):
                c[field] = c[field].copy()
            c['shape0'][0] = -1
            c['shape1'][1] = len(sb)+5
            c['normal'][2] = 0
        if case >= 32:
            worlds = 2
            q = np.concatenate((q_base, q_base+F(.013)))
            previous = np.concatenate((previous_base, previous_base-F(.007)))
            c['shape0'], c['shape1'] = c['shape0'].copy(), c['shape1'].copy()
            c['shape0'][::2] += len(sb)
            c['shape1'][::2] += len(sb)
            c['shape1'][0] -= len(sb)  # Cross-world contacts must be rejected.
        if case in (8, 9):
            c['shape1'] = c['shape0'].copy()
        if not offsets:
            c['offset0'] = c['offset1'] = None
        old_penalty = rng.uniform(0, 1e5, count).astype(F)
        old_dual = rng.normal(size=(count, 3)).astype(F)
        old_normal = rng.normal(size=(count, 3)).astype(F)
        old_normal /= np.linalg.norm(old_normal, axis=1)[:, None]
        mapping = (None if case >= 16 and case % 3 == 0 else
                   rng.integers(-1, count+2, count, dtype=np.int32))
        before = [rng.uniform(0, 1e5, count).astype(F), rng.normal(size=(count, 3)).astype(F),
                  rng.normal(size=(count, 3)).astype(F)]
        ptrs = [d.upload(v) for v in before]
        arr = lambda v: 0 if v is None else d.upload(v).value
        words = [arr(None if c['count'] is None else np.array([c['count']], np.int32)), count,
                 arr(c['shape0']), arr(c['shape1']), arr(c['point0']),
                 arr(c['point1']), arr(c['offset0']), arr(c['offset1']), arr(c['normal']), arr(c['margin0']),
                 arr(c['margin1']), arr(mapping), arr(sb), arr(st), arr(transform), arr(scale), arr(mat['ke']),
                 arr(mat['kd']), arr(mat['mu']), len(sb), len(sb), worlds, arr(bodies.ids), arr(indices), arr(com),
                 len(indices), particle_stride, arr(q), arr(previous)]
        raw = struct.pack('<29Q', *words)+struct.pack('<5f4B', 240, alpha, beta, gamma, start, history, 0, reset, 0)
        raw += struct.pack('<7Q', *(p.value for p in ptrs), arr(old_penalty), arr(old_dual), arr(old_normal),
                           arr(np.array([previous_count], np.int32)))
        assert len(raw) == 312
        view = (ctypes.c_char*312).from_buffer_copy(raw)
        d.launch(fun, count, [view])
        actual = [v.copy() for v in before]
        hard.initialize(c, shapes, bodies, q, previous, *actual, old_penalty, old_dual, old_normal, previous_count,
                        mapping, alpha, beta, gamma, start, history, reset, particle_stride, worlds)
        for name, ptr, original, mine in zip(('penalty', 'dual', 'anchor'), ptrs, before, actual):
            ref = d.download(ptr, original)
            result[f'{case}_{name}'] = compare(name, ref, mine)
            if not result[f'{case}_{name}']['bitwise_equal']:
                print(case, name, result[f'{case}_{name}'], flush=True)
        # Run the update on identical arbitrary histories, not on possibly differing initialization outputs.
        ptrs = [d.upload(v) for v in before]
        raw_update = raw[:256]+struct.pack('<3Q', *(p.value for p in ptrs))+raw[280:]
        d.launch(update, count, [(ctypes.c_char*312).from_buffer_copy(raw_update)])
        actual = [v.copy() for v in before]
        hard.update_duals(c, shapes, bodies, q, previous, *actual, alpha, beta, particle_stride, worlds)
        for name, ptr, original, mine in zip(('penalty', 'dual', 'anchor'), ptrs, before, actual):
            ref = d.download(ptr, original)
            result[f'update_{case}_{name}'] = compare(name, ref, mine)
            if not result[f'update_{case}_{name}']['bitwise_equal']:
                bad = np.argwhere(ref.view(np.uint32) != mine.view(np.uint32))
                print('update', case, name, bad.tolist(), result[f'update_{case}_{name}'], flush=True)
        if case < 10 or case in (16, 17, 18, 32, 33, 34, 35):
            for mode in ('force', 'product', 'blocks', 'affine'):
                ptrs = [d.upload(v) for v in before]
                raw_eval = bytearray(raw[:256]+struct.pack('<3Q', *(p.value for p in ptrs))+raw[280:])
                raw_eval[253] = case & 1
                direction = rng.normal(size=q.shape).astype(F)
                names = ('force', 'scalar', 'product', 'system', 'precond', 'affine_blocks')
                enabled = {'force': ('force', 'scalar'), 'product': ('product',),
                           'blocks': ('system', 'precond'), 'affine': ('affine_blocks',)}[mode]
                originals = {n: rng.normal(size=(len(q),) if n == 'scalar' else
                                           ((len(indices)*worlds, 144) if n == 'affine_blocks' else
                                            (len(q), 9) if n in ('system', 'precond') else q.shape)).astype(F)
                             for n in enabled}
                buffers = {n: d.upload(v) for n, v in originals.items()}
                get = lambda n: buffers.get(n, ctypes.c_uint64(0))
                d.launch(evaluate, count, [(ctypes.c_char*312).from_buffer_copy(raw_eval), get('force'), get('scalar'),
                                          d.upload(direction) if mode == 'product' else ctypes.c_uint64(0),
                                          get('product'), get('system'), get('precond'), get('affine_blocks')])
                actual_eval = {n: v.copy() for n, v in originals.items()}
                hard.evaluate(c, shapes, bodies, q, previous, *before, alpha, 240, bool(case & 1),
                              particle_stride, worlds, direction=direction if mode == 'product' else None, **actual_eval)
                for name, ptr, original in zip(('penalty', 'dual', 'anchor'), ptrs, before):
                    result[f'evaluate_{case}_{mode}_input_{name}'] = compare(name, d.download(ptr, original), original)
                for name, original in originals.items():
                    result[f'evaluate_{case}_{name}'] = compare(name, d.download(buffers[name], original), actual_eval[name])
                    if not result[f'evaluate_{case}_{name}']['bitwise_equal']:
                        print('evaluate', case, name, result[f'evaluate_{case}_{name}'], flush=True)
        if case == 0:
            ptrs = [d.upload(v) for v in before]
            raw_probe = raw[:256]+struct.pack('<3Q', *(p.value for p in ptrs))+raw[280:]
            d.launch(probe, count, [(ctypes.c_char*312).from_buffer_copy(raw_probe)])
            for side, ptr in enumerate(ptrs[1:]):
                ref = d.download(ptr, before[1])
                mine = np.array([hard.geometry(c, i, shapes, bodies, q, len(q))[4][side] for i in range(count)])
                bad = np.argwhere(ref.view(np.uint32) != mine.view(np.uint32))
                result[f'geometry_{side}'] = compare('adjusted_point', ref, mine)
                print('GEOMETRY', side, bad.tolist(), flush=True)
                np.savez(f'build/reconstruction-debug/hard-geometry-{side}.npz', native=ref, source=mine)
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--seed', type=int, default=1)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    d = Driver()
    try:
        result = run(d, np.random.default_rng(args.seed))
    finally:
        d.free()
    passed = all(v['bitwise_equal'] for v in result.values())
    args.output.write_text(json.dumps({'legacy_sha256': LEGACY_SHA, 'seed': args.seed,
                                      'passed': passed, 'cases': result}, indent=2)+'\n')
    print('passed', passed)
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
