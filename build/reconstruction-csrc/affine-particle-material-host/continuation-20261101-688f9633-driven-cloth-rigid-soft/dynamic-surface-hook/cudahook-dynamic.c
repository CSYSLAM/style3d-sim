// LD_PRELOAD shim: log host->device uploads and the raw arguments of selected kernel launches.
// Output goes to $CUDAHOOK_DIR: uploads/<seq>_<dst>_<bytes>.bin, launches.txt.
#define _GNU_SOURCE
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

static int seq = 0;

// Argument layouts from the legacy PTX ('f' = .f32, 'u' = .u64).
static const struct { const char *name; const char *layout; } kLayouts[] = {
    {"15initialize_step", "fuuuuuuufufufufufuuuuuuuu"},
    {"29initialize_block_non_diagonal", "uuuuuu"},
    {"22evaluate_bending_force", "uuuuuufuuuu"},
    {"22evaluate_stretch_force", "uuuuuuuuu"},
    {"add_cloth_membrane_gauss_newton_hessian", "uuuuuuuuuuuuu"},
    {"14initialize_rhs", "fuuuuuuuuuuu"},
    {"15update_velocity", "fuuuu"},
    {"20build_triangle_aabbs", "uuufuuu"},
    {"16build_edge_aabbs", "uuufuuu"},
    {"20build_particle_aabbs", "uuuuuuu"},
    {"9refit_bvh", "uuuuuuuu"},
    {"17query_vertex_face", "uuuuuuuuuffcuuuuuui"},
    {"20query_particle_pairs", "uuuuuuuuuuuuuuuui"},
    {"15query_edge_edge", "uuuuuuufuuuuui"},
    {"15query_edge_face", "uuuuuuuufuuuuuui"},
    {"22accumulate_vertex_face", "uuuuuuuffcfuuuuuuui"},
    {"25accumulate_particle_pairs", "uuuuuufuuuuuuui"},
    {"20accumulate_edge_edge", "uuuuuuuffuuuuuuui"},
    {"20accumulate_edge_face", "uuuuuuuuffuuuuuuui"},
    {"25multiply_contact_tangents", "uuuu"},
    {"20add_hessian_diagonal", "uuu"},
    {"25multiply_hessian_diagonal", "uuuu"},
    {"21generate_morton_codes", "uuGi"},
    {"16build_radix_tree", "uuui"},
    {"18build_escape_nodes", "uuui"},
    {"26build_primitive_leaf_nodes", "uui"},
    // Fluid: 'M' = synreal::Model by value (1864 B, saved to a file), 'V' = fluid_kernel::View (112 B).
    {"12fluid_kernel10build_grid", "Muuuuuuuuii"},
    {"12fluid_kernel13evaluate_rows", "Vuuuuuu"},
    {"12fluid_kernel15accumulate_rows", "Vuuuuuu"},
    {"12fluid_kernel13multiply_rows", "Vuuuu"},
    {"12fluid_kernel12add_diagonal", "uui"},
    {"12fluid_kernel16initialize_scale", "ufi"},
    {"12fluid_kernel11bound_scale", "Vuffu"},
    {"12fluid_kernel10scale_step", "Muui"},
    // Granular: 'W' = granular_kernel::View (120 B), printed as 15 words and saved to a file.
    {"15granular_kernel10build_grid", "MuuWuuuuuuuu"},
    {"15granular_kernel19accumulate_contacts", "Wuuuuu"},
    {"15granular_kernel17multiply_contacts", "Wuu"},
    {"15granular_kernel16accumulate_bonds", "Muufuuuuifuuu"},
    {"15granular_kernel14multiply_bonds", "uuuiuu"},
    {"15granular_kernel12commit_bonds", "Muuuuui"},
    {"15granular_kernel10form_bonds", "MWuuuuuuu"},
    {"15granular_kernel12add_diagonal", "uui"},
    // Triangle drag: 'T' = glm::vec3 by value.
    {"24initialize_triangle_drag", "uuuuuuu"},
    {"22evaluate_triangle_drag", "uuuuuufTfuuuuu"},
    {"32add_triangle_drag_preconditioner", "uuuuuuu"},
    {"30multiply_triangle_drag_tangent", "uuuuuuuu"},
    {"26evaluate_tetrahedron_force", "uuuuuuufuuuu"},
    {"30add_tetrahedron_preconditioner", "uuuuufuuuu"},
    {"28multiply_tetrahedron_tangent", "uuuuuufuuuu"},
    // Affine bodies.
    {"31refresh_inertial_cache_nonzeros", "uuuuuuuuu"},
    {"32refresh_inertial_cache_diagonals", "uuuuuu"},
    {"27combine_system_non_diagonal", "ffffffuuuuuuuuu"},
    {"32initialize_affine_body_so3_state", "uuuuuuu"},
    {"51evaluate_affine_body_so3_augmented_lagrangian_force", "uuuuufuuuu"},
    {"55add_affine_body_so3_augmented_lagrangian_preconditioner", "uuufuuuu"},
    {"53multiply_affine_body_so3_augmented_lagrangian_tangent", "uuuufuuuu"},
    {"49update_affine_body_so3_augmented_lagrangian_state", "uuuucuuu"},
    {"33evaluate_affine_body_spring_force", "uuufuuuu"},
    {"43add_affine_body_spring_gauss_newton_hessian", "uuufuuuuuuuu"},
    {"39evaluate_affine_body_constitutive_force", "uuufiuuuu"},
    {"43add_affine_body_constitutive_preconditioner", "uuufiuuuu"},
    {"41multiply_affine_body_constitutive_tangent", "uuuufiuuuu"},
    {"20apply_nonlinear_step", "uuuu"},
    {"35update_solution_residual_and_reduce", "iuuuuuuuucu"},
    // Current 23fb797 PCG ABI: world map and 32-bit particles-per-group divisor.
    {"23precondition_and_reduce", "uuucuiuu"},
    {"19update_cg_direction", "iuuiuuuu"},
    {"26multiply_matrix_and_reduce", "uuuuuuuuiuuu"},
    {"15multiply_matrix", "uuuuuuuuu"},
    {"28update_solution_and_residual", "uiuuuuuuu"},
    {"25initialize_block_diagonal", "uuuu"},
    {"27invert_block_preconditioner", "uuuuuu"},
    {"30prepare_inverse_preconditioner", "uuuuuu"},
    {"32multiply_bending_damping_tangent", "uuuuuufuuuu"},
    {"34add_bending_damping_preconditioner", "uuuuufuuuu"},
    {"22evaluate_contact_force", "uuuuuuuuuuuuuuuuuuufuuuuuuuuuuufuu"},
    {"24evaluate_contact_tangent", "uuuuuuuuuuuuuuuuuuufuuuuuuuuuuufuuu"},
    // 'R' = RollingContactView (248 B) as 31 hex words with their float view.
    {"30evaluate_rolling_contact_force", "Ru"},
    {"27evaluate_soft_contact_force", "uuuuuuuuuuuuuuuuuuuuuuuuffffuuuuuuufuuuuuu"},
    {"42multiply_soft_contact_hessian_off_diagonal", "uuuuuuuuuuuuuuuuuuuuuuuuuufuffuuuuuffuu"},
    {"34add_rolling_contact_preconditioner", "Ru"},
    {"32multiply_rolling_contact_tangent", "Ruu"},
    // Joints. 'J' = JointCoordinateView (120 B), 'L' = AngularLimitView (32 B), printed as words.
    {"34initialize_joint_body_spring_state", "uu"},
    {"26evaluate_body_spring_force", "uuuuuuuuufucuuuu"},
    {"30evaluate_body_point_line_force", "uuuuuuuuuuufucuuuu"},
    {"40add_body_point_line_gauss_newton_hessian", "uuuuuuuuufucuuuuuuuu"},
    {"41initialize_body_distance_constraint_state", "uuuuuuuuuuuuu"},
    {"39evaluate_body_distance_constraint_force", "uuuuuuuuuufuuuu"},
    {"37update_body_distance_constraint_state", "uuuuuuuuuuuuu"},
    {"36add_body_spring_gauss_newton_hessian", "uuuuuuuuuuuuuuuuu"},
    {"53evaluate_joint_body_spring_augmented_lagrangian_force", "uuuuuuuuufuuuuu"},
    {"51update_joint_body_spring_augmented_lagrangian_state", "uuuuuuuuuuuu"},
    {"25evaluate_joint_drive_load", "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuf"},
    {"30add_joint_drive_preconditioner", "uuuuuuuuuuuuuuuufuuuu"},
    {"28multiply_joint_drive_tangent", "uuuuuuuuuuuuuuuuufuuuu"},
    {"23evaluate_angular_limits", "JLuuuufuuu"},
    {"23evaluate_joint_armature", "Juuuufuuu"},
    {"38initialize_joint_coordinate_velocities", "Juuu"},
    // CableView: 17 device pointers followed by three size_t counts (160 bytes).
    {"prepare_cable_penalties", "uuuuufffffccu"},
    {"prepare_cable_tangents", "Cu"},
    {"evaluate_cables", "Cuufuuu"},
    {"update_cable_penalties", "Cuff"},
    {"build_affine_body_preconditioner", "uuuuuuuuuufCuufuuuuuuu"},
    {"apply_affine_body_preconditioner", "uuuuuuuu"},
    {"apply_block_diagonal_preconditioner", "uuuu"},
    {"30update_joint_drive_angle_state", "uuuuuuuuuuuuuuuuu"},
    {"55update_joint_body_point_line_augmented_lagrangian_state", "uuuuuuuuuuucuuuu"},
    {"57evaluate_joint_body_point_line_augmented_lagrangian_force", "uuuuuuuuuuuufuuuuu"},
    {"46add_joint_body_point_line_gauss_newton_hessian", "uuuuuuuufuuuuuuuuu"},
    {"38initialize_joint_body_point_line_state", "uuuuuuuuuuuuuuu"},
    // 'U' = SurfaceContactView (296 B) as 37 words.
    {"30evaluate_surface_contact_force", "Uu"},
    {"34add_surface_contact_preconditioner", "Uu"},
    {"35add_surface_contact_stiffness_scale", "Uu"},
    // 'H' = HardContactView (312 B) as 39 words.
    {"24initialize_hard_contacts", "H"},
    {"22evaluate_hard_contacts", "Huuuuuuu"},
    {"25update_hard_contact_duals", "H"},
    {"22snapshot_hard_contacts", "H"},
    {"32multiply_surface_contact_tangent", "Uuu"},
    // Complete the current owned-kernel inventory; three residual overloads share this raw layout.
    {"25apply_affine_body_torques", "uuuuuuuu"},
    {"32reset_selected_joint_drive_state", "uuu"},
    {"61add_joint_body_point_line_augmented_lagrangian_preconditioner", "uuuuuuuufuuuuu"},
    {"51multiply_joint_body_point_line_augmented_lagrangian", "uuuuuuuuufuuuuu"},
    {"11refit_aabbs", "uuuuuui"},
    {"17evaluate_residual", "uuuuuuuuuu"},
    {"21evaluate_spring_force", "uuuuuuuu"},
    {"31add_spring_gauss_newton_hessian", "uuuuuuuuuuuu"},
};
static int launches_logged = 0;
static void *real_symbol(const char *name);
static const char *dir(void);

