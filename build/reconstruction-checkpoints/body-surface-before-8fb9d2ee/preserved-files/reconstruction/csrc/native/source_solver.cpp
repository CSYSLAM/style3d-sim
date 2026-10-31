// Incremental native host reconstruction. Unsupported physics fails before touching state memory.
#include "source_driver.h"
#include "source_api.h"
#include "surface_view.h"
#include "bvh_library.h"
#include <cmath>
#include <cstddef>
#include <cstring>
#include <tuple>
#include <map>
#include <memory>
#include <set>

static std::uintptr_t stream_handle(py::object stream)
{
    if (stream.is_none()) return 0;
    if (py::isinstance<py::int_>(stream)) return stream.cast<std::uintptr_t>();
    if (py::hasattr(stream, "__cuda_stream__")) {
        auto protocol = stream.attr("__cuda_stream__")().cast<py::tuple>();
        if (protocol.size() != 2 || protocol[0].cast<int>() != 0)
            throw py::value_error("Invalid CUDA Stream Protocol result");
        return protocol[1].cast<std::uintptr_t>();
    }
    throw py::type_error("Expected a CUDA stream integer, CUDA Stream Protocol object, or None");
}

class Solver {
    std::unique_ptr<Driver> driver_;
    Model model_;
    std::size_t count_ = 0, per_world_ = 0;
    std::uint64_t zero_ = 0, previous_ = 0, target_ = 0, diagonal_ = 0, blocks_ = 0, inverse_ = 0, scalar_inverse_ = 0;
    std::uint64_t base_diagonal_ = 0, preconditioner_blocks_ = 0, contact_product_ = 0, collision_stiffness_ = 0;
    std::array<std::uint64_t, 5> particle_diagonal_templates_{};
    std::uint64_t particle_kind_ = 0;
    std::uint64_t tetrahedron_volumes_ = 0;
    std::uint64_t drag_indices_ = 0, drag_coefficients_ = 0, drag_normal_ = 0, drag_area_ = 0, drag_scalar_ = 0;
    std::uint64_t rhs_ = 0, residual_ = 0, solution_ = 0, direction_ = 0, product_ = 0;
    std::uint64_t numerator_ = 0, denominator_ = 0, z_ = 0, coefficient_world_ = 0;
    std::size_t group_count_ = 0;
    std::uint64_t host_diagonal_ = 0, row_count_ = 0, scalar_template_ = 0, block_template_ = 0, block_entries_ = 0;
    std::uint64_t local_row_count_ = 0;
    std::array<std::uint64_t, 5> retained_particle_templates_{};
    std::size_t max_entries_ = 0, spring_count_ = 0, triangle_count_ = 0, edge_count_ = 0;
    std::size_t tetrahedron_count_ = 0;
    std::size_t drag_count_ = 0, drag_local_count_ = 0;
    bool bending_damping_ = false, rolling_ = false;
    // Affine bodies (SO(3) augmented Lagrangian, Newton/PD). Templates are per world and slot-major like springs.
    std::size_t body_count_ = 0, body_state_count_ = 0;
    std::uint64_t body_l0_ = 0, body_l1_ = 0, body_l2_ = 0, body_zero_ell_ = 0, body_d1_ = 0, body_d2_ = 0, body_kind_ = 0;
    std::uint64_t body_offsets_a_ = 0, body_ids_a_ = 0, body_offsets_b_ = 0, body_ids_b_ = 0;
    std::size_t body_spring_total_ = 0, distance_total_ = 0, point_line_total_ = 0;
    // Newton joints: AL joint springs (the last joint_body_spring_count body springs) and joint drives.
    std::size_t plain_spring_count_ = 0, joint_spring_total_ = 0, drive_total_ = 0;
    bool angular_limits_ = false, armature_ = false;
    std::uint64_t joint_multiplier_ = 0, joint_d3_ = 0, joint_l4_ = 0;
    std::uint64_t drive_w_po_ = 0, drive_w_co_ = 0, drive_w_pa_ = 0, drive_w_pr_ = 0, drive_w_cr_ = 0;
    std::uint64_t drive_angle_ = 0, drive_initialized_ = 0, drive_qd_ = 0;
    std::uint64_t point_line_wp_ = 0, point_line_we0_ = 0, point_line_we1_ = 0;
    std::size_t plain_line_count_ = 0, joint_line_total_ = 0;
    std::uint64_t line_segment_ = 0, line_multiplier_ = 0, line_projector_ = 0;
    std::uint64_t distance_w0_ = 0, distance_w1_ = 0, distance_d5_ = 0, distance_l6_ = 0;
    std::uint64_t distance_target_ = 0, distance_multiplier_ = 0;
    std::uint64_t body_spring_w0_ = 0, body_spring_w1_ = 0;
    std::uint64_t body_diagonal_offsets_ = 0, body_diagonal_ids_ = 0, body_rotation_ = 0, body_multiplier_ = 0;
    std::size_t cable_count_ = 0;
    std::uint64_t cable_penalty_ = 0, cable_initialized_ = 0, cable_linear_ = 0, cable_angular_ = 0;
    std::uint64_t cable_indices_ = 0, cable_sizes_ = 0;
    std::size_t hard_capacity_ = 0;
    std::uint64_t hard_penalty_ = 0, hard_dual_ = 0, hard_anchor_ = 0, hard_previous_penalty_ = 0;
    std::uint64_t hard_previous_dual_ = 0, hard_previous_normal_ = 0, hard_previous_count_ = 0;
    std::uint64_t affine_blocks_ = 0, affine_valid_ = 0, affine_enabled_ = 0;
    std::uint64_t affine_cable_offsets_ = 0, affine_cable_ids_ = 0;
    int fluid_points_ = 0, fluid_rows_ = 0, fluid_slots_ = 0, fluid_stride_ = 0, fluid_worlds_ = 0;
    std::uint64_t fluid_head_ = 0, fluid_next_ = 0, fluid_ids_ = 0, fluid_world_ = 0, fluid_cells_ = 0;
    std::uint64_t fluid_positions_ = 0, fluid_volumes_ = 0, fluid_counts_ = 0, fluid_neighbors_ = 0, fluid_cache_ = 0;
    std::uint64_t fluid_gradients_ = 0, fluid_residuals_ = 0, fluid_weights_ = 0, fluid_diagonal_ = 0, fluid_scale_ = 0;
    struct GranularBonds {
        int count = 0;
        std::uint64_t pairs = 0, rest = 0, history = 0, active = 0, tangent = 0;
    };
    GranularBonds granular_initial_, granular_dynamic_;
    int granular_points_ = 0, granular_slots_ = 0;
    float granular_cell_size_ = 0.0f;
    std::uint64_t granular_head_ = 0, granular_next_ = 0, granular_ids_ = 0, granular_world_ = 0;
    std::uint64_t granular_cells_ = 0, granular_positions_ = 0, granular_previous_ = 0, granular_radius_ = 0;
    std::uint64_t granular_counts_ = 0, granular_neighbors_ = 0, granular_cache_ = 0, granular_diagonal_ = 0;
    std::uint64_t granular_offsets_ = 0, granular_columns_ = 0, granular_partner_ = 0;
    struct CollisionBvh {
        std::size_t count = 0;
        std::uint64_t boxes = 0, parents = 0, children = 0, sorted = 0, escape = 0, primitive_leaf = 0;
        std::uint64_t nodes = 0, visits = 0, builder_visits = 0;
    };
    CollisionBvh triangle_bvh_, edge_bvh_, particle_bvh_;
    struct SelfParticlePairs {
        std::size_t count = 0, local = 0, capacity = 0;
        std::uint64_t boxes = 0, nodes = 0, visits = 0, groups = 0, counts = 0, slots = 0;
        std::uint64_t diagonal = 0, stiffness = 0, contacts = 0, counter = 0;
    } self_pp_;
    std::vector<std::map<int, float>> spring_rows_;
    std::vector<float> spring_diagonal_;
    unsigned particles_per_group_ = 0;
    std::unordered_map<std::string, std::uintptr_t> functions_;
    std::unordered_map<std::string, std::size_t> launches_;

    static void require(Span span, std::size_t count, const char* field)
    {
        if (count && (!span.ptr || span.size < count))
            throw py::value_error(std::string(field) + " span is missing or too small");
    }

    void reject_model(const Model& model)
    {
        const bool has_bodies = model.body_count || model.body_state_count;
        if (model.hinge_count || (model.cable_count && !has_bodies) || (model.body_spring_count && !has_bodies) ||
            (model.body_distance_constraint_count && !has_bodies) ||
            (model.body_point_line_count && !has_bodies) || (model.joint_drive_count && !has_bodies) ||
            (model.joint_body_spring_count && !has_bodies) ||
            (model.joint_body_point_line_count && !has_bodies))
            throw std::runtime_error("Requested source model topology has not been implemented");
        if (model.granular_particle_count && (has_bodies || model.spring_count || model.triangle_count ||
                                            model.edge_count || model.tetrahedron_count || model.fluid_particle_count))
            throw std::runtime_error("Granular combined with other materials or bodies has not been captured");
        const bool bodies = model.body_count || model.body_state_count;
        const bool particle_materials = model.spring_count || model.triangle_count || model.edge_count;
        // Free joints contribute DOFs/targets but no kernels without drives (captured free-body schedule).
        if ((model.particle_mass_non_diagonal_count || model.joint_dof_count || model.joint_target_count) && !bodies)
            throw std::runtime_error("Requested source model topology has not been implemented");
        if (bodies && (model.tetrahedron_count || (model.collision_triangle_count && !model.triangle_count)))
            throw std::runtime_error("Affine bodies combined with other elements have not been implemented");
        if (bodies && particle_materials && (model.body_spring_count || model.body_distance_constraint_count ||
                model.body_point_line_count || model.joint_drive_count || model.joint_body_spring_count ||
                model.joint_body_point_line_count || model.cable_count || model.fluid_particle_count))
            throw std::runtime_error("Particle materials combined with constrained/fluid affine bodies are not captured");
    }

    void load(const std::string& key, const std::string& pattern)
    {
        std::vector<std::string> found;
        for (const auto& spec : source_kernels)
            if (std::string(spec.name).find(pattern) != std::string::npos) found.push_back(spec.name);
        if (found.size() != 1) throw std::runtime_error("Source kernel selection is not unique: " + pattern);
        functions_[key] = driver_->function(found[0]);
    }

    template <class T> static py::bytes pack(const T& value)
    {
        static_assert(std::is_trivially_copyable<T>::value, "CUDA arguments must be POD");
        return py::bytes(reinterpret_cast<const char*>(&value), sizeof(T));
    }

    template <class... Args> void launch_width(const std::string& key, std::size_t n, unsigned width,
                                              std::uintptr_t stream, const Args&... args)
    {
        driver_->launch(functions_.at(key), static_cast<unsigned>((n + width - 1) / width), width, {pack(args)...}, stream);
        ++launches_[key];
    }

    template <class... Args> void launch(const std::string& key, std::size_t n, std::uintptr_t stream, const Args&... args)
    {
        launch_width(key, n, 256, stream, args...);
    }

    void copy(std::uint64_t destination, std::uint64_t source, std::size_t bytes, std::uintptr_t stream)
    {
        if (!bytes || destination == source) return;
        check(cuMemcpyDtoDAsync(destination, source, bytes, reinterpret_cast<CUstream>(stream)), "cuMemcpyDtoDAsync");
    }

    void initialization_copy(std::uint64_t destination, std::uint64_t source, std::size_t bytes, std::uintptr_t stream)
    {
        if (!bytes || destination == source) return;
        copy(destination, source, bytes, stream);
        // Actual BVH and sorted-set copies synchronize their stream before releasing temporary storage.
        check(cuStreamSynchronize(reinterpret_cast<CUstream>(stream)), "cuStreamSynchronize initialization copy");
    }

    void clear(std::uint64_t pointer, std::size_t bytes, std::uintptr_t stream)
    {
        check(cuMemsetD8Async(pointer, 0, bytes, reinterpret_cast<CUstream>(stream)), "cuMemsetD8Async");
    }

    template <class T> std::vector<T> read(Span span, std::size_t count)
    {
        std::vector<T> result(count);
        if (count) check(cuMemcpyDtoH(result.data(), span.ptr, count * sizeof(T)), "cuMemcpyDtoH model data");
        return result;
    }

    template <class T> std::uint64_t upload(const std::vector<T>& values)
    {
        return driver_->upload(py::bytes(reinterpret_cast<const char*>(values.data()), values.size() * sizeof(T)));
    }

    std::uint64_t initialized_cache(std::size_t count, std::size_t width, SourceCacheType type)
    {
        if (!count) return 0;
        const auto pointer = driver_->allocate(count * width);
        // Use the original Thrust host path; its source-built device entries are validated independently.
        // Auxiliary dispatch remains separate from owned-kernel coverage counts.
        check_bvh_library(source_cache_initialize(reinterpret_cast<void*>(pointer), count, type),
                          "Cache value initialization");
        return pointer;
    }

    std::uint64_t template_row_counts() const { return local_row_count_ ? local_row_count_ : row_count_; }

    template <class Entry> void precompute_particle_matrices(const std::vector<float>& diagonal,
        const std::vector<int>& counts, const std::vector<Entry>& entries)
    {
        static_assert(sizeof(Entry) == 8, "Scalar ELL entry ABI");
        host_diagonal_ = upload(diagonal);
        const std::vector<float> empty(per_world_, 0.0f);
        for (auto& pointer : particle_diagonal_templates_) pointer = upload(empty);
        zero_ = particle_diagonal_templates_[0];
        local_row_count_ = upload(std::vector<int>(counts.begin(), counts.begin() + per_world_));
        row_count_ = upload(counts);
        scalar_template_ = entries.empty() ? 0 : upload(entries);
        auto inertial = entries;
        for (auto& entry : inertial) entry.value = 0.0f;
        body_l1_ = inertial.empty() ? 0 : upload(inertial);
        // The original retains all contribution channels even without bodies. Their CSR lists are empty,
        // and their ELL entries retain the real columns with zero values, including -1 padding columns.
        const std::vector<std::size_t> offsets(entries.size() + 1, 0);
        body_offsets_a_ = upload(offsets);
        body_offsets_b_ = upload(offsets);
        body_diagonal_offsets_ = upload(std::vector<std::size_t>(per_world_ + 1, 0));
        body_ids_a_ = body_ids_b_ = body_diagonal_ids_ = 0;
        for (auto& pointer : retained_particle_templates_) pointer = inertial.empty() ? 0 : upload(inertial);
        // precompute_matrices uploads tetrahedron volumes immediately before the particle-kind channel.
        precompute_tetrahedra();
        particle_kind_ = upload(std::vector<int>(per_world_, 0));
        if (max_entries_) {
            block_template_ = initialized_cache(max_entries_ * count_, 40, SourceCacheType::BlockEntry);
            block_entries_ = initialized_cache(max_entries_ * count_, 40, SourceCacheType::BlockEntry);
            load("block_entries", "kernel29initialize_block_non_diagonalE");
        }
        driver_->synchronize();
    }

    static void check_bvh_library(int status, const char* operation)
    {
        if (status) throw std::runtime_error(std::string(operation) + " failed: CUDA runtime " + std::to_string(status));
    }

    void build_collision_bvh(CollisionBvh& bvh, std::size_t count, const char* primitive_kernel, Span indices)
    {
        bvh = {};
        if (!count) return;
        if (count > 0x40000000ULL)
            throw std::length_error("LBVH node indices exceed the supported signed 32-bit range");
        require(indices, count, "collision primitive indices");
        bvh.count = count;
        const unsigned leaves = static_cast<unsigned>(count), nodes = 2*leaves - 1;
        auto allocate = [&](std::size_t size) { return size ? driver_->allocate(size) : std::uint64_t(0); };
        const auto copies = count_ / per_world_;
        // Original initialization and refit use the same replicated primitive boxes, not a separate rest cache.
        bvh.boxes = initialized_cache(copies * count, 24, SourceCacheType::Box);
        bvh.nodes = initialized_cache(copies * nodes, 24, SourceCacheType::Box);
        bvh.parents = initialized_cache(nodes, 4, SourceCacheType::Integer);
        bvh.children = initialized_cache(count - 1, 8, SourceCacheType::Index2);
        bvh.sorted = initialized_cache(count, 4, SourceCacheType::Integer);
        bvh.escape = initialized_cache(nodes, 4, SourceCacheType::Integer);
        bvh.primitive_leaf = initialized_cache(count, 4, SourceCacheType::Integer);
        bvh.visits = initialized_cache(copies * (count - 1), 4, SourceCacheType::Unsigned);
        const auto positions = model_.particle_rest_positions.ptr;
        if (std::string(primitive_kernel) == "bvh_particles") {
            require(model_.particle_radii, per_world_, "particle_radii");
            launch(primitive_kernel, count, 0, positions, indices.ptr, model_.particle_radii.ptr, bvh.boxes,
                   count, count, per_world_);
        } else {
            launch(primitive_kernel, count, 0, positions, indices.ptr, bvh.boxes, 0.0f, count, count, per_world_);
        }
        // Actual BvhBuilder::reserve follows primitive AABB generation, including its four typed initializers.
        const auto codes = initialized_cache(count, 4, SourceCacheType::Unsigned);
        const auto work_parents = initialized_cache(nodes, 4, SourceCacheType::Integer);
        const auto work_children = initialized_cache(count - 1, 8, SourceCacheType::Index2);
        bvh.builder_visits = initialized_cache(count - 1, 4, SourceCacheType::Unsigned);
        check_bvh_library(source_bvh_sequence_fill(reinterpret_cast<int*>(bvh.sorted),
                          reinterpret_cast<int*>(work_parents), leaves, nullptr), "BVH sequence/fill");
        if (leaves > 1) {
            std::size_t bytes = 0;
            check_bvh_library(source_bvh_reduce(nullptr, &bytes, reinterpret_cast<void*>(bvh.boxes), nullptr,
                              leaves, nullptr), "BVH scene reduction size");
            const auto reduction = allocate(bytes + 24);
            check_bvh_library(source_bvh_reduce(reinterpret_cast<void*>(reduction + 24), &bytes,
                              reinterpret_cast<void*>(bvh.boxes), reinterpret_cast<void*>(reduction), leaves, nullptr),
                              "BVH scene reduction");
            std::array<float, 6> scene;
            check(cuMemcpyDtoH(scene.data(), reduction, 24), "cuMemcpyDtoH BVH scene box");
            driver_->release(reduction);
            launch("bvh_morton", count, 0, codes, bvh.boxes, scene, leaves);
            int selectors[2] = {0, 0};
            bytes = 0;
            check_bvh_library(source_bvh_sort(nullptr, &bytes, reinterpret_cast<unsigned*>(codes), nullptr,
                              reinterpret_cast<int*>(bvh.sorted), nullptr, leaves, selectors, nullptr), "BVH sort size");
            // Actual BvhBuilder storage rounds each alternate array to 128 bytes, before the CUB workspace.
            const auto alternate_bytes = (4*count + 127) / 128 * 128;
            const auto sorting = allocate(2*alternate_bytes + bytes);
            check_bvh_library(source_bvh_sort(reinterpret_cast<void*>(sorting + 2*alternate_bytes), &bytes,
                              reinterpret_cast<unsigned*>(codes), reinterpret_cast<unsigned*>(sorting),
                              reinterpret_cast<int*>(bvh.sorted), reinterpret_cast<int*>(sorting + alternate_bytes),
                              leaves, selectors, nullptr), "BVH sort");
            if (selectors[0]) initialization_copy(codes, sorting, 4*count, 0);
            if (selectors[1]) initialization_copy(bvh.sorted, sorting + alternate_bytes, 4*count, 0);
            driver_->release(sorting);
            launch("bvh_radix", count - 1, 0, work_parents, work_children, codes, leaves);
        }
        initialization_copy(bvh.parents, work_parents, static_cast<std::size_t>(nodes) * 4, 0);
        if (count > 1) initialization_copy(bvh.children, work_children, (count - 1) * 8, 0);
        launch("bvh_escape", nodes, 0, bvh.escape, bvh.parents, bvh.children, nodes);
        launch("bvh_leaf", count, 0, bvh.primitive_leaf, bvh.sorted, leaves);
        driver_->synchronize();
    }

    void precompute_collision_bvhs()
    {
        if (!model_.collision_triangle_count && !model_.collision_edge_count && !model_.collision_particle_count) return;
        if (model_.collision_particle_count) {
            require(model_.collision_particle_indices, model_.collision_particle_count, "collision_particle_indices");
            require(model_.particle_radii, per_world_, "particle_radii");
            const auto indices = read<int>(model_.collision_particle_indices, model_.collision_particle_count);
            const auto radii = read<float>(model_.particle_radii, per_world_);
            std::set<int> unique;
            // SelfCollision::initialize 1387e0..13884b validates each selected index, uniqueness, then radius.
            for (int index : indices) {
                if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error("collision_particle_indices contains an invalid particle index");
                if (!unique.insert(index).second)
                    throw py::value_error("collision_particle_indices contains a duplicate particle index");
                if (!std::isfinite(radii[index]) || radii[index] <= 0.0f)
                    throw py::value_error("collision particle radii must be finite and positive");
            }
        }
        load("bvh_triangles", "21self_collision_kernel20build_triangle_aabbsE");
        load("bvh_edges", "21self_collision_kernel16build_edge_aabbsE");
        load("bvh_particles", "21self_collision_kernel20build_particle_aabbsE");
        load("bvh_morton", "kernel21generate_morton_codesE");
        load("bvh_radix", "kernel16build_radix_treeE");
        load("bvh_escape", "kernel18build_escape_nodesE");
        load("bvh_leaf", "kernel26build_primitive_leaf_nodesE");
        triangle_bvh_.count = model_.collision_triangle_count;
        edge_bvh_.count = model_.collision_edge_count;
        particle_bvh_.count = model_.collision_particle_count;
    }

    void finish_collision_bvhs()
    {
        // SelfCollision::initialize builds topology after the candidate/Hessian caches, even with collisions disabled.
        build_collision_bvh(triangle_bvh_, model_.collision_triangle_count, "bvh_triangles", model_.collision_triangle_indices);
        build_collision_bvh(edge_bvh_, model_.collision_edge_count, "bvh_edges", model_.collision_edge_indices);
        build_collision_bvh(particle_bvh_, model_.collision_particle_count, "bvh_particles", model_.collision_particle_indices);
    }

    struct SelfMeshTree {
        std::uint64_t boxes = 0, nodes = 0, visits = 0;
    } self_tri_tree_, self_edge_tree_;
    struct SelfCandidates {
        std::size_t local = 0, count = 0;
        std::uint64_t indices = 0, counts = 0, slots = 0;
    } self_vf_mesh_, self_vf_free_, self_ee_, self_ef_;
    std::uint64_t self_opposite_offsets_ = 0, self_opposite_vertices_ = 0;

