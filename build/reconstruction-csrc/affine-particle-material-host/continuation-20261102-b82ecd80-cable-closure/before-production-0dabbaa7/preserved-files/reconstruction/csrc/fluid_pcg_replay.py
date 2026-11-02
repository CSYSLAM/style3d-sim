"""Replay captured coupled-fluid PCG inputs with the source .so, retaining strict aggregate failures.

Only the all-fluid/body fixture with contiguous coefficient worlds is supported here. Atomic scalar results
are checked separately against concrete float32 summation permutations; no full trajectory is accepted.
"""
import argparse
import json
from pathlib import Path
import re
import struct

import numpy as np

from reconstruction.pcg import dot
from .host_particles_ab import native_source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--captures', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    core = native_source()
    driver = core._KernelDriver()
    rng = np.random.default_rng(604)
    reports, arrays = [], {}
    groups = {
        '23precondition_and_reduce': {'pointer': (0, 1, 2, 6), 'world': 4, 'per_world': 5, 'count': 7,
                                    'output': 2, 'aggregate': 6, 'left': 2, 'right': 1},
        '26multiply_matrix_and_reduce': {'pointer': (0, 1, 3, 4, 5, 6, 9), 'world': 7, 'per_world': 8,
                                        'count': 10, 'output': 6, 'aggregate': 9, 'left': 6, 'right': 4},
    }
    for tag in ('original0', 'original1', 'source'):
        directory = args.captures/tag
        all_lines = (directory/'launches.txt').read_text().splitlines()
        for kernel, spec in groups.items():
            lines = [line for line in all_lines if line.split()[1] == kernel]
            captures = sorted(directory.glob(f'dump_{kernel}_call*_pre_arg{spec["aggregate"]}.bin'))
            assert captures and len(captures) <= len(lines)
            for call, _ in enumerate(captures):
                line = lines[call]
                symbol = re.search(r' symbol:(\S+)', line).group(1)
                words = line.split()[5:]
                words = words[:words.index('symbol:'+symbol)]
                assert len(words) == (8 if spec['output'] == 2 else 12)

                def integer(argument):
                    token = words[argument]
                    return int(token[2:], 16 if token.startswith('u:') else 10)

                count, per_world = integer(spec['count']), integer(spec['per_world'])
                assert integer(spec['world']) == 0 and count % per_world == 0
                worlds = count // per_world
                allocations, pointers = [], {}

                def data(phase, argument):
                    return (directory/f'dump_{kernel}_call{call:03}_{phase}_arg{argument}.bin').read_bytes()

                for argument in spec['pointer']:
                    pointer = driver.upload(data('pre', argument))
                    pointers[argument] = pointer
                    allocations.append(pointer)
                parameters = []
                for argument, token in enumerate(words):
                    kind = token[0]
                    if argument in pointers:
                        parameters.append(struct.pack('<Q', pointers[argument]))
                    elif argument == spec['world']:
                        parameters.append(struct.pack('<Q', 0))
                    else:
                        parameters.append(struct.pack({'u': '<Q', 'i': '<I', 'c': '<B'}[kind], integer(argument)))
                driver.launch(driver.function(symbol), (count + 255)//256, 256, parameters)
                driver.synchronize()
                output = driver.download(pointers[spec['output']], count*12)
                expected = data('post', spec['output'])
                assert output == expected, (tag, kernel, call, 'pointwise output differs')
                scalar = driver.download(pointers[spec['aggregate']], worlds*4)
                captured = data('post', spec['aggregate'])
                left = np.frombuffer(output, dtype='f4').reshape(count, 3)
                right = np.frombuffer(data('pre', spec['right']), dtype='f4').reshape(count, 3)
                contributions = dot(left, right).reshape(worlds, per_world)
                initial = np.frombuffer(data('pre', spec['aggregate']), dtype='f4')
                assert np.isfinite(contributions).all() and np.all(initial == 0)
                targets = [np.frombuffer(value, dtype='u4') for value in (captured, scalar)]
                matches, unexplained = [], []
                key = f'{tag}_{kernel}_{call:03}'
                arrays[key+'_contributions'] = contributions
                for world, values in enumerate(contributions):
                    missing, found = {int(value[world]) for value in targets}, {}
                    for trial in range(10000):
                        order = rng.permutation(per_world) if trial else np.arange(per_world)
                        total = np.float32(initial[world])
                        for index in order:
                            total = np.float32(total + values[index])
                        bits = int(total.view('u4'))
                        if bits in missing:
                            missing.remove(bits)
                            arrays[f'{key}_w{world}_order_{bits}'] = order.astype('i4')
                            found[str(bits)] = {'trial': trial, 'order': order.tolist()}
                        if not missing:
                            break
                    matches.append(found)
                    unexplained.append(sorted(missing))
                reports.append({'capture': tag, 'kernel': kernel, 'call': call, 'count': count,
                                'pointwise_output_bitwise': True, 'aggregate_bitwise': scalar == captured,
                                'exact_permutations': matches, 'unexplained': unexplained})
                for pointer in allocations:
                    driver.release(pointer)
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
    report = {'source_sha256': build['extension_sha256'], 'cuda_source_digest': build['cuda_source_digest'],
              'calls': len(reports), 'pointwise_bitwise': True, 'original_mapped': False,
              'production_order_inferred': False, 'whole_trajectory_accepted': False, 'results': reports}
    np.savez(args.output/'permutations.npz', **arrays)
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    unexplained = sum(bool(world) for row in reports for world in row['unexplained'])
    strict_failures = sum(not row['aggregate_bitwise'] for row in reports)
    print(json.dumps({'calls': len(reports), 'strict_aggregate_failures': strict_failures,
                      'unexplained_scalars': unexplained}))
    return int(bool(unexplained))


if __name__ == '__main__':
    raise SystemExit(main())