// CUDAHOOK_DUMP="key=arg:bytes,...;key2=..." dumps device buffers. arg+offset reads a pointer in a by-value view.
static int dumped[64];

static void dump_buffers(const char *key, void **args, const char *spec, const char *phase) {
    cudaError_t (*sync)(void) = real_symbol("cudaDeviceSynchronize");
    cudaError_t (*copy)(void *, const void *, size_t, enum cudaMemcpyKind) = real_symbol("cudaMemcpy");
    sync();
    const char *c = spec;
    while (*c && *c != ';') {
        int arg = atoi(c);
        const char *colon = strchr(c, ':');
        if (!colon) break;
        const char *plus = strchr(c, '+');
        size_t offset = (plus && plus < colon) ? strtoull(plus + 1, NULL, 10) : 0;
        size_t bytes = strtoull(colon + 1, NULL, 10);
        void *ptr; memcpy(&ptr, (const char *)args[arg] + offset, 8);
        if (arg == 0 && strstr(key, "30evaluate_surface_contact_force") &&
            (offset == 16 || offset == 24 || offset == 32 || offset == 40 || offset == 48 || offset == 56)) {
            int active = 0;
            size_t capacity = 0;
            memcpy(&capacity, (const char *)args[0] + 8, 8);
            void *counter; memcpy(&counter, args[0], 8);
            cudaError_t (*read_count)(void *, const void *, size_t, enum cudaMemcpyKind) =
                dlsym(RTLD_NEXT, "cudaMemcpy");
            if (!read_count || read_count(&active, counter, 4, cudaMemcpyDeviceToHost) != cudaSuccess) abort();
            if (active < 0 || (size_t)active > capacity || active > 1000000) abort();
            bytes = (size_t)active * (offset == 32 ? 4 : 12);
        }

        void *host = malloc(bytes);
        if (host && ptr && copy(host, ptr, bytes, cudaMemcpyDeviceToHost) == cudaSuccess) {
            char path[512];
            if (offset) snprintf(path, sizeof path, "%s/dump_%s_%s_arg%d_offset%zu.bin", dir(), key, phase, arg, offset);
            else snprintf(path, sizeof path, "%s/dump_%s_%s_arg%d.bin", dir(), key, phase, arg);
            FILE *f = fopen(path, "wb");
            if (f) { fwrite(host, 1, bytes, f); fclose(f); }
        }
        free(host);
        const char *next = strpbrk(colon, ",;");
        if (!next || *next == ';') break;
        c = next + 1;
    }
}


