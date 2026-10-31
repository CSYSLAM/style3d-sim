"""Diagnostic-only atomic return-value probes for one captured production PCG reduction.

The production kernels and reference .so remain untouched. The probe returns each atomic's previous value and
contribution so its observed order can be reconstructed exactly; recording changes timing and does not claim to
reveal the order of an earlier uninstrumented launch.
"""
import argparse
import ctypes as c
import hashlib
import json
from pathlib import Path
import re
import struct

import numpy as np

from reconstruction import kernel_ab as k
from . import ptx_compare as pc
from .library_entries import entries

OUT = pc.OUT/'pcg-order-investigation'


def probe(entry):
    index = re.search(r'add\.s64\s+(%rd\d+),\s*%rd\d+,\s*%rd\d+;', entry)[1]
    end = entry.index(')')
    entry = entry[:end] + ',\n.param .u64 audit_output\n' + entry[end:]
    entry = entry.replace('{', '{\n.reg .f32 %audit_previous;\n'
                          '.reg .b64 %audit_base, %audit_offset, %audit_target;\n', 1)
    pattern = r'red\.global\.add\.f32\s+\[([^\]]+)\],\s*(%f\d+);'
    match = re.search(pattern, entry)
    assert match and len(re.findall(pattern, entry)) == 1
    replacement = f'''atom.global.add.f32 %audit_previous, [{match[1]}], {match[2]};
ld.param.u64 %audit_base, [audit_output];
mul.lo.u64 %audit_offset, {index}, 8;
add.u64 %audit_target, %audit_base, %audit_offset;
st.global.f32 [%audit_target], %audit_previous;
st.global.f32 [%audit_target+4], {match[2]};'''
    return entry[:match.start()] + replacement + entry[match.end():]


def bits(value):
    return int(np.asarray(value, dtype='f4').view('u4'))


def reconstruct(pairs, initial, final):
    previous, contributions = pairs[:, 0], pairs[:, 1]
    assert np.all(np.isfinite(pairs)) and np.all(contributions >= 0)
    after = np.add(previous, contributions, dtype='f4')
    order = np.lexsort((np.arange(len(pairs)), after.view('u4'), previous.view('u4')))
    accumulator = np.float32(initial)
    for index in order:
        assert bits(accumulator) == bits(previous[index]), 'Observed atomic history does not form an exact sum chain'
        accumulator = np.float32(accumulator + contributions[index])
    assert bits(accumulator) == bits(final), 'Replay of observed order did not reconstruct the final scalar'
    return order


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--directory', type=Path, default=pc.OUT/'host-particles/trace-seed1/final-trace/legacy')
    parser.add_argument('--trials', type=int, default=16)
    args = parser.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    meta = sorted(args.directory.glob('*23precondition_and_reduce*.json'))[0]
    name, prefix = json.loads(meta.read_text())['name'], meta.name[:-4]

    def data(label):
        return (args.directory/(prefix + label + '.bin')).read_bytes()

    inverse, residual = data('before.inverse'), data('before.r')
    n = len(residual) // 12
    assert data('before.precomputed') == bytes(1) and len(data('before.numerator')) == 4
    per_group = struct.unpack('<I', data('before.per_group'))[0]
    assert per_group == n and not (args.directory/(prefix+'before.world.bin')).exists()
    reference = next(entries(p.read_text())[name] for p in
                     (pc.ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx') if name in entries(p.read_text()))
    source = entries((pc.OUT/'pcg_23fb797.ptx').read_text())[name]
    assert pc.normalise(reference) == pc.normalise(source)
    prepared = {tag: probe(body) for tag, body in (('original', reference), ('source', source))}
    assert pc.normalise(prepared['original']) == pc.normalise(prepared['source'])
    driver, captures, trials = k.Driver(), {}, []
    first_contributions = None
    for backend, body in prepared.items():
        text = '.version 8.4\n.target sm_52\n.address_size 64\n' + body + '\n'
        (OUT/f'{backend}-order-probe.ptx').write_text(text)
        function = driver.function(text, name)
        for trial in range(args.trials):
            m, r = driver.upload(np.frombuffer(inverse, dtype='f4')), driver.upload(np.frombuffer(residual, dtype='f4'))
            z = driver.upload(np.zeros((n, 3), dtype='f4'))
            initial = np.frombuffer(data('before.numerator'), dtype='f4').copy()
            total, history = driver.upload(initial), driver.upload(np.zeros((n, 2), dtype='f4'))
            driver.launch(function, n, [m, r, z, c.c_bool(False), c.c_void_p(), c.c_uint(per_group), total,
                                       k.u64(n), history])
            pairs = driver.download(history, np.zeros((n, 2), dtype='f4'))
            final = driver.download(total, initial)[0]
            actual_z = driver.download(z, np.zeros((n, 3), dtype='f4'))
            assert actual_z.tobytes() == data('after.z'), 'Pointwise preconditioner changed'
            if first_contributions is None:
                first_contributions = pairs[:, 1].copy()
            assert np.array_equal(first_contributions.view('u4'), pairs[:, 1].copy().view('u4'))
            order = reconstruct(pairs, initial[0], final)
            key = f'{backend}_{trial}'
            captures[key+'_history'], captures[key+'_order'] = pairs, order.astype('i4')
            trials.append({'backend': backend, 'trial': trial, 'scalar_bits': bits(final),
                           'order_sha256': hashlib.sha256(order.astype('<i4').tobytes()).hexdigest(),
                           'first_threads': order[:16].tolist(), 'ordered_replay_bitwise_equal': True})
            driver.free()
    report = {'captured_production_call': str(meta), 'particles': n, 'trials': trials,
              'all_pointwise_outputs_equal': True, 'all_atomic_contributions_equal': True,
              'unique_observed_orders': len({row['order_sha256'] for row in trials}),
              'unique_scalar_results': sorted({row['scalar_bits'] for row in trials}),
              'production_scalar_bits': bits(np.frombuffer(data('after.numerator'), dtype='f4')[0]),
              'production_order_inferred': False, 'probe_changes_timing': True}
    np.savez(OUT/'atomic-order-captures.npz', **captures)
    (OUT/'atomic-order-report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('pointwise/contributions identical; exact sum chains', len(trials), 'orders', report['unique_observed_orders'],
          'scalar bit patterns', len(report['unique_scalar_results']))


if __name__ == '__main__':
    main()