    void precompute_self_particle_pairs()
    {
        self_pp_ = {};
        self_tri_tree_ = {};
        self_edge_tree_ = {};
        self_vf_mesh_ = {};
        self_vf_free_ = {};
        self_ee_ = {};
        self_ef_ = {};
        self_opposite_offsets_ = self_opposite_vertices_ = 0;
        const auto copies = count_ / per_world_;
        const auto triangles = read<std::array<int, 3>>(model_.collision_triangle_indices, triangle_bvh_.count);
        const auto edges = read<std::array<int, 4>>(model_.collision_edge_indices, edge_bvh_.count);
        std::set<int> vertices;
        std::map<std::pair<int, int>, std::set<int>> adjacent;
        // The original joins triangle adjacency and authored opposite vertices in sorted sets.
        for (const auto& triangle : triangles) {
            vertices.insert(triangle.begin(), triangle.end());
            for (int i = 0; i < 3; ++i)
                adjacent[std::minmax(triangle[(i+1)%3], triangle[(i+2)%3])].insert(triangle[i]);
        }
        std::vector<int> offsets(1, 0), opposite;
        for (const auto& edge : edges) {
            vertices.insert(edge[2]);
            vertices.insert(edge[3]);
            auto& neighbors = adjacent[std::minmax(edge[2], edge[3])];
            if (edge[0] >= 0) neighbors.insert(edge[0]);
            if (edge[1] >= 0) neighbors.insert(edge[1]);
            opposite.insert(opposite.end(), neighbors.begin(), neighbors.end());
            offsets.push_back(static_cast<int>(opposite.size()));
        }
        const bool available = (triangle_bvh_.count && !vertices.empty()) ||
                               edge_bvh_.count > 1 || particle_bvh_.count > 1;
        auto allocate = [&](std::size_t bytes) { return bytes ? driver_->allocate(bytes) : std::uint64_t(0); };
        auto candidates = [&](SelfCandidates& result, std::size_t local, std::uint64_t indices) {
            result.local = local;
            result.count = local * copies;
            result.indices = indices;
            result.counts = initialized_cache(result.count, 4, SourceCacheType::Integer);
            result.slots = initialized_cache(result.count * 31, 4, SourceCacheType::Integer);
            self_pp_.capacity += result.count * 31;
        };
        self_pp_.local = particle_bvh_.count;
        self_pp_.count = particle_bvh_.count > 1 ? particle_bvh_.count * copies : 0;
        std::vector<int> groups(per_world_, 0);
        auto assign_group = [&](Span indices, std::size_t count, int group, const char* field) {
            // SelfCollision's copy_to_host has its own collision-count error, unlike SolverNewton's helper.
            if (indices.size < count)
                throw py::value_error(std::string(field) + " is smaller than its collision count");
            for (int index : read<int>(indices, count)) {
                if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error(group == 1 ? "fluid particle index is out of range" :
                                                       "granular particle index is out of range");
                if (group == 2 && groups[index] == 1)
                    throw py::value_error("fluid and granular particle selections cannot overlap");
                groups[index] = group;
            }
        };
        // Actual initialize 138030..1380e1 marks fluid first, then granular; zero denotes other particles.
        assign_group(model_.fluid_particle_indices, model_.fluid_particle_count, 1, "fluid_particle_indices");
        assign_group(model_.granular_particle_indices, model_.granular_particle_count, 2, "granular_particle_indices");
        self_pp_.groups = upload(groups);
        self_opposite_offsets_ = upload(offsets);
        // Empty original device vectors have null data; Driver::upload reserves an address even for zero bytes.
        self_opposite_vertices_ = opposite.empty() ? std::uint64_t(0) : upload(opposite);
        self_pp_.capacity = self_pp_.count * 31;
        if (triangle_bvh_.count) {
            const std::vector<int> mesh_vertices(vertices.begin(), vertices.end());
            // Original insertion from the sorted host set stages through a temporary device range.
            const auto indices = allocate(mesh_vertices.size() * 4);
            const auto staging = upload(mesh_vertices);
            initialization_copy(indices, staging, mesh_vertices.size() * 4, 1);
            driver_->release(staging);
            candidates(self_vf_mesh_, mesh_vertices.size(), indices);
            if (self_pp_.local) candidates(self_vf_free_, self_pp_.local, model_.collision_particle_indices.ptr);
        }
        // The original allocates these vectors even for a single local primitive, whose PP query is skipped.
        self_pp_.counts = initialized_cache(copies * self_pp_.local, 4, SourceCacheType::Integer);
        self_pp_.slots = initialized_cache(copies * self_pp_.local * 31, 4, SourceCacheType::Integer);
        if (edge_bvh_.count > 1) candidates(self_ee_, edge_bvh_.count, model_.collision_edge_indices.ptr);
        if (triangle_bvh_.count && edge_bvh_.count)
            candidates(self_ef_, edge_bvh_.count, model_.collision_edge_indices.ptr);
        self_pp_.diagonal = initialized_cache(count_, 36, SourceCacheType::Matrix3);
        self_pp_.stiffness = collision_stiffness_;
        self_pp_.counter = initialized_cache(1, 4, SourceCacheType::Unsigned);
        finish_collision_bvhs();
        self_tri_tree_ = {triangle_bvh_.boxes, triangle_bvh_.nodes, triangle_bvh_.visits};
        self_edge_tree_ = {edge_bvh_.boxes, edge_bvh_.nodes, edge_bvh_.visits};
        self_pp_.boxes = particle_bvh_.boxes;
        self_pp_.nodes = particle_bvh_.nodes;
        self_pp_.visits = particle_bvh_.visits;
        if (!available) return;
        load("self_refit", "21self_collision_kernel9refit_bvhE");
        load("self_query_pp", "21self_collision_kernel20query_particle_pairsE");
        load("self_query_vf", "21self_collision_kernel17query_vertex_faceE");
        load("self_query_ee", "21self_collision_kernel15query_edge_edgeE");
        load("self_query_ef", "21self_collision_kernel15query_edge_faceE");
        load("self_accumulate_pp", "21self_collision_kernel25accumulate_particle_pairsE");
        load("self_accumulate_vf", "21self_collision_kernel22accumulate_vertex_faceE");
        load("self_accumulate_ee", "21self_collision_kernel20accumulate_edge_edgeE");
        load("self_accumulate_ef", "21self_collision_kernel20accumulate_edge_faceE");
        load("self_preconditioner", "21self_collision_kernel20add_hessian_diagonalE");
        load("self_full_tangent", "21self_collision_kernel25multiply_contact_tangentsE");
        load("self_diagonal_tangent", "21self_collision_kernel25multiply_hessian_diagonalE");
    }

    void begin_self_particle_pairs(const State& state, std::uintptr_t stream)
    {
        const auto copies = count_ / per_world_;
        const float radius = config.self_collision_radius;
        auto refit = [&](const CollisionBvh& bvh, const SelfMeshTree& dynamic, const char* key, Span indices) {
            if (!bvh.count) return;
            const auto count = bvh.count * copies;
            launch(key, count, stream, state.particle_q.ptr, indices.ptr, dynamic.boxes, radius,
                   count, bvh.count, per_world_);
            if (bvh.count > 1) clear(dynamic.visits, copies * (bvh.count-1) * 4, stream);
            launch("self_refit", count, stream, dynamic.boxes, bvh.sorted, bvh.parents, bvh.children,
                   dynamic.visits, dynamic.nodes, count, bvh.count);
        };
        refit(triangle_bvh_, self_tri_tree_, "bvh_triangles", model_.collision_triangle_indices);
        refit(edge_bvh_, self_edge_tree_, "bvh_edges", model_.collision_edge_indices);
        if (self_pp_.local) {
            const auto count = self_pp_.local * copies;
            launch("bvh_particles", count, stream, state.particle_q.ptr, model_.collision_particle_indices.ptr,
                   model_.particle_radii.ptr, self_pp_.boxes, count, self_pp_.local, per_world_);
            if (self_pp_.local > 1) clear(self_pp_.visits, copies * (self_pp_.local-1) * 4, stream);
            launch("self_refit", count, stream, self_pp_.boxes, particle_bvh_.sorted, particle_bvh_.parents,
                   particle_bvh_.children, self_pp_.visits, self_pp_.nodes, count, self_pp_.local);
        }
        const auto worlds = model_.particle_world.size ? model_.particle_world.ptr : std::uint64_t(0);
        auto vf = [&](const SelfCandidates& candidate, std::uint64_t radii, bool incident) {
            if (!candidate.count) return;
            launch("self_query_vf", candidate.count, stream, state.particle_q.ptr, candidate.indices, radii,
                   model_.collision_triangle_indices.ptr, worlds, self_tri_tree_.nodes, triangle_bvh_.parents,
                   triangle_bvh_.children, triangle_bvh_.sorted, radius, radius, incident, candidate.counts,
                   candidate.slots, candidate.count, candidate.local, triangle_bvh_.count, per_world_, 31);
        };
        vf(self_vf_mesh_, 0, true);
        vf(self_vf_free_, model_.particle_radii.ptr, false);
        // Actual mixed captures return from both VF queries into PP, before the EE/EF branches.
        if (self_pp_.count)
            launch("self_query_pp", self_pp_.count, stream, state.particle_q.ptr, model_.collision_particle_indices.ptr,
                   model_.particle_radii.ptr, worlds, self_pp_.groups, self_pp_.nodes, particle_bvh_.parents,
                   particle_bvh_.children, particle_bvh_.sorted, particle_bvh_.escape, particle_bvh_.primitive_leaf,
                   self_pp_.counts, self_pp_.slots, self_pp_.count, self_pp_.local, per_world_, 31);
        if (self_ee_.count)
            launch("self_query_ee", self_ee_.count, stream, state.particle_q.ptr, self_ee_.indices, worlds,
                   self_edge_tree_.nodes, edge_bvh_.parents, edge_bvh_.children, edge_bvh_.sorted, radius,
                   self_ee_.counts, self_ee_.slots, self_ee_.count, self_ee_.local, per_world_, 31);
        if (self_ef_.count)
            launch("self_query_ef", self_ef_.count, stream, state.particle_q.ptr, self_ef_.indices,
                   model_.collision_triangle_indices.ptr, worlds, self_tri_tree_.nodes, triangle_bvh_.parents,
                   triangle_bvh_.children, triangle_bvh_.sorted, radius, self_ef_.counts, self_ef_.slots,
                   self_ef_.count, self_ef_.local, triangle_bvh_.count, per_world_, 31);
    }

    void accumulate_self_particle_pairs(const State& state, std::uintptr_t stream)
    {
        const bool full = config.enable_collision_hessian_non_diagonal;
        if (full && !self_pp_.contacts && self_pp_.capacity) {
            // Actual prepare_contact_tangent_cache allocates once on first full use, outside graph capture.
            CUstreamCaptureMode mode = CU_STREAM_CAPTURE_MODE_RELAXED;
            check(cuThreadExchangeStreamCaptureMode(&mode), "cuThreadExchangeStreamCaptureMode self tangent");
            try {
                self_pp_.contacts = driver_->allocate(self_pp_.capacity * 60);
            } catch (...) {
                cuThreadExchangeStreamCaptureMode(&mode);
                throw;
            }
            check(cuThreadExchangeStreamCaptureMode(&mode), "cuThreadExchangeStreamCaptureMode restore self tangent");
        }
        clear(self_pp_.diagonal, count_ * 36, stream);
        if (full) clear(self_pp_.counter, 4, stream);
        const auto contacts = full ? self_pp_.contacts : std::uint64_t(0);
        const float radius = config.self_collision_radius, thickness = radius + radius;
        auto vf = [&](const SelfCandidates& candidate, std::uint64_t radii, bool incident) {
            if (!candidate.count || !(config.self_collision_vertex_face_stiffness > 0.0f)) return;
            launch("self_accumulate_vf", candidate.count, stream, state.particle_q.ptr, candidate.indices, radii,
                   model_.collision_triangle_indices.ptr, candidate.counts, candidate.slots, self_pp_.stiffness,
                   radius, radius, incident, config.self_collision_vertex_face_stiffness, rhs_, self_pp_.diagonal,
                   contacts, self_pp_.counter, candidate.count, candidate.local, per_world_, 31);
        };
        vf(self_vf_mesh_, 0, true);
        vf(self_vf_free_, model_.particle_radii.ptr, false);
        if (self_pp_.count && config.self_collision_particle_particle_stiffness > 0.0f)
            launch("self_accumulate_pp", self_pp_.count, stream, state.particle_q.ptr,
                   model_.collision_particle_indices.ptr, model_.particle_radii.ptr, self_pp_.counts, self_pp_.slots,
                   self_pp_.stiffness, config.self_collision_particle_particle_stiffness, rhs_, self_pp_.diagonal,
                   contacts, self_pp_.counter, self_pp_.count, self_pp_.local, per_world_, 31);
        if (self_ee_.count && config.self_collision_edge_edge_stiffness > 0.0f)
            launch("self_accumulate_ee", self_ee_.count, stream, state.particle_q.ptr, self_ee_.indices,
                   self_opposite_offsets_, self_opposite_vertices_, self_ee_.counts, self_ee_.slots, self_pp_.stiffness,
                   thickness, config.self_collision_edge_edge_stiffness, rhs_, self_pp_.diagonal,
                   contacts, self_pp_.counter, self_ee_.count, self_ee_.local, per_world_, 31);
        if (self_ef_.count && config.self_collision_edge_face_stiffness > 0.0f)
            launch("self_accumulate_ef", self_ef_.count, stream, state.particle_q.ptr, self_ef_.indices,
                   self_opposite_offsets_, self_opposite_vertices_, model_.collision_triangle_indices.ptr,
                   self_ef_.counts, self_ef_.slots, self_pp_.stiffness, thickness,
                   config.self_collision_edge_face_stiffness, rhs_, self_pp_.diagonal,
                   contacts, self_pp_.counter, self_ef_.count, self_ef_.local, per_world_, 31);
    }

    void multiply_self_particle_pairs(std::uintptr_t stream)
    {
        if (config.enable_collision_hessian_non_diagonal)
            launch("self_full_tangent", std::min<std::size_t>(self_pp_.capacity, 256*256), stream,
                   self_pp_.contacts, self_pp_.counter, direction_, contact_product_);
        else
            launch("self_diagonal_tangent", count_, stream, self_pp_.diagonal, direction_, contact_product_, count_);
    }

    void precompute_springs()
    {
        host_diagonal_ = zero_;
        row_count_ = scalar_template_ = block_template_ = block_entries_ = 0;
        body_l1_ = 0;
        max_entries_ = 0;
        spring_rows_.clear();
        spring_diagonal_.clear();
        spring_count_ = model_.spring_count * (count_ / per_world_);
        struct ScalarEntry { int column; float value; };
        if (!spring_count_) {
            if (!model_.body_count && !model_.triangle_count && !model_.edge_count)
                precompute_particle_matrices(std::vector<float>(per_world_, 0.0f), std::vector<int>(count_, 0),
                                             std::vector<ScalarEntry>{});
            return;
        }
        struct Index { int a, b; };
        static_assert(sizeof(Index) == 8 && sizeof(ScalarEntry) == 8);
        const auto indices = read<Index>(model_.spring_indices, model_.spring_count);
        const auto stiffness = read<float>(model_.spring_stiffnesses, model_.spring_count);
        const auto rest = read<float>(model_.spring_rest_lengths, model_.spring_count);
        std::vector<std::map<int, float>> rows(per_world_);
        std::vector<float> diagonal(per_world_, 0.0f);
        for (std::size_t i = 0; i < indices.size(); ++i) {
            if (!(stiffness[i] >= 0.0f) || !std::isfinite(stiffness[i]))
                throw py::value_error("spring stiffness must be finite and non-negative");
            if (!(rest[i] > 0.0f) || !std::isfinite(rest[i]))
                throw py::value_error("spring rest length must be finite and positive");
            const auto [a, b] = indices[i];
            if (a < 0 || b < 0 || static_cast<std::size_t>(a) >= per_world_ || static_cast<std::size_t>(b) >= per_world_)
                throw py::value_error("spring references an invalid particle index");
            if (a == b) throw py::value_error("spring endpoints must reference different particles");
            // The original host accumulates duplicate columns in spring order, then traverses std::map by column.
            rows[a][b] += stiffness[i];
            rows[b][a] += stiffness[i];
        }
        for (std::size_t i = 0; i < indices.size(); ++i) {
            diagonal[indices[i].a] += stiffness[i];
            diagonal[indices[i].b] += stiffness[i];
        }
        load("spring_force", "kernel21evaluate_spring_forceE");
        load("spring_hessian", "kernel31add_spring_gauss_newton_hessianE");
        if (model_.body_count || model_.triangle_count || model_.edge_count) {
            // Preserve the spring contribution for the shared cloth/body column pattern.
            // Negating once after duplicate-spring summation preserves both rounding and signed-zero behavior.
            for (auto& row : rows) for (auto& entry : row) entry.second = -entry.second;
            spring_rows_ = std::move(rows);
            spring_diagonal_ = std::move(diagonal);
            return;
        }
        std::vector<int> counts(count_);
        for (std::size_t i = 0; i < count_; ++i) {
            counts[i] = static_cast<int>(rows[i % per_world_].size());
            max_entries_ = std::max(max_entries_, static_cast<std::size_t>(counts[i]));
        }
        std::vector<ScalarEntry> entries(max_entries_ * per_world_, {-1, 0.0f});
        for (std::size_t i = 0; i < per_world_; ++i) {
            std::size_t slot = 0;
            for (const auto& [column, value] : rows[i]) entries[slot++ * per_world_ + i] = {column, -value};
        }
        precompute_particle_matrices(diagonal, counts, entries);
    }