static void *real_symbol(const char *name) {
    void *f = dlsym(RTLD_NEXT, name);
    if (!f) {
        void *lib = dlopen("libcudart.so.12", RTLD_NOW | RTLD_GLOBAL);
        if (lib) f = dlsym(lib, name);
    }
    return f;
}

static const char *dir(void) { const char *d = getenv("CUDAHOOK_DIR"); return d ? d : "/tmp"; }

static void save_upload(void *dst, const void *src, size_t count) {
    char path[512];
    snprintf(path, sizeof path, "%s/uploads/%05d_%p_%zu.bin", dir(), seq++, dst, count);
    FILE *f = fopen(path, "wb");
    if (f) { fwrite(src, 1, count, f); fclose(f); }
}

static int host_source(const void *src, enum cudaMemcpyKind kind) {
    if (kind == cudaMemcpyHostToDevice) return 1;
    if (kind != cudaMemcpyDefault) return 0;
    struct cudaPointerAttributes a;
    cudaError_t (*attr)(struct cudaPointerAttributes *, const void *) = real_symbol("cudaPointerGetAttributes");
    if (attr(&a, src) != cudaSuccess) { cudaGetLastError(); return 1; }
    return a.type == cudaMemoryTypeHost || a.type == cudaMemoryTypeUnregistered;
}

