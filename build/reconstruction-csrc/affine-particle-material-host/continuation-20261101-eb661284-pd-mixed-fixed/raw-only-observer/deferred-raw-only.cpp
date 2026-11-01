// Test-only LD_PRELOAD observer: snapshot real no-topology Newton/PCG launches in both original and source workers.
// Synchronization is intentional for diagnosis; this observer is never linked into the delivered solver.
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <algorithm>
#include <cstdint>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <map>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
#include "surface_view.h"

static std::string trace_directory;
static std::size_t sequence = 0;
static thread_local bool observing = false;

// Diagnostic staging preserves each stream's order and postpones host copies until all three steps finish.
struct DeferredFile {
    std::string name;
    std::vector<char> host;
    std::size_t offset = 0, size = 0;
    bool device = false;
};
static std::vector<DeferredFile> deferred_files;
static CUdeviceptr staging = 0;
static std::size_t staging_used = 0;
static const std::size_t staging_capacity = 64 * 1024 * 1024;


template <class T> static T argument(void** args, int index)
{
    T result;
    std::memcpy(&result, args[index], sizeof(T));
    return result;
}

static void checked(CUresult result)
{
    if (result != CUDA_SUCCESS) throw std::runtime_error("CUDA failure in test observer");
}

static std::string category(const char* name)
{
    if (!name) return {};
    const std::string value(name);
    for (const char* token : {"15initialize_stepE", "14initialize_rhsE", "25initialize_block_diagonalE",
            "27invert_block_preconditionerE", "23precondition_and_reduceIN3glm", "19update_cg_directionE",
            "26multiply_matrix_and_reduceINS_17BlockNonZeroEntry", "28update_solution_and_residualEP",
            "20apply_nonlinear_stepE", "15update_velocityE", "21evaluate_spring_forceE",
            "31add_spring_gauss_newton_hessianE", "30prepare_inverse_preconditionerE",
            "23precondition_and_reduceIf", "26multiply_matrix_and_reduceINS_12NonZeroEntryEf",
            "26multiply_matrix_and_reduceINS_12NonZeroEntryEN3glm", "27combine_system_non_diagonalE",
            "27evaluate_soft_contact_forceE", "42multiply_soft_contact_hessian_off_diagonalE",
            "22evaluate_stretch_forceE", "39add_cloth_membrane_gauss_newton_hessianE", "22evaluate_bending_forceE",
            "34add_bending_damping_preconditionerE", "32multiply_bending_damping_tangentE",
            "26evaluate_tetrahedron_forceE", "30add_tetrahedron_preconditionerE", "28multiply_tetrahedron_tangentE",
            "24initialize_triangle_dragE", "22evaluate_triangle_dragE", "32add_triangle_drag_preconditionerE",
            "30multiply_triangle_drag_tangentE", "30evaluate_surface_contact_forceE",
            "35add_surface_contact_stiffness_scaleE", "34add_surface_contact_preconditionerE",
            "32multiply_surface_contact_tangentE"})
        if (value.find(std::string("kernel") + token) != std::string::npos) return token;
    return {};
}

class Observation {
    std::string prefix_, group_;
    void** args_;
    CUstream stream_;

    void bytes(const std::string& label, const void* data, std::size_t count)
    {
        const char* begin = static_cast<const char*>(data);
        deferred_files.push_back({prefix_ + label + ".bin", std::vector<char>(begin, begin + count), 0, count, false});
    }

    void address(const std::string& label, CUdeviceptr pointer, std::size_t count, std::size_t width)
    {
        if (!pointer || !count) return;
        if (count > 1000000) throw std::runtime_error("Observer only supports bounded diagnostic cases");
        const auto size = count * width;
        if (!staging || staging_used + size > staging_capacity)
            throw std::runtime_error("Deferred diagnostic staging capacity exceeded");
        checked(cuMemcpyDtoDAsync(staging + staging_used, pointer, size, stream_));
        deferred_files.push_back({prefix_ + label + ".bin", {}, staging_used, size, true});
        staging_used += size;
    }