    void precompute_bodies()
    {
        body_count_ = model_.body_count;
        body_state_count_ = model_.body_state_count ? model_.body_state_count : model_.body_count * (count_ / per_world_);
        if (!body_count_) return;
        require(model_.affine_body_indices, body_count_, "affine_body_indices");
        require(model_.body_masses, body_count_, "body_masses");
        if (body_state_count_ != body_count_ * (count_ / per_world_))
            throw py::value_error("Body state count must contain whole replicated worlds");
        struct Index4 { int x, y, z, w; };
        struct Pair { int a, b; };
        struct ScalarEntry { int column; float value; };
        const auto bodies = read<Index4>(model_.affine_body_indices, body_count_);
        const std::size_t mass_count = model_.particle_mass_non_diagonal_count;
        if (mass_count) {
            require(model_.particle_mass_non_diagonal_indices, mass_count, "particle_mass_non_diagonal_indices");
            require(model_.particle_mass_non_diagonal_values, mass_count, "particle_mass_non_diagonal_values");
        }
        const auto pairs = read<Pair>(model_.particle_mass_non_diagonal_indices, mass_count);
        auto valid = [&](int p) { return p >= 0 && static_cast<std::size_t>(p) < per_world_; };
        // Per-entry contribution lists of the inertial cache, keyed by (row, column) in std::map column order as in
        // SolverNewton::precompute_matrices: list a holds mass non-diagonal entries, list b the bodies whose affine
        // columns couple the pair (the SIX_SPRINGS -w template, refreshed under SO(3) as well but weighted 0).
        struct Entry { std::vector<int> a, b; float l0 = 0.0f, l4 = 0.0f, l6 = 0.0f; };
        std::vector<std::map<int, Entry>> rows(per_world_);
        std::vector<float> host_diagonal(per_world_, 0.0f), distance_diagonal(per_world_, 0.0f),
            joint_diagonal(per_world_, 0.0f);
        // Actual mixed templates put the particle material Laplacian in L0 and the host diagonal.
        // All inertia/constraint channels retain the same combined columns with their own values.
        if (!spring_rows_.empty()) {
            for (std::size_t i = 0; i < per_world_; ++i)
                for (const auto& [column, value] : spring_rows_[i]) rows[i][column].l0 = value;
            host_diagonal = spring_diagonal_;
        }
        // Constant template k s s^T of one element, as the original host builds it: each slot pair a <= b is
        // evaluated once as F(F(k s_a) s_b) and stored to both (i, j) and (j, i) (captured 1-ULP asymmetry of
        // example_chain_heavy_ball's L4 entries (31, 27) / (627, 623)).
        auto accumulate = [&](const std::vector<std::pair<int, float>>& ends, float k, std::vector<float>& diagonal,
                              float Entry::*member) {
            for (std::size_t a = 0; a < ends.size(); ++a)
                for (std::size_t b = a; b < ends.size(); ++b) {
                    const auto [i, wi] = ends[a];
                    const auto [j, wj] = ends[b];
                    const float v = (k * wi) * wj;
                    if (i == j) {
                        diagonal[i] += v;
                        if (a != b) diagonal[i] += v;
                    } else {
                        rows[i][j].*member += v;
                        rows[j][i].*member += v;
                    }
                }
        };
        std::vector<std::vector<int>> diagonal_ids(per_world_);
        std::vector<int> kind(per_world_, 0);
        for (std::size_t m = 0; m < pairs.size(); ++m) {
            const auto [a, b] = pairs[m];
            if (!valid(a) || !valid(b) || a == b)
                throw py::value_error("mass non-diagonal entry references an invalid particle pair");
            rows[a][b].a.push_back(static_cast<int>(m));
            rows[b][a].a.push_back(static_cast<int>(m));
        }
        for (std::size_t body = 0; body < bodies.size(); ++body) {
            const int ids[4] = {bodies[body].x, bodies[body].y, bodies[body].z, bodies[body].w};
            for (int p : ids)
                if (!valid(p)) throw py::value_error("affine body references an invalid particle index");
            kind[ids[0]] = 1;
            for (int c = 1; c < 4; ++c) {
                kind[ids[c]] = 2;
                diagonal_ids[ids[c]].push_back(static_cast<int>(body));
                for (int d = 1; d < 4; ++d)
                    if (c != d) rows[ids[c]][ids[d]].b.push_back(static_cast<int>(body));
            }
        }
        // Plain body springs (penalties): host weights w = (1, p_local - com) per body end (+w0, -w1) and the
        // constant template F(F(k w_i) w_j) accumulated in spring order into the host diagonal and L0, as in
        // SolverNewton::precompute_matrices (captured host diagonal / L0 / weights of example_body_spring).
        body_spring_total_ = joint_spring_total_ = plain_spring_count_ = 0;
        if (model_.body_spring_count) {
            const std::size_t n = model_.body_spring_count;
            if (model_.joint_body_spring_count > n)
                throw py::value_error("joint_body_spring_count exceeds body_spring_count");
            plain_spring_count_ = n - model_.joint_body_spring_count;
            for (auto field : {std::make_pair(model_.body_spring_indices, "body_spring_indices"),
                    std::make_pair(model_.body_spring_points0, "body_spring_points0"),
                    std::make_pair(model_.body_spring_points1, "body_spring_points1"),
                    std::make_pair(model_.body_spring_stiffnesses, "body_spring_stiffnesses"),
                    std::make_pair(model_.body_spring_rest_lengths, "body_spring_rest_lengths")})
                require(field.first, n, field.second);
            require(model_.body_centers_of_mass, body_count_, "body_centers_of_mass");
            struct Vec3 { float x, y, z; };
            struct Vec4 { float w, x, y, z; };
            const auto spring_bodies = read<Pair>(model_.body_spring_indices, n);
            const auto points0 = read<Vec3>(model_.body_spring_points0, n);
            const auto points1 = read<Vec3>(model_.body_spring_points1, n);
            const auto stiffness = read<float>(model_.body_spring_stiffnesses, n);
            const auto com = read<Vec3>(model_.body_centers_of_mass, body_count_);
            std::vector<Vec4> w0(n, {0, 0, 0, 0}), w1(n, {0, 0, 0, 0});
            auto weight = [&](int b, const Vec3& p) -> Vec4 {
                if (b < 0) return {0.0f, 0.0f, 0.0f, 0.0f};
                if (static_cast<std::size_t>(b) >= body_count_)
                    throw py::value_error("body spring references an invalid body");
                return {1.0f, p.x - com[b].x, p.y - com[b].y, p.z - com[b].z};
            };
            for (std::size_t s = 0; s < n; ++s) {
                w0[s] = weight(spring_bodies[s].a, points0[s]);
                w1[s] = weight(spring_bodies[s].b, points1[s]);
                std::vector<std::pair<int, float>> ends;
                for (int side = 0; side < 2; ++side) {
                    const int b = side ? spring_bodies[s].b : spring_bodies[s].a;
                    if (b < 0) continue;
                    const Vec4 w = side ? w1[s] : w0[s];
                    const float sign = side ? -1.0f : 1.0f;
                    const int ids[4] = {bodies[b].x, bodies[b].y, bodies[b].z, bodies[b].w};
                    const float values[4] = {w.w, w.x, w.y, w.z};
                    for (int j = 0; j < 4; ++j) ends.emplace_back(ids[j], sign * values[j]);
                }
                // Plain springs go to the host constant (diagonal, L0); joint springs to D3/L4 (weight alpha).
                const bool joint = s >= plain_spring_count_;
                accumulate(ends, stiffness[s], joint ? joint_diagonal : host_diagonal, joint ? &Entry::l4 : &Entry::l0);
            }
            body_spring_total_ = n * (count_ / per_world_);
            joint_spring_total_ = model_.joint_body_spring_count * (count_ / per_world_);
            body_spring_w0_ = upload(w0);
            body_spring_w1_ = upload(w1);
            load("body_spring_force", "kernel26evaluate_body_spring_forceE");
            load("body_spring_hessian", "kernel36add_body_spring_gauss_newton_hessianE");
            if (joint_spring_total_) {
                joint_multiplier_ = driver_->allocate(joint_spring_total_ * 12);
                load("joint_spring_initialize", "kernel34initialize_joint_body_spring_stateE");
                load("joint_spring_force", "kernel53evaluate_joint_body_spring_augmented_lagrangian_forceE");
                load("joint_spring_update", "kernel51update_joint_body_spring_augmented_lagrangian_stateE");
            }
        }
        // Joint drives: host weights (1, p_local - com) of the parent origin/axis/reference points (parent body) and
        // the child origin/reference points (child body), zero for world sides; persistent angle branch state.
        drive_total_ = 0;
        angular_limits_ = armature_ = false;
        if (model_.joint_drive_count) {
            const std::size_t n = model_.joint_drive_count, dofs = model_.joint_dof_count;
            for (auto field : {std::make_pair(model_.joint_drive_types, "joint_drive_types"),
                    std::make_pair(model_.joint_drive_body_indices, "joint_drive_body_indices"),
                    std::make_pair(model_.joint_drive_parent_origins, "joint_drive_parent_origins"),
                    std::make_pair(model_.joint_drive_parent_axis_points, "joint_drive_parent_axis_points"),
                    std::make_pair(model_.joint_drive_parent_reference_points, "joint_drive_parent_reference_points"),
                    std::make_pair(model_.joint_drive_child_origins, "joint_drive_child_origins"),
                    std::make_pair(model_.joint_drive_child_reference_points, "joint_drive_child_reference_points"),
                    std::make_pair(model_.joint_drive_dof_indices, "joint_drive_dof_indices"),
                    std::make_pair(model_.joint_drive_target_indices, "joint_drive_target_indices")})
                require(field.first, n, field.second);
            for (auto field : {std::make_pair(model_.joint_target_stiffnesses, "joint_target_stiffnesses"),
                    std::make_pair(model_.joint_target_dampings, "joint_target_dampings"),
                    std::make_pair(model_.joint_effort_limits, "joint_effort_limits"),
                    std::make_pair(model_.joint_target_modes, "joint_target_modes"),
                    std::make_pair(model_.joint_passive_dampings, "joint_passive_dampings")})
                require(field.first, dofs, field.second);
            if (model_.joint_armature.size) {
                require(model_.joint_armature, dofs, "joint_armature");
                for (float value : read<float>(model_.joint_armature, dofs)) armature_ = armature_ || value > 0.0f;
            }
            require(model_.body_centers_of_mass, body_count_, "body_centers_of_mass");
            struct Vec3 { float x, y, z; };
            struct Vec4 { float w, x, y, z; };
            const auto drive_bodies = read<Pair>(model_.joint_drive_body_indices, n);
            const auto po = read<Vec3>(model_.joint_drive_parent_origins, n);
            const auto pa = read<Vec3>(model_.joint_drive_parent_axis_points, n);
            const auto pr = read<Vec3>(model_.joint_drive_parent_reference_points, n);
            const auto co = read<Vec3>(model_.joint_drive_child_origins, n);
            const auto cr = read<Vec3>(model_.joint_drive_child_reference_points, n);
            const auto com = read<Vec3>(model_.body_centers_of_mass, body_count_);
            auto weight = [&](int b, const Vec3& p) -> Vec4 {
                if (b < 0) return {0.0f, 0.0f, 0.0f, 0.0f};
                if (static_cast<std::size_t>(b) >= body_count_)
                    throw py::value_error("joint drive references an invalid body");
                return {1.0f, p.x - com[b].x, p.y - com[b].y, p.z - com[b].z};
            };
            std::vector<Vec4> w_po(n), w_co(n), w_pa(n), w_pr(n), w_cr(n);
            for (std::size_t i = 0; i < n; ++i) {
                w_po[i] = weight(drive_bodies[i].a, po[i]);
                w_pa[i] = weight(drive_bodies[i].a, pa[i]);
                w_pr[i] = weight(drive_bodies[i].a, pr[i]);
                w_co[i] = weight(drive_bodies[i].b, co[i]);
                w_cr[i] = weight(drive_bodies[i].b, cr[i]);
            }
            drive_total_ = n * (count_ / per_world_);
            drive_w_po_ = upload(w_po);
            drive_w_co_ = upload(w_co);
            drive_w_pa_ = upload(w_pa);
            drive_w_pr_ = upload(w_pr);
            drive_w_cr_ = upload(w_cr);
            drive_angle_ = upload(std::vector<float>(drive_total_, 0.0f));
            drive_initialized_ = upload(std::vector<int>(drive_total_, 0));
            drive_qd_ = driver_->allocate(drive_total_ * 4);
            angular_limits_ = model_.joint_limit_stiffnesses.size || model_.joint_limit_dampings.size;
            if (angular_limits_)
                for (auto field : {std::make_pair(model_.joint_limit_lower, "joint_limit_lower"),
                        std::make_pair(model_.joint_limit_upper, "joint_limit_upper"),
                        std::make_pair(model_.joint_limit_stiffnesses, "joint_limit_stiffnesses"),
                        std::make_pair(model_.joint_limit_dampings, "joint_limit_dampings")})
                    require(field.first, dofs, field.second);
            load("drive_load", "kernel25evaluate_joint_drive_loadE");
            load("drive_preconditioner", "kernel30add_joint_drive_preconditionerE");
            load("drive_tangent", "kernel28multiply_joint_drive_tangentE");
            load("drive_angle_update", "kernel30update_joint_drive_angle_stateE");
            load("drive_reset", "kernel32reset_selected_joint_drive_stateE");
            load("drive_velocity", "kernel38initialize_joint_coordinate_velocitiesE");
            if (armature_) load("joint_armature", "kernel23evaluate_joint_armatureE");
            if (angular_limits_) load("angular_limits", "kernel23evaluate_angular_limitsE");
        }
        // Plain body point-lines (penalties): host weights (1, p_local - com) for the point and both line endpoints;
        // the constant template uses -w_pt on the point body, then 0.5 (w_e0 + w_e1) on the line body, k s_i s_j in
        // line order after the springs (captured host diagonal of example_body_point_line).
        point_line_total_ = joint_line_total_ = plain_line_count_ = 0;
        if (model_.body_point_line_count) {
            const std::size_t n = model_.body_point_line_count;
            if (model_.joint_body_point_line_count > n)
                throw py::value_error("joint_body_point_line_count exceeds body_point_line_count");
            plain_line_count_ = n - model_.joint_body_point_line_count;
            if (plain_spring_count_ && plain_line_count_)
                throw std::runtime_error("Mixed plain body springs and point-lines have not been captured");
            for (auto field : {std::make_pair(model_.body_point_line_indices, "body_point_line_indices"),
                    std::make_pair(model_.body_point_line_points, "body_point_line_points"),
                    std::make_pair(model_.body_point_line_endpoints0, "body_point_line_endpoints0"),
                    std::make_pair(model_.body_point_line_endpoints1, "body_point_line_endpoints1"),
                    std::make_pair(model_.body_point_line_stiffnesses, "body_point_line_stiffnesses"),
                    std::make_pair(model_.body_point_line_dampings, "body_point_line_dampings")})
                require(field.first, n, field.second);
            require(model_.body_centers_of_mass, body_count_, "body_centers_of_mass");
            struct Vec3 { float x, y, z; };
            struct Vec4 { float w, x, y, z; };
            const auto line_bodies = read<Pair>(model_.body_point_line_indices, n);
            const auto points = read<Vec3>(model_.body_point_line_points, n);
            const auto end0 = read<Vec3>(model_.body_point_line_endpoints0, n);
            const auto end1 = read<Vec3>(model_.body_point_line_endpoints1, n);
            const auto stiffness = read<float>(model_.body_point_line_stiffnesses, n);
            const auto com = read<Vec3>(model_.body_centers_of_mass, body_count_);
            auto weight = [&](int b, const Vec3& p) -> Vec4 {
                if (b < 0) return {0.0f, 0.0f, 0.0f, 0.0f};
                if (static_cast<std::size_t>(b) >= body_count_)
                    throw py::value_error("point-line references an invalid body");
                return {1.0f, p.x - com[b].x, p.y - com[b].y, p.z - com[b].z};
            };
            std::vector<Vec4> wp(n), we0(n), we1(n);
            for (std::size_t j = 0; j < n; ++j) {
                const int pb = line_bodies[j].a, lb = line_bodies[j].b;
                wp[j] = weight(pb, points[j]);
                we0[j] = weight(lb, end0[j]);
                we1[j] = weight(lb, end1[j]);
                std::vector<std::pair<int, float>> ends;
                if (pb >= 0) {
                    const int ids[4] = {bodies[pb].x, bodies[pb].y, bodies[pb].z, bodies[pb].w};
                    const float values[4] = {wp[j].w, wp[j].x, wp[j].y, wp[j].z};
                    for (int k = 0; k < 4; ++k) ends.emplace_back(ids[k], -values[k]);
                }
                if (lb >= 0) {
                    const int ids[4] = {bodies[lb].x, bodies[lb].y, bodies[lb].z, bodies[lb].w};
                    const float values[4] = {0.5f * (we0[j].w + we1[j].w), 0.5f * (we0[j].x + we1[j].x),
                                             0.5f * (we0[j].y + we1[j].y), 0.5f * (we0[j].z + we1[j].z)};
                    for (int k = 0; k < 4; ++k) ends.emplace_back(ids[k], values[k]);
                }
                if (j < plain_line_count_) accumulate(ends, stiffness[j], host_diagonal, &Entry::l0);
                else {
                    // Joint line Hessians vary with the frozen projector/segment state. Only reserve their ELL
                    // columns here; their constant template is zero (original example_joints capture).
                    for (const auto& a : ends) for (const auto& b : ends)
                        if (a.first != b.first) rows[a.first][b.first];
                }
            }
            point_line_total_ = n * (count_ / per_world_);
            joint_line_total_ = model_.joint_body_point_line_count * (count_ / per_world_);
            point_line_wp_ = upload(wp);
            point_line_we0_ = upload(we0);
            point_line_we1_ = upload(we1);
            load("point_line_force", "kernel30evaluate_body_point_line_forceE");
            load("point_line_hessian", "kernel40add_body_point_line_gauss_newton_hessianE");
            if (joint_line_total_) {
                line_segment_ = driver_->allocate(joint_line_total_ * 4);
                line_multiplier_ = driver_->allocate(joint_line_total_ * 12);
                line_projector_ = driver_->allocate(joint_line_total_ * 36);
                load("joint_line_initialize", "kernel38initialize_joint_body_point_line_stateE");
                load("joint_line_force", "kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceE");
                load("joint_line_hessian", "kernel46add_joint_body_point_line_gauss_newton_hessianE");
                load("joint_line_update", "kernel55update_joint_body_point_line_augmented_lagrangian_stateE");
            }
        }
        // Body distance constraints (augmented Lagrangian): the host copies the model weights (zero for world ends)
        // and builds D5/L6 = m_s (s_i)(s_j), s = (+w0, -w1), in constraint order (weighted constraint_alpha).
        distance_total_ = 0;
        if (model_.body_distance_constraint_count) {
            const std::size_t n = model_.body_distance_constraint_count;
            for (auto field : {std::make_pair(model_.body_distance_constraint_indices, "body_distance_constraint_indices"),
                    std::make_pair(model_.body_distance_constraint_points0, "body_distance_constraint_points0"),
                    std::make_pair(model_.body_distance_constraint_points1, "body_distance_constraint_points1"),
                    std::make_pair(model_.body_distance_constraint_weights0, "body_distance_constraint_weights0"),
                    std::make_pair(model_.body_distance_constraint_weights1, "body_distance_constraint_weights1"),
                    std::make_pair(model_.body_distance_constraint_rest_lengths, "body_distance_constraint_rest_lengths"),
                    std::make_pair(model_.body_distance_constraint_mass_scales, "body_distance_constraint_mass_scales")})
                require(field.first, n, field.second);
            struct Vec4 { float w, x, y, z; };
            const auto pairs_c = read<Pair>(model_.body_distance_constraint_indices, n);
            auto w0 = read<Vec4>(model_.body_distance_constraint_weights0, n);
            auto w1 = read<Vec4>(model_.body_distance_constraint_weights1, n);
            const auto scale = read<float>(model_.body_distance_constraint_mass_scales, n);
            for (std::size_t c = 0; c < n; ++c) {
                std::vector<std::pair<int, float>> ends;
                for (int side = 0; side < 2; ++side) {
                    const int b = side ? pairs_c[c].b : pairs_c[c].a;
                    Vec4& w = side ? w1[c] : w0[c];
                    if (b < 0) { w = {0.0f, 0.0f, 0.0f, 0.0f}; continue; }
                    if (static_cast<std::size_t>(b) >= body_count_)
                        throw py::value_error("distance constraint references an invalid body");
                    const float sign = side ? -1.0f : 1.0f;
                    const int ids[4] = {bodies[b].x, bodies[b].y, bodies[b].z, bodies[b].w};
                    const float values[4] = {w.w, w.x, w.y, w.z};
                    for (int j = 0; j < 4; ++j) ends.emplace_back(ids[j], sign * values[j]);
                }
                accumulate(ends, scale[c], distance_diagonal, &Entry::l6);
            }
            distance_total_ = n * (count_ / per_world_);
            distance_w0_ = upload(w0);
            distance_w1_ = upload(w1);
            distance_target_ = driver_->allocate(distance_total_ * 12);
            distance_multiplier_ = driver_->allocate(distance_total_ * 12);
            load("distance_initialize", "kernel41initialize_body_distance_constraint_stateE");
            load("distance_force", "kernel39evaluate_body_distance_constraint_forceE");
            load("distance_update", "kernel37update_body_distance_constraint_stateE");
        }
        max_entries_ = 0;
        for (const auto& row : rows) max_entries_ = std::max(max_entries_, row.size());
        std::vector<int> counts(count_);
        for (std::size_t i = 0; i < count_; ++i) counts[i] = static_cast<int>(rows[i % per_world_].size());
        const std::size_t entries = max_entries_ * per_world_;
        // Every template carries the full column pattern with +0 values; padding is {-1, +0} (captured buffers).
        std::vector<ScalarEntry> pattern(std::max<std::size_t>(entries, 1), {-1, 0.0f});
        std::vector<std::size_t> offsets_a(entries + 1, 0), offsets_b(entries + 1, 0);
        std::vector<std::vector<int>> lists_a(entries), lists_b(entries);
        std::vector<ScalarEntry> l0(pattern.size(), {-1, 0.0f}), l4(pattern.size(), {-1, 0.0f}),
            l6(pattern.size(), {-1, 0.0f});
        for (std::size_t i = 0; i < per_world_; ++i) {
            std::size_t slot = 0;
            for (const auto& [column, entry] : rows[i]) {
                const std::size_t e = slot++ * per_world_ + i;
                pattern[e].column = column;
                l0[e] = {column, entry.l0};
                l4[e] = {column, entry.l4};
                l6[e] = {column, entry.l6};
                lists_a[e] = entry.a;
                lists_b[e] = entry.b;
            }
        }
        std::vector<int> ids_a, ids_b;
        for (std::size_t e = 0; e < entries; ++e) {
            ids_a.insert(ids_a.end(), lists_a[e].begin(), lists_a[e].end());
            ids_b.insert(ids_b.end(), lists_b[e].begin(), lists_b[e].end());
            offsets_a[e + 1] = ids_a.size();
            offsets_b[e + 1] = ids_b.size();
        }
        std::vector<std::size_t> diagonal_offsets(per_world_ + 1, 0);
        std::vector<int> diagonal_list;
        for (std::size_t i = 0; i < per_world_; ++i) {
            diagonal_list.insert(diagonal_list.end(), diagonal_ids[i].begin(), diagonal_ids[i].end());
            diagonal_offsets[i + 1] = diagonal_list.size();
        }
        // Empty lists are never dereferenced; keep non-empty allocations so every kernel pointer is valid.
        if (ids_a.empty()) ids_a.push_back(0);
        if (ids_b.empty()) ids_b.push_back(0);
        if (diagonal_list.empty()) diagonal_list.push_back(0);
        // Actual body constructors retain independent D0..D5 and L0..L6 templates in this order.
        // Refresh kernels update inertial values per step, but the uploaded initial values are already populated.
        const auto body_mass = read<float>(model_.body_masses, body_count_);
        const auto mass_values = read<float>(model_.particle_mass_non_diagonal_values, mass_count);
        std::vector<float> d1(per_world_, 0.0f), d2(per_world_, 0.0f);
        for (std::size_t i = 0; i < per_world_; ++i) {
            float sum = 0.0f;
            for (int body : diagonal_ids[i]) sum += body_mass[body];
            d1[i] = sum * 3.0f;
            d2[i] = sum;
        }
        auto l1 = pattern, l2 = pattern;
        for (std::size_t e = 0; e < entries; ++e) {
            for (int id : lists_a[e]) l1[e].value += mass_values[id];
            for (int body : lists_b[e]) l2[e].value -= body_mass[body];
        }
        host_diagonal_ = upload(host_diagonal);
        body_d1_ = upload(d1);
        body_d2_ = upload(d2);
        joint_d3_ = upload(joint_diagonal);
        zero_ = upload(std::vector<float>(per_world_, 0.0f));
        distance_d5_ = upload(distance_diagonal);
        local_row_count_ = upload(std::vector<int>(counts.begin(), counts.begin() + per_world_));
        row_count_ = upload(counts);
        body_l0_ = upload(l0);
        body_l1_ = upload(l1);
        body_offsets_a_ = upload(offsets_a);
        body_ids_a_ = upload(ids_a);
        body_offsets_b_ = upload(offsets_b);
        body_ids_b_ = upload(ids_b);
        body_diagonal_offsets_ = upload(diagonal_offsets);
        body_diagonal_ids_ = upload(diagonal_list);
        body_l2_ = upload(l2);
        body_zero_ell_ = retained_particle_templates_[0] = upload(pattern);
        joint_l4_ = retained_particle_templates_[1] = upload(l4);
        retained_particle_templates_[2] = upload(pattern);
        distance_l6_ = retained_particle_templates_[3] = upload(l6);
        scalar_template_ = initialized_cache(entries, 8, SourceCacheType::ScalarEntry);
        body_kind_ = upload(kind);
        // Original body caches use typed zero initialization before any valid-slot-only ELL writes or full copies.
        block_template_ = initialized_cache(max_entries_ * count_, 40, SourceCacheType::BlockEntry);
        block_entries_ = initialized_cache(max_entries_ * count_, 40, SourceCacheType::BlockEntry);
        load("refresh_nonzeros", "kernel31refresh_inertial_cache_nonzerosE");
        load("refresh_diagonals", "kernel32refresh_inertial_cache_diagonalsE");
        load("combine", "kernel27combine_system_non_diagonalE");
        load("block_entries", "kernel29initialize_block_non_diagonalE");
        load("so3_initialize", "kernel32initialize_affine_body_so3_stateE");
        load("so3_force", "kernel51evaluate_affine_body_so3_augmented_lagrangian_forceE");
        load("so3_preconditioner", "kernel55add_affine_body_so3_augmented_lagrangian_preconditionerE");
        load("so3_tangent", "kernel53multiply_affine_body_so3_augmented_lagrangian_tangentE");
        load("so3_update", "kernel49update_affine_body_so3_augmented_lagrangian_stateE");
        load("rigidity_spring_force", "kernel33evaluate_affine_body_spring_forceE");
        load("rigidity_spring_hessian", "kernel43add_affine_body_spring_gauss_newton_hessianE");
        load("constitutive_force", "kernel39evaluate_affine_body_constitutive_forceE");
        load("constitutive_preconditioner", "kernel43add_affine_body_constitutive_preconditionerE");
        load("constitutive_tangent", "kernel41multiply_affine_body_constitutive_tangentE");
        driver_->synchronize();
    }

    // RollingContactView of the rolling/torsional friction kernels, passed by value (248 bytes in the original).
    struct RollingView {
        std::uint64_t count; std::size_t capacity;
        std::uint64_t shape0, shape1, point0, point1, offset0, offset1, normal, margin0, margin1;
        std::uint64_t shape_body, shape_type, transform, scale, ke, kd, rolling, torsional;
        std::size_t local_shapes, shapes_per_world, worlds;
        std::uint64_t body_ids, body_indices, body_com, inertia;
        std::size_t body_count, particles_per_world;
        std::uint64_t x, previous;
        float inverse_dt, epsilon;
    };
    static_assert(sizeof(RollingView) == 248 && offsetof(RollingView, inertia) == 200 &&
                  offsetof(RollingView, inverse_dt) == 240, "RollingContactView layout");