cudaError_t cudaMemcpy(void *dst, const void *src, size_t count, enum cudaMemcpyKind kind) {
    cudaError_t (*real)(void *, const void *, size_t, enum cudaMemcpyKind) = real_symbol("cudaMemcpy");
    if (count >= 4 && host_source(src, kind)) save_upload(dst, src, count);
    return real(dst, src, count, kind);
}

cudaError_t cudaMemcpyAsync(void *dst, const void *src, size_t count, enum cudaMemcpyKind kind, cudaStream_t s) {
    cudaError_t (*real)(void *, const void *, size_t, enum cudaMemcpyKind, cudaStream_t) =
        real_symbol("cudaMemcpyAsync");
    if (count >= 4 && host_source(src, kind)) save_upload(dst, src, count);
    return real(dst, src, count, kind, s);
}

static void log_launch(const char *n, unsigned grid_x, unsigned grid_y, unsigned grid_z,
                       unsigned block_x, unsigned block_y, unsigned block_z, size_t shared, void *stream, void **args) {
    // Keep complete schedules: silently truncating at 20,000 hid the tail of large joint demos.
    if (n) {
        for (size_t k = 0; k < sizeof kLayouts / sizeof kLayouts[0]; ++k) {
            if (!strstr(n, kLayouts[k].name)) continue;
            char path[512];
            snprintf(path, sizeof path, "%s/launches.txt", dir());
            FILE *f = fopen(path, "a");
            if (f) {
                fprintf(f, "%d %s grid=%u block=%u upload_seq=%d", launches_logged, kLayouts[k].name, grid_x, block_x, seq);
                for (const char *c = kLayouts[k].layout; *c; ++c) {
                    int i = (int)(c - kLayouts[k].layout);
                    if (*c == 'f') { float v; memcpy(&v, args[i], 4); fprintf(f, " f:%.9g", v); }
                    else if (*c == 'G') { float g[6]; memcpy(g, args[i], 24); fprintf(f, " aabb:%.9g,%.9g,%.9g,%.9g,%.9g,%.9g", g[0], g[1], g[2], g[3], g[4], g[5]); }
                    else if (*c == 'V') {
                        unsigned long long w[14]; memcpy(w, args[i], 112);
                        fprintf(f, " Vview:");
                        for (int k = 0; k < 14; ++k) fprintf(f, "%d:%llx(bits),", 8*k, w[k]);
                    }
                    else if (*c == 'T') { float t[3]; memcpy(t, args[i], 12); fprintf(f, " vec3:%.9g,%.9g,%.9g", t[0], t[1], t[2]); }
                    else if (*c == 'R') {
                        unsigned long long w[31]; memcpy(w, args[i], 248);
                        fprintf(f, " rview:");
                        for (int k = 0; k < 31; ++k) { float lo, hi; unsigned int l = (unsigned int)w[k], h = (unsigned int)(w[k] >> 32); memcpy(&lo, &l, 4); memcpy(&hi, &h, 4); fprintf(f, "%d:%llx(%g|%g),", 8*k, w[k], lo, hi); }
                    }
                    else if (*c == 'J' || *c == 'L' || *c == 'U' || *c == 'H' || *c == 'C') {
                        int words = *c == 'J' ? 15 : (*c == 'U' ? 37 : (*c == 'H' ? 39 : (*c == 'C' ? 20 : 4)));
                        unsigned long long w[39]; memcpy(w, args[i], 8*words);
                        fprintf(f, " %cview:", *c);
                        for (int k = 0; k < words; ++k) { float lo, hi; unsigned int l = (unsigned int)w[k], h = (unsigned int)(w[k] >> 32); memcpy(&lo, &l, 4); memcpy(&hi, &h, 4); fprintf(f, "%d:%llx(%g|%g),", 8*k, w[k], lo, hi); }
                    }
                    else if (*c == 'W') {
                        unsigned long long w[15]; memcpy(w, args[i], 120);
                        fprintf(f, " gview:");
                        for (int k = 0; k < 15; ++k) fprintf(f, "%d:%llx(bits),", 8*k, w[k]);
                    }
                    else if (*c == 'M') {
                        char path2[512];
                        snprintf(path2, sizeof path2, "%s/model_%d.bin", dir(), launches_logged);
                        FILE *g = fopen(path2, "wb");
                        if (g) { fwrite(args[i], 1, 1864, g); fclose(g); }
                        unsigned long long w[233]; memcpy(w, args[i], 1864);
                        fprintf(f, " Mview:");
                        for (int k = 0; k < 233; ++k) fprintf(f, "%d:%llx(bits),", 8*k, w[k]);
                    }
                    else if (*c == 'i') { unsigned int v; memcpy(&v, args[i], 4); fprintf(f, " i:%u", v); }
                    else if (*c == 'c' || *c == 'b') { unsigned char v; memcpy(&v, args[i], 1); fprintf(f, " c:%u", v); }
                    else { unsigned long long v; memcpy(&v, args[i], 8); fprintf(f, " u:%llx", v); }
                }
                unsigned stream_kind = (uintptr_t)stream <= 2 ? (unsigned)(uintptr_t)stream : 3;
                fprintf(f, " symbol:%s launch:%u,%u,%u,%u,%u,%u,%zu,%u\n",
                        n, grid_x, grid_y, grid_z, block_x, block_y, block_z, shared, stream_kind);
                fclose(f);
            }
            launches_logged++;
            return;
        }
        if (strstr(n, "synreal")) {
            char path[512];
            snprintf(path, sizeof path, "%s/launches.txt", dir());
            FILE *f = fopen(path, "a");
            if (f) {
                fprintf(f, "%d UNKNOWN:%s grid=%u block=%u upload_seq=%d\n",
                        launches_logged++, n, grid_x, block_x, seq);
                fclose(f);
            }
        }
    }
}

