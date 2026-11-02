"""Compare old prepare's world-frame and angular-strain derivative exits against readable CUDA."""
import ctypes
import json
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.diagnostics.cable_cuda_ab import scene


def original_probe():
    name, entry, text = next((name, entry, path.read_text()) for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                             for name, entry in pc.entries(path.read_text()).items()
                             if '22prepare_cable_tangents' in name)
    original = entry
    entry = entry.replace('{', '{\n.reg .b64 %probe_out, %probe_offset;\n', 1)
    frames = f'''
ld.param.u64 %probe_out, [{name}_param_0+104];
mul.lo.s64 %probe_offset, %rd4, 96;
add.s64 %probe_out, %probe_out, %probe_offset;
'''
    frames += ''.join(f'st.global.f32 [%probe_out+{at*4}], %f{reg};\n' for at, reg in
                      enumerate(list(range(3043, 3052)) + list(range(3084, 3090))))
    entry = entry.replace('$L__BB72_82:', '$L__BB72_82:\n' + frames, 1)
    linear = f'''
ld.param.u64 %probe_out, [{name}_param_0+104];
mul.lo.s64 %probe_offset, %rd4, 96;
add.s64 %probe_out, %probe_out, %probe_offset;
'''
    linear += ''.join(f'st.global.f32 [%probe_out+{60 + at*4}], %f{414 + at};\n' for at in range(9))
    assert entry.count('mov.u32 %r1705, 0;') == 1
    entry = entry.replace('mov.u32 %r1705, 0;', linear + 'mov.u32 %r1705, 0;', 1)
    # Run both endpoint differential branches even for static endpoints. The probe
    # exports derivatives before slot assembly, so it never reads static-body ids.
    skip = '@%p131 bra $L__BB72_208;'
    assert entry.count(skip) == 1
    entry = entry.replace(skip, '')
    derivatives = f'''
ld.param.u64 %probe_out, [{name}_param_0+112];
mul.lo.s64 %probe_offset, %rd4, 72;
add.s64 %probe_out, %probe_out, %probe_offset;
mul.wide.u32 %probe_offset, %r1705, 36;
add.s64 %probe_out, %probe_out, %probe_offset;
'''
    registers = (473, 474, 3157, 594, 595, 3203, 715, 716, 3249)
    derivatives += ''.join(f'st.global.f32 [%probe_out+{at*4}], %f{reg};\n'
                           for at, reg in enumerate(registers))
    derivatives += '@!%p130 ret;\nbra $L__BB72_208;\n'
    entry = entry.replace('$L__BB72_202:', '$L__BB72_202:\n' + derivatives, 1)
    return text.replace(original, entry, 1), name


def cases(rng):
    for case in ('identity', 'affine', 'zero_inertia', 'nonsymmetric_inertia', 'parallel', 'opposite',
                 'opposite_degenerate_parent', 'cap_boundary', 'nan_quaternion', 'inf_quaternion',
                 'nan_affine', 'zero_affine', 'reflection') + tuple(f'near_opposite_{i}' for i in range(8)) + \
                tuple(f'rotated_opposite_{i}' for i in range(8)):
        data, q, stride = scene(rng, n=32, worlds=3, variant=0 if case == 'identity' else 1)
        affine = q.reshape(3, -1, 4, 3)[:, :, 1:]
        if case == 'zero_inertia': data[16][:] = 0
        if case == 'nonsymmetric_inertia': data[16] += rng.normal(0, .2, data[16].shape).astype(np.float32)
        if case in ('parallel', 'opposite', 'opposite_degenerate_parent', 'cap_boundary') or \
                case.startswith(('near_opposite_', 'rotated_opposite_')):
            data[24][:] = -1
            data[32][:, 3:], data[40][:, 3:] = [0, 0, 0, 1], [0, 0, 0, 1]
            if case == 'opposite': data[40][:, 3:] = [1, 0, 0, 0]
            if case == 'opposite_degenerate_parent':
                data[32][:, 3:], data[40][:, 3:] = [0, .5, .5, 0], [1, 0, 0, .5]
            if case == 'cap_boundary':
                angle = np.float32(np.arctan(10))
                data[40][:, 3:] = [np.sin(angle), 0, 0, np.cos(angle)]
            if case.startswith(('near_opposite_', 'rotated_opposite_')):
                epsilon = (-.2, -.1, -1e-4, -1e-7, 1e-7, 1e-4, .1, .2)[int(case.rsplit('_', 1)[1])]
                data[40][:, 3:] = [np.sqrt(1 - epsilon * epsilon), 0, 0, epsilon]
                data[32][:, 3:] = [0, 0, np.sin(.3), np.cos(.3)]
            if case.startswith('rotated_opposite_'):
                rotation = rng.normal(size=(len(data[24]), 4)).astype(np.float32)
                rotation /= np.linalg.norm(rotation, axis=1)[:, None]
                for off in (32, 40):
                    authored = data[off][:, 3:].copy()
                    vector = rotation[:, 3:] * authored[:, :3] + authored[:, 3:] * rotation[:, :3] + \
                        np.cross(rotation[:, :3], authored[:, :3])
                    scalar = rotation[:, 3] * authored[:, 3] - np.sum(rotation[:, :3] * authored[:, :3], axis=1)
                    data[off][:, 3:6], data[off][:, 6] = vector, scalar
        if case == 'nan_quaternion': data[32][:, 3] = np.nan
        if case == 'inf_quaternion': data[40][:, 6] = np.inf
        if case == 'nan_affine': affine[:, :, 0, 0] = np.nan
        if case == 'zero_affine': affine[:] = 0
        if case == 'reflection': affine[:, :, 0] *= -1
        yield case, data, q, stride