    // JointCoordinateView (120 B) and AngularLimitView (32 B) of evaluate_angular_limits, passed by value.
    struct JointView {
        std::uint64_t body_particles, types, bodies, parent_origin, parent_axis, parent_reference;
        std::uint64_t w_po, w_co, w_pa, w_pr, w_cr, dofs;
        std::size_t joints_per_world, count, particles_per_world;
    };
    struct LimitView { std::uint64_t lower, upper, stiffness, damping; };
    static_assert(sizeof(JointView) == 120 && offsetof(JointView, joints_per_world) == 96, "JointCoordinateView");
    static_assert(sizeof(LimitView) == 32, "AngularLimitView");

    JointView joint_view() const
    {
        return {model_.affine_body_indices.ptr, model_.joint_drive_types.ptr, model_.joint_drive_body_indices.ptr,
                model_.joint_drive_parent_origins.ptr, model_.joint_drive_parent_axis_points.ptr,
                model_.joint_drive_parent_reference_points.ptr, drive_w_po_, drive_w_co_, drive_w_pa_, drive_w_pr_,
                drive_w_cr_, model_.joint_drive_dof_indices.ptr, model_.joint_drive_count, drive_total_, per_world_};
    }

    LimitView limit_view() const
    {
        return {model_.joint_limit_lower.ptr, model_.joint_limit_upper.ptr, model_.joint_limit_stiffnesses.ptr,
                model_.joint_limit_dampings.ptr};
    }

    struct CableView {
        std::uint64_t body_indices, body_com, inertia, pairs, frame0, frame1, base, penalty, damping, rest;
        std::uint64_t angular_bias, angular_hessian, enabled, linear, angular, indices, sizes;
        std::size_t per_world, total, particles_per_world;
    };
    static_assert(sizeof(CableView) == 160 && offsetof(CableView, per_world) == 136, "CableView layout");

    bool cable_ramping() const
    {
        return config.cable_linear_beta > 0.0f || config.cable_angular_beta > 0.0f;
    }

    void validate_cable_config() const
    {
        if (!std::isfinite(config.cable_penalty_gamma) || config.cable_penalty_gamma < 0.0f ||
            config.cable_penalty_gamma > 1.0f)
            throw py::value_error("cable_penalty_gamma must be finite and in [0, 1]");
        for (float value : {config.cable_linear_beta, config.cable_angular_beta,
                            config.cable_linear_k_start, config.cable_angular_k_start})
            if (!std::isfinite(value) || value < 0.0f)
                throw py::value_error("cable penalty ramps and seeds must be finite and non-negative");
    }

    void validate_step_config() const
    {
        if (config.nonlinear_iterations < 0 || config.nonlinear_iterations > 999)
            throw py::value_error("config.nonlinear_iterations must be between 0 and 999");
        if (config.linear_iterations < 1 || config.linear_iterations > 999)
            throw py::value_error("config.linear_iterations must be between 1 and 999");
        if (!std::isfinite(config.constraint_alpha) || config.constraint_alpha < 0.0f)
            throw py::value_error("config.constraint_alpha must be finite and non-negative");
        if (config.joint_constraint_primal_iterations < 1 || config.joint_constraint_primal_iterations > 999)
            throw py::value_error("config.joint_constraint_primal_iterations must be between 1 and 999");
        if (config.affine_body_rigidity_primal_iterations < 1 || config.affine_body_rigidity_primal_iterations > 999)
            throw py::value_error("config.affine_body_rigidity_primal_iterations must be between 1 and 999");
        // SolverNewton validates these even when self-collision is disabled or unavailable.
        if (!std::isfinite(config.self_collision_radius) || config.self_collision_radius <= 0.0f)
            throw py::value_error("config.self_collision_radius must be finite and positive");
        for (float value : {config.self_collision_vertex_face_stiffness, config.self_collision_edge_edge_stiffness,
                            config.self_collision_edge_face_stiffness, config.self_collision_particle_particle_stiffness})
            if (!std::isfinite(value) || value < 0.0f)
                throw py::value_error("self-collision stiffness factors must be finite and non-negative");
        if (!std::isfinite(config.rigid_contact_friction_epsilon) || config.rigid_contact_friction_epsilon < 0.0f)
            throw py::value_error("rigid_contact_friction_epsilon must be finite and non-negative");
        if (!std::isfinite(config.rigid_contact_alpha) || config.rigid_contact_alpha < 0.0f ||
            config.rigid_contact_alpha > 1.0f)
            throw py::value_error("rigid_contact_alpha must be finite and in [0, 1]");
        if (!std::isfinite(config.rigid_contact_gamma) || config.rigid_contact_gamma < 0.0f ||
            config.rigid_contact_gamma > 1.0f)
            throw py::value_error("rigid_contact_gamma must be finite and in [0, 1]");
        if (!std::isfinite(config.rigid_contact_beta) || config.rigid_contact_beta < 0.0f ||
            !std::isfinite(config.rigid_contact_k_start) || config.rigid_contact_k_start < 0.0f)
            throw py::value_error("hard-contact penalty ramp and seed must be finite and non-negative");
        validate_cable_config();
        if (fluid_rows_ && (!std::isfinite(config.fluid_relaxation) || config.fluid_relaxation <= 0.0f ||
            config.fluid_relaxation > 1.0f || !std::isfinite(config.fluid_max_step_ratio) ||
            config.fluid_max_step_ratio < 0.0f))
            throw py::value_error("fluid relaxation must be in (0, 1] and maximum step ratio finite and non-negative");
    }

    void prepare_cable_penalties(std::uintptr_t stream, bool reset, bool rescale, std::uint64_t mask = 0)
    {
        launch("cable_penalty_prepare", cable_count_, stream, model_.cable_stiffnesses.ptr, cable_penalty_,
               cable_initialized_, static_cast<std::size_t>(model_.cable_count), cable_count_,
               config.cable_linear_beta, config.cable_angular_beta, config.cable_penalty_gamma,
               config.cable_linear_k_start, config.cable_angular_k_start, reset, rescale, mask);
    }

    CableView cable_view() const
    {
        return {model_.affine_body_indices.ptr, model_.body_centers_of_mass.ptr, model_.body_inertia_tensors.ptr,
                model_.cable_body_indices.ptr, model_.cable_parent_transforms.ptr, model_.cable_child_transforms.ptr,
                model_.cable_stiffnesses.ptr, cable_ramping() ? cable_penalty_ : 0, model_.cable_dampings.ptr,
                model_.cable_rest_bend_twist.ptr, model_.cable_angular_bias.ptr, model_.cable_angular_hessian.ptr,
                model_.cable_enabled.ptr, cable_linear_, cable_angular_, cable_indices_, cable_sizes_,
                model_.cable_count, cable_count_, per_world_};
    }

    void precompute_cables()
    {
        cable_count_ = model_.cable_count * (count_ / per_world_);
        if (!cable_count_) return;
        if (model_.body_spring_count || model_.body_point_line_count || model_.body_distance_constraint_count ||
            model_.joint_drive_count)
            throw std::runtime_error("Cable mixed with body constraints has not been captured");
        const std::size_t n = model_.cable_count;
        for (auto field : {std::make_pair(model_.cable_body_indices, "cable_body_indices"),
                std::make_pair(model_.cable_parent_transforms, "cable_parent_transforms"),
                std::make_pair(model_.cable_child_transforms, "cable_child_transforms"),
                std::make_pair(model_.cable_stiffnesses, "cable_stiffnesses"),
                std::make_pair(model_.cable_dampings, "cable_dampings"),
                std::make_pair(model_.cable_rest_bend_twist, "cable_rest_bend_twist")}) require(field.first, n, field.second);
        require(model_.body_centers_of_mass, body_count_, "body_centers_of_mass");
        require(model_.body_inertia_tensors, body_count_, "body_inertia_tensors");
        if (model_.cable_enabled.size) require(model_.cable_enabled, n, "cable_enabled");
        for (auto field : {std::make_pair(model_.cable_angular_bias, "cable_angular_bias"),
                std::make_pair(model_.cable_angular_hessian, "cable_angular_hessian")})
            if (field.first.size) require(field.first, cable_count_, field.second);
        const auto pairs = read<std::array<int, 2>>(model_.cable_body_indices, n);
        for (const auto& pair : pairs) for (int b : pair)
            if (b < -1 || (b >= 0 && static_cast<std::size_t>(b) >= body_count_))
                throw py::value_error("cable references an invalid body");
        cable_penalty_ = driver_->allocate(cable_count_ * 16);
        cable_initialized_ = driver_->allocate(cable_count_ * 4);
        check(cuMemsetD8(cable_initialized_, 0, cable_count_ * 4), "cuMemsetD8 cable initialized");
        cable_linear_ = driver_->allocate(cable_count_ * 8 * 36);
        cable_angular_ = driver_->allocate(cable_count_ * 8 * 36);
        cable_indices_ = driver_->allocate(cable_count_ * 8 * 4);
        cable_sizes_ = driver_->allocate(cable_count_ * 4);
        load("cable_penalty_prepare", "kernel23prepare_cable_penaltiesE");
        load("cable_prepare", "kernel22prepare_cable_tangentsE");
        load("cable_evaluate", "kernel15evaluate_cablesE");
        load("cable_penalty_update", "kernel22update_cable_penaltiesE");
    }

    void joint_armature(const State& state, float inverse_dt, std::uintptr_t stream,
                        std::uint64_t direction, std::uint64_t force, std::uint64_t block)
    {
        // All three original modes retain the cached qd pointer, even when the kernel does not read it.
        launch("joint_armature", drive_total_, stream, joint_view(), model_.joint_armature.ptr,
               state.particle_q.ptr, previous_, drive_qd_, inverse_dt, direction, force, block);
    }

    struct FluidView {
        std::uint64_t head, next, ids, world, cells, positions, volumes, counts, neighbors, cache;
        int slots, stride, local_count, rows;
        float radius, bulk, viscosity, dt;
    };
    static_assert(sizeof(FluidView) == 112 && offsetof(FluidView, slots) == 80);

    FluidView fluid_view(float dt) const
    {
        return {fluid_head_, fluid_next_, fluid_ids_, fluid_world_, fluid_cells_, fluid_positions_, fluid_volumes_,
                fluid_counts_, fluid_neighbors_, fluid_cache_, fluid_slots_, fluid_stride_,
                static_cast<int>(model_.fluid_particle_count), fluid_rows_, model_.fluid_smoothing_radius,
                model_.fluid_bulk_modulus, model_.fluid_viscosity, dt};
    }

    std::array<unsigned char, 1864> fluid_model() const
    {
        // The GPU Model is a separate ABI from the public Python binding. Only named, kernel-read fields are used.
        std::array<unsigned char, 1864> data{};
        auto put = [&](std::size_t offset, auto value) { std::memcpy(data.data() + offset, &value, sizeof(value)); };
        put(24, static_cast<std::uint32_t>(model_.particle_count));
        put(28, static_cast<std::uint32_t>(model_.particle_state_count));
        put(48, model_.particle_masses.ptr);
        put(56, model_.particle_masses.size);
        put(120, model_.particle_world.ptr);
        put(128, model_.particle_world.size);
        put(136, model_.particle_radii.ptr);
        put(144, model_.particle_radii.size);
        put(192, static_cast<std::uint32_t>(model_.fluid_particle_count));
        put(200, model_.fluid_particle_indices.ptr);
        put(208, model_.fluid_particle_indices.size);
        put(216, model_.fluid_rest_density);
        put(220, model_.fluid_smoothing_radius);
        put(224, model_.fluid_bulk_modulus);
        put(228, model_.fluid_viscosity);
        put(232, static_cast<std::uint32_t>(model_.fluid_boundary_count));
        put(240, model_.fluid_boundary_positions.ptr);
        put(248, model_.fluid_boundary_positions.size);
        put(256, model_.fluid_boundary_volumes.ptr);
        put(264, model_.fluid_boundary_volumes.size);
        return data;
    }

    void precompute_fluid()
    {
        if (!model_.fluid_particle_count) return;
        const std::size_t local = model_.fluid_particle_count, boundaries = model_.fluid_boundary_count;
        const std::size_t copies = count_ / per_world_;
        if (!std::isfinite(model_.fluid_rest_density) || model_.fluid_rest_density <= 0.0f ||
            !std::isfinite(model_.fluid_smoothing_radius) || model_.fluid_smoothing_radius <= 0.0f ||
            !std::isfinite(model_.fluid_bulk_modulus) || model_.fluid_bulk_modulus < 0.0f ||
            !std::isfinite(model_.fluid_viscosity) || model_.fluid_viscosity < 0.0f)
            throw py::value_error("fluid density/radius must be positive; bulk modulus/viscosity non-negative and finite");
        require(model_.fluid_particle_indices, local, "fluid_particle_indices");
        const auto indices = read<int>(model_.fluid_particle_indices, local);
        const auto masses = read<float>(model_.particle_masses, per_world_);
        const auto flags = model_.particle_flags.size ? read<int>(model_.particle_flags, per_world_) : std::vector<int>();
        std::vector<bool> selected(per_world_, false);
        for (int index : indices) {
            if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                throw py::value_error("fluid particle index is out of range");
            if (selected[index]) throw py::value_error("fluid indices must be unique valid particle indices");
            selected[index] = true;
            if (!std::isfinite(masses[index]) || masses[index] <= 0.0f || (!flags.empty() && !(flags[index] & 1)))
                throw py::value_error("fluid particles must have positive finite mass and be active");
        }
        // Fluid::initialize checks these five index lists in this order, before boundary validation.
        auto reject_overlap = [&](const auto& elements) {
            for (const auto& element : elements)
                for (int particle : element)
                    if (particle >= 0 && static_cast<std::size_t>(particle) < per_world_ && selected[particle])
                        throw py::value_error("fluid particles cannot also belong to elastic or affine topology");
        };
        reject_overlap(read<std::array<int, 3>>(model_.triangle_indices, model_.triangle_count));
        reject_overlap(read<std::array<int, 4>>(model_.edge_indices, model_.edge_count));
        reject_overlap(read<std::array<int, 2>>(model_.spring_indices, model_.spring_count));
        reject_overlap(read<std::array<int, 4>>(model_.tetrahedron_indices, model_.tetrahedron_count));
        reject_overlap(read<std::array<int, 4>>(model_.affine_body_indices, model_.body_count));
        require(model_.fluid_boundary_positions, boundaries, "fluid_boundary_positions");
        require(model_.fluid_boundary_volumes, boundaries, "fluid_boundary_volumes");
        const auto positions = read<std::array<float, 3>>(model_.fluid_boundary_positions, boundaries);
        const auto volumes = read<float>(model_.fluid_boundary_volumes, boundaries);
        for (std::size_t i = 0; i < boundaries; ++i) {
            for (float value : positions[i])
                if (!std::isfinite(value))
                    throw py::value_error("fluid boundary positions must be finite and volumes positive and finite");
            if (!std::isfinite(volumes[i]) || volumes[i] <= 0.0f)
                throw py::value_error("fluid boundary positions must be finite and volumes positive and finite");
        }
        if (local + boundaries > 0x1fffffffULL / copies || count_ > 0x7fffffffULL)
            throw py::value_error("fluid grid is too large");
        fluid_stride_ = static_cast<int>(local + boundaries);
        fluid_points_ = static_cast<int>((local + boundaries) * copies);
        fluid_rows_ = static_cast<int>(local * copies);
        fluid_slots_ = 1;
        while (fluid_slots_ < fluid_points_) fluid_slots_ *= 2;
        fluid_slots_ *= 2;
        fluid_worlds_ = static_cast<int>(copies);
        if (copies == 1 && model_.particle_world.size) {
            const auto worlds = read<int>(model_.particle_world, model_.particle_world.size);
            for (int world : worlds) {
                if (world >= 0x1fffffff) throw py::value_error("fluid world index is too large");
                fluid_worlds_ = std::max(fluid_worlds_, world + 1);
            }
        }
        auto allocate = [&](std::size_t size) { return driver_->allocate(size); };
        fluid_head_ = allocate(static_cast<std::size_t>(fluid_slots_) * 4);
        fluid_next_ = allocate(static_cast<std::size_t>(fluid_points_) * 4);
        fluid_ids_ = allocate(static_cast<std::size_t>(fluid_points_) * 4);
        fluid_world_ = allocate(static_cast<std::size_t>(fluid_points_) * 4);
        fluid_cells_ = allocate(static_cast<std::size_t>(fluid_points_) * 12);
        fluid_positions_ = allocate(static_cast<std::size_t>(fluid_points_) * 12);
        fluid_volumes_ = allocate(static_cast<std::size_t>(fluid_points_) * 4);
        fluid_counts_ = allocate(static_cast<std::size_t>(fluid_rows_) * 4);
        fluid_neighbors_ = allocate(static_cast<std::size_t>(fluid_rows_) * 64 * 4);
        fluid_cache_ = allocate(static_cast<std::size_t>(fluid_rows_) * 64 * 16);
        fluid_gradients_ = allocate(static_cast<std::size_t>(fluid_rows_) * 12);
        fluid_residuals_ = allocate(static_cast<std::size_t>(fluid_rows_) * 4);
        fluid_weights_ = allocate(static_cast<std::size_t>(fluid_rows_) * 4);
        fluid_diagonal_ = allocate(count_ * 36);
        fluid_scale_ = allocate(static_cast<std::size_t>(fluid_worlds_) * 4);
        for (const auto& suffix : {"10build_grid", "13evaluate_rows", "15accumulate_rows", "13multiply_rows",
                                  "12add_diagonal", "16initialize_scale", "11bound_scale", "10scale_step"})
            load(std::string("fluid_") + suffix, std::string("12fluid_kernel") + suffix);
    }

    void accumulate_fluid(const State& state, float dt, std::uintptr_t stream)
    {
        check(cuMemsetD8Async(fluid_head_, 0xff, static_cast<std::size_t>(fluid_slots_) * 4,
                             reinterpret_cast<CUstream>(stream)), "cuMemsetD8Async fluid heads");
        clear(fluid_diagonal_, count_ * 36, stream);
        launch_width("fluid_10build_grid", fluid_points_, 128, stream, fluid_model(), state.particle_q.ptr,
                     fluid_positions_, fluid_volumes_, fluid_ids_, fluid_world_, fluid_cells_, fluid_head_, fluid_next_,
                     fluid_points_, fluid_slots_);
        launch_width("fluid_13evaluate_rows", fluid_rows_, 128, stream, fluid_view(dt), fluid_gradients_, fluid_residuals_,
                     fluid_weights_, fluid_counts_, fluid_neighbors_, fluid_cache_);
        launch_width("fluid_15accumulate_rows", fluid_rows_, 128, stream, fluid_view(dt), fluid_gradients_,
                     fluid_residuals_, fluid_weights_, previous_, rhs_, fluid_diagonal_);
    }

    void limit_fluid(float dt, std::uintptr_t stream)
    {
        launch_width("fluid_16initialize_scale", fluid_worlds_, 128, stream, fluid_scale_, 1.0f, fluid_worlds_);
        launch_width("fluid_11bound_scale", fluid_rows_, 128, stream, fluid_view(dt), solution_, config.fluid_relaxation,
                     config.fluid_max_step_ratio * model_.fluid_smoothing_radius, fluid_scale_);
        launch_width("fluid_10scale_step", count_, 128, stream, fluid_model(), solution_, fluid_scale_,
                     static_cast<int>(count_));
    }

    struct GranularView {
        std::uint64_t head, next, ids, world, cells, positions, previous, radius, counts, neighbors, cache;
        int count, slots;
        float cell_size, stiffness, friction, damping, dt;
    };
    static_assert(sizeof(GranularView) == 120 && offsetof(GranularView, count) == 88);

    GranularView granular_view(float dt) const
    {
        return {granular_head_, granular_next_, granular_ids_, granular_world_, granular_cells_, granular_positions_,
                granular_previous_, granular_radius_, granular_counts_, granular_neighbors_, granular_cache_,
                granular_points_, granular_slots_, granular_cell_size_, model_.granular_contact_stiffness,
                model_.granular_friction, model_.granular_friction_damping, dt};
    }

    std::array<unsigned char, 1864> granular_model() const
    {
        auto data = fluid_model();
        auto put = [&](std::size_t offset, auto value) { std::memcpy(data.data() + offset, &value, sizeof(value)); };
        put(272, static_cast<std::uint32_t>(model_.granular_particle_count));
        put(280, model_.granular_particle_indices.ptr);
        put(288, model_.granular_particle_indices.size);
        put(312, model_.granular_bond_damping);
        put(316, model_.granular_yield_strain);
        put(320, model_.granular_max_compaction);
        put(324, model_.granular_break_strain);
        put(328, model_.granular_adhesion);
        put(332, model_.granular_bond_formation_gap);
        put(336, model_.granular_bond_formation_speed);
        put(340, static_cast<int>(model_.granular_max_dynamic_bonds));
        return data;
    }

