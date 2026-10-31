"""Compare old prepare first-body rotation and angular differential exits against named CUDA."""
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
    entry = entry.replace('{', '{\n.reg .b64 %probe_out, %probe_offset, %probe_flag;\n', 1)

    def matrix_output(registers):
        return ''.join(f'st.global.{'u32' if register.startswith('%r') else 'f32'} '
                       f'[%probe_out+{at*4}], {register};\n' for at, register in enumerate(registers))

    code = f'''
ld.param.u64 %probe_out, [{name}_param_0+112];
mul.lo.s64 %probe_offset, %rd4, 108;
add.s64 %probe_out, %probe_out, %probe_offset;
'''
    code += matrix_output([f'%r{i}' for i in range(1508, 1481, -1)])
    code += f'''
ld.param.u64 %probe_out, [{name}_param_0+104];
mul.lo.s64 %probe_offset, %rd4, 36;
add.s64 %probe_out, %probe_out, %probe_offset;
ld.param.u64 %probe_flag, [{name}_param_0+128];
mul.lo.s64 %probe_offset, %rd4, 4;
add.s64 %probe_flag, %probe_flag, %probe_offset;
@%p173 bra PROBE_FALLBACK;
st.global.u32 [%probe_flag], 1;
'''
    code += matrix_output([f'%f{i}' for i in range(3011, 3020)]) + 'ret;\nPROBE_FALLBACK:\n'
    code += 'st.global.u32 [%probe_flag], 0;\n' + matrix_output([f'%f{i}' for i in range(109, 118)]) + 'ret;\n'
    entry = entry.replace('$L__BB72_43:', '$L__BB72_43:\n' + code, 1)
    return text.replace(original, entry, 1), name