cudaError_t cudaLaunchKernel(const void *func, dim3 grid, dim3 block, void **args, size_t shm, cudaStream_t s) {
    cudaError_t (*real)(const void *, dim3, dim3, void **, size_t, cudaStream_t) = real_symbol("cudaLaunchKernel");
    Dl_info info;
    log_launch(dladdr(func, &info) ? info.dli_sname : NULL,
               grid.x, grid.y, grid.z, block.x, block.y, block.z, shm, s, args);
    const char *spec_all = getenv("CUDAHOOK_DUMP");
    // Default remains first-call-only. Numbered files keep multi-iteration captures separate.
    const char *limit_env = getenv("CUDAHOOK_DUMP_LIMIT");
    int dump_limit = limit_env ? atoi(limit_env) : 1;
    if (dump_limit < 1) dump_limit = 1;
    int dump_slot = -1;
    const char *spec = NULL;
    char key[128] = {0};
    if (spec_all && dladdr(func, &info) && info.dli_sname) {
        int slot = 0;
        for (const char *e = spec_all; e && *e; slot++) {
            const char *eq = strchr(e, '=');
            if (!eq) break;
            size_t len = (size_t)(eq - e);
            if (len < sizeof key) {
                char k[128]; memcpy(k, e, len); k[len] = 0;
                if (strstr(info.dli_sname, k) && slot < 64 && dumped[slot] < dump_limit) {
                    dump_slot = slot; spec = eq + 1; memcpy(key, k, len + 1);
                    break;
                }
            }
            e = strchr(eq, ';');
            if (e) e++;
        }
    }
    char dump_key[160];
    if (dump_slot >= 0) {
        if (dump_limit > 1) snprintf(dump_key, sizeof dump_key, "%s_call%03d", key, dumped[dump_slot]);
        else snprintf(dump_key, sizeof dump_key, "%s", key);
        dump_buffers(dump_key, args, spec, "pre");
    }
    cudaError_t result = real(func, grid, block, args, shm, s);
    if (dump_slot >= 0) { dump_buffers(dump_key, args, spec, "post"); dumped[dump_slot]++; }
    return result;
}

