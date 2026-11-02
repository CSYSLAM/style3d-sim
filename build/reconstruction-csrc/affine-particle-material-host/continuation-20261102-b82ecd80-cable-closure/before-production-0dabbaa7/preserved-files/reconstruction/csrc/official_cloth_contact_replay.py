"""Capture or replay the first official native contact input; keep this diagnostic outside acceptance cohorts."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from . import host_api_probe, host_particles_ab, official_cloth_balls_ab


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--input', type=Path)
    parser.add_argument('--observe', action='store_true')
    args = parser.parse_args()
    assert args.input or args.backend == 'original'
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    driver = ct.CDLL('libcuda.so.1')
    driver.cuMemcpyDtoH_v2.argtypes = [ct.c_void_p, ct.c_uint64, ct.c_size_t]
    driver.cuMemcpyHtoD_v2.argtypes = [ct.c_uint64, ct.c_void_p, ct.c_size_t]
    for name in ('cuMemcpyDtoH_v2', 'cuMemcpyHtoD_v2', 'cuCtxSynchronize'):
        getattr(driver, name).restype = ct.c_int
    observer = ct.CDLL(None) if args.observe else None
    if observer:
        observer.solver_trace_begin.argtypes = [ct.c_char_p]
    schema = json.loads((Path(__file__).parent / 'native/api_schema.json').read_text())['classes']
    widths = {name: 12 for name in (
        'normal', 'offset0', 'offset1', 'point0', 'point1', 'soft_barycentric', 'soft_body_pos',
        'soft_body_vel', 'soft_indices', 'soft_normal')}

    def download(span, length):
        assert span.ptr and length >= 0
        result = np.empty(length, dtype='u1')
        assert driver.cuMemcpyDtoH_v2(ct.c_void_p(result.ctypes.data), span.ptr, length) == 0
        return result

    owner = host_api_probe if args.backend == 'original' else host_particles_ab
    factory_name = 'load_reference' if args.backend == 'original' else 'native_source'
    factory = getattr(owner, factory_name)
    count = 0

    def selected():
        core = factory()
        step = core.Solver.step

        def observed(solver, state_in, state_out, control, contact, dt, stream):
            nonlocal count
            count += 1
            if count != 1:
                return step(solver, state_in, state_out, control, contact, dt, stream)
            assert driver.cuCtxSynchronize() == 0
            payload, fields = {}, {}
            active = {name: int(download(getattr(contact, name), 4).view('i4')[0])
                      for name in ('count', 'soft_count')}
            assert active == {'count': 17, 'soft_count': 1380}
            for group, value in (('state', state_in), ('control', control), ('contact', contact)):
                kind = {'state': 'State', 'control': 'Control', 'contact': 'Contact'}[group]
                for name, field in schema[kind].items():
                    key = group + '.' + name
                    item = getattr(value, name)
                    if field['type'] != 'Span':
                        fields[key] = {'value': item}
                        continue
                    row = {'size': item.size, 'null': item.ptr == 0}
                    if item.ptr:
                        if group == 'contact':
                            n = item.size if name in ('count', 'soft_count', 'soft_particle_only_shapes') else \
                                active['soft_count' if name.startswith('soft_') else 'count']
                            width = widths.get(name, 4)
                        else:
                            n, width = item.size, 12 if group == 'state' else 4
                        assert 0 <= n <= item.size
                        row.update(elements=n, width=width)
                        payload[key] = download(item, n * width)
                    fields[key] = row
            fields['dt'] = {'hex': float(dt).hex()}
            current = {'fields': fields, 'active': active}
            if args.input:
                expected = json.loads((args.input / 'native-input.json').read_text())
                assert expected['fields'] == fields and expected['active'] == active
                with np.load(args.input / 'native-input.npz') as saved:
                    assert set(saved.files) == set(payload)
                    checks = {key: payload[key].tobytes() == saved[key].tobytes()
                              for key in payload if not key.startswith('contact.')}
                    assert all(checks.values()), checks
                    current['state_and_control_equal_before_injection'] = checks
                    for key in payload:
                        if key.startswith('contact.'):
                            initial = saved[key]
                            span = getattr(contact, key.removeprefix('contact.'))
                            assert driver.cuMemcpyHtoD_v2(span.ptr, ct.c_void_p(initial.ctypes.data), initial.nbytes) == 0
                            payload[key] = download(span, initial.nbytes)
                            assert payload[key].tobytes() == initial.tobytes()
                current['input_sha256'] = hashlib.sha256((args.input / 'native-input.npz').read_bytes()).hexdigest()
            np.savez_compressed(args.output / 'native-input.npz', **payload)
            (args.output / 'native-input.json').write_text(json.dumps(current, indent=2) + '\n')
            if observer:
                observer.solver_trace_begin(str(args.output / 'native').encode())
            result = step(solver, state_in, state_out, control, contact, dt, stream)
            if observer:
                observer.solver_trace_end()
            assert driver.cuCtxSynchronize() == 0
            outputs = {name: download(getattr(state_out, name), getattr(state_out, name).size * 12)
                       for name in ('particle_q', 'particle_qd')}
            np.savez_compressed(args.output / 'native-output.npz', **outputs)
            return result

        core.Solver.step = observed
        (args.output / 'diagnostic-provenance.json').write_text(json.dumps({
            'source_or_reference_image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
            'input': str(args.input), 'observed': args.observe, 'acceptance_cohort_changed': False,
            'same_first_native_state_required': True, 'contact_tail_read_or_replaced': False,
            'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        }, indent=2) + '\n')
        return core

    setattr(owner, factory_name, selected)
    official_cloth_balls_ab.worker(argparse.Namespace(
        worker=args.backend, mode='eager', frames=60, output=args.output))
    assert count == 120


if __name__ == '__main__':
    main()
