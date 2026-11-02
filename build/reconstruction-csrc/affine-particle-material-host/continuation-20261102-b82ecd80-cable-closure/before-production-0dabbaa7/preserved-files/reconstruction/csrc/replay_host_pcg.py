"""Replay each captured original PCG call independently through the current compiled source .so.

Every pointwise output and atomic aggregate remains a raw-bit comparison. Atomic aggregate failures are recorded
separately so they cannot be mistaken for accepted full-kernel or full-demo equivalence.
"""
import argparse
import json
from pathlib import Path
import struct

from .host_particles_ab import native_source


def replay(directory, nonlinear_iterations=1, linear_iterations=7, steps=3):
    module = native_source()
    assert module.source_only and module.kernel_count == 176
    driver = module._KernelDriver()
    report = []
    for meta in sorted(directory.glob('*.json')):
        row = json.loads(meta.read_text())
        name, prefix = row['name'], meta.name[:-4]
        if not any(token in name for token in ('23precondition_and_reduce', '19update_cg_directionE',
                                                '26multiply_matrix_and_reduceINS_', '28update_solution_and_residualEP')):
            continue
        allocations = []
        buffers = {}

        def data(label, optional=False):
            path = directory/(prefix + label + '.bin')
            return path.read_bytes() if path.exists() else None if optional else path.read_bytes()

        def upload(payload):
            pointer = driver.upload(payload)
            allocations.append(pointer)
            return struct.pack('<Q', pointer)

        def pointer(label, optional=False):
            payload = data(label, optional)
            return upload(payload) if payload is not None else bytes(8)

        def output(key, initial=None):
            template = data('after.' + key)
            parameter = upload(bytes(len(template)) if initial is None else initial)
            buffers[key] = (struct.unpack('<Q', parameter)[0], template)
            return parameter

        world = pointer('before.world', True)
        per_group = data('before.per_group')
        if '23precondition_and_reduce' in name:
            assert data('before.precomputed') == bytes(1), 'This captured host path must compute its preconditioner output'
            residual = data('before.r')
            n = len(residual) // 12
            args = [pointer('before.inverse'), upload(residual), output('z'), data('before.precomputed'), world,
                    per_group, output('numerator', data('before.numerator')), struct.pack('<Q', n)]
            atomic = {'numerator'}
        elif '19update_cg_directionE' in name:
            z = data('before.z')
            n = len(z) // 12
            args = [data('before.iteration'), upload(z), world, per_group, pointer('before.numerator'),
                    pointer('before.previous_numerator', True), output('p', data('before.p', True)), struct.pack('<Q', n)]
            atomic = set()
        elif '26multiply_matrix_and_reduce' in name:
            direction = data('before.p')
            n = len(direction) // 12
            maximum, rows = data('before.max_count', True), data('before.rows', True)
            if maximum is None or rows is None:
                raise ValueError('Captured ELL dimensions required; recapture with the current host_trace.so')
            entries = struct.unpack('<Q', maximum)[0]
            row_count = pointer('before.row_count') if entries else bytes(8)
            matrix = pointer('before.entries') if entries else bytes(8)
            args = [row_count, matrix, maximum, pointer('before.blocks'), upload(direction), pointer('before.extra', True),
                    output('ap'), world, per_group, output('denominator', data('before.denominator')),
                    struct.pack('<Q', n), rows]
            atomic = {'denominator'}
        else:
            direction = data('before.p')
            n = len(direction) // 12
            args = [world, per_group, pointer('before.numerator'), pointer('before.denominator'), upload(direction),
                    pointer('before.ap'), output('x', data('before.x')), output('r', data('before.r')), struct.pack('<Q', n)]
            atomic = set()
        driver.launch(driver.function(name), row['grid'], row['block'], args)
        driver.synchronize()
        checks = {key: driver.download(pointer, len(expected)) == expected for key, (pointer, expected) in buffers.items()}
        report.append({'launch': meta.name, 'checks': checks, 'atomic_outputs': sorted(atomic)})
        for pointer in allocations:
            driver.release(pointer)
    expected = 4 * nonlinear_iterations * linear_iterations * steps
    assert expected > 0 and len(report) == expected, 'Captured PCG calls do not cover the declared scene'
    for start in range(0, len(report), 4):
        for item, token in zip(report[start:start+4], ('23precondition', '19update_cg', '26multiply', '28update_solution')):
            assert token in item['launch'], 'Captured PCG stage order differs'
    pointwise = [(r['launch'], k) for r in report for k, v in r['checks'].items() if k not in r['atomic_outputs'] and not v]
    aggregate = [(r['launch'], k) for r in report for k, v in r['checks'].items() if k in r['atomic_outputs'] and not v]
    from .host_particles_ab import OUT
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text(), 'Original solver mapped in source replay'
    return {'calls': report, 'pointwise_failures': pointwise, 'atomic_aggregate_failures': aggregate,
            'expected_calls': expected, 'original_solver_mapped': False,
            'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256'],
            'pointwise_checks': sum(k not in r['atomic_outputs'] for r in report for k in r['checks']),
            'aggregate_checks': sum(len(r['atomic_outputs']) for r in report),
            'full_bitwise_equal': not pointwise and not aggregate}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('directory', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--nonlinear-iterations', type=int, default=1)
    parser.add_argument('--linear-iterations', type=int, default=7)
    parser.add_argument('--steps', type=int, default=3)
    args = parser.parse_args()
    result = replay(args.directory, args.nonlinear_iterations, args.linear_iterations, args.steps)
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('pointwise', result['pointwise_checks'], 'failures', len(result['pointwise_failures']),
          'atomic aggregates', result['aggregate_checks'], 'failures', len(result['atomic_aggregate_failures']))
    assert result['full_bitwise_equal'], 'Strict replay still differs; inspect pointwise and atomic outputs separately'


if __name__ == '__main__':
    main()
