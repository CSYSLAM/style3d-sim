"""Compare freshly compiled mechanical CUDA cable sources against untouched legacy PTX."""
import argparse
import ctypes
import json
from pathlib import Path
import struct

import numpy as np

from reconstruction.kernel_ab import Driver, F, LEGACY_SHA, compare, f32, legacy_ptx, null
from reconstruction.cable_cuda import NAMES, compile_sources


def scene(rng, n=32, worlds=2, variant=0):
    nb, stride = n*2, n*8
    ids = np.arange(stride, dtype=np.int32).reshape(nb, 4)
    q = np.zeros((worlds, nb, 4, 3), F)
    q[:, :, 1:] = np.eye(3, dtype=F)
    q[:, :, 0] = rng.normal(size=(worlds, nb, 3))
    if variant:
        q[:, :, 1:] += rng.normal(0, .15, (worlds, nb, 3, 3)).astype(F)
    frames = []
    for _ in range(2):
        frame = rng.normal(0, .1, (n, 7)).astype(F)
        if not variant:
            frame[:, 3:6] = 0
        frame[:, 6] = 1
        frame[:, 3:] /= np.linalg.norm(frame[:, 3:], axis=1)[:, None]
        frames.append(frame)
    pair = np.arange(nb, dtype=np.int32).reshape(n, 2)
    pair[::4, 0] = -1
    pair[1::4, 1] = -1
    pair[2::8] = -1
    count = n*worlds
    data = {0: ids, 8: rng.normal(0, .1, (nb, 3)).astype(F),
            16: np.tile(np.eye(3, dtype=F), (nb, 1, 1)), 24: pair, 32: frames[0], 40: frames[1],
            48: rng.uniform(1, 100, (n, 4)).astype(F), 56: rng.uniform(.1, 2, (count, 4)).astype(F),
            64: rng.uniform(0, 1, (n, 4)).astype(F), 72: rng.normal(0, .1, (n, 3)).astype(F),
            80: rng.normal(0, .1, (count, 3)).astype(F), 88: rng.uniform(0, 1, (count, 3)).astype(F),
            96: np.ones(n, np.int32), 104: np.full((count, 8, 9), -19, F),
            112: np.full((count, 8, 9), -23, F), 120: np.full((count, 8), -29, np.int32),
            128: np.full(count, -31, np.int32)}
    data[96][3::7] = 0
    return data, q.reshape(-1, 3), stride


def run(d, rng, compiled):
    functions = {}
    for name in NAMES:
        original, symbol = legacy_ptx(str(len(name))+name)
        functions[name] = (d.function(original, symbol),
                           d.function((compiled/f'{name}.ptx').read_text(), f'synreal__kernel__{name}'))
    results = {}
    for variant in range(9):
        data, q, stride = scene(rng, n=137 if variant == 7 else 32, variant=variant)
        n, count = len(data[24]), len(data[56])
        if variant == 2:
            data[96] = None
            data[80] = None
            data[88] = None
        if variant == 3:
            data[64][:] = 0
            data[48][:] = 0
            data[56][:] = 0
        if variant == 4:
            q.reshape(2, -1, 4, 3)[:, :, 1:] *= F(1e-7)
        if variant == 5:
            q.reshape(2, -1, 4, 3)[:, :, 1:] = 0
        if variant == 6:
            data[16][:] += rng.normal(0, .1, data[16].shape).astype(F)
            data[72][:] = rng.uniform(-4, 4, data[72].shape).astype(F)
        if variant == 7:
            data[24][::3, 1] = data[24][::3, 0]
            data[32][:, 3:] = rng.normal(size=(n, 4))
            data[32][:, 3:] /= np.linalg.norm(data[32][:, 3:], axis=1)[:, None]
        if variant == 8:
            q = np.roll(q.reshape(2, -1, 4, 3), -1, axis=2).reshape(-1, 3).copy()
        old = (q+rng.normal(0, .01, q.shape)).astype(F)
        direction = rng.normal(size=q.shape).astype(F)
        # Each cable owns distinct bodies, avoiding unspecified inter-thread atomic ordering.
        for name in NAMES:
            modes = ('force', 'product', 'preconditioner', 'pipeline_product', 'pipeline_preconditioner', 'mixed')
            for mode in (modes if name == 'evaluate_cables' else ('default',)):
                outputs = []
                for backend, fun in enumerate(functions[name]):
                    ptr = {off: null() if a is None else d.upload(a) for off, a in data.items()}
                    def view():
                        words = [ptr[off].value for off in range(0, 136, 8)]+[n, count, stride]
                        return (ctypes.c_char*160).from_buffer_copy(struct.pack('<20Q', *words))
                    qp = d.upload(q)
                    if name == 'prepare_cable_tangents':
                        params = [view(), qp]
                        offsets = (104, 112, 120, 128)
                    elif name == 'update_cable_penalties':
                        params = [view(), qp, f32(2), f32(3)]
                        offsets = (56,)
                    else:
                        # Isolate evaluate: both sides consume identical reference-prepared Jacobians.
                        prep_backend = backend if mode.startswith('pipeline_') else 0
                        d.launch(functions['prepare_cable_tangents'][prep_backend], count, [view(), qp])
                        force = np.zeros_like(q)
                        matrix = np.zeros((len(q), 9), F)
                        fp, mp = d.upload(force), d.upload(matrix)
                        params = [view(), qp, d.upload(old), f32(60),
                                  d.upload(direction) if mode.endswith('product') or mode == 'mixed' else null(), fp,
                                  mp if mode.endswith('preconditioner') or mode == 'mixed' else null()]
                        offsets = ()
                    if name == 'evaluate_cables' and variant == 2:
                        ptr[56] = null()
                        params[0] = view()
                    d.launch(fun, count, params)
                    readonly = [off for off, a in data.items() if a is not None and off not in (104, 112, 120, 128)
                                and not (off == 56 and (name == 'update_cable_penalties' or variant == 2))]
                    for off in readonly:
                        key = f'{variant}/{name}/{mode}/backend{backend}/readonly{off}'
                        results[key] = compare(key, data[off], d.download(ptr[off], data[off]))
                    key = f'{variant}/{name}/{mode}/backend{backend}/positions_unchanged'
                    results[key] = compare(key, q, d.download(qp, q))
                    got = {str(off): d.download(ptr[off], data[off]) for off in offsets}
                    if name == 'evaluate_cables':
                        got['force'] = d.download(fp, force)
                        got['matrix'] = d.download(mp, matrix)
                    outputs.append(got)
                for field, ref in outputs[0].items():
                    key = f'{variant}/{name}/{mode}/{field}'
                    results[key] = compare(key, ref, outputs[1][field])
                    results[key]['locations'] = np.argwhere(ref.view(np.uint32) !=
                                                            outputs[1][field].view(np.uint32)).tolist()
                    if not results[key]['bitwise_equal']:
                        np.savez(compiled/(key.replace('/', '-')+'.npz'), reference=ref, actual=outputs[1][field])
                    print(key, results[key], flush=True)
                d.free()
    return results


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--seed', type=int, default=1)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    compiled = compile_sources()
    d = Driver()
    try:
        cases = run(d, np.random.default_rng(args.seed), compiled)
    finally:
        d.free()
    passed = all(c['bitwise_equal'] for c in cases.values())
    args.output.write_text(json.dumps({'legacy_sha256': LEGACY_SHA, 'seed': args.seed,
                                      'passed': passed, 'cases': cases}, indent=2)+'\n')
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