    void precompute_granular()
    {
        granular_points_ = granular_slots_ = 0;
        granular_initial_ = {};
        granular_dynamic_ = {};
        const std::size_t local = model_.granular_particle_count, authored = model_.granular_bond_count;
        if (!local) {
            if (authored) throw py::value_error("granular bonds require granular particles");
            return;
        }
        bool valid = std::isfinite(model_.granular_contact_stiffness) && model_.granular_contact_stiffness > 0.0f;
        for (float value : {model_.granular_friction, model_.granular_friction_damping, model_.granular_cohesion,
                            model_.granular_bond_damping, model_.granular_yield_strain, model_.granular_max_compaction,
                            model_.granular_break_strain, model_.granular_adhesion, model_.granular_bond_formation_gap,
                            model_.granular_bond_formation_speed})
            valid = valid && std::isfinite(value) && value >= 0.0f;
        if (!valid || model_.granular_yield_strain >= 1.0f || model_.granular_max_compaction >= 1.0f ||
            model_.granular_max_dynamic_bonds < 1 || model_.granular_max_dynamic_bonds > 64)
            throw py::value_error("granular parameters must be finite with positive contact stiffness, "
                                  "non-negative friction/damping/cohesion/adhesion/formation gap/speed/break strain, "
                                  "yield/compaction in [0, 1), and dynamic bond capacity in [1, 64]");
        if (!model_.granular_particle_indices.ptr || model_.granular_particle_indices.size < local)
            throw py::value_error("granular_particle_indices is smaller than its collision count");
        auto enough = [](Span span, std::size_t size) {
            if (size && (!span.ptr || span.size < size))
                throw py::value_error("granular model array is smaller than its count");
        };
        enough(model_.particle_radii, per_world_);
        const auto indices = read<int>(model_.granular_particle_indices, local);
        const auto masses = read<float>(model_.particle_masses, per_world_);
        const auto radii = read<float>(model_.particle_radii, per_world_);
        const auto flags = model_.particle_flags.size ? read<int>(model_.particle_flags, per_world_) : std::vector<int>();
        const auto worlds = model_.particle_world.size ? read<int>(model_.particle_world, per_world_) :
                                                       std::vector<int>(per_world_, 0);
        std::vector<int> inverse(per_world_, -1);
        float maximum_radius = 0.0f;
        for (std::size_t i = 0; i < local; ++i) {
            const int index = indices[i];
            if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                throw py::value_error("granular particle index is out of range");
            if (inverse[index] >= 0) throw py::value_error("granular indices must be unique valid particle indices");
            inverse[index] = static_cast<int>(i);
            if (!std::isfinite(masses[index]) || masses[index] <= 0.0f || !std::isfinite(radii[index]) ||
                radii[index] <= 0.0f || (!flags.empty() && !(flags[index] & 1)))
                throw py::value_error("granular particles must have positive finite mass/radius and be active");
            maximum_radius = std::max(maximum_radius, radii[index]);
        }
        enough(model_.granular_bond_indices, authored);
        enough(model_.granular_bond_rest_lengths, authored);
        const auto pairs = read<std::array<int, 2>>(model_.granular_bond_indices, authored);
        const auto rest = read<float>(model_.granular_bond_rest_lengths, authored);
        std::set<std::pair<int, int>> unique;
        for (std::size_t i = 0; i < authored; ++i) {
            const int a = pairs[i][0], b = pairs[i][1];
            if (a < 0 || b < 0 || static_cast<std::size_t>(a) >= per_world_ ||
                static_cast<std::size_t>(b) >= per_world_ || a == b || inverse[a] < 0 || inverse[b] < 0 ||
                !unique.emplace(std::min(a, b), std::max(a, b)).second)
                throw py::value_error("granular bonds must be unique pairs of distinct granular particles");
            if (!std::isfinite(rest[i]) || rest[i] <= 0.0f)
                throw py::value_error("granular bond rest lengths must be positive and finite");
            if (worlds[a] != worlds[b]) throw py::value_error("granular bond endpoints must belong to the same world");
        }
        const std::size_t copies = count_ / per_world_, points = local * copies;
        const std::size_t dynamic = model_.granular_adhesion > 0.0f ? points * model_.granular_max_dynamic_bonds : 0;
        if (points > 0x1fffffffULL || count_ > 0x7fffffffULL || authored * copies > 0x7fffffffULL ||
            dynamic > 0x7fffffffULL)
            throw py::value_error("granular model exceeds supported index range");
        granular_points_ = static_cast<int>(points);
        granular_cell_size_ = (maximum_radius + maximum_radius) + (dynamic ? model_.granular_bond_formation_gap : 0.0f);
        if (!std::isfinite(granular_cell_size_)) throw py::value_error("granular radii exceed supported range");
        granular_slots_ = 1;
        while (granular_slots_ < granular_points_) granular_slots_ *= 2;
        granular_slots_ *= 2;
        auto allocate = [&](std::size_t size) { return driver_->allocate(size); };
        granular_head_ = allocate(static_cast<std::size_t>(granular_slots_) * 4);
        granular_next_ = allocate(points * 4);
        granular_ids_ = allocate(points * 4);
        granular_world_ = allocate(points * 4);
        granular_cells_ = allocate(points * 12);
        granular_positions_ = allocate(points * 12);
        granular_previous_ = allocate(points * 12);
        granular_radius_ = allocate(points * 4);
        granular_counts_ = allocate(points * 4);
        granular_neighbors_ = allocate(points * 32 * 4);
        granular_cache_ = allocate(points * 32 * 16);
        granular_diagonal_ = allocate(count_ * 36);
        auto prepare_bonds = [&](GranularBonds& group, const auto& bonds, const auto& lengths, int active) {
            group.count = static_cast<int>(bonds.size());
            if (!group.count) return;
            group.pairs = upload(bonds);
            group.rest = upload(lengths);
            group.history = upload(lengths);
            group.active = upload(std::vector<int>(bonds.size(), active));
            group.tangent = allocate(bonds.size() * 36);
        };
        std::vector<std::array<int, 2>> global_pairs;
        std::vector<float> global_rest;
        std::vector<std::vector<int>> adjacency(points);
        for (std::size_t world = 0; world < copies; ++world)
            for (std::size_t i = 0; i < authored; ++i) {
                const int a = pairs[i][0], b = pairs[i][1];
                if (model_.granular_cohesion > 0.0f) {
                    global_pairs.push_back({a + static_cast<int>(world * per_world_),
                                            b + static_cast<int>(world * per_world_)});
                    global_rest.push_back(rest[i]);
                }
                // The original excludes every authored pair from adhesion, including zero-cohesion bonds.
                // It stores each pair once, in the smaller grain's row, independent of endpoint orientation.
                const int ga = inverse[a] + static_cast<int>(world * local);
                const int gb = inverse[b] + static_cast<int>(world * local);
                adjacency[std::min(ga, gb)].push_back(std::max(ga, gb));
            }
        prepare_bonds(granular_initial_, global_pairs, global_rest, 1);
        if (dynamic) {
            prepare_bonds(granular_dynamic_, std::vector<std::array<int, 2>>(dynamic, {0, 0}),
                          std::vector<float>(dynamic, 0.0f), 0);
            granular_partner_ = upload(std::vector<int>(dynamic, -1));
            std::vector<int> offsets{0}, columns;
            for (auto& row : adjacency) {
                std::sort(row.begin(), row.end());
                columns.insert(columns.end(), row.begin(), row.end());
                offsets.push_back(static_cast<int>(columns.size()));
            }
            granular_offsets_ = upload(offsets);
            granular_columns_ = columns.empty() ? 0 : upload(columns);
        }
        for (const auto& suffix : {"10build_grid", "19accumulate_contacts", "16accumulate_bonds", "12add_diagonal",
                                  "17multiply_contacts", "14multiply_bonds", "12commit_bonds", "10form_bonds"})
            load(std::string("granular_") + suffix, std::string("15granular_kernel") + suffix);
    }

    void build_granular_grid(const State& state, float dt, std::uintptr_t stream, bool reset_diagonal = false)
    {
        check(cuMemsetD8Async(granular_head_, 0xff, static_cast<std::size_t>(granular_slots_) * 4,
                             reinterpret_cast<CUstream>(stream)), "cuMemsetD8Async granular heads");
        if (reset_diagonal) clear(granular_diagonal_, count_ * 36, stream);
        launch_width("granular_10build_grid", granular_points_, 128, stream, granular_model(), state.particle_q.ptr,
                     previous_, granular_view(dt), granular_positions_, granular_previous_, granular_radius_,
                     granular_ids_, granular_world_, granular_cells_, granular_head_, granular_next_);
    }

    void accumulate_granular(const State& state, float dt, std::uintptr_t stream)
    {
        build_granular_grid(state, dt, stream, true);
        launch_width("granular_19accumulate_contacts", granular_points_, 128, stream, granular_view(dt), rhs_,
                     granular_diagonal_, granular_counts_, granular_neighbors_, granular_cache_);
        for (const auto& item : {std::make_pair(granular_initial_, model_.granular_cohesion),
                                 std::make_pair(granular_dynamic_, model_.granular_adhesion)}) {
            const auto& g = item.first;
            if (g.count)
                launch_width("granular_16accumulate_bonds", g.count, 128, stream, granular_model(), state.particle_q.ptr,
                             previous_, dt, g.pairs, g.rest, g.history, g.active, g.count, item.second, rhs_,
                             granular_diagonal_, g.tangent);
        }
    }

    void multiply_granular(float dt, std::uintptr_t stream)
    {
        launch_width("granular_17multiply_contacts", granular_points_, 128, stream, granular_view(dt), direction_,
                     contact_product_);
        for (const auto& g : {granular_initial_, granular_dynamic_})
            if (g.count)
                launch_width("granular_14multiply_bonds", g.count, 128, stream, g.pairs, g.active, g.tangent,
                             g.count, direction_, contact_product_);
    }

    void commit_granular(const State& state, float dt, std::uintptr_t stream)
    {
        for (const auto& g : {granular_initial_, granular_dynamic_})
            if (g.count)
                launch_width("granular_12commit_bonds", g.count, 128, stream, granular_model(), state.particle_q.ptr,
                             g.pairs, g.rest, g.history, g.active, g.count);
        if (granular_dynamic_.count) {
            build_granular_grid(state, dt, stream);
            const auto& g = granular_dynamic_;
            launch_width("granular_10form_bonds", granular_points_, 128, stream, granular_model(), granular_view(dt),
                         granular_offsets_, granular_columns_, granular_partner_, g.pairs, g.rest, g.history, g.active);
        }
    }

    void precompute_affine_blocks()
    {
        if (!body_count_) return;
        // This setup precedes precompute_bodies/precompute_cables now; preserve their indexing preconditions.
        require(model_.affine_body_indices, body_count_, "affine_body_indices");
        if (body_state_count_ != body_count_ * (count_ / per_world_))
            throw py::value_error("Body state count must contain whole replicated worlds");
        affine_blocks_ = initialized_cache(body_state_count_ * 144, 4, SourceCacheType::Scalar);
        affine_valid_ = initialized_cache(body_state_count_, 4, SourceCacheType::Integer);
        const auto bodies = read<std::array<int, 4>>(model_.affine_body_indices, body_count_);
        std::vector<int> owner(per_world_, -1), enabled(body_count_, 1);
        for (std::size_t body = 0; body < body_count_; ++body)
            for (int particle : bodies[body]) {
                if (particle < 0 || static_cast<std::size_t>(particle) >= per_world_)
                    throw py::value_error("affine body references an invalid particle index");
                if (owner[particle] >= 0) enabled[body] = enabled[owner[particle]] = 0;
                else owner[particle] = static_cast<int>(body);
            }
        // Sharing even one proxy coordinate disables both overlapping twelve-DOF blocks in the original host.
        affine_enabled_ = upload(enabled);
        std::vector<std::vector<int>> adjacency(body_count_);
        require(model_.cable_body_indices, model_.cable_count, "cable_body_indices");
        const auto pairs = read<std::array<int, 2>>(model_.cable_body_indices, model_.cable_count);
        for (std::size_t cable = 0; cable < pairs.size(); ++cable) {
            const auto [a, b] = pairs[cable];
            for (int body : {a, b})
                if (body < -1 || (body >= 0 && static_cast<std::size_t>(body) >= body_count_))
                    throw py::value_error("cable references an invalid body");
            if (a >= 0) adjacency[a].push_back(static_cast<int>(cable));
            if (b >= 0 && b != a) adjacency[b].push_back(static_cast<int>(cable));
        }
        std::vector<std::size_t> offsets(body_count_ + 1, 0);
        std::vector<int> ids;
        for (std::size_t body = 0; body < body_count_; ++body) {
            ids.insert(ids.end(), adjacency[body].begin(), adjacency[body].end());
            offsets[body + 1] = ids.size();
        }
        affine_cable_offsets_ = upload(offsets);
        affine_cable_ids_ = ids.empty() ? 0 : upload(ids);
        body_rotation_ = initialized_cache(body_state_count_, 36, SourceCacheType::Matrix3);
        body_multiplier_ = initialized_cache(body_state_count_, 36, SourceCacheType::Matrix3);
        load("affine_build", "kernel32build_affine_body_preconditionerINS_17BlockNonZeroEntryE");
        load("affine_build_scalar", "kernel32build_affine_body_preconditionerINS_12NonZeroEntryE");
        load("affine_apply", "kernel32apply_affine_body_preconditionerE");
        load("block_apply", "kernel35apply_block_diagonal_preconditionerE");
    }

    struct HardView {
        std::uint64_t count;
        std::size_t capacity;
        std::uint64_t shape0, shape1, point0, point1, offset0, offset1, normal, margin0, margin1, match;
        std::uint64_t shape_body, shape_type, shape_transform, shape_scale, shape_ke, shape_kd, shape_mu;
        std::size_t local_shapes, shapes_per_world, worlds;
        std::uint64_t body_ids, body_indices, body_com;
        std::size_t bodies, particles_per_world;
        std::uint64_t x, previous;
        float inverse_dt, alpha, beta, gamma, start;
        std::uint8_t history, exact_friction, reset, padding;
        std::uint64_t penalty, dual, anchor, previous_penalty, previous_dual, previous_normal, previous_count;
    };
    static_assert(sizeof(HardView) == 312 && offsetof(HardView, penalty) == 256);

    HardView hard_view(const Contact& contact, const State& state, float inverse_dt) const
    {
        return {contact.count.ptr, contact.max_count, contact.shape0.ptr, contact.shape1.ptr, contact.point0.ptr,
                contact.point1.ptr, contact.offset0.ptr, contact.offset1.ptr, contact.normal.ptr, contact.margin0.ptr,
                contact.margin1.ptr, contact.match_index.ptr, model_.shape_bodies.ptr, model_.shape_types.ptr,
                model_.shape_transforms.ptr, model_.shape_scales.ptr, model_.shape_contact_stiffnesses.ptr,
                model_.shape_contact_dampings.ptr, model_.shape_frictions.ptr, model_.shape_count,
                model_.shape_replicated_count, count_ / per_world_, model_.affine_body_ids.ptr,
                model_.affine_body_indices.ptr, model_.body_centers_of_mass.ptr, body_count_, per_world_,
                state.particle_q.ptr, previous_, inverse_dt, config.rigid_contact_alpha, config.rigid_contact_beta,
                config.rigid_contact_gamma, config.rigid_contact_k_start,
                static_cast<std::uint8_t>(config.rigid_contact_history),
                static_cast<std::uint8_t>(config.rigid_contact_sliding_tangent),
                static_cast<std::uint8_t>(contact.history_refresh), 0, hard_penalty_, hard_dual_, hard_anchor_,
                hard_previous_penalty_, hard_previous_dual_, hard_previous_normal_, hard_previous_count_};
    }

    RollingView rolling_view(const Contact& contact, const State& state, float inverse_dt) const
    {
        return {contact.count.ptr, contact.max_count, contact.shape0.ptr, contact.shape1.ptr, contact.point0.ptr,
                contact.point1.ptr, contact.offset0.ptr, contact.offset1.ptr, contact.normal.ptr, contact.margin0.ptr,
                contact.margin1.ptr, model_.shape_bodies.ptr, model_.shape_types.ptr, model_.shape_transforms.ptr,
                model_.shape_scales.ptr, model_.shape_contact_stiffnesses.ptr, model_.shape_contact_dampings.ptr,
                model_.shape_rolling_frictions.ptr, model_.shape_torsional_frictions.ptr, model_.shape_count,
                model_.shape_replicated_count, count_ / per_world_, model_.affine_body_ids.ptr,
                model_.affine_body_indices.ptr, model_.body_centers_of_mass.ptr, model_.body_inertia_tensors.ptr,
                body_count_, per_world_, state.particle_q.ptr, previous_, inverse_dt,
                config.rolling_friction_velocity_epsilon};
    }

    // Rigid contact force (direction == 0) or tangent (system/preconditioner blocks, or direction -> product).
    void rigid_contact(const Contact& contact, const State& state, float inverse_dt, std::uintptr_t stream, bool force,
                       std::uint64_t direction, std::uint64_t product, std::uint64_t system, std::uint64_t preconditioner)
    {
        const auto common = std::make_tuple(contact.count.ptr, static_cast<std::size_t>(contact.max_count),
            contact.shape0.ptr, contact.shape1.ptr, contact.point0.ptr, contact.point1.ptr, contact.offset0.ptr,
            contact.offset1.ptr, contact.normal.ptr, contact.margin0.ptr, contact.margin1.ptr, model_.shape_bodies.ptr,
            model_.shape_types.ptr, model_.shape_transforms.ptr, model_.shape_scales.ptr,
            model_.shape_contact_stiffnesses.ptr, model_.shape_contact_dampings.ptr,
            model_.shape_contact_friction_gains.ptr, model_.shape_frictions.ptr, config.rigid_contact_friction_epsilon,
            static_cast<std::size_t>(model_.shape_count), static_cast<std::size_t>(model_.shape_replicated_count),
            count_ / per_world_, model_.affine_body_ids.ptr, model_.affine_body_indices.ptr,
            model_.body_centers_of_mass.ptr, body_count_);
        std::apply([&](const auto&... head) {
            if (force)
                launch("rigid_force", contact.max_count, stream, head..., per_world_, state.particle_q.ptr,
                       state.particle_qd.ptr, previous_, inverse_dt, rhs_, diagonal_);
            else
                launch("rigid_tangent", contact.max_count, stream, head..., state.particle_q.ptr, previous_, direction,
                       product, inverse_dt, per_world_, system, preconditioner);
        }, common);
    }

    void soft_contact(const Contact& contact, const State& state, float inverse_dt, std::uintptr_t stream,
                      std::uint64_t force, std::uint64_t scalar, std::uint64_t system, std::uint64_t preconditioner,
                      bool filtered = false)
    {
        const std::uint64_t null = 0;
        launch("soft_contact", contact.soft_max_count, stream, contact.soft_count.ptr,
               static_cast<std::size_t>(contact.soft_max_count), contact.soft_particle.ptr, contact.soft_shape.ptr,
               contact.soft_body_pos.ptr, contact.soft_body_vel.ptr, contact.soft_normal.ptr, model_.particle_radii.ptr,
               model_.particle_masses.ptr, body_count_ ? body_kind_ : particle_kind_, per_world_, count_,
               model_.shape_bodies.ptr,
               model_.shape_types.ptr,
               model_.shape_transforms.ptr, model_.shape_scales.ptr, model_.shape_margins.ptr,
               model_.shape_contact_stiffnesses.ptr, model_.shape_contact_dampings.ptr,
               model_.shape_contact_friction_gains.ptr, model_.shape_frictions.ptr,
               static_cast<std::size_t>(model_.shape_count), static_cast<std::size_t>(model_.shape_replicated_count),
               count_ / per_world_, model_.soft_contact_stiffness, model_.soft_contact_damping,
               model_.soft_contact_friction_gain, model_.soft_contact_friction, body_ids(), body_indices(), body_com(),
               body_count_, state.particle_q.ptr, state.particle_qd.ptr, previous_, inverse_dt, force, scalar,
               filtered ? contact.soft_particle_only_shapes.ptr : null,
               filtered ? contact.soft_particle_only_shapes.size : std::size_t(0), system, preconditioner);
    }

    SourceSurfaceView surface_view(const Contact& contact, const State& state, float inverse_dt) const
    {
        SourceSurfaceView v{};
        v.count = contact.soft_count.ptr;
        v.capacity = contact.soft_max_count;
        v.indices = contact.soft_indices.ptr;
        v.barycentric = contact.soft_barycentric.ptr;
        v.shape = contact.soft_shape.ptr;
        v.body_pos = contact.soft_body_pos.ptr;
        v.body_vel = contact.soft_body_vel.ptr;
        v.normal = contact.soft_normal.ptr;
        v.particle_only = contact.soft_particle_only_shapes.size ? contact.soft_particle_only_shapes.ptr : 0;
        v.particle_only_count = contact.soft_particle_only_shapes.size;
        v.radius = model_.particle_radii.ptr;
        v.mass = model_.particle_masses.ptr;
        v.flags = model_.particle_flags.size ? model_.particle_flags.ptr : 0;
        v.kind = particle_kind_;
        v.particles_per_world = per_world_;
        v.total_particles = count_;
        v.shape_body = model_.shape_bodies.ptr;
        v.shape_type = model_.shape_types.ptr;
        v.transform = model_.shape_transforms.ptr;
        v.shape_scale = model_.shape_scales.ptr;
        v.shape_margin = model_.shape_margins.ptr;
        v.shape_ke = model_.shape_contact_stiffnesses.ptr;
        v.shape_kd = model_.shape_contact_dampings.ptr;
        v.shape_kf = model_.shape_contact_friction_gains.ptr;
        v.shape_mu = model_.shape_frictions.ptr;
        v.local_shape_count = model_.shape_count;
        v.shapes_per_world = model_.shape_replicated_count;
        v.worlds = count_ / per_world_;
        v.ke = model_.soft_contact_stiffness;
        v.kd = model_.soft_contact_damping;
        v.kf = model_.soft_contact_friction_gain;
        v.mu = model_.soft_contact_friction;
        v.x = state.particle_q.ptr;
        v.previous = previous_;
        v.inv_dt = inverse_dt;
        return v;
    }

