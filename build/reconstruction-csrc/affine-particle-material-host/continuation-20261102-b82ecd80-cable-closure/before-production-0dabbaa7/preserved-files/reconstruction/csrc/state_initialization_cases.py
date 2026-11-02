"""Hard-history/cable-state exceptional-value probes against the original GPU, without modifying frozen specs."""
import hashlib
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def run(d, rng):
    out = {}

    def modules(suffix):
        if hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() != k.LEGACY_SHA:
            raise RuntimeError('Unexpected original library')
        chosen, name = k.legacy_ptx(suffix)
        original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                        if name in pc.entries(path.read_text()))
        return name, (original, chosen)

    for capacity in (0, 16):
        for count in (None, -5, 0, 7, 16, 99):
            n = 21
            penalty = rng.normal(size=n).astype(k.F)
            dual = rng.normal(size=(n, 3)).astype(k.F)
            normal = rng.normal(size=(n, 3)).astype(k.F)
            normal[:8] = ((0, 0, 0), (1, 0, 0), (-0.0, -0.0, 0), (np.nan, 1, 2), (np.inf, 0, 0),
                          (1, np.inf, 0), (1e-20, 2e-20, 0), (1e20, 1e20, 1e20))
            penalty[:3] = (np.nan, np.inf, -0.0)
            dual[:2] = ((np.nan, np.inf, -0.0), (1, -np.inf, 0))
            initial = (rng.normal(size=n).astype(k.F), rng.normal(size=(n, 3)).astype(k.F),
                       rng.normal(size=(n, 3)).astype(k.F), np.array([-19], np.int32))
            inputs = [d.upload(a) for a in (penalty, dual, normal)]
            name, texts = modules('22snapshot_hard_contacts')
            results = []
            for text in texts:
                outputs = [d.upload(a) for a in initial]
                words = [0]*39
                words[0] = 0 if count is None else d.upload(np.array([count], np.int32)).value
                words[1] = capacity
                for offset, pointer in zip((256, 264, 64, 280, 288, 296, 304), inputs + outputs):
                    words[offset//8] = pointer.value
                view = (k.ctypes.c_char*312).from_buffer_copy(struct.pack('<39Q', *words))
                d.launch(d.function(text, name), capacity + 17, [view])
                results.append([d.download(pointer, a) for pointer, a in zip(outputs, initial)])
            label = f'snapshot_cap{capacity}_count{count}'
            for field, a, b in zip(('penalty', 'dual', 'normal', 'count'), *results):
                out[label + '_' + field] = k.compare(field, a, b)
            out[label + '_clamped_count'] = {'bitwise_equal': int(results[0][3][0]) ==
                                             (0 if count is None else min(max(count, 0), capacity))}

    per_world, count, size = 7, 19, 24
    base = rng.uniform(-2, 20, (per_world, 4)).astype(k.F)
    base[0] = (0, 1, np.inf, np.nan)
    base[1] = (-0.0, -1, 3, 8)
    old = rng.uniform(-5, 30, (size, 4)).astype(k.F)
    old[2] = (np.nan, np.inf, -np.inf, -0.0)
    flags = np.resize(np.array((-1, 0, 2), np.int32), size)
    masks = (None, rng.integers(-1, 2, size, dtype=np.int32), np.zeros(size, np.int32))
    cases = ((0.3, 0.7, 0, 3, 8), (0.3, 0.7, -1, 3, 8), (0.3, 0.7, np.nan, 3, 8),
             (np.nan, 0.7, np.inf, 3, 8), (0.3, np.nan, 1, np.nan, np.inf), (-0.1, 0, 1, 0, -1))
    name, texts = modules('23prepare_cable_penalties')
    for reset in (False, True):
        for rescale in (False, True):
            for ci, (beta0, beta1, scale, cap0, cap1) in enumerate(cases):
                for mi, mask in enumerate(masks):
                    results = []
                    for text in texts:
                        penalty, initialized = d.upload(old), d.upload(flags)
                        args = [d.upload(base), penalty, initialized, k.u64(per_world), k.u64(count)]
                        args += [k.f32(v) for v in (beta0, beta1, scale, cap0, cap1)]
                        args += [k.ctypes.c_uint8(reset), k.ctypes.c_uint8(rescale),
                                 k.null() if mask is None else d.upload(mask)]
                        d.launch(d.function(text, name), count + 17, args)
                        results.append((d.download(penalty, old), d.download(initialized, flags)))
                    label = f'cable_reset{reset}_rescale{rescale}_case{ci}_mask{mi}'
                    out[label + '_penalty'] = k.compare('p', results[0][0], results[1][0])
                    out[label + '_initialized'] = k.compare('i', results[0][1], results[1][1])
    return out