// libcuda is often loaded outside the global scope (dlopen by Warp), so RTLD_NEXT alone may miss it.
static void *driver_symbol(const char *name) {
    void *f = dlsym(RTLD_NEXT, name);
    if (!f) {
        void *lib = dlopen("libcuda.so.1", RTLD_NOW | RTLD_NOLOAD);
        if (!lib) lib = dlopen("libcuda.so.1", RTLD_NOW);
        if (lib) f = dlsym(lib, name);
    }
    return f;
}

static void driver_dump(const char *key, void **args, const char *spec, const char *phase) {
    CUresult (*sync)(void) = driver_symbol("cuCtxSynchronize");
    CUresult (*copy)(void *, CUdeviceptr, size_t) = driver_symbol("cuMemcpyDtoH_v2");
    if (!sync || !copy) return;
    sync();
    const char *c = spec;
    while (*c && *c != ';') {
        int arg = atoi(c);
        const char *colon = strchr(c, ':');
        if (!colon) break;
        const char *plus = strchr(c, '+');
        size_t offset = (plus && plus < colon) ? strtoull(plus + 1, NULL, 10) : 0;
        size_t bytes = strtoull(colon + 1, NULL, 10);
        CUdeviceptr ptr; memcpy(&ptr, (const char *)args[arg] + offset, 8);
        if (arg == 0 && strstr(key, "30evaluate_surface_contact_force") &&
            (offset == 16 || offset == 24 || offset == 32 || offset == 40 || offset == 48 || offset == 56)) {
            int active = 0;
            size_t capacity = 0;
            memcpy(&capacity, (const char *)args[0] + 8, 8);
            CUdeviceptr counter; memcpy(&counter, args[0], 8);
            if (copy(&active, counter, 4) != CUDA_SUCCESS) abort();
            if (active < 0 || (size_t)active > capacity || active > 1000000) abort();
            bytes = (size_t)active * (offset == 32 ? 4 : 12);
        }

        void *host = malloc(bytes);
        if (host && ptr && copy(host, ptr, bytes) == CUDA_SUCCESS) {
            char path[512];
            if (offset) snprintf(path, sizeof path, "%s/dump_%s_%s_arg%d_offset%zu.bin", dir(), key, phase, arg, offset);
            else snprintf(path, sizeof path, "%s/dump_%s_%s_arg%d.bin", dir(), key, phase, arg);
            FILE *f = fopen(path, "wb");
            if (f) { fwrite(host, 1, bytes, f); fclose(f); }
        }
        free(host);
        const char *next = strpbrk(colon, ",;");
        if (!next || *next == ';') break;
        c = next + 1;
    }
}