def main():
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    rng = np.random.default_rng(seed)
    out = pc.OUT/'cable-spin-audit'
    out.mkdir(parents=True, exist_ok=True)
    wrapper = out/'cable-spin-probe.cu'
    wrapper.write_text('''#include "cable_types.cuh"
#include "cable_spin.cuh"
using namespace synreal::kernel;
extern "C" __global__ void cable_spin_probe(CableView view, const glm::vec3* x) {
    const size_t i = thread_index();
    if (i >= view.total_count) return;
    const size_t local = i % view.per_world, world = i / view.per_world;
    const int body = view.body_pairs[local].x;
    const glm::ivec4 ids = view.body_indices[body] + static_cast<int>(world * view.particles_per_world);
    const float* inertia = reinterpret_cast<const float*>(view.body_matrix) + body * 9;
    const CableSpin result = cable_rotation_spin(x[ids.y], x[ids.z], x[ids.w], inertia);
    reinterpret_cast<glm::mat3*>(view.linear)[i] = result.rotation;
    view.count[i] = result.inertia_weighted;
    for (int k = 0; k < 3; ++k) view.angular[i * 3 + k] = result.maps[k];
}
''')
    source = pc.compile_ptx(wrapper, pc.DEFAULT_NVCC)
    legacy, symbol = original_probe()
    d, reports = k.Driver(), {}
    try:
        functions = d.function(legacy, symbol), d.function(source, 'cable_spin_probe')
        cases = ('identity', 'affine', 'nonsymmetric_inertia', 'positive_inertia', 'physical_inertia', 'zero_inertia',
                 'negative_inertia', 'tiny_inertia', 'huge_inertia', 'nan_inertia', 'inf_inertia',
                 'reflection', 'zero_affine', 'rank_one', 'tiny_affine', 'threshold_affine', 'huge_affine',
                 'nan_affine', 'inf_affine')
        for case in cases:
            data, q, stride = scene(rng, n=64, worlds=3, variant=0 if case == 'identity' else 1)
            n, count = len(data[24]), len(data[56])
            data[24][:, 0] = np.arange(n) * 2
            data[96][::7] = 0
            affine = q.reshape(3, -1, 4, 3)[:, :, 1:]
            if case == 'nonsymmetric_inertia': data[16] += rng.normal(0, .25, data[16].shape).astype(np.float32)
            if case == 'positive_inertia':
                r = rng.normal(size=data[16].shape).astype(np.float32)
                data[16] = r @ r.transpose(0, 2, 1) + np.eye(3, dtype=np.float32) * .1
            if case == 'physical_inertia':
                r = rng.normal(scale=.2, size=data[16].shape).astype(np.float32)
                moment = r @ r.transpose(0, 2, 1) + np.eye(3, dtype=np.float32) * .3
                data[16] = np.trace(moment, axis1=1, axis2=2)[:, None, None] * np.eye(3) - moment
                data[16] = data[16].astype(np.float32)
            if case == 'zero_inertia': data[16][:] = 0
            if case == 'negative_inertia': data[16] *= -1
            if case == 'tiny_inertia': data[16] *= np.float32(1e-35)
            if case == 'huge_inertia': data[16] *= np.float32(1e35)
            if case == 'nan_inertia': data[16][:, 0, 0] = np.nan
            if case == 'inf_inertia': data[16][:, 0, 0] = np.inf
            if case == 'reflection': affine[:, :, 0] *= -1
            if case == 'zero_affine': affine[:] = 0
            if case == 'rank_one': affine[:, :, 1:] = affine[:, :, :1]
            if case == 'tiny_affine': affine[:] *= np.float32(1e-20)
            if case == 'threshold_affine':
                affine[:] = np.eye(3, dtype=np.float32) * np.float32(1e-10)
                affine[:, ::2, 0, 0] = np.nextafter(np.float32(1e-10), np.float32(0))
                affine[:, 1::2, 0, 0] = np.nextafter(np.float32(1e-10), np.float32(np.inf))
            if case == 'huge_affine': affine[:] *= np.float32(1e20)
            if case == 'nan_affine': affine[:, :, 0, 0] = np.nan
            if case == 'inf_affine': affine[:, :, 0, 0] = np.inf
            matrices = np.full((count + 7, 9), -19, np.float32)
            flags = np.full(count + 7, -31, np.int32)
            spins = np.full((count + 7, 27), -23, np.float32)
            outputs = []
            for backend, fun in enumerate(functions):
                ptr = {off: d.upload(array) for off, array in data.items()}
                ptr[104], ptr[128] = d.upload(matrices), d.upload(flags)
                ptr[112] = d.upload(spins)
                words = [ptr[off].value for off in range(0, 136, 8)] + [n, count, stride]
                view = (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
                args = [view, d.upload(q)]
                d.launch(fun, count + 7, args, block=32)
                outputs.append((d.download(ptr[104], matrices), d.download(ptr[128], flags), d.download(ptr[112], spins)))
            reports[case + '_rotation'] = k.compare(case, outputs[0][0], outputs[1][0])
            reports[case + '_weighted'] = k.compare(case, outputs[0][1], outputs[1][1])
            reports[case + '_spin'] = k.compare(case, outputs[0][2], outputs[1][2])
            reports[case + '_rotation']['weighted_body_count'] = int(np.count_nonzero(outputs[0][1] == 1))
            if not reports[case + '_rotation']['bitwise_equal'] or not reports[case + '_spin']['bitwise_equal']:
                np.savez(out/f'diff-{case}-seed{seed}.npz', original=outputs[0][0], source=outputs[1][0],
                         q=q, inertia=data[16], original_spin=outputs[0][2], source_spin=outputs[1][2],
                         original_flags=outputs[0][1], source_flags=outputs[1][1])
            print(case, reports[case + '_rotation']['mismatches'], reports[case + '_weighted']['mismatches'],
                  reports[case + '_spin']['mismatches'], flush=True)
    finally:
        d.free()
    (out/f'gpu-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(any(not row['bitwise_equal'] for row in reports.values()))


if __name__ == '__main__':
    sys.exit(main())
