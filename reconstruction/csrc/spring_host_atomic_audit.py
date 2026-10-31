"""Strictly diagnose the duplicate-spring host failure using exact captured inputs and isolated contributions."""
import argparse
import ctypes as c
import itertools
import json
from pathlib import Path
import struct

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import OUT, native_source
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, default=OUT/'pd_mixed_cloth/trace-seed3/locate-duplicate-boundary')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    directory = args.directory
    output_directory = args.output or directory
    output_directory.mkdir(parents=True, exist_ok=True)
    original_trace, source_trace = directory/'legacy', directory/'source'
    meta = next(original_trace.glob('000002.*.json'))
    name = json.loads(meta.read_text())['name']
    prefix = meta.name[:-4]

    def data(label, dtype='f4', width=1):
        value = np.fromfile(original_trace/(prefix+label+'.bin'), dtype=dtype)
        return value.reshape(-1, width) if width > 1 else value

    x, indices = data('before.x', width=3), data('before.indices', 'i4', 2)
    stiffness, rest = data('before.stiffness'), data('before.rest')
    initial = data('before.rhs', width=3)
    local, particles = len(indices), 3
    assert local == 3 and len(x) % particles == 0
    count = local * (len(x)//particles)
    original_ptx = next(path.read_text() for path in
                        (OUT.parents[1]/'reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                        if name in entries(path.read_text()))
    driver = k.Driver()
    core = native_source()
    source_driver = core._KernelDriver()
    functions = {'original': driver.function(original_ptx, name),
                 'source': c.c_void_p(source_driver.function(name))}
    outputs = {}
    try:
        px, pi, pk, pr, po = [driver.upload(a) for a in (x, indices, stiffness, rest, initial)]
        for tag, function in functions.items():
            runs = []
            for trial in range(16):
                driver.check(driver.cu.cuMemcpyHtoD_v2(po, initial.ctypes.data_as(c.c_void_p), c.c_size_t(initial.nbytes)))
                driver.launch(function, count, [px, pi, pk, pr, po, k.u64(count), k.u64(local), k.u64(particles)])
                runs.append(driver.download(po, initial))
            outputs[tag] = np.stack(runs)
        # Clone each element's numerical inputs onto disjoint endpoints. No output has multiple writers now.
        separate_x = np.empty((2*count, 3), dtype='f4')
        for element in range(count):
            world, index = divmod(element, local)
            separate_x[2*element:2*element+2] = x[indices[index]+world*particles]
        isolated = np.zeros_like(separate_x)
        parameters = [driver.upload(a) for a in (separate_x, np.arange(2*count, dtype='i4').reshape(-1, 2),
                                                np.tile(stiffness, count//local), np.tile(rest, count//local), isolated)]
        contributions = {}
        for tag, function in functions.items():
            driver.check(driver.cu.cuMemcpyHtoD_v2(parameters[-1], isolated.ctypes.data_as(c.c_void_p),
                                                  c.c_size_t(isolated.nbytes)))
            driver.launch(function, count, parameters+[k.u64(count), k.u64(count), k.u64(2*count)])
            contributions[tag] = driver.download(parameters[-1], isolated)
        assert np.array_equal(contributions['original'].view('u4'), contributions['source'].view('u4'))
        assert np.isfinite(contributions['original']).all() and np.all(contributions['original'] != 0)
        contribution = contributions['original']
        allowed = [[{int(initial[p, axis].view('u4'))} for axis in range(3)] for p in range(len(x))]
        for world in range(count//local):
            for endpoint in range(2):
                particle = world*particles + int(indices[0, endpoint])
                assert np.all(indices[:, endpoint] == indices[0, endpoint])
                for axis in range(3):
                    values = contribution[2*(world*local+np.arange(local))+endpoint, axis]
                    bits = set()
                    for order in itertools.permutations(range(local)):
                        total = initial[particle, axis]
                        for index in order:
                            total = np.float32(total+values[index])
                        bits.add(int(total.view('u4')))
                    allowed[particle][axis] = bits
        captured = {tag: np.fromfile(path/(prefix+'after.rhs.bin'), dtype='f4').reshape(-1, 3)
                    for tag, path in (('original', original_trace), ('source', source_trace))}
        checked = 0
        for values in [*outputs.values(), *(v[None] for v in captured.values())]:
            for trial in values:
                for p in range(len(x)):
                    for axis in range(3):
                        assert int(trial[p, axis].view('u4')) in allowed[p][axis], (p, axis)
                        checked += 1
        report = {'diagnostic_only': True, 'whole_solver_accepted': False, 'isolated_elements': count,
                  'contribution_scalar_checks': contribution.size, 'all_contributions_bitwise_equal': True,
                  'original_and_source_states_explained_by_float32_order': checked,
                  'original_distinct_run_outputs': len({a.tobytes() for a in outputs['original']}),
                  'source_distinct_run_outputs': len({a.tobytes() for a in outputs['source']}),
                  'captured_outputs_bitwise_equal': captured['original'].tobytes() == captured['source'].tobytes(),
                  'original_solver_mapped': '_core.cpython-' in Path('/proc/self/maps').read_text(),
                  'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256']}
        assert not report['original_solver_mapped']
        (output_directory/'spring-atomic-audit.json').write_text(json.dumps(report, indent=2)+'\n')
        np.savez(output_directory/'spring-atomic-audit.npz', **outputs, **{'contributions': contribution})
        print('Isolated contribution checks', contribution.size, 'all equal;', checked,
              'scalar outputs explained by actual float32 permutations; captured strict equality',
              report['captured_outputs_bitwise_equal'])
        assert report['captured_outputs_bitwise_equal'], 'Strict host output still differs; order diagnosis is not acceptance'
    finally:
        driver.free()


if __name__ == '__main__':
    main()
