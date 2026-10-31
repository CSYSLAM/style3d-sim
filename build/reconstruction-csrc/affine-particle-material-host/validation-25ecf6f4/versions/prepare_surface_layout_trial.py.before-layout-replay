"""Build an isolated 220-byte contact-layout experiment; never overwrite accepted CUDA sources or bundles."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

from .demo_source_ab import ROOT
from .ptx_compare import DEFAULT_NVCC


def generate():
    source = (ROOT / 'reconstruction/csrc/kernels/surface_contacts.cu').read_text()
    header = source[:source.index('struct SurfaceContact {')]
    header = header.replace('#include "contact_geometry.cuh"',
                            '#include "' + str(ROOT / 'reconstruction/csrc/kernels/contact_geometry.cuh') + '"')
    structures = '''struct SurfaceJacobianTrial {
    int targets[7];
    float weights[7];
    int count;
    __device__ __forceinline__ void append(int target, float weight) {
        targets[count] = target;
        weights[count] = weight;
        ++count;
    }
};
struct SurfaceContactTrial {
    SurfaceJacobianTrial normal_jacobian, friction_jacobian;
    glm::vec3 normal_force, friction_force;
    glm::mat3 normal_matrix, friction_matrix;
    float stiffness_sum;
};
static_assert(sizeof(SurfaceJacobianTrial) == 60);
static_assert(sizeof(SurfaceContactTrial) == 220);
static_assert(offsetof(SurfaceContactTrial, normal_force) == 120);
static_assert(offsetof(SurfaceContactTrial, normal_matrix) == 144);
static_assert(offsetof(SurfaceContactTrial, stiffness_sum) == 216);

__device__ __forceinline__ glm::mat3 trial_matrix(const glm::vec3& n, float scale, bool friction)
{
    const float xx = friction ? 1.0f - n.x * n.x : n.x * n.x;
    const float xy = friction ? 0.0f - n.y * n.x : n.y * n.x;
    const float xz = friction ? 0.0f - n.z * n.x : n.z * n.x;
    const float yy = friction ? 1.0f - n.y * n.y : n.y * n.y;
    const float yz = friction ? 0.0f - n.z * n.y : n.z * n.y;
    const float zz = friction ? 1.0f - n.z * n.z : n.z * n.z;
    return glm::mat3(glm::vec3(xx, xy, xz) * scale, glm::vec3(xy, yy, yz) * scale, glm::vec3(xz, yz, zz) * scale);
}

'''
    calculation = source[source.index('__device__ __forceinline__ bool surface_finite'):
                         source.index('__device__ __forceinline__ glm::mat3 surface_matrix')]
    replacements = [
        ('SurfaceContact& contact', 'SurfaceContactTrial& output'),
        ('    contact.entries = 0;',
         '    SurfaceContactTrial contact;\n    contact.normal_jacobian.count = contact.friction_jacobian.count = 0;'),
        ('''        contact.targets[contact.entries] = vertex;
        contact.normal_weights[contact.entries] = b;
        contact.friction_weights[contact.entries] = b;
        ++contact.entries;''',
         '''        contact.normal_jacobian.append(vertex, b);
        contact.friction_jacobian.append(vertex, b);'''),
        ('!contact.entries', '!contact.normal_jacobian.count'),
        ('''            contact.targets[contact.entries + j] = ids[j];
            contact.normal_weights[contact.entries + j] = wn[j];
            contact.friction_weights[contact.entries + j] = wt[j];''',
         '''            contact.normal_jacobian.append(ids[j], wn[j]);
            contact.friction_jacobian.append(ids[j], wt[j]);'''),
        ('        contact.entries += 4;\n', ''),
        ('''    contact.normal = n;
    contact.tangent = tangent;
    contact.force = fn;
    contact.eta = eta;
    contact.stiffness = fmaf(kd, view.inv_dt, ke);
    contact.stiffness_sum = ke + kdh;
    contact.friction = eta * view.inv_dt;
    return true;''',
         '''    contact.normal_force = fn * n;
    contact.friction_force = -eta * tangent;
    contact.stiffness_sum = ke + kdh;
    contact.normal_matrix = trial_matrix(n, fmaf(kd, view.inv_dt, ke), false);
    contact.friction_matrix = trial_matrix(n, eta * view.inv_dt, true);
    output = contact;
    return true;'''),
    ]
    for before, after in replacements:
        assert before in calculation, before
        calculation = calculation.replace(before, after)
    kernels = '''
__device__ __forceinline__ void trial_scatter(const SurfaceJacobianTrial& jacobian,
                                              const glm::vec3& value, glm::vec3* output)
{
    for (int j = 0; j < jacobian.count; ++j)
        atomic_add(&output[jacobian.targets[j]], jacobian.weights[j] * value);
}

__global__ void evaluate_surface_contact_force(SurfaceContactView view, glm::vec3* force)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact;
        if (!surface_contact<false, true>(view, i, contact)) continue;
        trial_scatter(contact.normal_jacobian, contact.normal_force, force);
        trial_scatter(contact.friction_jacobian, contact.friction_force, force);
    }
}

__global__ void add_surface_contact_stiffness_scale(SurfaceContactView view, float* scale)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact;
        if (!surface_contact<true, true>(view, i, contact)) continue;
        for (int j = 0; j < contact.normal_jacobian.count; ++j) {
            const float w = contact.normal_jacobian.weights[j];
            atomicAdd(&scale[contact.normal_jacobian.targets[j]], (w * w) * contact.stiffness_sum);
        }
    }
}

__global__ void add_surface_contact_preconditioner(SurfaceContactView view, glm::mat3* blocks)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact;
        if (!surface_contact<true, true>(view, i, contact)) continue;
        for (int part = 0; part < 2; ++part) {
            const auto& jacobian = part ? contact.friction_jacobian : contact.normal_jacobian;
            const auto& matrix = part ? contact.friction_matrix : contact.normal_matrix;
            for (int j = 0; j < jacobian.count; ++j) {
                const float w = jacobian.weights[j];
                atomic_add(&blocks[jacobian.targets[j]], matrix * (w * w));
            }
        }
    }
}

__global__ void multiply_surface_contact_tangent(SurfaceContactView view, const glm::vec3* direction,
                                                glm::vec3* product)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact;
        if (!surface_contact<false, false>(view, i, contact)) continue;
        for (int part = 0; part < 2; ++part) {
            const auto& jacobian = part ? contact.friction_jacobian : contact.normal_jacobian;
            const auto& matrix = part ? contact.friction_matrix : contact.normal_matrix;
            glm::vec3 sum(0.0f);
            for (int j = 0; j < jacobian.count; ++j)
                sum = contact_fma(jacobian.weights[j], direction[jacobian.targets[j]], sum);
            const glm::vec3 value(contact_dot(matrix[0], sum), contact_dot(matrix[1], sum), contact_dot(matrix[2], sum));
            trial_scatter(jacobian, value, product);
        }
    }
}
} // namespace synreal::kernel
'''
    return header + structures + calculation + kernels


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    source = args.output / 'surface_struct220_trial.cu'
    source.write_text(generate())
    ptx = source.with_suffix('.ptx')
    command = [DEFAULT_NVCC, '-ptx', '-arch=sm_52', '-Wno-deprecated-gpu-targets', '-diag-suppress=20012',
               '-std=c++17', '-O3', '-DNDEBUG', '-I', str(ROOT / 'build/third_party/glm-1.0.1'),
               str(source), '-o', str(ptx)]
    (args.output / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    subprocess.run(command, check=True)
    (args.output / 'provenance.json').write_text(json.dumps({
        'experimental_only': True, 'production_changed': False,
        'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        'ptx_sha256': hashlib.sha256(ptx.read_bytes()).hexdigest(),
        'generator_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