// Driver-API launches (the compiled source module) are logged with the same layouts, named via cuFuncGetName.
CUresult cuLaunchKernel(CUfunction f, unsigned gx, unsigned gy, unsigned gz, unsigned bx, unsigned by, unsigned bz,
                        unsigned shm, CUstream s, void **params, void **extra) {
    CUresult (*real)(CUfunction, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned, CUstream,
                     void **, void **) = driver_symbol("cuLaunchKernel");
    CUresult (*get_name)(const char **, CUfunction) = driver_symbol("cuFuncGetName");
    const char *name = NULL;
    if (params && get_name && get_name(&name, f) == CUDA_SUCCESS && name && strstr(name, "synreal"))
        log_launch(name, gx, gy, gz, bx, by, bz, shm, s, params);
    // Same CUDAHOOK_DUMP selection as the runtime path; copies use the driver API in the launch's own context.
    const char *spec_all = getenv("CUDAHOOK_DUMP");
    const char *limit_env = getenv("CUDAHOOK_DUMP_LIMIT");
    int dump_limit = limit_env ? atoi(limit_env) : 1;
    if (dump_limit < 1) dump_limit = 1;
    int dump_slot = -1;
    const char *spec = NULL;
    char key[128] = {0};
    if (spec_all && name && params) {
        int slot = 0;
        for (const char *e = spec_all; e && *e; slot++) {
            const char *eq = strchr(e, '=');
            if (!eq) break;
            size_t len = (size_t)(eq - e);
            if (len < sizeof key) {
                char k[128]; memcpy(k, e, len); k[len] = 0;
                if (strstr(name, k) && slot < 64 && dumped[slot] < dump_limit) {
                    dump_slot = slot; spec = eq + 1; memcpy(key, k, len + 1);
                    break;
                }
            }
            e = strchr(eq, ';');
            if (e) e++;
        }
    }
    char dump_key[160];
    if (dump_slot >= 0) {
        if (dump_limit > 1) snprintf(dump_key, sizeof dump_key, "%s_call%03d", key, dumped[dump_slot]);
        else snprintf(dump_key, sizeof dump_key, "%s", key);
        driver_dump(dump_key, params, spec, "pre");
    }
    CUresult result = real(f, gx, gy, gz, bx, by, bz, shm, s, params, extra);
    if (dump_slot >= 0) { driver_dump(dump_key, params, spec, "post"); dumped[dump_slot]++; }
    return result;
}