    void precompute_cloth()
    {
        triangle_count_ = model_.triangle_count * (count_ / per_world_);
        edge_count_ = model_.edge_count * (count_ / per_world_);
        bending_damping_ = false;
        if (!triangle_count_ && !edge_count_) return;
        using Indices = std::array<int, 3>;
        using Pose = std::array<float, 4>;
        using Stiffness = std::array<float, 3>;
        const auto indices = read<Indices>(model_.triangle_indices, model_.triangle_count);
        const auto poses = read<Pose>(model_.triangle_inv_dms, model_.triangle_count);
        const auto stiffness = read<Stiffness>(model_.triangle_aniso_stiffnesses, model_.triangle_count);
        const auto areas = read<float>(model_.triangle_rest_areas, model_.triangle_count);
        auto rows = std::move(spring_rows_);
        auto diagonal = std::move(spring_diagonal_);
        if (rows.empty()) rows.resize(per_world_);
        if (diagonal.empty()) diagonal.resize(per_world_, 0.0f);
        // These scalar host operations follow the original SSE order; build without fast-math or native FMA.
        for (std::size_t t = 0; t < indices.size(); ++t) {
            for (auto index : indices[t])
                if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error("triangle references an invalid particle index");
            const auto& m = poses[t];
            const float u[3] = {-m[0] - m[2], m[0], m[2]};
            const float v[3] = {-m[1] - m[3], m[1], m[3]};
            const float ku = stiffness[t][0] + stiffness[t][2], kv = stiffness[t][2] + stiffness[t][1];
            for (int a = 0; a < 3; ++a) {
                const float pa = u[a] * ku, qa = v[a] * kv;
                for (int b = a; b < 3; ++b) {
                    const float value = ((pa * u[b]) + (qa * v[b])) * areas[t];
                    const int row = indices[t][a], col = indices[t][b];
                    if (a == b) diagonal[row] += value;
                    else { rows[row][col] += value; rows[col][row] += value; }
                }
            }
        }
        const auto edges = read<std::array<int, 4>>(model_.edge_indices, model_.edge_count);
        const auto cots = read<std::array<float, 4>>(model_.edge_bending_cots, model_.edge_count);
        const auto properties = read<std::array<float, 2>>(model_.edge_bending_properties, model_.edge_count);
        const auto edge_areas = read<float>(model_.edge_rest_areas, model_.edge_count);
        for (std::size_t e = 0; e < edges.size(); ++e) {
            bool valid = edge_areas[e] > 0.0f;
            for (int a = 0; a < 4; ++a) {
                valid = valid && edges[e][a] >= 0;
                for (int b = a + 1; b < 4; ++b) valid = valid && edges[e][a] != edges[e][b];
            }
            if (!valid) continue;
            for (auto index : edges[e])
                if (static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error("bending edge references an invalid particle index");
            bending_damping_ = bending_damping_ || properties[e][1] > 0.0f;
            const auto& c = cots[e];
            const float w[4] = {-c[0] - c[2], -c[1] - c[3], c[2] + c[3], c[0] + c[1]};
            const float scale = (3.0f / edge_areas[e]) * properties[e][0];
            for (int a = 0; a < 4; ++a) {
                const float wa = w[a] * scale;
                for (int b = a; b < 4; ++b) {
                    const float value = wa * w[b];
                    const int row = edges[e][a], col = edges[e][b];
                    if (a == b) diagonal[row] += value;
                    else { rows[row][col] += value; rows[col][row] += value; }
                }
            }
        }
        std::vector<int> counts(count_);
        for (std::size_t i = 0; i < count_; ++i) {
            counts[i] = static_cast<int>(rows[i % per_world_].size());
            max_entries_ = std::max(max_entries_, static_cast<std::size_t>(counts[i]));
        }
        struct ScalarEntry { int column; float value; };
        static_assert(sizeof(ScalarEntry) == 8);
        std::vector<ScalarEntry> entries(max_entries_ * per_world_, {-1, 0.0f});
        for (std::size_t i = 0; i < per_world_; ++i) {
            std::size_t slot = 0;
            for (const auto& [column, value] : rows[i]) entries[slot++ * per_world_ + i] = {column, value};
        }
        load("stretch_force", "kernel22evaluate_stretch_forceE");
        load("membrane_hessian", "kernel39add_cloth_membrane_gauss_newton_hessianE");
        load("bending_force", "kernel22evaluate_bending_forceE");
        load("bending_preconditioner", "kernel34add_bending_damping_preconditionerE");
        load("bending_tangent", "kernel32multiply_bending_damping_tangentE");
        if (model_.body_count) {
            // Keep the recovered scalar material contribution for the body CSR/ELL assembly.
            spring_rows_ = std::move(rows);
            spring_diagonal_ = std::move(diagonal);
            return;
        }
        precompute_particle_matrices(diagonal, counts, entries);
    }

    std::uint64_t body_ids() const { return body_count_ ? model_.affine_body_ids.ptr : 0; }
    std::uint64_t body_indices() const { return body_count_ ? model_.affine_body_indices.ptr : 0; }
    std::uint64_t body_com() const { return body_count_ ? model_.body_centers_of_mass.ptr : 0; }

    void soft_contact_product(const Contact& contact, const State& state, float inverse_dt, std::uintptr_t stream,
                              bool filtered = false)
    {
        const std::uint64_t null = 0;
        // SolverNewton::step fb7cf..fb7ea caps this grid at 32 blocks; the kernel walks a grid-stride loop.
        launch("soft_contact_product", std::min<std::size_t>(contact.soft_max_count, 32 * 256), stream, contact.soft_count.ptr,
               static_cast<std::size_t>(contact.soft_max_count), contact.soft_particle.ptr, contact.soft_shape.ptr,
               contact.soft_body_pos.ptr, contact.soft_normal.ptr, model_.particle_radii.ptr,
               model_.shape_bodies.ptr, model_.shape_types.ptr, model_.shape_transforms.ptr, model_.shape_scales.ptr,
               model_.particle_masses.ptr, body_count_ ? body_kind_ : particle_kind_, model_.shape_margins.ptr,
               model_.shape_contact_stiffnesses.ptr, model_.shape_contact_dampings.ptr,
               static_cast<std::size_t>(model_.shape_count), static_cast<std::size_t>(model_.shape_replicated_count),
               count_ / per_world_, body_ids(), body_indices(), body_com(), body_count_, state.particle_q.ptr,
               direction_, contact_product_, inverse_dt, per_world_,
               model_.soft_contact_stiffness, model_.soft_contact_damping, count_,
               filtered ? contact.soft_particle_only_shapes.ptr : null,
               filtered ? contact.soft_particle_only_shapes.size : std::size_t(0),
               model_.shape_contact_friction_gains.ptr, model_.shape_frictions.ptr,
               model_.soft_contact_friction_gain, model_.soft_contact_friction, contact.soft_body_vel.ptr, previous_);
    }

    void precompute_tetrahedra()
    {
        tetrahedron_count_ = model_.tetrahedron_count * (count_ / per_world_);
        tetrahedron_volumes_ = 0;
        if (!tetrahedron_count_) return;
        const auto indices = read<std::array<int, 4>>(model_.tetrahedron_indices, model_.tetrahedron_count);
        for (const auto& element : indices)
            for (auto index : element)
                if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error("tetrahedron references an invalid particle index");
        const auto inverse = read<std::array<float, 9>>(model_.tetrahedron_inverse_dms, model_.tetrahedron_count);
        std::vector<float> volumes(inverse.size());
        for (std::size_t i = 0; i < inverse.size(); ++i) {
            const auto& m = inverse[i];
            const float a = m[8] * m[4] - m[5] * m[7];
            const float b = m[8] * m[3] - m[5] * m[6];
            const float c = m[3] * m[7] - m[6] * m[4];
            const float determinant = (m[0] * a - m[1] * b) + m[2] * c;
            volumes[i] = 1.0f / (determinant * 6.0f);
        }
        tetrahedron_volumes_ = upload(volumes);
        load("tetrahedron_force", "kernel26evaluate_tetrahedron_forceE");
        load("tetrahedron_preconditioner", "kernel30add_tetrahedron_preconditionerE");
        load("tetrahedron_tangent", "kernel28multiply_tetrahedron_tangentE");
    }

    void precompute_drag()
    {
        drag_count_ = drag_local_count_ = 0;
        drag_indices_ = drag_coefficients_ = drag_normal_ = drag_area_ = drag_scalar_ = 0;
        if (!model_.collision_triangle_count || !model_.triangle_drag_coefficients.size) return;
        require(model_.triangle_drag_coefficients, model_.collision_triangle_count, "triangle_drag_coefficients");
        require(model_.collision_triangle_indices, model_.collision_triangle_count, "collision_triangle_indices");
        const auto indices = read<std::array<int, 3>>(model_.collision_triangle_indices, model_.collision_triangle_count);
        const auto coefficients = read<float>(model_.triangle_drag_coefficients, model_.collision_triangle_count);
        std::vector<std::array<int, 3>> compact_indices;
        std::vector<float> compact_coefficients;
        for (std::size_t i = 0; i < indices.size(); ++i) {
            if (!std::isfinite(coefficients[i]) || coefficients[i] < 0.0f)
                throw py::value_error("triangle drag coefficients must be finite and non-negative");
            if (!(coefficients[i] > 0.0f)) continue;
            for (auto index : indices[i])
                if (index < 0 || static_cast<std::size_t>(index) >= per_world_)
                    throw py::value_error("drag triangle references an invalid particle index");
            compact_indices.push_back(indices[i]);
            compact_coefficients.push_back(coefficients[i]);
        }
        drag_local_count_ = compact_indices.size();
        drag_count_ = drag_local_count_ * (count_ / per_world_);
        if (!drag_count_) return;
        drag_indices_ = upload(compact_indices);
        drag_coefficients_ = upload(compact_coefficients);
        drag_normal_ = initialized_cache(drag_count_, 12, SourceCacheType::Vector3);
        drag_area_ = initialized_cache(drag_count_, 4, SourceCacheType::Scalar);
        drag_scalar_ = initialized_cache(drag_count_, 4, SourceCacheType::Scalar);
        load("drag_start", "kernel24initialize_triangle_dragE");
        load("drag_force", "kernel22evaluate_triangle_dragE");
        load("drag_preconditioner", "kernel32add_triangle_drag_preconditionerE");
        load("drag_tangent", "kernel30multiply_triangle_drag_tangentE");
    }

public:
    Config config;

    void initialize(const Model& model)
    {
        reject_model(model);
        const std::size_t count = model.particle_state_count ? model.particle_state_count : model.particle_count;
        if (count && (!model.particle_count || count % model.particle_count))
            throw py::value_error("Particle state count must contain whole replicated worlds");
        require(model.particle_masses, model.particle_count, "particle_masses");
        require(model.particle_rest_positions, count, "particle_rest_positions");
        if (model.particle_flags.size) require(model.particle_flags, model.particle_count, "particle_flags");
        if (model.particle_world.size) require(model.particle_world, model.particle_count, "particle_world");
        if (model.gravity.size) require(model.gravity, model.gravity.size, "gravity");
        if (model.spring_count) {
            require(model.spring_indices, model.spring_count, "spring_indices");
            require(model.spring_stiffnesses, model.spring_count, "spring_stiffnesses");
            require(model.spring_rest_lengths, model.spring_count, "spring_rest_lengths");
        }
        if (model.triangle_count) {
            require(model.triangle_indices, model.triangle_count, "triangle_indices");
            require(model.triangle_inv_dms, model.triangle_count, "triangle_inv_dms");
            require(model.triangle_rest_areas, model.triangle_count, "triangle_rest_areas");
            require(model.triangle_aniso_stiffnesses, model.triangle_count, "triangle_aniso_stiffnesses");
        }
        if (model.edge_count) {
            require(model.edge_indices, model.edge_count, "edge_indices");
            require(model.edge_rest_areas, model.edge_count, "edge_rest_areas");
            require(model.edge_bending_cots, model.edge_count, "edge_bending_cots");
            require(model.edge_bending_properties, model.edge_count, "edge_bending_properties");
        }
        if (model.tetrahedron_count) {
            require(model.tetrahedron_indices, model.tetrahedron_count, "tetrahedron_indices");
            require(model.tetrahedron_inverse_dms, model.tetrahedron_count, "tetrahedron_inverse_dms");
            require(model.tetrahedron_materials, model.tetrahedron_count, "tetrahedron_materials");
        }
        if (model.shape_count) {
            if (model.shape_replicated_count > model.shape_count)
                throw py::value_error("shape_replicated_count exceeds shape_count");
            require(model.particle_radii, model.particle_count, "particle_radii");
            for (auto field : {std::make_pair(model.shape_bodies, "shape_bodies"),
                    std::make_pair(model.shape_types, "shape_types"),
                    std::make_pair(model.shape_transforms, "shape_transforms"),
                    std::make_pair(model.shape_scales, "shape_scales"), std::make_pair(model.shape_margins, "shape_margins"),
                    std::make_pair(model.shape_contact_stiffnesses, "shape_contact_stiffnesses"),
                    std::make_pair(model.shape_contact_dampings, "shape_contact_dampings"),
                    std::make_pair(model.shape_contact_friction_gains, "shape_contact_friction_gains"),
                    std::make_pair(model.shape_frictions, "shape_frictions")})
                require(field.first, model.shape_count, field.second);
        }
        driver_ = std::make_unique<Driver>();
        hard_capacity_ = 0;
        hard_penalty_ = hard_dual_ = hard_anchor_ = hard_previous_penalty_ = 0;
        hard_previous_dual_ = hard_previous_normal_ = hard_previous_count_ = 0;
        local_row_count_ = 0;
        particle_diagonal_templates_.fill(0);
        retained_particle_templates_.fill(0);
        functions_.clear();
        launches_.clear();
        model_ = model;
        count_ = count;
        per_world_ = model.particle_count;
        tetrahedron_count_ = 0;
        tetrahedron_volumes_ = 0;
        triangle_bvh_ = {};
        edge_bvh_ = {};
        particle_bvh_ = {};
        fluid_points_ = fluid_rows_ = fluid_slots_ = fluid_stride_ = fluid_worlds_ = 0;
        if (!count_) return;
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        for (float value : read<float>(model_.particle_masses, per_world_))
            if (!std::isfinite(value) || value < 0.0f)
                throw py::value_error("particle masses must be finite and non-negative");
        // SolverNewton::initialize 10ef29..10efb3 only checks these radii for shapes or collision particles.
        if (model_.shape_count || model_.collision_particle_count) {
            require(model_.particle_radii, per_world_, "particle_radii");
            for (float radius : read<float>(model_.particle_radii, per_world_))
                if (std::isnan(radius) || radius < 0.0f)
                    throw py::value_error("particle radii must be non-negative and not NaN");
        }
        // Body-owned shapes only matter for contacts, which are rejected for body models in step().
        if (model.shape_count && !(model.body_count || model.body_state_count)) {
            const auto bodies = read<int>(model.shape_bodies, model.shape_count);
            for (auto body : bodies)
                if (body >= 0) throw std::runtime_error("Source shape host currently supports static shapes only");
        }
        auto allocate = [&](std::size_t bytes) { return driver_->allocate(bytes); };
        // SolverNewton::initialize fills this history vector even when no hard contacts are active.
        hard_previous_count_ = initialized_cache(1, 4, SourceCacheType::Integer);
        solution_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        rhs_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        previous_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        target_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        // initialize 10db31..10dbce creates drag geometry/cache before the four scalar diagonal caches.
        precompute_drag();
        base_diagonal_ = initialized_cache(count_, 4, SourceCacheType::Scalar);
        diagonal_ = initialized_cache(count_, 4, SourceCacheType::Scalar);
        collision_stiffness_ = initialized_cache(count_, 4, SourceCacheType::Scalar);
        scalar_inverse_ = initialized_cache(count_, 4, SourceCacheType::Scalar);
        blocks_ = initialized_cache(count_, 36, SourceCacheType::Matrix3);
        preconditioner_blocks_ = initialized_cache(count_, 36, SourceCacheType::Matrix3);
        inverse_ = preconditioner_blocks_;
        zero_ = particle_kind_ = 0;
        body_count_ = model_.body_count;
        body_state_count_ = model_.body_state_count ? model_.body_state_count : body_count_ * (count_ / per_world_);
        // The actual body storage precedes CPU matrix-template uploads and all CG/self caches.
        precompute_affine_blocks();
        coefficient_world_ = 0;
        std::vector<int> local_ids(per_world_, 0), ids(count_);
        if (model.particle_world.size)
            check(cuMemcpyDtoH(local_ids.data(), model.particle_world.ptr, per_world_ * 4), "cuMemcpyDtoH world IDs");
        // SolverNewton::precompute_matrices 1070e8..107207 remaps arbitrary labels (including -1) in first-seen
        // order, then 10b79c offsets each replicated template by its number of distinct local world labels.
        std::unordered_map<int, int> labels;
        for (auto& value : local_ids) {
            auto found = labels.emplace(value, static_cast<int>(labels.size()));
            value = found.first->second;
        }
        group_count_ = (count_ / per_world_) * labels.size();
        particles_per_group_ = static_cast<unsigned>(count_ / group_count_);
        bool contiguous = count_ % group_count_ == 0;
        for (std::size_t i = 0; i < count_; ++i) {
            ids[i] = static_cast<int>((i / per_world_) * labels.size()) + local_ids[i % per_world_];
            contiguous = contiguous && ids[i] == static_cast<int>(i / particles_per_group_);
        }
        if (!contiguous) {
            coefficient_world_ = allocate(count_ * 4);
            check(cuMemcpyHtoD(coefficient_world_, ids.data(), count_ * 4), "cuMemcpyHtoD normalized world IDs");
        }
        load("start", "kernel15initialize_stepE");
        load("rhs", "kernel14initialize_rhsE");
        load("blocks", "kernel25initialize_block_diagonalE");
        load("inverse", "kernel27invert_block_preconditionerE");
        load("scalar_inverse", "kernel30prepare_inverse_preconditionerE");
        load("precondition", "kernel23precondition_and_reduceIN3glm");
        load("scalar_precondition", "kernel23precondition_and_reduceIf");
        load("direction", "kernel19update_cg_directionE");
        load("multiply", "kernel26multiply_matrix_and_reduceINS_17BlockNonZeroEntry");
        load("scalar_multiply", "kernel26multiply_matrix_and_reduceINS_12NonZeroEntryEf");
        load("scalar_block_multiply", "kernel26multiply_matrix_and_reduceINS_12NonZeroEntryEN3glm");
        load("update", "kernel28update_solution_and_residualEP");
        load("apply", "kernel20apply_nonlinear_stepE");
        load("velocity", "kernel15update_velocityE");
        load("soft_contact", "kernel27evaluate_soft_contact_forceE");
        load("soft_contact_product", "kernel42multiply_soft_contact_hessian_off_diagonalE");
        rolling_ = false;
        if (model_.body_count) {
            // The original launches the rolling/torsional kernels only when some shape has such friction
            // (captured: none with all-zero coefficients, all three with Newton's defaults).
            for (auto span : {model_.shape_rolling_frictions, model_.shape_torsional_frictions})
                if (span.ptr && span.size >= model_.shape_count)
                    for (float value : read<float>(span, model_.shape_count)) rolling_ = rolling_ || value != 0.0f;
            if (rolling_) require(model_.body_inertia_tensors, model_.body_count, "body_inertia_tensors");
            load("rigid_force", "kernel22evaluate_contact_forceE");
            load("rigid_tangent", "kernel24evaluate_contact_tangentE");
            load("rolling_force", "kernel30evaluate_rolling_contact_forceE");
            load("rolling_preconditioner", "kernel34add_rolling_contact_preconditionerE");
            load("rolling_tangent", "kernel32multiply_rolling_contact_tangentE");
        }
        if (model_.shape_count) {
            load("surface_force", "kernel30evaluate_surface_contact_forceE");
            load("surface_stiffness", "kernel35add_surface_contact_stiffness_scaleE");
            load("surface_preconditioner", "kernel34add_surface_contact_preconditionerE");
            load("surface_tangent", "kernel32multiply_surface_contact_tangentE");
        }
        if (!model_.body_count) {
            // Original initialize retains the empty cable/body CSR before precompute_matrices.
            affine_cable_offsets_ = upload(std::vector<std::size_t>{0});
            affine_cable_ids_ = 0;
        }
        precompute_springs();
        precompute_cloth();
        precompute_bodies();
        precompute_cables();
        // The original retains row counts even for an empty non-diagonal pattern (also without fluid).
        if (!row_count_) row_count_ = upload(std::vector<int>(count_, 0));
        residual_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        direction_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        z_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        product_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        contact_product_ = initialized_cache(count_, 12, SourceCacheType::Vector3);
        denominator_ = initialized_cache(999 * group_count_, 4, SourceCacheType::Scalar);
        numerator_ = initialized_cache(999 * group_count_, 4, SourceCacheType::Scalar);
        precompute_collision_bvhs();
        precompute_self_particle_pairs();
        precompute_fluid();
        precompute_granular();
        if (body_count_) {
            load("hard_initialize", "kernel24initialize_hard_contactsE");
            load("hard_evaluate", "kernel22evaluate_hard_contactsE");
            load("hard_update", "kernel25update_hard_contact_dualsE");
            load("hard_snapshot", "kernel22snapshot_hard_contactsE");
        }
    }

    void reserve_rigid_contact_capacity(std::size_t capacity)
    {
        if (!driver_ || capacity <= hard_capacity_) return;
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        if (!hard_previous_count_) {
            hard_previous_count_ = driver_->allocate(4);
            check(cuMemsetD8(hard_previous_count_, 0, 4), "cuMemsetD8 hard previous count");
        }
        auto resize = [&](std::uint64_t& pointer, std::size_t stride) {
            const auto next = driver_->allocate(capacity * stride);
            check(cuMemsetD8(next + hard_capacity_ * stride, 0, (capacity - hard_capacity_) * stride),
                  "cuMemsetD8 hard capacity tail");
            if (pointer) {
                check(cuMemcpyDtoD(next, pointer, hard_capacity_ * stride), "cuMemcpyDtoD hard capacity");
                driver_->release(pointer);
            }
            pointer = next;
        };
        resize(hard_penalty_, 4);
        resize(hard_dual_, 12);
        resize(hard_anchor_, 12);
        resize(hard_previous_penalty_, 4);
        resize(hard_previous_dual_, 12);
        resize(hard_previous_normal_, 12);
        hard_capacity_ = capacity;
    }

    void step(const State& in, const State& out, const Control& control, const Contact& contact, float dt,
              std::uintptr_t stream)
    {
        if (!driver_) throw std::runtime_error("initialize() must be called before step()");
        if (!count_) return;
        if (!(dt > 0.0f) || !std::isfinite(dt)) throw py::value_error("dt must be finite and positive");
        validate_step_config();
        const bool self = config.enable_self_collision && self_pp_.capacity;
        const bool pd = config.nonlinear_solver == NonlinearSolver::PD_NEWTON;
        const bool drag = drag_count_ && config.air_density > 0.0f;
        const bool surface = contact.soft_max_count && contact.soft_indices.size && contact.soft_barycentric.size;
        const bool particle_contact = contact.soft_max_count && (!surface || contact.soft_particle_only_shapes.size);
        const bool contact_product = particle_contact && config.enable_collision_hessian_non_diagonal;
        const bool bodies = body_count_ != 0;
        if (self && surface && (fluid_rows_ || granular_points_))
            throw std::runtime_error("Self-collision combined with other physics has not been captured");
        const auto rigidity = config.affine_body_rigidity_model;
        const bool so3 = bodies && rigidity == AffineBodyRigidityModel::SO3_AUGMENTED_LAGRANGIAN;
        const bool six_springs = bodies && rigidity == AffineBodyRigidityModel::SIX_SPRINGS;
        const bool constitutive = bodies && !so3 && !six_springs;
        if (self && bodies && (!so3 || body_spring_total_ || distance_total_ || point_line_total_ || drive_total_ ||
                              cable_count_ || fluid_rows_ || (contact.max_count && config.rigid_contact_hard)))
            throw std::runtime_error("This affine self-collision constraint/rigidity branch has not been captured");
        if (bodies && surface)
            throw std::runtime_error("Requested affine-body scheduling branch has not been implemented");
        if (bodies && !so3 && (spring_count_ || triangle_count_ || edge_count_ || body_spring_total_ ||
                              distance_total_ || point_line_total_ || drive_total_ ||
                              cable_count_ || contact.max_count || contact.soft_max_count || fluid_rows_))
            throw std::runtime_error("Other affine rigidity models combined with constraints have not been captured");
        const float alpha = config.constraint_alpha;
        const bool rigid = bodies && contact.max_count && contact.count.size;
        const bool body_tangent = (bodies && alpha > 0.0f && !six_springs) || rigid || cable_count_ || drive_total_;
        const bool block = !pd || self || surface || contact_product || bending_damping_ || tetrahedron_count_ || drag ||
                           body_tangent || fluid_rows_ || granular_points_;
        // The original ignores the body-block option when PD selects the scalar matrix branch.
        const bool body_block = bodies && block && config.affine_body_block_preconditioner;
        if (body_block && (body_spring_total_ || distance_total_ || point_line_total_ || drive_total_))
            throw std::runtime_error("Affine body blocks combined with body constraints have not been captured");
        const bool extra_product = self || surface || contact_product || bending_damping_ || tetrahedron_count_ || drag ||
                                   body_tangent || fluid_rows_ || granular_points_;
        const bool hard = rigid && config.rigid_contact_hard;
        const bool contact_block = hard && body_block && config.affine_body_contact_block_preconditioner;
        if (hard && config.rigid_contact_history && !contact.match_index.size)
            throw py::value_error("hard-contact history requires collision match indices");
        // Joint/contact ordering is captured in example_basic_joints; plain constraints still lack that capture.
        if ((body_spring_total_ || distance_total_ || point_line_total_ || drive_total_) &&
            pd)
            throw std::runtime_error("Body constraints with PD_NEWTON have not been implemented");
        if ((plain_spring_count_ || plain_line_count_ || distance_total_) && (rigid || contact.soft_max_count))
            throw std::runtime_error("Plain body constraints with contacts have not been captured");
        if ((joint_spring_total_ || joint_line_total_) &&
            config.joint_constraint_mode != JointConstraintMode::AUGMENTED_LAGRANGIAN)
            throw std::runtime_error("Only augmented-Lagrangian joint constraints have been captured");
        const bool rolling = rigid && rolling_;
        if (!drive_total_ && (control.joint_f.size || control.joint_target_q.size ||
            control.joint_target_qd.size || control.joint_drive_velocities.size))
            throw std::runtime_error("Contact/control source host scheduling has not been implemented");
        if (control.tetrahedron_activations.size && control.tetrahedron_activations.size < tetrahedron_count_)
            throw py::value_error("tetrahedron activations are smaller than the tetrahedron state count");
        if (contact.soft_max_count) {
            if (!surface && (contact.soft_indices.size || contact.soft_barycentric.size ||
                             contact.soft_particle_only_shapes.size))
                throw std::runtime_error("Partial surface-contact inputs have not been implemented");
            if (!model_.shape_count) throw py::value_error("Soft contacts require model shapes");
            require(contact.soft_count, 1, "soft_count");
            if (particle_contact && contact.soft_particle.size < contact.soft_max_count)
                throw py::value_error("soft contact arrays are smaller than soft_max_count");
            if (surface) {
                require(contact.soft_indices, contact.soft_max_count, "soft_indices");
                require(contact.soft_barycentric, contact.soft_max_count, "soft_barycentric");
            }
            require(contact.soft_shape, contact.soft_max_count, "soft_shape");
            require(contact.soft_body_pos, contact.soft_max_count, "soft_body_pos");
            require(contact.soft_body_vel, contact.soft_max_count, "soft_body_vel");
            require(contact.soft_normal, contact.soft_max_count, "soft_normal");
        }
        if (drive_total_) {
            if (control.joint_drive_velocities.size)
                require(control.joint_drive_velocities, drive_total_, "control.joint_drive_velocities");
            const std::size_t worlds = count_ / per_world_;
            require(control.joint_f, model_.joint_dof_count * worlds, "control.joint_f");
            require(control.joint_target_q, model_.joint_target_count * worlds, "control.joint_target_q");
            require(control.joint_target_qd, model_.joint_dof_count * worlds, "control.joint_target_qd");
        }
        require(in.particle_q, count_, "state_in.particle_q");
        require(in.particle_qd, count_, "state_in.particle_qd");
        if (in.particle_f.size) require(in.particle_f, count_, "state_in.particle_f");
        require(out.particle_q, count_, "state_out.particle_q");
        require(out.particle_qd, count_, "state_out.particle_qd");
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        const std::uint64_t null = 0;
        const float zero = 0.0f, inverse_dt = 1.0f / dt, inverse_dt2 = 1.0f / (dt * dt);
        const auto mass = model_.particle_masses.ptr;
        const auto flags = model_.particle_flags.size ? model_.particle_flags.ptr : null;
        // Old host fbf06/101de8 passes a null world map for homogeneous replicated models.
        const auto worlds = model_.world_count <= 1 && model_.particle_world.size ? model_.particle_world.ptr : null;
        const float so3_alpha = alpha * inverse_dt2;
        const float spring_alpha = six_springs ? alpha : zero;
        const float body_so3_alpha = so3 ? so3_alpha : zero;
        // Query the pre-prediction positions once per step, before initialize_step mutates them.
        if (self) begin_self_particle_pairs(in, stream);
        if (cable_count_ && cable_ramping())
            prepare_cable_penalties(stream, false, true);
        if (hard) {
            reserve_rigid_contact_capacity(contact.max_count);
            launch("hard_initialize", contact.max_count, stream, hard_view(contact, in, inverse_dt));
        }
        if (bodies) {
            // SolverNewton::step refreshes the inertial cache from the (possibly updated) body and mass arrays.
            const std::size_t entries = max_entries_ * per_world_;
            launch("refresh_nonzeros", entries, stream, model_.particle_mass_non_diagonal_values.ptr, body_offsets_a_,
                   body_ids_a_, model_.body_masses.ptr, body_offsets_b_, body_ids_b_, body_l1_, body_l2_, entries);
            launch("refresh_diagonals", per_world_, stream, model_.body_masses.ptr, body_diagonal_offsets_,
                   body_diagonal_ids_, body_d1_, body_d2_, per_world_);
            // Only SIX_SPRINGS weights D1/L2. Constitutive models use their matrix-free tangent, not D2.
            launch("start", count_, stream, dt, model_.gravity.ptr, model_.gravity.size, worlds, in.particle_qd.ptr,
                   in.particle_q.ptr, host_diagonal_, body_d1_, spring_alpha, body_d2_, zero, joint_d3_, alpha, zero_, zero,
                   distance_d5_, alpha, mass, flags, body_kind_, previous_, target_, diagonal_, count_, per_world_);
            copy(base_diagonal_, diagonal_, count_ * 4, stream);
            // initialize_body_distance_constraint_state runs on the prediction, before the SO(3) state.
            if (distance_total_)
                launch("distance_initialize", distance_total_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_distance_constraint_indices.ptr, model_.body_distance_constraint_points0.ptr,
                       model_.body_distance_constraint_points1.ptr, distance_w0_, distance_w1_,
                       model_.body_distance_constraint_rest_lengths.ptr, distance_target_, distance_multiplier_,
                       distance_total_, static_cast<std::size_t>(model_.body_distance_constraint_count), per_world_);
            // Derive velocities from the saved pre-prediction positions when the optional control span is absent.
            // The supplied-span path copies into the same internal cache (original captures).
            if (drive_total_) {
                if (control.joint_drive_velocities.size)
                    copy(drive_qd_, control.joint_drive_velocities.ptr, drive_total_ * 4, stream);
                else
                    launch("drive_velocity", drive_total_, stream, joint_view(), previous_, in.particle_qd.ptr,
                           drive_qd_);
            }
            if (so3)
                launch("so3_initialize", body_state_count_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       body_rotation_, body_multiplier_, body_state_count_, body_count_, per_world_);
            if (joint_spring_total_)
                launch("joint_spring_initialize", joint_spring_total_, stream, joint_multiplier_, joint_spring_total_);
            if (joint_line_total_)
                launch("joint_line_initialize", joint_line_total_, stream, in.particle_q.ptr,
                       model_.affine_body_indices.ptr, model_.body_point_line_indices.ptr, point_line_wp_,
                       point_line_we0_, point_line_we1_, model_.body_point_line_endpoints0.ptr,
                       model_.body_point_line_endpoints1.ptr, line_segment_, line_multiplier_, line_projector_,
                       joint_line_total_, static_cast<std::size_t>(model_.body_point_line_count),
                       static_cast<std::size_t>(model_.joint_body_point_line_count), per_world_);
            launch("combine", entries, stream, inverse_dt2, spring_alpha, zero, alpha, zero, alpha,
                   body_l0_, body_l1_, body_l2_, body_zero_ell_, joint_l4_,
                   retained_particle_templates_[2], distance_l6_,
                   scalar_template_, entries);
        } else {
            launch("start", count_, stream, dt, model_.gravity.ptr, model_.gravity.size, worlds, in.particle_qd.ptr,
                   in.particle_q.ptr, host_diagonal_, particle_diagonal_templates_[0], zero,
                   particle_diagonal_templates_[1], zero, particle_diagonal_templates_[2], alpha,
                   particle_diagonal_templates_[3], zero, particle_diagonal_templates_[4], alpha,
                   mass, flags, particle_kind_, previous_, target_, diagonal_, count_, per_world_);
            copy(base_diagonal_, diagonal_, count_ * 4, stream);
        }
        if (drag)
            launch("drag_start", drag_count_, stream, previous_, drag_indices_, drag_normal_, drag_area_,
                   drag_count_, drag_local_count_, per_world_);
        // Actual launches initialize drag before rebuilding Newton's block template, even without self contacts.
        if (!pd && max_entries_)
            launch("block_entries", max_entries_ * count_, stream, scalar_template_, template_row_counts(), per_world_,
                   max_entries_, block_template_, count_);
        for (int iteration = 0; iteration < config.nonlinear_iterations; ++iteration) {
            if (cable_count_) launch("cable_prepare", cable_count_, stream, cable_view(), in.particle_q.ptr);
            // The actual solver restores this cache on every iteration, including contact-free models.
            copy(diagonal_, base_diagonal_, count_ * 4, stream);
            const auto surface_data = surface ? surface_view(contact, in, inverse_dt) : SourceSurfaceView{};
            const auto force = in.particle_f.size ? in.particle_f.ptr : null;
            // With bodies the original couples the inertia through the unscaled mass non-diagonal cache (L1).
            launch("rhs", count_, stream, inverse_dt2, in.particle_q.ptr, target_, mass, template_row_counts(),
                   (bodies || max_entries_) ? body_l1_ : null, max_entries_, force, flags, rhs_, count_,
                   per_world_);
            if (fluid_rows_) accumulate_fluid(in, dt, stream);
            if (granular_points_) accumulate_granular(in, dt, stream);
            if (drag)
                launch("drag_force", drag_count_, stream, in.particle_q.ptr, previous_, drag_indices_, drag_coefficients_,
                       drag_normal_, drag_area_, config.air_density, config.wind_velocity, inverse_dt, rhs_, drag_scalar_,
                       drag_count_, drag_local_count_, per_world_);
            if (surface) launch("surface_force", contact.soft_max_count, stream, surface_data, rhs_);
            if (hard)
                launch("hard_evaluate", contact.max_count, stream, hard_view(contact, in, inverse_dt), rhs_, diagonal_,
                       null, null, null, null, null);
            else if (rigid) rigid_contact(contact, in, inverse_dt, stream, true, null, null, null, null);
            if (rolling) launch("rolling_force", contact.max_count, stream, rolling_view(contact, in, inverse_dt), rhs_);
            if (particle_contact) soft_contact(contact, in, inverse_dt, stream, rhs_, diagonal_, null, null, surface);
            if (self) {
                // Preserve the base for the next iteration; self penalties use this iteration's contact increment.
                copy(self_pp_.stiffness, diagonal_, count_ * 4, stream);
                // Actual full-surface/self calls add to this scale before any self force accumulation.
                if (surface)
                    launch("surface_stiffness", contact.soft_max_count, stream, surface_data, self_pp_.stiffness);
                accumulate_self_particle_pairs(in, stream);
            }
            // Force order (captures + spec): plain body springs (the kernel skips joint springs), distance
            // constraints, AL joint springs, point-lines, joint drive load, angular limits; finally SO(3).
            if (body_spring_total_)
                launch("body_spring_force", body_spring_total_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_spring_indices.ptr, model_.body_spring_points0.ptr, model_.body_spring_points1.ptr,
                       body_spring_w0_, body_spring_w1_, model_.body_spring_stiffnesses.ptr,
                       model_.body_spring_rest_lengths.ptr, so3_alpha,
                       static_cast<std::size_t>(model_.joint_body_spring_count), false, rhs_, body_spring_total_,
                       static_cast<std::size_t>(model_.body_spring_count), per_world_);
            if (distance_total_)
                launch("distance_force", distance_total_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_distance_constraint_indices.ptr, model_.body_distance_constraint_points0.ptr,
                       model_.body_distance_constraint_points1.ptr, distance_w0_, distance_w1_,
                       model_.body_distance_constraint_mass_scales.ptr, distance_target_, distance_multiplier_, so3_alpha,
                       rhs_, distance_total_, static_cast<std::size_t>(model_.body_distance_constraint_count), per_world_);
            if (joint_spring_total_)
                launch("joint_spring_force", joint_spring_total_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_spring_indices.ptr, model_.body_spring_points0.ptr, model_.body_spring_points1.ptr,
                       body_spring_w0_, body_spring_w1_, model_.body_spring_stiffnesses.ptr, joint_multiplier_, so3_alpha,
                       rhs_, joint_spring_total_, static_cast<std::size_t>(model_.body_spring_count),
                       static_cast<std::size_t>(model_.joint_body_spring_count), per_world_);
            // The point-line force kernel receives state_in velocities for its damping term (captured argument).
            if (point_line_total_)
                launch("point_line_force", point_line_total_, stream, in.particle_q.ptr, in.particle_qd.ptr,
                       model_.affine_body_indices.ptr, model_.body_point_line_indices.ptr, point_line_wp_, point_line_we0_,
                       point_line_we1_, model_.body_point_line_endpoints0.ptr, model_.body_point_line_endpoints1.ptr,
                       model_.body_point_line_stiffnesses.ptr, model_.body_point_line_dampings.ptr, so3_alpha,
                       static_cast<std::size_t>(model_.joint_body_point_line_count), false, rhs_, point_line_total_,
                       static_cast<std::size_t>(model_.body_point_line_count), per_world_);
            if (joint_line_total_)
                launch("joint_line_force", joint_line_total_, stream, in.particle_q.ptr,
                       model_.affine_body_indices.ptr, model_.body_point_line_indices.ptr, point_line_wp_,
                       point_line_we0_, point_line_we1_, model_.body_point_line_endpoints0.ptr,
                       model_.body_point_line_endpoints1.ptr, model_.body_point_line_stiffnesses.ptr,
                       line_segment_, line_multiplier_, line_projector_, so3_alpha, rhs_, joint_line_total_,
                       static_cast<std::size_t>(model_.body_point_line_count),
                       static_cast<std::size_t>(model_.joint_body_point_line_count), per_world_);
            if (drive_total_) {
                launch("drive_load", drive_total_, stream, in.particle_q.ptr, previous_, drive_qd_, drive_angle_,
                       drive_initialized_, model_.affine_body_indices.ptr, model_.joint_drive_types.ptr,
                       model_.joint_drive_body_indices.ptr, model_.joint_drive_parent_origins.ptr,
                       model_.joint_drive_parent_axis_points.ptr, model_.joint_drive_parent_reference_points.ptr,
                       drive_w_po_, drive_w_co_, drive_w_pa_, drive_w_pr_, drive_w_cr_, model_.joint_drive_dof_indices.ptr,
                       model_.joint_drive_target_indices.ptr, model_.joint_target_stiffnesses.ptr,
                       model_.joint_target_dampings.ptr, model_.joint_effort_limits.ptr, model_.joint_target_modes.ptr,
                       model_.joint_passive_dampings.ptr, control.joint_f.ptr, control.joint_target_q.ptr,
                       control.joint_target_qd.ptr, rhs_, drive_total_, static_cast<std::size_t>(model_.joint_drive_count),
                       per_world_, static_cast<std::size_t>(model_.joint_dof_count),
                       static_cast<std::size_t>(model_.joint_target_count), inverse_dt);
                if (armature_) joint_armature(in, inverse_dt, stream, null, rhs_, null);
                if (angular_limits_)
                    launch("angular_limits", drive_total_, stream, joint_view(), limit_view(), in.particle_q.ptr,
                           previous_, drive_angle_, drive_initialized_, inverse_dt, null, rhs_, null);
            }
            // Contacts precede the joint forces/drives; SO(3) follows those constraint forces.
            if (cable_count_)
                launch("cable_evaluate", cable_count_, stream, cable_view(), in.particle_q.ptr, previous_, inverse_dt,
                       null, rhs_, null);
            if (so3 && so3_alpha > 0.0f)
                launch("so3_force", body_state_count_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_masses.ptr, body_rotation_, body_multiplier_, so3_alpha, rhs_, body_state_count_,
                       body_count_, per_world_);
            if (six_springs && so3_alpha > 0.0f)
                launch("rigidity_spring_force", body_state_count_, stream, in.particle_q.ptr,
                       model_.affine_body_indices.ptr, model_.body_masses.ptr, so3_alpha, rhs_, body_state_count_,
                       body_count_, per_world_);
            if (constitutive && so3_alpha > 0.0f)
                launch("constitutive_force", body_state_count_, stream, in.particle_q.ptr,
                       model_.affine_body_indices.ptr, model_.body_masses.ptr, so3_alpha, rigidity, rhs_,
                       body_state_count_, body_count_, per_world_);
            if (spring_count_)
                launch("spring_force", spring_count_, stream, in.particle_q.ptr, model_.spring_indices.ptr,
                       model_.spring_stiffnesses.ptr, model_.spring_rest_lengths.ptr, rhs_, spring_count_,
                       static_cast<std::size_t>(model_.spring_count), per_world_);
            if (triangle_count_)
                launch("stretch_force", triangle_count_, stream, in.particle_q.ptr, model_.triangle_rest_areas.ptr,
                       model_.triangle_inv_dms.ptr, model_.triangle_indices.ptr, model_.triangle_aniso_stiffnesses.ptr,
                       rhs_, triangle_count_, static_cast<std::size_t>(model_.triangle_count), per_world_);
            if (tetrahedron_count_)
                launch("tetrahedron_force", tetrahedron_count_, stream, in.particle_q.ptr, previous_,
                       model_.tetrahedron_indices.ptr, model_.tetrahedron_inverse_dms.ptr, model_.tetrahedron_materials.ptr,
                       tetrahedron_volumes_, control.tetrahedron_activations.size ? control.tetrahedron_activations.ptr : null,
                       inverse_dt, rhs_, tetrahedron_count_, static_cast<std::size_t>(model_.tetrahedron_count), per_world_);
            if (edge_count_)
                launch("bending_force", edge_count_, stream, in.particle_q.ptr, previous_, model_.edge_rest_areas.ptr,
                       model_.edge_bending_cots.ptr, model_.edge_indices.ptr, model_.edge_bending_properties.ptr,
                       inverse_dt, rhs_, edge_count_, static_cast<std::size_t>(model_.edge_count), per_world_);
            if (!block) {
                // The original contact-free PD path keeps the constant scalar spring matrix and uses 1 / D.
                launch("scalar_inverse", count_, stream, diagonal_, mass, flags, scalar_inverse_, count_, per_world_);
            } else {
                launch("blocks", count_, stream, diagonal_, blocks_, pd ? preconditioner_blocks_ : null, count_);
                if (!pd && max_entries_)
                    copy(block_entries_, block_template_, max_entries_ * count_ * 40, stream);
                if (!pd && triangle_count_)
                    launch("membrane_hessian", triangle_count_, stream, in.particle_q.ptr, model_.triangle_indices.ptr,
                           model_.triangle_inv_dms.ptr, model_.triangle_rest_areas.ptr,
                           model_.triangle_aniso_stiffnesses.ptr, blocks_, row_count_, block_entries_, max_entries_,
                           triangle_count_, static_cast<std::size_t>(model_.triangle_count), per_world_, count_);
                if (!pd && spring_count_)
                    launch("spring_hessian", spring_count_, stream, in.particle_q.ptr, model_.spring_indices.ptr,
                           model_.spring_stiffnesses.ptr, model_.spring_rest_lengths.ptr, blocks_, row_count_, block_entries_,
                           max_entries_, spring_count_, static_cast<std::size_t>(model_.spring_count), per_world_, count_);
                if (!pd && six_springs && so3_alpha > 0.0f)
                    launch("rigidity_spring_hessian", body_state_count_, stream, in.particle_q.ptr,
                           model_.affine_body_indices.ptr, model_.body_masses.ptr, so3_alpha, blocks_, row_count_,
                           block_entries_, max_entries_, body_state_count_, body_count_, per_world_, count_);
                if (!pd && plain_spring_count_)
                    launch("body_spring_hessian", body_spring_total_, stream, in.particle_q.ptr,
                           model_.affine_body_indices.ptr, model_.body_spring_indices.ptr, model_.body_spring_points0.ptr,
                           model_.body_spring_points1.ptr, body_spring_w0_, body_spring_w1_,
                           model_.body_spring_stiffnesses.ptr, model_.body_spring_rest_lengths.ptr, blocks_, row_count_,
                           block_entries_, max_entries_, body_spring_total_,
                           static_cast<std::size_t>(model_.body_spring_count), per_world_, count_);
                if (!pd && plain_line_count_)
                    launch("point_line_hessian", point_line_total_, stream, in.particle_q.ptr,
                           model_.affine_body_indices.ptr, model_.body_point_line_indices.ptr, point_line_wp_,
                           point_line_we0_, point_line_we1_, model_.body_point_line_endpoints0.ptr,
                           model_.body_point_line_endpoints1.ptr, model_.body_point_line_stiffnesses.ptr, so3_alpha,
                           static_cast<std::size_t>(model_.joint_body_point_line_count), !joint_line_total_,
                           blocks_, row_count_, block_entries_, max_entries_, point_line_total_,
                           static_cast<std::size_t>(model_.body_point_line_count), per_world_, count_);
                if (!pd && joint_line_total_)
                    launch("joint_line_hessian", joint_line_total_, stream, model_.affine_body_indices.ptr,
                           model_.body_point_line_indices.ptr, point_line_wp_, point_line_we0_, point_line_we1_,
                           model_.body_point_line_stiffnesses.ptr, line_segment_, line_projector_, so3_alpha,
                           blocks_, row_count_, block_entries_, max_entries_, joint_line_total_,
                           static_cast<std::size_t>(model_.body_point_line_count),
                           static_cast<std::size_t>(model_.joint_body_point_line_count), per_world_, count_);
                // The original retains A and inverts its separate cache in place, even without corrections.
                if (!pd) copy(preconditioner_blocks_, blocks_, count_ * 36, stream);
                if (contact_block) clear(affine_blocks_, body_state_count_ * 144 * 4, stream);
                if (hard)
                    launch("hard_evaluate", contact.max_count, stream, hard_view(contact, in, inverse_dt),
                           null, null, null, null, blocks_, preconditioner_blocks_,
                           contact_block ? affine_blocks_ : null);
                else if (rigid && config.enable_collision_hessian_non_diagonal)
                    rigid_contact(contact, in, inverse_dt, stream, false, null, null, blocks_, preconditioner_blocks_);
                if (particle_contact && (!pd || config.enable_collision_hessian_non_diagonal))
                    soft_contact(contact, in, inverse_dt, stream, null, null, blocks_, preconditioner_blocks_, surface);
                // Without the full body block, the original adds SO(3) before tetrahedra/bending/fluid.
                if (constitutive && so3_alpha > 0.0f)
                    launch("constitutive_preconditioner", body_state_count_, stream, in.particle_q.ptr,
                           model_.affine_body_indices.ptr, model_.body_masses.ptr, so3_alpha, rigidity,
                           preconditioner_blocks_, body_state_count_, body_count_, per_world_);
                if (so3 && !body_block && so3_alpha > 0.0f)
                    launch("so3_preconditioner", body_state_count_, stream, model_.affine_body_indices.ptr,
                           model_.body_masses.ptr, body_rotation_, so3_alpha, preconditioner_blocks_, body_state_count_,
                           body_count_, per_world_);
                if (tetrahedron_count_)
                    launch("tetrahedron_preconditioner", tetrahedron_count_, stream, in.particle_q.ptr,
                           model_.tetrahedron_indices.ptr, model_.tetrahedron_inverse_dms.ptr, model_.tetrahedron_materials.ptr,
                           tetrahedron_volumes_, inverse_dt, preconditioner_blocks_, tetrahedron_count_,
                           static_cast<std::size_t>(model_.tetrahedron_count), per_world_);
                if (bending_damping_)
                    launch("bending_preconditioner", edge_count_, stream, in.particle_q.ptr, model_.edge_rest_areas.ptr,
                           model_.edge_bending_cots.ptr, model_.edge_indices.ptr, model_.edge_bending_properties.ptr,
                           inverse_dt, preconditioner_blocks_, edge_count_,
                           static_cast<std::size_t>(model_.edge_count), per_world_);
                // Actual self/fluid captures add self Hessians before the fluid contribution.
                if (self)
                    launch("self_preconditioner", count_, stream, self_pp_.diagonal, preconditioner_blocks_, count_);
                if (fluid_rows_)
                    launch_width("fluid_12add_diagonal", count_, 128, stream, fluid_diagonal_, preconditioner_blocks_,
                                 static_cast<int>(count_));
                if (granular_points_)
                    launch_width("granular_12add_diagonal", count_, 128, stream, granular_diagonal_,
                                 preconditioner_blocks_, static_cast<int>(count_));
                if (surface)
                    launch("surface_preconditioner", contact.soft_max_count, stream, surface_data, preconditioner_blocks_);
                if (body_block) {
                    if (rolling)
                        launch("rolling_preconditioner", contact.max_count, stream, rolling_view(contact, in, inverse_dt),
                               preconditioner_blocks_);
                    // The body assembly adds SO(3) and cable terms itself, before the per-particle copies do.
                    launch(pd ? "affine_build_scalar" : "affine_build", body_state_count_, stream,
                           model_.affine_body_indices.ptr, model_.body_masses.ptr, mass, flags, preconditioner_blocks_,
                           row_count_, pd ? scalar_template_ : block_entries_, max_entries_, pd ? per_world_ : count_,
                           body_rotation_, body_so3_alpha, cable_view(), affine_cable_offsets_, affine_cable_ids_, inverse_dt,
                           affine_enabled_, contact_block ? affine_blocks_ : null, affine_blocks_, affine_valid_,
                           body_state_count_, body_count_, per_world_);
                }
                if (so3 && body_block && so3_alpha > 0.0f)
                    launch("so3_preconditioner", body_state_count_, stream, model_.affine_body_indices.ptr,
                           model_.body_masses.ptr, body_rotation_, so3_alpha, preconditioner_blocks_, body_state_count_,
                           body_count_, per_world_);
                if (drive_total_) {
                    launch("drive_preconditioner", drive_total_, stream, in.particle_q.ptr, model_.affine_body_indices.ptr,
                           model_.joint_drive_types.ptr, model_.joint_drive_body_indices.ptr,
                           model_.joint_drive_parent_origins.ptr, model_.joint_drive_parent_axis_points.ptr,
                           model_.joint_drive_parent_reference_points.ptr, drive_w_po_, drive_w_co_, drive_w_pa_,
                           drive_w_pr_, drive_w_cr_, model_.joint_drive_dof_indices.ptr, model_.joint_target_modes.ptr,
                           model_.joint_passive_dampings.ptr, model_.joint_target_dampings.ptr, inverse_dt,
                           preconditioner_blocks_, drive_total_, static_cast<std::size_t>(model_.joint_drive_count),
                           per_world_);
                    if (armature_) joint_armature(in, inverse_dt, stream, null, null, preconditioner_blocks_);
                    if (angular_limits_)
                        launch("angular_limits", drive_total_, stream, joint_view(), limit_view(), in.particle_q.ptr,
                               previous_, drive_angle_, drive_initialized_, inverse_dt, null, null, preconditioner_blocks_);
                }
                if (cable_count_)
                    launch("cable_evaluate", cable_count_, stream, cable_view(), in.particle_q.ptr, previous_, inverse_dt,
                           null, null, preconditioner_blocks_);
                if (rolling && !body_block)
                    launch("rolling_preconditioner", contact.max_count, stream, rolling_view(contact, in, inverse_dt),
                           preconditioner_blocks_);
                if (drag)
                    launch("drag_preconditioner", drag_count_, stream, drag_indices_, drag_normal_, drag_scalar_,
                           preconditioner_blocks_, drag_count_, drag_local_count_, per_world_);
                launch("inverse", count_, stream, preconditioner_blocks_,
                       mass, flags, inverse_, count_, per_world_);
            }
            copy(residual_, rhs_, count_ * 12, stream);
            clear(solution_, count_ * 12, stream);
            clear(numerator_, config.linear_iterations * group_count_ * 4, stream);
            clear(denominator_, config.linear_iterations * group_count_ * 4, stream);
            for (int k = 0; k < config.linear_iterations; ++k) {
                const auto numerator = numerator_ + k * group_count_ * 4;
                const auto previous_numerator = k ? numerator - group_count_ * 4 : null;
                const auto denominator = denominator_ + k * group_count_ * 4;
                const auto per_world = particles_per_group_;
                if (body_block) {
                    launch("block_apply", count_, stream, inverse_, residual_, z_, count_);
                    launch("affine_apply", body_state_count_, stream, model_.affine_body_indices.ptr, affine_blocks_,
                           affine_valid_, residual_, z_, body_state_count_, body_count_, per_world_);
                }
                launch(block ? "precondition" : "scalar_precondition", count_, stream,
                       block ? inverse_ : scalar_inverse_, residual_, z_, body_block, coefficient_world_, per_world,
                       numerator, count_);
                launch("direction", count_, stream, k, z_, coefficient_world_, per_world, numerator,
                       previous_numerator, direction_, count_);
                if (extra_product) clear(contact_product_, count_ * 12, stream);
                if (tetrahedron_count_)
                    launch("tetrahedron_tangent", tetrahedron_count_, stream, in.particle_q.ptr, direction_,
                           model_.tetrahedron_indices.ptr, model_.tetrahedron_inverse_dms.ptr, model_.tetrahedron_materials.ptr,
                           tetrahedron_volumes_, inverse_dt, contact_product_, tetrahedron_count_,
                           static_cast<std::size_t>(model_.tetrahedron_count), per_world_);
                // Captured joint/contact order: SO(3), rigid tangent, soft off-diagonal, drive/limits, rolling.
                if (so3 && so3_alpha > 0.0f)
                    launch("so3_tangent", body_state_count_, stream, direction_, model_.affine_body_indices.ptr,
                           model_.body_masses.ptr, body_rotation_, so3_alpha, contact_product_, body_state_count_,
                           body_count_, per_world_);
                if (constitutive && so3_alpha > 0.0f)
                    launch("constitutive_tangent", body_state_count_, stream, in.particle_q.ptr, direction_,
                           model_.affine_body_indices.ptr, model_.body_masses.ptr, so3_alpha, rigidity, contact_product_,
                           body_state_count_, body_count_, per_world_);
                // Actual body/cloth calls add SO(3) before the bending contribution.
                if (bending_damping_)
                    launch("bending_tangent", edge_count_, stream, in.particle_q.ptr, direction_,
                           model_.edge_rest_areas.ptr, model_.edge_bending_cots.ptr, model_.edge_indices.ptr,
                           model_.edge_bending_properties.ptr, inverse_dt, contact_product_, edge_count_,
                           static_cast<std::size_t>(model_.edge_count), per_world_);
                // Actual affine/self captures accumulate the SO(3) tangent before the self tangent.
                if (self) multiply_self_particle_pairs(stream);
                if (surface)
                    launch("surface_tangent", contact.soft_max_count, stream, surface_data, direction_, contact_product_);
                if (fluid_rows_)
                    launch_width("fluid_13multiply_rows", fluid_rows_, 128, stream, fluid_view(dt), fluid_gradients_,
                                 fluid_weights_, direction_, contact_product_);
                if (granular_points_) multiply_granular(dt, stream);
                if (hard)
                    launch("hard_evaluate", contact.max_count, stream, hard_view(contact, in, inverse_dt),
                           null, null, direction_, contact_product_, null, null, null);
                else if (rigid && config.enable_collision_hessian_non_diagonal)
                    rigid_contact(contact, in, inverse_dt, stream, false, direction_, contact_product_, null, null);
                if (contact_product) soft_contact_product(contact, in, inverse_dt, stream, surface);
                if (drive_total_) {
                    launch("drive_tangent", drive_total_, stream, in.particle_q.ptr, direction_,
                           model_.affine_body_indices.ptr, model_.joint_drive_types.ptr, model_.joint_drive_body_indices.ptr,
                           model_.joint_drive_parent_origins.ptr, model_.joint_drive_parent_axis_points.ptr,
                           model_.joint_drive_parent_reference_points.ptr, drive_w_po_, drive_w_co_, drive_w_pa_,
                           drive_w_pr_, drive_w_cr_, model_.joint_drive_dof_indices.ptr, model_.joint_target_modes.ptr,
                           model_.joint_passive_dampings.ptr, model_.joint_target_dampings.ptr, inverse_dt,
                           contact_product_, drive_total_, static_cast<std::size_t>(model_.joint_drive_count), per_world_);
                    if (armature_) joint_armature(in, inverse_dt, stream, direction_, contact_product_, null);
                    if (angular_limits_)
                        launch("angular_limits", drive_total_, stream, joint_view(), limit_view(), in.particle_q.ptr,
                               previous_, drive_angle_, drive_initialized_, inverse_dt, direction_, contact_product_,
                               null);
                }
                if (cable_count_)
                    launch("cable_evaluate", cable_count_, stream, cable_view(), in.particle_q.ptr, previous_, inverse_dt,
                           direction_, contact_product_, null);
                if (rolling)
                    launch("rolling_tangent", contact.max_count, stream, rolling_view(contact, in, inverse_dt),
                           direction_, contact_product_);
                if (drag)
                    launch("drag_tangent", drag_count_, stream, direction_, drag_indices_, drag_normal_, drag_scalar_,
                           contact_product_, drag_count_, drag_local_count_, per_world_);
                // The current original passes nullptr when there is no matrix-free material/contact tangent.
                // Adding a zero buffer instead would introduce an observable signed-zero operation.
                launch(pd ? (block ? "scalar_block_multiply" : "scalar_multiply") : "multiply",
                       count_, stream, row_count_, pd ? scalar_template_ : block_entries_, max_entries_,
                       block ? blocks_ : diagonal_, direction_, extra_product ? contact_product_ : null,
                       product_, coefficient_world_, per_world, denominator, count_,
                       pd ? per_world_ : count_);
                launch("update", count_, stream, coefficient_world_, per_world, numerator, denominator, direction_,
                       product_, solution_, residual_, count_);
            }
            // The old host updates state_in.q in place, even when state_out owns a separate allocation.
            if (fluid_rows_) limit_fluid(dt, stream);
            launch("apply", count_, stream, in.particle_q.ptr, out.particle_q.ptr, solution_, count_);
            if (cable_count_ && cable_ramping())
                launch("cable_penalty_update", cable_count_, stream, cable_view(), out.particle_q.ptr,
                       config.cable_linear_beta, config.cable_angular_beta);
            if (hard) launch("hard_update", contact.max_count, stream, hard_view(contact, out, inverse_dt));
            if (distance_total_)
                launch("distance_update", distance_total_, stream, out.particle_q.ptr, model_.affine_body_indices.ptr,
                       model_.body_distance_constraint_indices.ptr, model_.body_distance_constraint_points0.ptr,
                       model_.body_distance_constraint_points1.ptr, distance_w0_, distance_w1_,
                       model_.body_distance_constraint_rest_lengths.ptr, distance_target_, distance_multiplier_,
                       distance_total_, static_cast<std::size_t>(model_.body_distance_constraint_count), per_world_);
            if (so3 && so3_alpha > 0.0f) {
                // The multiplier advances only after iteration c (from 1) == primal iterations, never the last one.
                const int c = iteration + 1;
                const bool advance = c < config.nonlinear_iterations && c == config.affine_body_rigidity_primal_iterations;
                launch("so3_update", body_state_count_, stream, out.particle_q.ptr, model_.affine_body_indices.ptr,
                       body_rotation_, body_multiplier_, advance, body_state_count_, body_count_, per_world_);
            }
            // Joint multipliers advance after iterations whose count is a multiple of the primal iteration count,
            // never after the last one (captured: iterations 2, 4, ..., 18 of 20 with primal = 2).
            if (joint_spring_total_) {
                const int c = iteration + 1, primal = std::max(config.joint_constraint_primal_iterations, 1);
                if (c < config.nonlinear_iterations && c % primal == 0)
                    launch("joint_spring_update", joint_spring_total_, stream, out.particle_q.ptr,
                           model_.affine_body_indices.ptr, model_.body_spring_indices.ptr,
                           model_.body_spring_points0.ptr, model_.body_spring_points1.ptr, body_spring_w0_,
                           body_spring_w1_, joint_multiplier_, joint_spring_total_,
                           static_cast<std::size_t>(model_.body_spring_count),
                           static_cast<std::size_t>(model_.joint_body_spring_count), per_world_);
            }
            if (joint_line_total_) {
                const int c = iteration + 1, primal = std::max(config.joint_constraint_primal_iterations, 1);
                const bool advance = c < config.nonlinear_iterations && c % primal == 0;
                launch("joint_line_update", joint_line_total_, stream, out.particle_q.ptr,
                       model_.affine_body_indices.ptr, model_.body_point_line_indices.ptr, point_line_wp_,
                       point_line_we0_, point_line_we1_, model_.body_point_line_endpoints0.ptr,
                       model_.body_point_line_endpoints1.ptr, line_segment_, line_multiplier_, line_projector_,
                       advance, joint_line_total_, static_cast<std::size_t>(model_.body_point_line_count),
                       static_cast<std::size_t>(model_.joint_body_point_line_count), per_world_);
            }
            copy(in.particle_q.ptr, out.particle_q.ptr, count_ * 12, stream);
        }
        if (!hard) clear(hard_previous_count_, 4, stream);
        if (!config.nonlinear_iterations) copy(out.particle_q.ptr, in.particle_q.ptr, count_ * 12, stream);
        if (granular_points_) commit_granular(out, dt, stream);
        if (hard) launch("hard_snapshot", contact.max_count, stream, hard_view(contact, in, inverse_dt));
        launch("velocity", count_, stream, inverse_dt, previous_, out.particle_q.ptr, out.particle_qd.ptr, count_);
        if (drive_total_)
            launch("drive_angle_update", drive_total_, stream, out.particle_q.ptr, drive_angle_, drive_initialized_,
                   model_.affine_body_indices.ptr, model_.joint_drive_types.ptr, model_.joint_drive_body_indices.ptr,
                   model_.joint_drive_parent_origins.ptr, model_.joint_drive_parent_axis_points.ptr,
                   model_.joint_drive_parent_reference_points.ptr, drive_w_po_, drive_w_co_, drive_w_pa_, drive_w_pr_,
                   drive_w_cr_, drive_total_, static_cast<std::size_t>(model_.joint_drive_count), per_world_);
    }

    // Clears the persistent angle-branch flags: all drives, or those selected by a per-drive mask.
    void reset_joint_drive_state(std::uintptr_t stream, Span mask)
    {
        if (!driver_ || !drive_total_) return;
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        if (!mask.size) clear(drive_initialized_, drive_total_ * 4, stream);
        else {
            require(mask, drive_total_, "mask");
            launch("drive_reset", drive_total_, stream, mask.ptr, drive_initialized_, drive_total_);
        }
    }

    void reset_cable_penalty_state(std::uintptr_t stream, Span mask)
    {
        validate_cable_config();
        if (mask.size && mask.size != cable_count_)
            throw py::value_error("cable penalty reset mask must match the cable state count");
        if (!driver_ || !cable_count_) return;
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        prepare_cable_penalties(stream, true, false, mask.size ? mask.ptr : 0);
    }

    void copy_cable_penalties(Span output, std::uintptr_t stream)
    {
        validate_cable_config();
        if (output.size != cable_count_)
            throw py::value_error("cable penalty output must match the cable state count");
        if (!driver_ || !cable_count_) return;
        ContextScope scope(reinterpret_cast<CUcontext>(driver_->context()));
        prepare_cable_penalties(stream, false, false);
        copy(output.ptr, cable_penalty_, cable_count_ * 16, stream);
    }

    py::dict launch_counts() const
    {
        py::dict result;
        for (const auto& item : launches_) result[py::str(item.first)] = item.second;
        return result;
    }
};

PYBIND11_MODULE(_source_solver, module)
{
    module.doc() = "Incremental source-only C++ solver; supported physics is listed in supported_physics";
    module.attr("source_only") = true;
    module.attr("solver_api_ready") = false;
    module.attr("source_digest") = source_digest;
    module.attr("kernel_count") = source_kernels.size();
    module.attr("supported_physics") = py::make_tuple("free_particles_newton", "particle_springs_newton",
                                                     "free_particles_pd_newton", "particle_springs_pd_newton",
                                                     "static_particle_soft_contact_newton",
                                                     "static_particle_soft_contact_pd_newton",
                                                     "anisotropic_membrane_newton", "anisotropic_membrane_pd_newton",
                                                     "cotangent_bending_newton", "cotangent_bending_pd_newton",
                                                     "spring_cloth_newton", "spring_cloth_pd_newton",
                                                     "tetrahedra_newton", "tetrahedra_pd_newton",
                                                     "triangle_drag_newton", "triangle_drag_pd_newton",
                                                     "static_surface_contact_newton", "static_surface_contact_pd_newton",
                                                     "free_affine_body_so3_newton", "free_affine_body_so3_pd_newton",
                                                     "affine_body_rigid_contact_newton",
                                                     "affine_body_rigid_contact_pd_newton", "plain_body_springs_newton",
                                                     "body_distance_constraints_newton",
                                                     "plain_body_point_lines_newton",
                                                     "joint_springs_and_drives_newton", "joint_point_lines_newton",
                                                     "joint_armature_newton", "cables_newton", "cables_pd_newton",
                                                     "affine_body_hard_contact_newton",
                                                     "affine_body_hard_contact_pd_newton",
                                                     "affine_body_block_preconditioner_newton",
                                                     "affine_body_block_preconditioner_pd_newton",
                                                     "cable_contacts_newton", "cable_contacts_pd_newton",
                                                     "particle_fluid_newton", "particle_fluid_pd_newton",
                                                     "free_affine_body_six_springs_newton",
                                                     "free_affine_body_six_springs_pd_newton",
                                                     "free_affine_body_corotated_newton",
                                                     "free_affine_body_corotated_pd_newton",
                                                     "free_affine_body_abd_newton", "free_affine_body_abd_pd_newton",
                                                     "particle_granular_newton", "particle_granular_pd_newton",
                                                     "free_particle_self_collision_newton",
                                                     "free_particle_self_collision_pd_newton",
                                                     "mesh_self_collision_without_material_forces_newton",
                                                     "mesh_self_collision_without_material_forces_pd_newton",
                                                     "cloth_self_collision_newton", "cloth_self_collision_pd_newton",
                                                     "spring_self_collision_newton", "spring_self_collision_pd_newton",
                                                     "tetrahedron_self_collision_newton",
                                                     "tetrahedron_self_collision_pd_newton",
                                                     "aerodynamic_self_collision_newton",
                                                     "aerodynamic_self_collision_pd_newton",
                                                     "collision_bvh_initialization");
    bind_api(module);
    // Internal verification API for replaying captured original-kernel inputs through this exact compiled image.
    py::class_<Driver>(module, "_KernelDriver", py::module_local())
        .def(py::init<int>(), py::arg("device") = 0)
        .def("upload", &Driver::upload).def("download", &Driver::download).def("release", &Driver::release)
        .def("function", &Driver::function).def("synchronize", &Driver::synchronize)
        .def("launch", &Driver::launch, py::arg("function"), py::arg("grid"), py::arg("block"), py::arg("args"),
             py::arg("stream") = 0, py::arg("shared_bytes") = 0);
    py::class_<Solver>(module, "Solver")
        .def(py::init<>()).def_readwrite("config", &Solver::config)
        .def("initialize", &Solver::initialize)
        .def_property_readonly("source_launch_counts", &Solver::launch_counts)
        .def("reserve_rigid_contact_capacity", &Solver::reserve_rigid_contact_capacity, py::arg("capacity"))
        .def("reset_joint_drive_state", [](Solver& s, py::object stream, Span mask) {
            s.reset_joint_drive_state(stream_handle(stream), mask);
        },
             py::arg("stream") = py::none(), py::arg("mask") = Span{})
        .def("reset_cable_penalty_state", [](Solver& s, py::object stream, Span mask) {
            s.reset_cable_penalty_state(stream_handle(stream), mask);
        },
             py::arg("stream") = py::none(), py::arg("mask") = Span{})
        .def("copy_cable_penalties", [](Solver& s, Span output, py::object stream) {
            s.copy_cable_penalties(output, stream_handle(stream));
        },
             py::arg("output"), py::arg("stream") = py::none())
        .def("step", [](Solver& s, const State& a, const State& b, float dt, py::object stream) {
            s.step(a, b, Control{}, Contact{}, dt, stream_handle(stream));
        }, py::arg("state_in"), py::arg("state_out"), py::arg("dt"), py::arg("stream") = py::none())
        .def("step", [](Solver& s, const State& a, const State& b, const Contact& c, float dt, py::object stream) {
            s.step(a, b, Control{}, c, dt, stream_handle(stream));
        }, py::arg("state_in"), py::arg("state_out"), py::arg("contact"), py::arg("dt"), py::arg("stream") = py::none())
        .def("step", [](Solver& s, const State& a, const State& b, const Control& u, const Contact& c, float dt,
                        py::object stream) { s.step(a, b, u, c, dt, stream_handle(stream)); },
             py::arg("state_in"), py::arg("state_out"), py::arg("control"), py::arg("contact"), py::arg("dt"),
             py::arg("stream") = py::none());
    module.def("set_log_callback", [](py::object) {}, py::arg("callback") = py::none());
}