def main():
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    out = pc.OUT/'cable-strain-jacobian-audit'
    out.mkdir(parents=True, exist_ok=True)
    wrapper = out/'cable-strain-jacobian-probe.cu'
    wrapper.write_text('''#include "cable_tangent_geometry.cuh"
using namespace synreal::kernel;
extern "C" __global__ void cable_strain_jacobian_probe(CableView view, const glm::vec3* x) {
    const size_t i = thread_index();
    if (i >= view.total_count) return;
    const size_t local = i % view.per_world, world = i / view.per_world;
    const CableFrame parent = cable_prepare_frame<true>(view, local, world, x);
    const CableFrame child = cable_prepare_frame<false>(view, local, world, x);
    glm::vec3* frames = reinterpret_cast<glm::vec3*>(view.linear) + i * 8;
    for (int k = 0; k < 3; ++k) frames[k] = parent.basis[k];
    frames[3] = child.basis[0]; frames[4] = child.basis[2];
    const glm::mat3 linear = cable_linear_rotation_jacobian(parent, child);
    for (int k = 0; k < 3; ++k) frames[5 + k] = linear[k];
    view.angular[i * 2] = cable_angular_jacobian<true>(parent, child);
    view.angular[i * 2 + 1] = cable_angular_jacobian<false>(parent, child);
}
''')
    source = pc.compile_ptx(wrapper, pc.DEFAULT_NVCC)
    old, name = original_probe()
    driver, reports = k.Driver(), {}
    try:
        functions = driver.function(old, name), driver.function(source, 'cable_strain_jacobian_probe')
        for case, data, q, stride in cases(np.random.default_rng(seed)):
            count, n = len(data[56]), len(data[24])
            frames, jacobians = np.full((count + 7, 24), -17, np.float32), np.full((count + 7, 18), -19, np.float32)
            outputs = []
            for fun in functions:
                ptr = {off: driver.upload(array) for off, array in data.items()}
                ptr[104], ptr[112] = driver.upload(frames), driver.upload(jacobians)
                words = [ptr[off].value for off in range(0, 136, 8)] + [n, count, stride]
                view = (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
                driver.launch(fun, count + 7, [view, driver.upload(q)])
                outputs.append((driver.download(ptr[104], frames), driver.download(ptr[112], jacobians)))
            for at, field in enumerate(('frames', 'jacobians')):
                reports[case + '_' + field] = k.compare(field, outputs[0][at], outputs[1][at])
            if any(not reports[case + '_' + field]['bitwise_equal'] for field in ('frames', 'jacobians')):
                np.savez(out/f'diff-{case}-seed{seed}.npz', old_frames=outputs[0][0], source_frames=outputs[1][0],
                         old_jacobians=outputs[0][1], source_jacobians=outputs[1][1], q=q,
                         **{f'input_{off}': array for off, array in data.items()})
            print(case, reports[case + '_frames']['mismatches'], reports[case + '_jacobians']['mismatches'], flush=True)
    finally:
        driver.free()
    (out/f'gpu-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(any(not row['bitwise_equal'] for row in reports.values()))


if __name__ == '__main__':
    sys.exit(main())