    void device(const std::string& label, int arg, std::size_t count, std::size_t width)
    {
        address(label, argument<CUdeviceptr>(args_, arg), count, width);
    }

    std::size_t groups(int world_arg, int divisor_arg, std::size_t n)
    {
        const auto pointer = argument<CUdeviceptr>(args_, world_arg);
        if (!pointer) {
            const auto divisor = argument<unsigned>(args_, divisor_arg);
            return (n + divisor - 1) / divisor;
        }
        throw std::runtime_error("Deferred diagnostic requires contiguous groups with a null world pointer");
    }

    void snapshot(bool after)
    {

        const std::string at = after ? "after." : "before.";
        auto copy = [&](const char* label, int arg, std::size_t count, std::size_t width) {
            device(at + label, arg, count, width);
        };
        auto scalar = [&](const char* label, int arg, std::size_t width) { bytes(at + label, args_[arg], width); };
        if (!after && group_ == "30prepare_inverse_preconditionerE") {
            const std::size_t widths[] = {8,8,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "23precondition_and_reduceIf") {
            const std::size_t widths[] = {8,8,8,1,8,4,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "26multiply_matrix_and_reduceINS_12NonZeroEntryEf") {
            const std::size_t widths[] = {8,8,8,8,8,8,8,8,4,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "15initialize_stepE") {
            const std::size_t widths[] = {4,8,8,8,8,8,8,8,4,8,4,8,4,8,4,8,4,8,8,8,8,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "14initialize_rhsE") {
            const std::size_t widths[] = {4,8,8,8,8,8,8,8,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "27invert_block_preconditionerE") {
            const std::size_t widths[] = {8,8,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "25initialize_block_diagonalE") {
            const std::size_t widths[] = {8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "23precondition_and_reduceIN3glm") {
            const std::size_t widths[] = {8,8,8,1,8,4,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "19update_cg_directionE") {
            const std::size_t widths[] = {4,8,8,4,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "26multiply_matrix_and_reduceINS_17BlockNonZeroEntry") {
            const std::size_t widths[] = {8,8,8,8,8,8,8,8,4,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "28update_solution_and_residualEP") {
            const std::size_t widths[] = {8,4,8,8,8,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "20apply_nonlinear_stepE") {
            const std::size_t widths[] = {8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (!after && group_ == "15update_velocityE") {
            const std::size_t widths[] = {4,8,8,8,8};
            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)
                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);
        }
        if (group_ == "15initialize_stepE") {
            const auto n = argument<std::size_t>(args_, 23), local = argument<std::size_t>(args_, 24);
            copy("x", 5, n, 12);
            if (after) { copy("previous", 20, n, 12); copy("target", 21, n, 12); copy("diagonal", 22, n, 4); }
            else { copy("v", 4, n, 12); copy("mass", 17, local, 4); copy("flags", 18, local, 4);
                   copy("host_diagonal", 6, local, 4);
                   for (int i = 0; i < 5; ++i) device(at + "diagonal_template" + std::to_string(i), 7+2*i, local, 4);
                   copy("particle_kind", 19, local, 4);
                   copy("gravity", 1, argument<std::size_t>(args_, 2), 12);
                   copy("world", 3, local, 4); }
        } else if (group_ == "14initialize_rhsE") {
            const auto n = argument<std::size_t>(args_, 10);
            if (after) copy("rhs", 9, n, 12);
            else { copy("x", 1, n, 12); copy("target", 2, n, 12); copy("external", 7, n, 12);
                   const auto local = argument<std::size_t>(args_, 11);
                   copy("mass", 3, local, 4); copy("flags", 8, local, 4);
                   const auto maximum = argument<std::size_t>(args_, 6);
                   if (maximum) { copy("row_count", 4, local, 4); copy("entries", 5, maximum * local, 8); } }
        } else if (group_ == "25initialize_block_diagonalE") {
            const auto n = argument<std::size_t>(args_, 3);
            if (after) { copy("blocks", 1, n, 36); copy("precond", 2, n, 36); }
            else copy("diagonal", 0, n, 4);
        } else if (group_ == "27invert_block_preconditionerE") {
            const auto n = argument<std::size_t>(args_, 4);
            if (after) copy("inverse", 3, n, 36);
            else { copy("blocks", 0, n, 36);
                   const auto local = argument<std::size_t>(args_, 5);
                   copy("mass", 1, local, 4); copy("flags", 2, local, 4); }
        } else if (group_ == "30prepare_inverse_preconditionerE") {
            const auto n = argument<std::size_t>(args_, 4);
            if (after) copy("inverse", 3, n, 4); else copy("diagonal", 0, n, 4);
        } else if (group_ == "23precondition_and_reduceIN3glm" || group_ == "23precondition_and_reduceIf") {
            const auto n = argument<std::size_t>(args_, 7), bins = groups(4, 5, n);
            copy("numerator", 6, bins, 4);
            if (after) copy("z", 2, n, 12);
            else { copy("r", 1, n, 12); copy("inverse", 0, n, group_ == "23precondition_and_reduceIf" ? 4 : 36);
                   copy("world", 4, n, 4);
                   scalar("precomputed", 3, 1); scalar("per_group", 5, 4); }
        } else if (group_ == "19update_cg_directionE") {
            const auto n = argument<std::size_t>(args_, 7), bins = groups(2, 3, n);
            if (after) copy("p", 6, n, 12);
            else { copy("z", 1, n, 12); copy("numerator", 4, bins, 4); copy("previous_numerator", 5, bins, 4);
                   copy("world", 2, n, 4); scalar("per_group", 3, 4); scalar("iteration", 0, 4);
                   if (argument<int>(args_, 0) > 0) copy("p", 6, n, 12); }
        } else if (group_.find("26multiply_matrix_and_reduceINS_") == 0) {
            const auto n = argument<std::size_t>(args_, 10), bins = groups(7, 8, n);
            const auto maximum = argument<std::size_t>(args_, 2), rows = argument<std::size_t>(args_, 11);
            copy("denominator", 9, bins, 4);
            if (after) copy("ap", 6, n, 12);
            else { copy("blocks", 3, n, group_.find("EntryEf") != std::string::npos ? 4 : 36);
                   copy("p", 4, n, 12); copy("extra", 5, n, 12);
                   copy("world", 7, n, 4); scalar("per_group", 8, 4); scalar("max_count", 2, 8);
                   scalar("rows", 11, 8); if (maximum) { copy("row_count", 0, rows, 4);
                       copy("entries", 1, maximum * rows, group_.find("17Block") != std::string::npos ? 40 : 8); } }
        } else if (group_ == "42multiply_soft_contact_hessian_off_diagonalE") {
            const auto n = argument<std::size_t>(args_, 30);
            copy("product", 25, n, 12);
            if (!after) { copy("direction", 24, n, 12); scalar("capacity", 1, 8);
                          scalar("local_shapes", 16, 8); scalar("shapes_per_world", 17, 8);
                          scalar("worlds", 18, 8); scalar("body_count", 22, 8); }
        } else if (group_ == "27evaluate_soft_contact_forceE") {
            const auto n = argument<std::size_t>(args_, 11), local = argument<std::size_t>(args_, 10);
            const auto cap = argument<std::size_t>(args_, 1), shapes = argument<std::size_t>(args_, 21);
            copy("rhs", 36, n, 12); copy("diagonal", 37, n, 4);
            copy("blocks", 40, n, 36); copy("precond", 41, n, 36);
            if (!after) {
                copy("count", 0, 1, 4); scalar("capacity", 1, 8);
                copy("particle", 2, cap, 4); copy("shape", 3, cap, 4); copy("body_pos", 4, cap, 12);
                copy("body_vel", 5, cap, 12); copy("normal", 6, cap, 12); copy("radius", 7, local, 4);
                copy("mass", 8, local, 4); copy("kind", 9, local, 4); scalar("local", 10, 8);
                scalar("total", 11, 8); copy("shape_body", 12, shapes, 4); copy("shape_type", 13, shapes, 4);
                copy("shape_transform", 14, shapes, 28); copy("shape_scale", 15, shapes, 12);
                for (int i = 16; i <= 20; ++i) device(at + "material" + std::to_string(i), i, shapes, 4);
                for (int i = 21; i <= 23; ++i) bytes(at + "size" + std::to_string(i), args_[i], 8);
                for (int i = 24; i <= 27; ++i) bytes(at + "material" + std::to_string(i), args_[i], 4);
                copy("x", 32, n, 12); copy("velocity", 33, n, 12); copy("previous", 34, n, 12);
                scalar("inv_dt", 35, 4); scalar("filter_count", 39, 8);
                copy("filter", 38, argument<std::size_t>(args_, 39), 4);
                const unsigned aliases = (argument<CUdeviceptr>(args_, 40) != 0) |
                    ((argument<CUdeviceptr>(args_, 41) != 0) << 1) |
                    ((argument<CUdeviceptr>(args_, 40) == argument<CUdeviceptr>(args_, 41)) << 2);
                bytes(at + "block_pointer_flags", &aliases, 4);
            }
        } else if (group_ == "30evaluate_surface_contact_forceE" || group_ == "35add_surface_contact_stiffness_scaleE" ||
                   group_ == "34add_surface_contact_preconditionerE" || group_ == "32multiply_surface_contact_tangentE") {
            const auto v = argument<SourceSurfaceView>(args_, 0);
            const bool tangent = group_ == "32multiply_surface_contact_tangentE";
            const auto width = group_ == "34add_surface_contact_preconditionerE" ? 36 :
                group_ == "35add_surface_contact_stiffness_scaleE" ? 4 : 12;
            copy("output", tangent ? 2 : 1, v.total_particles, width);
            if (!after) {
                auto buffer = [&](const char* label, CUdeviceptr pointer, std::size_t n, std::size_t stride) {
                    address(at + label, pointer, n, stride);
                };
                buffer("count", v.count, 1, 4); buffer("indices", v.indices, v.capacity, 12);
                buffer("barycentric", v.barycentric, v.capacity, 12); buffer("shape", v.shape, v.capacity, 4);
                buffer("body_pos", v.body_pos, v.capacity, 12); buffer("body_vel", v.body_vel, v.capacity, 12);
                buffer("normal", v.normal, v.capacity, 12);
                buffer("particle_only", v.particle_only, v.particle_only_count, 4);
                buffer("radius", v.radius, v.particles_per_world, 4); buffer("mass", v.mass, v.particles_per_world, 4);
                buffer("flags", v.flags, v.particles_per_world, 4); buffer("kind", v.kind, v.particles_per_world, 4);
                buffer("shape_body", v.shape_body, v.local_shape_count, 4);
                buffer("shape_type", v.shape_type, v.local_shape_count, 4);
                buffer("transform", v.transform, v.local_shape_count, 28);
                buffer("shape_scale", v.shape_scale, v.local_shape_count, 12);
                buffer("shape_margin", v.shape_margin, v.local_shape_count, 4);
                buffer("shape_ke", v.shape_ke, v.local_shape_count, 4); buffer("shape_kd", v.shape_kd, v.local_shape_count, 4);
                buffer("shape_kf", v.shape_kf, v.local_shape_count, 4); buffer("shape_mu", v.shape_mu, v.local_shape_count, 4);
                buffer("x", v.x, v.total_particles, 12); buffer("previous", v.previous, v.total_particles, 12);
                bytes(at + "capacity", &v.capacity, 8); bytes(at + "local", &v.particles_per_world, 8);
                bytes(at + "total", &v.total_particles, 8); bytes(at + "shapes", &v.local_shape_count, 8);
                bytes(at + "shape_replicated", &v.shapes_per_world, 8); bytes(at + "worlds", &v.worlds, 8);
                bytes(at + "ke", &v.ke, 4); bytes(at + "kd", &v.kd, 4); bytes(at + "kf", &v.kf, 4);
                bytes(at + "mu", &v.mu, 4); bytes(at + "inv_dt", &v.inv_dt, 4);
                if (tangent) copy("direction", 1, v.total_particles, 12);
            }
        } else if (group_ == "24initialize_triangle_dragE") {
            const auto count = argument<std::size_t>(args_, 4), local = argument<std::size_t>(args_, 5);
            const auto particles = count / local * argument<std::size_t>(args_, 6);
            if (after) { copy("normal", 2, count, 12); copy("area", 3, count, 4); }
            else { copy("x", 0, particles, 12); copy("indices", 1, local, 12); }
        } else if (group_ == "22evaluate_triangle_dragE") {
            const auto count = argument<std::size_t>(args_, 11), local = argument<std::size_t>(args_, 12);
            const auto particles = count / local * argument<std::size_t>(args_, 13);
            copy("rhs", 9, particles, 12);
            if (after) copy("scalar", 10, count, 4);
            else { copy("x", 0, particles, 12); copy("previous", 1, particles, 12); copy("indices", 2, local, 12);
                   copy("coefficients", 3, local, 4); copy("normal", 4, count, 12); copy("area", 5, count, 4);
                   scalar("density", 6, 4); scalar("wind", 7, 12); scalar("inv_dt", 8, 4); }
        } else if (group_ == "32add_triangle_drag_preconditionerE") {
            const auto count = argument<std::size_t>(args_, 4), local = argument<std::size_t>(args_, 5);
            const auto particles = count / local * argument<std::size_t>(args_, 6);
            copy("blocks", 3, particles, 36);
            if (!after) { copy("indices", 0, local, 12); copy("normal", 1, count, 12); copy("scalar", 2, count, 4); }
        } else if (group_ == "30multiply_triangle_drag_tangentE") {
            const auto count = argument<std::size_t>(args_, 5), local = argument<std::size_t>(args_, 6);
            const auto particles = count / local * argument<std::size_t>(args_, 7);
            copy("product", 4, particles, 12);
            if (!after) { copy("direction", 0, particles, 12); copy("indices", 1, local, 12);
                          copy("normal", 2, count, 12); copy("scalar", 3, count, 4); }
        } else if (group_ == "26evaluate_tetrahedron_forceE") {
            const auto count = argument<std::size_t>(args_, 9), local = argument<std::size_t>(args_, 10);
            const auto particles = count / local * argument<std::size_t>(args_, 11);
            copy("rhs", 8, particles, 12);
            if (!after) {
                copy("x", 0, particles, 12); copy("previous", 1, particles, 12); copy("indices", 2, local, 16);
                copy("inverse_dm", 3, local, 36); copy("materials", 4, local, 12); copy("volumes", 5, local, 4);
                copy("activation", 6, count, 4); scalar("inv_dt", 7, 4);
            }
        } else if (group_ == "30add_tetrahedron_preconditionerE") {
            const auto count = argument<std::size_t>(args_, 7), local = argument<std::size_t>(args_, 8);
            const auto particles = count / local * argument<std::size_t>(args_, 9);
            copy("blocks", 6, particles, 36);
            if (!after) { copy("x", 0, particles, 12); copy("volumes", 4, local, 4); scalar("inv_dt", 5, 4); }
        } else if (group_ == "28multiply_tetrahedron_tangentE") {
            const auto count = argument<std::size_t>(args_, 8), local = argument<std::size_t>(args_, 9);
            const auto particles = count / local * argument<std::size_t>(args_, 10);
            copy("product", 7, particles, 12);
            if (!after) { copy("x", 0, particles, 12); copy("direction", 1, particles, 12);
                          copy("volumes", 5, local, 4); scalar("inv_dt", 6, 4); }
        } else if (group_ == "22evaluate_bending_forceE" || group_ == "32multiply_bending_damping_tangentE") {
            const auto count = argument<std::size_t>(args_, 8), local = argument<std::size_t>(args_, 9);
            const auto particles = (count / local) * argument<std::size_t>(args_, 10);
            copy("output", 7, particles, 12);
            if (!after) { copy("x", 0, particles, 12); copy("previous_or_direction", 1, particles, 12);
                          copy("area", 2, local, 4); copy("cots", 3, local, 16); copy("indices", 4, local, 16);
                          copy("properties", 5, local, 8); scalar("inv_dt", 6, 4); }
        } else if (group_ == "34add_bending_damping_preconditionerE") {
            const auto count = argument<std::size_t>(args_, 7), local = argument<std::size_t>(args_, 8);
            const auto particles = (count / local) * argument<std::size_t>(args_, 9);
            copy("blocks", 6, particles, 36);
            if (!after) copy("x", 0, particles, 12);
        } else if (group_ == "22evaluate_stretch_forceE") {
            const auto count = argument<std::size_t>(args_, 6), local = argument<std::size_t>(args_, 7);
            const auto particles = (count / local) * argument<std::size_t>(args_, 8);
            copy("rhs", 5, particles, 12);
            if (!after) { copy("x", 0, particles, 12); copy("area", 1, local, 4); copy("pose", 2, local, 16);
                          copy("indices", 3, local, 12); copy("stiffness", 4, local, 12); }
        } else if (group_ == "39add_cloth_membrane_gauss_newton_hessianE") {
            const auto rows = argument<std::size_t>(args_, 12), maximum = argument<std::size_t>(args_, 8);
            copy("blocks", 5, rows, 36); copy("entries", 7, rows * maximum, 40);
            if (!after) copy("row_count", 6, rows, 4);
        } else if (group_ == "21evaluate_spring_forceE") {
            const auto springs = argument<std::size_t>(args_, 5), local = argument<std::size_t>(args_, 6);
            const auto particles = (springs / local) * argument<std::size_t>(args_, 7);
            copy("rhs", 4, particles, 12);
            if (!after) { copy("x", 0, particles, 12); copy("indices", 1, local, 8);
                          copy("stiffness", 2, local, 4); copy("rest", 3, local, 4); }
        } else if (group_ == "31add_spring_gauss_newton_hessianE") {
            const auto rows = argument<std::size_t>(args_, 11), maximum = argument<std::size_t>(args_, 7);
            copy("blocks", 4, rows, 36); copy("entries", 6, rows * maximum, 40);
            if (!after) copy("row_count", 5, rows, 4);
        } else if (group_ == "27combine_system_non_diagonalE") {
            const auto count = argument<std::size_t>(args_, 14);
            if (after) copy("entries", 13, count, 8);
            else {
                for (int i = 0; i < 7; ++i) device(at + "template" + std::to_string(i), 6 + i, count, 8);
                for (int i = 0; i < 6; ++i) bytes(at + "scale" + std::to_string(i), args_[i], 4);
            }
        } else if (group_ == "28update_solution_and_residualEP") {
            const auto n = argument<std::size_t>(args_, 8), bins = groups(0, 1, n);
            copy("x", 6, n, 12); copy("r", 7, n, 12);
            if (!after) { copy("numerator", 2, bins, 4); copy("denominator", 3, bins, 4);
                         copy("p", 4, n, 12); copy("ap", 5, n, 12);
                         copy("world", 0, n, 4); scalar("per_group", 1, 4); }
        } else if (group_ == "20apply_nonlinear_stepE") {
            const auto n = argument<std::size_t>(args_, 3);
            if (after) copy("q", 1, n, 12); else { copy("q", 0, n, 12); copy("dx", 2, n, 12); }
        } else if (group_ == "15update_velocityE") {
            const auto n = argument<std::size_t>(args_, 4);
            if (after) copy("v", 3, n, 12); else { copy("previous", 1, n, 12); copy("q", 2, n, 12); }
        }
    }

public:
    Observation(const char* name, void** args, CUstream stream, unsigned grid, unsigned block)
        : group_(category(name)), args_(args), stream_(stream)
    {
        if (trace_directory.empty() || observing || group_.empty()) { group_.clear(); return; }
        observing = true;
        std::ostringstream label;
        label << trace_directory << '/' << std::setw(6) << std::setfill('0') << sequence++ << '.' << group_ << '.';
        prefix_ = label.str();
        std::ostringstream meta;
        meta << "{\"name\":\"" << name << "\",\"grid\":" << grid << ",\"block\":" << block;
        if (group_ == "15initialize_stepE") {
            // Compare actual alias relationships without putting process-specific device addresses in metadata.
            std::map<CUdeviceptr, int> groups;
            meta << ",\"template_alias_groups\":[";
            bool first = true;
            for (int index : {6, 7, 9, 11, 13, 15, 19}) {
                auto value = groups.emplace(argument<CUdeviceptr>(args_, index), static_cast<int>(groups.size()));
                meta << (first ? "" : ",") << value.first->second;
                first = false;
            }
            meta << ']';
        }
        meta << "}\n";
        const auto metadata = meta.str();
        deferred_files.push_back({prefix_ + "json", std::vector<char>(metadata.begin(), metadata.end()),
                                  0, metadata.size(), false});
        snapshot(false);
    }
    ~Observation() { if (!group_.empty()) observing = false; }
    void finish() { if (!group_.empty()) snapshot(true); }
};

extern "C" void solver_trace_begin(const char* directory)
{
    if (staging || !deferred_files.empty()) throw std::runtime_error("Deferred diagnostic already active");
    checked(cuMemAlloc(&staging, staging_capacity));
    staging_used = 0;
    trace_directory = directory;
    sequence = 0;
    std::filesystem::create_directories(trace_directory);
}

extern "C" void solver_trace_end()
{
    trace_directory.clear();
    checked(cuCtxSynchronize());
    std::vector<char> data(staging_used);
    checked(cuMemcpyDtoH(data.data(), staging, data.size()));
    for (const auto& item : deferred_files) {
        std::ofstream file(item.name, std::ios::binary);
        file.write(item.device ? data.data() + item.offset : item.host.data(), item.size);
    }
    std::ofstream receipt(std::filesystem::path(deferred_files.front().name).parent_path() / "deferred-receipt.json");
    receipt << "{\"device_bytes\":" << staging_used << ",\"files\":" << deferred_files.size()
            << ",\"per_snapshot_host_synchronization\":false}\n";
    checked(cuMemFree(staging));
    staging = 0;
    staging_used = 0;
    deferred_files.clear();
}

extern "C" cudaError_t cudaLaunchKernel(const void* function, dim3 grid, dim3 block, void** args,
                                        std::size_t shared, cudaStream_t stream)
{
    Dl_info symbol{};
    dladdr(function, &symbol);
    auto next = reinterpret_cast<decltype(&cudaLaunchKernel)>(dlsym(RTLD_NEXT, "cudaLaunchKernel"));
    if (!next && symbol.dli_fname) {
        // The CPython extension and its CUDA runtime may be RTLD_LOCAL, outside RTLD_NEXT's lookup scope.
        void* owner = dlopen(symbol.dli_fname, RTLD_NOW | RTLD_NOLOAD);
        if (owner) next = reinterpret_cast<decltype(&cudaLaunchKernel)>(dlsym(owner, "cudaLaunchKernel"));
    }
    if (!next || next == &cudaLaunchKernel) throw std::runtime_error("Cannot resolve original cudaLaunchKernel");
    Observation trace(symbol.dli_sname, args, reinterpret_cast<CUstream>(stream), grid.x, block.x);
    const auto result = next(function, grid, block, args, shared, stream);
    trace.finish();
    return result;
}

extern "C" CUresult CUDAAPI cuLaunchKernel(CUfunction function, unsigned gx, unsigned gy, unsigned gz,
    unsigned bx, unsigned by, unsigned bz, unsigned shared, CUstream stream, void** args, void** extra)
{
    static auto next = reinterpret_cast<decltype(&cuLaunchKernel)>(dlsym(RTLD_NEXT, "cuLaunchKernel"));
    const char* name = nullptr;
    cuFuncGetName(&name, function);
    Observation trace(name, args, stream, gx, bx);
    const auto result = next(function, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
    trace.finish();
    return result;
}
