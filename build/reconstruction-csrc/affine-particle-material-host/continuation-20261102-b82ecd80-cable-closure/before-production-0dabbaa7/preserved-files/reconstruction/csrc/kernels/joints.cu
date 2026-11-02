// Joint constraint kernels of synreal::SolverNewton (body springs, point-lines, drives).
#include "types.cuh"

namespace synreal::kernel {

// Augmented-Lagrangian multipliers of the joint body springs start every substep at zero.
__global__ void initialize_joint_body_spring_state(glm::vec3* multiplier, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    multiplier[i] = glm::vec3(0.0f);
}

// Clears the drive state (e.g. the unwrapped-angle initialised flag) of the joints selected by the host.
__global__ void reset_selected_joint_drive_state(const int* selected, int* state, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    if (selected[i] != 0) state[i] = 0;
}

// World position of a body-attached point: affine combination of the body's four proxy particles.
__device__ __forceinline__ glm::vec3 body_point(const glm::vec3* x, const glm::ivec4& particles, const glm::vec4& weights)
{
    return weights.x * x[particles.x] + weights.y * x[particles.y] + weights.z * x[particles.z] +
           weights.w * x[particles.w];
}

// Joint springs are the last `joints_per_world` body springs. Multiplier update lambda = (p1 + lambda) - p0, where
// an end attached to no body (index < 0) is its fixed world anchor.
__global__ void update_joint_body_spring_augmented_lagrangian_state(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, glm::vec3* multiplier,
    size_t count, size_t spring_count, size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t spring = i % joints_per_world + (spring_count - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[spring];
    glm::vec3 p0 = anchor0[spring];
    glm::vec3 p1 = anchor1[spring];
    if (pair.x >= 0) p0 = body_point(x, body_particles[pair.x] + offset, weights0[spring]);
    if (pair.y >= 0) p1 = body_point(x, body_particles[pair.y] + offset, weights1[spring]);
    multiplier[i] = p1 + multiplier[i] - p0;
}

// Joint spring force f = k alpha ((p1 - p0) + lambda), spread to the proxies of body 0 as f w and of body 1 as
// -f w (alpha = augmented-Lagrangian weight times h^2, set by the host).
__global__ void evaluate_joint_body_spring_augmented_lagrangian_force(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, const float* stiffness,
    const glm::vec3* multiplier, float alpha, glm::vec3* force, size_t count, size_t spring_count,
    size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t spring = i % joints_per_world + (spring_count - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[spring];
    glm::vec3 p0 = anchor0[spring];
    glm::vec3 p1 = anchor1[spring];
    const glm::vec4& w0 = weights0[spring];
    const glm::vec4& w1 = weights1[spring];
    glm::ivec4 particles0(0), particles1(0);
    if (pair.x >= 0) {
        particles0 = body_particles[pair.x] + offset;
        p0 = body_point(x, particles0, w0);
    }
    if (pair.y >= 0) {
        particles1 = body_particles[pair.y] + offset;
        p1 = body_point(x, particles1, w1);
    }
    const glm::vec3 f = (p1 - p0 + multiplier[i]) * (stiffness[spring] * alpha);
    if (pair.x >= 0) {
        const glm::vec3 fx = f * w0.x, fy = f * w0.y, fz = f * w0.z, fw = f * w0.w;
        atomic_add(&force[particles0.x], fx);
        atomic_add(&force[particles0.y], fy);
        atomic_add(&force[particles0.z], fz);
        atomic_add(&force[particles0.w], fw);
    }
    if (pair.y >= 0) {
        const glm::vec3 g = -f;
        const glm::vec3 gx = w1.x * g, gy = w1.y * g, gz = w1.z * g, gw = w1.w * g;
        atomic_add(&force[particles1.x], gx);
        atomic_add(&force[particles1.y], gy);
        atomic_add(&force[particles1.z], gz);
        atomic_add(&force[particles1.w], gw);
    }
}

// Target separation of a distance constraint along d with length rest; (rest, 0, 0) when d is degenerate and zero
// when rest <= 0. The squared length is fma(z, z, fma(y, y, x x)) with explicit fmaf: x^2 is the rounded term,
// whereas glm::length (and any plain sum) contracts to fma(x, x, y y).
__device__ __forceinline__ glm::vec3 distance_target(const glm::vec3& d, float rest)
{
    if (rest <= 0.0f) return glm::vec3(0.0f);
    const float length = std::sqrt(fmaf(d.z, d.z, fmaf(d.y, d.y, d.x * d.x)));
    if (length > 1e-8f) return d * (rest / length);
    return glm::vec3(rest, 0.0f, 0.0f);
}

// Target after an iteration: along e = (p1 - p0) + lambda, else along the previous target, else (rest, 0, 0);
// zero when rest <= 0. Lengths as glm::length (y^2 rounded first).
__device__ __forceinline__ glm::vec3 updated_distance_target(const glm::vec3& e, const glm::vec3& previous, float rest)
{
    if (rest <= 0.0f) return glm::vec3(0.0f);
    const float length = glm::length(e);
    if (length > 1e-8f) return e * (rest / length);
    const float previous_length = glm::length(previous);
    if (previous_length > 1e-8f) return previous * (rest / previous_length);
    return glm::vec3(rest, 0.0f, 0.0f);
}

// Separation p1 - p0 of constraint c (ends on bodies or fixed anchors), shared by all three distance kernels.
__device__ __forceinline__ glm::vec3 constraint_separation(const glm::vec3* x, const glm::ivec4* body_particles,
                                                           const glm::ivec2* bodies, const glm::vec3* anchor0,
                                                           const glm::vec3* anchor1, const glm::vec4* w0,
                                                           const glm::vec4* w1, size_t c, int offset)
{
    const glm::ivec2 pair = bodies[c];
    glm::vec3 p0 = anchor0[c];
    glm::vec3 p1 = anchor1[c];
    if (pair.x >= 0) p0 = body_point(x, body_particles[pair.x] + offset, w0[c]);
    if (pair.y >= 0) p1 = body_point(x, body_particles[pair.y] + offset, w1[c]);
    return p1 - p0;
}

// Start of a step: target r along the current separation, multiplier lambda = 0.
__global__ void initialize_body_distance_constraint_state(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, const float* rest,
    glm::vec3* target, glm::vec3* multiplier, size_t count, size_t constraints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / constraints_per_world;
    const size_t c = i % constraints_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::vec3 d = constraint_separation(x, body_particles, bodies, anchor0, anchor1, weights0, weights1, c,
                                              offset);
    target[i] = distance_target(d, rest[c]);
    multiplier[i] = glm::vec3(0.0f);
}

// Force f = alpha m_s ((p1 - p0) - r + lambda): body 0 proxies get f w0, body 1 proxies (-f) w1.
__global__ void evaluate_body_distance_constraint_force(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, const float* mass_scale,
    const glm::vec3* target, const glm::vec3* multiplier, float alpha, glm::vec3* force, size_t count,
    size_t constraints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / constraints_per_world;
    const size_t c = i % constraints_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[c];
    glm::vec3 p0 = anchor0[c];
    glm::vec3 p1 = anchor1[c];
    const glm::vec4& w0 = weights0[c];
    const glm::vec4& w1 = weights1[c];
    glm::ivec4 particles0(0), particles1(0);
    if (pair.x >= 0) {
        particles0 = body_particles[pair.x] + offset;
        p0 = body_point(x, particles0, w0);
    }
    if (pair.y >= 0) {
        particles1 = body_particles[pair.y] + offset;
        p1 = body_point(x, particles1, w1);
    }
    const glm::vec3 f = (p1 - p0 - target[i] + multiplier[i]) * (mass_scale[c] * alpha);
    if (pair.x >= 0) {
        const glm::vec3 fx = f * w0.x, fy = f * w0.y, fz = f * w0.z, fw = f * w0.w;
        atomic_add(&force[particles0.x], fx);
        atomic_add(&force[particles0.y], fy);
        atomic_add(&force[particles0.z], fz);
        atomic_add(&force[particles0.w], fw);
    }
    if (pair.y >= 0) {
        const glm::vec3 g = -f;
        const glm::vec3 gx = g * w1.x, gy = g * w1.y, gz = g * w1.z, gw = g * w1.w;
        atomic_add(&force[particles1.x], gx);
        atomic_add(&force[particles1.y], gy);
        atomic_add(&force[particles1.z], gz);
        atomic_add(&force[particles1.w], gw);
    }
}

// After each Newton iteration: e = (p1 - p0) + lambda; r follows e (or the previous r when e is degenerate);
// lambda = e - r.
__global__ void update_body_distance_constraint_state(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, const float* rest,
    glm::vec3* target, glm::vec3* multiplier, size_t count, size_t constraints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / constraints_per_world;
    const size_t c = i % constraints_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::vec3 d = constraint_separation(x, body_particles, bodies, anchor0, anchor1, weights0, weights1, c,
                                              offset);
    const glm::vec3 e = d + multiplier[i];
    const glm::vec3 previous = target[i];
    const glm::vec3 r = updated_distance_target(e, previous, rest[c]);
    multiplier[i] = e - r;
    target[i] = r;
}

// Body springs: f = k (d - rest d/|d|), d = p1 - p0 (|d|^2 = fma(z, z, fma(y, y, x x)); zero direction for
// |d| = 0). The trailing `joint_count` springs are joint springs: skipped unless the joints run in penalty mode
// (include_joints), then with stiffness alpha k. Body 0 proxies get w0 f and body 1 proxies w1 (-f), slot by slot.
__global__ void evaluate_body_spring_force(const glm::vec3* x, const glm::ivec4* body_particles,
                                           const glm::ivec2* bodies, const glm::vec3* anchor0,
                                           const glm::vec3* anchor1, const glm::vec4* weights0,
                                           const glm::vec4* weights1, const float* stiffness, const float* rest,
                                           float alpha, size_t joint_count, bool include_joints, glm::vec3* force,
                                           size_t count, size_t springs_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / springs_per_world;
    const size_t spring = i % springs_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[spring];
    glm::vec3 p0 = anchor0[spring];
    glm::vec3 p1 = anchor1[spring];
    const glm::vec4& w0 = weights0[spring];
    const glm::vec4& w1 = weights1[spring];
    glm::ivec4 particles0(0), particles1(0);
    if (pair.x >= 0) {
        particles0 = body_particles[pair.x] + offset;
        p0 = body_point(x, particles0, w0);
    }
    if (pair.y >= 0) {
        particles1 = body_particles[pair.y] + offset;
        p1 = body_point(x, particles1, w1);
    }
    const glm::vec3 d = p1 - p0;
    const size_t first_joint = springs_per_world - joint_count;
    if (spring >= first_joint && !include_joints) return;
    const float k = (spring < first_joint ? 1.0f : alpha) * stiffness[spring];
    const float length = std::sqrt(fmaf(d.z, d.z, fmaf(d.y, d.y, d.x * d.x)));
    const glm::vec3 f = k * (d - rest[spring] * normalized_or_zero(d, length, 0.0f));
    const glm::vec3 g = -f;
    for (int slot = 0; slot < 4; ++slot) {
        if (pair.x >= 0) atomic_add(&force[particles0[slot]], w0[slot] * f);
        if (pair.y >= 0) atomic_add(&force[particles1[slot]], w1[slot] * g);
    }
}

// Body point-line penalty: the point p (on body pairs.x) is pulled towards the closest point q of the segment
// [a, b] (on body pairs.y, or fixed ends when pairs.y < 0), q = a + t (b - a) with t clamped to [0, 1] (t = 0 for a
// degenerate segment, |b - a|^2 <= 1e-12). f = k (q - p); the trailing `joint_count` lines are joint constraints,
// skipped unless include_joints and then with stiffness alpha k. Lines with |f|^2 <= 1e-12 are skipped. The point
// body proxies get f w_p, the line body proxies wq (-f) with wq = (1 - t) w_a + t w_b, slot by slot.
// `previous` and `damping` are part of the legacy interface but unused.
__global__ void evaluate_body_point_line_force(const glm::vec3* x, const glm::vec3* previous,
                                               const glm::ivec4* body_particles, const glm::ivec2* bodies,
                                               const glm::vec4* point_weights, const glm::vec4* end0_weights,
                                               const glm::vec4* end1_weights, const glm::vec3* end0,
                                               const glm::vec3* end1, const float* stiffness, const float* damping,
                                               float alpha, size_t joint_count, bool include_joints, glm::vec3* force,
                                               size_t count, size_t lines_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / lines_per_world;
    const size_t line = i % lines_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    const glm::vec4& wp = point_weights[line];
    const glm::vec3 p = body_point(x, point_particles, wp);
    glm::vec3 a = end0[line];
    glm::vec3 b = end1[line];
    const glm::vec4& wa = end0_weights[line];
    const glm::vec4& wb = end1_weights[line];
    glm::ivec4 line_particles(0);
    if (pair.y >= 0) {
        line_particles = body_particles[pair.y] + offset;
        a = body_point(x, line_particles, wa);
        b = body_point(x, line_particles, wb);
    }
    const glm::vec3 d = b - a;
    const float dd = glm::dot(d, d);
    float t = 0.0f;
    // fminf/fmaxf (compiled to cvt.sat): a NaN ratio clamps to 0, unlike glm::clamp.
    if (dd > 1e-12f) t = fminf(fmaxf(glm::dot(p - a, d) / dd, 0.0f), 1.0f);
    const glm::vec4 wq = wa * (1.0f - t) + t * wb;
    const glm::vec3 diff = d * t + a - p;
    const size_t first_joint = lines_per_world - joint_count;
    if (line >= first_joint && !include_joints) return;
    const glm::vec3 f = diff * ((line < first_joint ? 1.0f : alpha) * stiffness[line]);
    if (glm::dot(f, f) <= 1e-12f) return;
    const glm::vec3 g = -f;
    for (int slot = 0; slot < 4; ++slot) {
        atomic_add(&force[point_particles[slot]], f * wp[slot]);
        if (pair.y >= 0) atomic_add(&force[line_particles[slot]], wq[slot] * g);
    }
}

// Joint point-line geometry: the point p on body pairs.x and the segment midpoint / direction of body pairs.y
// (weights (w0 + w1) / 2 and w1 - w0), or of the fixed ends when pairs.y < 0.
struct PointLineGeometry {
    glm::vec3 point;
    glm::vec3 middle;
    glm::vec3 direction;
};

__device__ __forceinline__ PointLineGeometry point_line_geometry(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2& pair, const glm::vec4& point_weights,
    const glm::vec4& w0, const glm::vec4& w1, const glm::vec3& end0, const glm::vec3& end1, int offset)
{
    PointLineGeometry g;
    g.point = body_point(x, body_particles[pair.x] + offset, point_weights);
    if (pair.y >= 0) {
        const glm::ivec4 line_particles = body_particles[pair.y] + offset;
        g.middle = body_point(x, line_particles, (w0 + w1) * 0.5f);
        g.direction = body_point(x, line_particles, w1 - w0);
    } else {
        g.middle = (end0 + end1) * 0.5f;
        g.direction = end1 - end0;
    }
    return g;
}

// Segment parameter s = clamp(rel . d / |d|^2, -1/2, 1/2) of a joint point-line and its frozen projector
// P = I - d d^T / |d|^2 while s is strictly inside (else I; s = 0 and P = I for |d|^2 <= 1e-12). |d|^2 is the trace
// of d d^T. Writes P to `projector` and returns s.
template <bool XFirst>
__device__ __forceinline__ float point_line_projection(const glm::vec3& d, const glm::vec3& rel, glm::mat3* projector)
{
    const glm::mat3 dd = glm::outerProduct(d, d);
    const float length2 = dd[0][0] + dd[1][1] + dd[2][2];
    *projector = glm::mat3(1.0f);
    if (length2 <= 1e-12f) return 0.0f;
    // The state initialisation rounds x first (explicit fmaf); the update uses glm::dot.
    const float t = (XFirst ? fmaf(rel.z, d.z, fmaf(rel.y, d.y, rel.x * d.x)) : glm::dot(rel, d)) / length2;
    const float s = fminf(0.5f, fmaxf(-0.5f, t));
    if (t > -0.5f && t < 0.5f) *projector = glm::mat3(1.0f) - dd / length2;
    return s;
}

// Start of a step for the joint point-lines (the last `joints_per_world` lines): s and P from p - mid, lambda = 0.
__global__ void initialize_joint_body_point_line_state(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const glm::vec3* end0, const glm::vec3* end1,
    float* segment, glm::vec3* multiplier, glm::mat3* projector, size_t count, size_t lines_per_world,
    size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const PointLineGeometry g = point_line_geometry(x, body_particles, bodies[line], point_weights[line],
                                                    end0_weights[line], end1_weights[line], end0[line], end1[line],
                                                    offset);
    segment[i] = point_line_projection<true>(g.direction, g.point - g.middle, &projector[i]);
    multiplier[i] = glm::vec3(0.0f);
}

// Joint point-line force: c = (mid + s d - p) + lambda, f = k alpha P c. Point body proxies get w_p f, line body
// proxies wq (-f) with wq = (w0 + w1) / 2 + s (w1 - w0).
__global__ void evaluate_joint_body_point_line_augmented_lagrangian_force(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const glm::vec3* end0, const glm::vec3* end1,
    const float* stiffness, const float* segment, const glm::vec3* multiplier, const glm::mat3* projector,
    float alpha, glm::vec3* force, size_t count, size_t lines_per_world, size_t joints_per_world,
    size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const PointLineGeometry g = point_line_geometry(x, body_particles, pair, point_weights[line],
                                                    end0_weights[line], end1_weights[line], end0[line], end1[line],
                                                    offset);
    const float s = segment[i];
    const glm::vec3 c = g.direction * s + g.middle - g.point + multiplier[i];
    const glm::vec3 f = projector[i] * c * (stiffness[line] * alpha);
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    const glm::vec4& wp = point_weights[line];
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[point_particles[slot]], wp[slot] * f);
    if (pair.y < 0) return;
    const glm::vec4& w0 = end0_weights[line];
    const glm::vec4& w1 = end1_weights[line];
    const glm::vec4 wq = (w0 + w1) * 0.5f + s * (w1 - w0);
    const glm::ivec4 line_particles = body_particles[pair.y] + offset;
    const glm::vec3 negative = -f;
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[line_particles[slot]], wq[slot] * negative);
}

// After a Newton iteration: s and P from p - lambda; with the multiplier step, lambda = P ((lambda + q) - p) for the
// segment point q = mid + s d, then s and P again from p - lambda.
__global__ void update_joint_body_point_line_augmented_lagrangian_state(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const glm::vec3* end0, const glm::vec3* end1,
    float* segment, glm::vec3* multiplier, glm::mat3* projector, bool update_multiplier, size_t count,
    size_t lines_per_world, size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const PointLineGeometry g = point_line_geometry(x, body_particles, bodies[line], point_weights[line],
                                                    end0_weights[line], end1_weights[line], end0[line], end1[line],
                                                    offset);
    glm::vec3 lambda = multiplier[i];
    glm::mat3 p;
    float s = point_line_projection<false>(g.direction, g.point - lambda - g.middle, &p);
    if (update_multiplier) {
        const glm::vec3 q = g.direction * s + g.middle;
        lambda = p * (lambda + q - g.point);
        s = point_line_projection<false>(g.direction, g.point - lambda - g.middle, &p);
    }
    segment[i] = s;
    multiplier[i] = lambda;
    projector[i] = p;
}

// Line-body weights of a joint point-line at segment parameter s: (w0 + w1) / 2 + s (w1 - w0).
__device__ __forceinline__ glm::vec4 segment_weights(const glm::vec4& w0, const glm::vec4& w1, float s)
{
    return (w0 + w1) * 0.5f + s * (w1 - w0);
}

// PD_NEWTON block preconditioner of the joint point-lines: w (k w) P on the diagonal block of every point-body
// proxy, then of every line-body proxy (weights at the current segment parameter); k = stiffness alpha.
__global__ void add_joint_body_point_line_augmented_lagrangian_preconditioner(
    const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const float* stiffness, const float* segment,
    const glm::mat3* projector, float alpha, glm::mat3* preconditioner, size_t count, size_t lines_per_world,
    size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const float k = stiffness[line] * alpha;
    const glm::mat3& p = projector[i];
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    const glm::vec4& wp = point_weights[line];
    for (int slot = 0; slot < 4; ++slot) atomic_add(&preconditioner[point_particles[slot]], wp[slot] * (k * wp[slot]) * p);
    if (pair.y < 0) return;
    const glm::vec4 wq = segment_weights(end0_weights[line], end1_weights[line], segment[i]);
    const glm::ivec4 line_particles = body_particles[pair.y] + offset;
    for (int slot = 0; slot < 4; ++slot) atomic_add(&preconditioner[line_particles[slot]], wq[slot] * (k * wq[slot]) * p);
}

// PD_NEWTON matrix-free tangent of the joint point-lines: f = k P (J_p v - J_q v) with k = stiffness alpha; point
// proxies get f w_p, line proxies wq (-f). Without a line body the subtracted line term is +0.
__global__ void multiply_joint_body_point_line_augmented_lagrangian(
    const glm::vec3* v, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const float* stiffness, const float* segment,
    const glm::mat3* projector, float alpha, glm::vec3* product, size_t count, size_t lines_per_world,
    size_t joints_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    const glm::vec4& wp = point_weights[line];
    const glm::vec4 wq = segment_weights(end0_weights[line], end1_weights[line], segment[i]);
    glm::ivec4 line_particles(0);
    glm::vec3 line_motion(0.0f);
    if (pair.y >= 0) {
        line_particles = body_particles[pair.y] + offset;
        line_motion = body_point(v, line_particles, wq);
    }
    const glm::vec3 f = projector[i] * (body_point(v, point_particles, wp) - line_motion) * (stiffness[line] * alpha);
    for (int slot = 0; slot < 4; ++slot) atomic_add(&product[point_particles[slot]], f * wp[slot]);
    if (pair.y < 0) return;
    const glm::vec3 negative = -f;
    for (int slot = 0; slot < 4; ++slot) atomic_add(&product[line_particles[slot]], wq[slot] * negative);
}

// Body spring Gauss-Newton correction on top of the host's constant k I: K = k (M - I) with
// M = n n^T + max(0, 1 - rest/|d|) (I - n n^T) (M = I for |d| <= 1e-8; |d|^2 rounds x^2 first). Springs with
// rest <= 0 or k <= 0 are skipped. The Jacobian entries are -w0 on body 0's proxies and w1 on body 1's; entry a gets
// K w_a^2 on its diagonal block and every later entry b gets K w_a w_b at (a, b) and (b, a) (the diagonal block
// when both are the same particle, else the block-ELL entry).
__global__ void add_body_spring_gauss_newton_hessian(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec3* anchor0,
    const glm::vec3* anchor1, const glm::vec4* weights0, const glm::vec4* weights1, const float* stiffness,
    const float* rest_length, glm::mat3* diagonal, const int* row_count, BlockNonZeroEntry* entries,
    size_t max_count, size_t count, size_t springs_per_world, size_t particles_per_world, size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / springs_per_world;
    const size_t spring = i % springs_per_world;
    const float rest = rest_length[spring];
    const float k = stiffness[spring];
    if (rest <= 0.0f || !(k > 0.0f)) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[spring];
    int ids[8];
    float weights[8];
    int n = 0;
    glm::vec3 p0 = anchor0[spring];
    glm::vec3 p1 = anchor1[spring];
    if (pair.x >= 0) {
        const glm::ivec4 particles = body_particles[pair.x] + offset;
        const glm::vec4& w = weights0[spring];
        p0 = body_point(x, particles, w);
        for (int slot = 0; slot < 4; ++slot, ++n) {
            ids[n] = particles[slot];
            weights[n] = -w[slot];
        }
    }
    if (pair.y >= 0) {
        const glm::ivec4 particles = body_particles[pair.y] + offset;
        const glm::vec4& w = weights1[spring];
        p1 = body_point(x, particles, w);
        for (int slot = 0; slot < 4; ++slot, ++n) {
            ids[n] = particles[slot];
            weights[n] = w[slot];
        }
    }
    const glm::vec3 d = p1 - p0;
    const float length = std::sqrt(fmaf(d.z, d.z, fmaf(d.y, d.y, d.x * d.x)));
    glm::mat3 m(1.0f);
    if (length > 1e-8f) {
        const glm::vec3 unit = d / length;
        const glm::mat3 nn = glm::outerProduct(unit, unit);
        m = (glm::mat3(1.0f) - nn) * fmaxf(0.0f, 1.0f - rest / length) + nn;
    }
    const glm::mat3 correction = k * (m - glm::mat3(1.0f));
    for (int a = 0; a < n; ++a) {
        atomic_add(&diagonal[ids[a]], correction * (weights[a] * weights[a]));
        for (int b = a + 1; b < n; ++b) {
            const glm::mat3 block = correction * (weights[a] * weights[b]);
            if (ids[a] == ids[b]) atomic_add(&diagonal[ids[a]], block);
            else atomic_add_block(row_count, entries, max_count, rows, ids[a], ids[b], block);
            if (ids[a] == ids[b]) atomic_add(&diagonal[ids[b]], block);
            else atomic_add_block(row_count, entries, max_count, rows, ids[b], ids[a], block);
        }
    }
}

// Adds a symmetric pair of Jacobian-entry blocks: `block` at (a, b) and `transposed` at (b, a), into the diagonal
// when both entries are the same particle, else into the block-ELL matrix.
__device__ __forceinline__ void add_pair_blocks(glm::mat3* diagonal, const int* row_count, BlockNonZeroEntry* entries,
                                                size_t max_count, size_t rows, int a, int b, const glm::mat3& block,
                                                const glm::mat3& transposed)
{
    if (a == b) atomic_add(&diagonal[a], block);
    else atomic_add_block(row_count, entries, max_count, rows, a, b, block);
    if (a == b) atomic_add(&diagonal[b], transposed);
    else atomic_add_block(row_count, entries, max_count, rows, b, a, transposed);
}

// Joint point-line Gauss-Newton Hessian: Jacobian entries -w_p (point body) and wq (line body, weights at the
// current segment parameter); entry a gets P w_a (k w_a) on its diagonal block, every later b gets P (k w_a) w_b at
// (a, b) and (b, a). k = stiffness alpha; lines with k <= 0 are skipped.
__global__ void add_joint_body_point_line_gauss_newton_hessian(
    const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const float* stiffness, const float* segment,
    const glm::mat3* projector, float alpha, glm::mat3* diagonal, const int* row_count, BlockNonZeroEntry* entries,
    size_t max_count, size_t count, size_t lines_per_world, size_t joints_per_world, size_t particles_per_world,
    size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / joints_per_world;
    const size_t line = i % joints_per_world + (lines_per_world - joints_per_world);
    const float k = stiffness[line] * alpha;
    if (!(k > 0.0f)) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const glm::vec4 wq = segment_weights(end0_weights[line], end1_weights[line], segment[i]);
    int ids[8];
    float weights[8];
    int n = 0;
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    for (int slot = 0; slot < 4; ++slot, ++n) {
        ids[n] = point_particles[slot];
        weights[n] = -point_weights[line][slot];
    }
    if (pair.y >= 0) {
        const glm::ivec4 line_particles = body_particles[pair.y] + offset;
        for (int slot = 0; slot < 4; ++slot, ++n) {
            ids[n] = line_particles[slot];
            weights[n] = wq[slot];
        }
    }
    const glm::mat3& p = projector[i];
    for (int a = 0; a < n; ++a) {
        const float ka = k * weights[a];
        atomic_add(&diagonal[ids[a]], p * (weights[a] * ka));
        for (int b = a + 1; b < n; ++b) {
            const glm::mat3 block = p * (ka * weights[b]);
            add_pair_blocks(diagonal, row_count, entries, max_count, rows, ids[a], ids[b], block, block);
        }
    }
}

// Point-line penalty Gauss-Newton Hessian k (J_a^T J_b - s_a s_b I) for the residual q(t) - p, with the
// closest-point parameter t differentiated while strictly inside the segment (|d|^2 > 1e-12, 0 < t < 1).
// r = p - a, d = b - a, g = r - 2 t d. Entry Jacobians J = d v^T + base I (base I alone outside the interior):
//   point slot (weight w):   base = (0 t + 0) - w,        v = (d w + g 0) / |d|^2,              s = -w;
//   line slot (we0, we1):    base = t (we1 - we0) + we0,  v = (d (0 - we0) + g (we1 - we0)) / |d|^2,
//                            s = (we0 + we1) / 2.
// The s s I term removes the constant part held by the host templates. Joint lines are skipped unless
// include_joints (stiffness alpha k); lines with k <= 0 are skipped.
__global__ void add_body_point_line_gauss_newton_hessian(
    const glm::vec3* x, const glm::ivec4* body_particles, const glm::ivec2* bodies, const glm::vec4* point_weights,
    const glm::vec4* end0_weights, const glm::vec4* end1_weights, const glm::vec3* end0, const glm::vec3* end1,
    const float* stiffness, float alpha, size_t joint_count, bool include_joints, glm::mat3* diagonal,
    const int* row_count, BlockNonZeroEntry* entries, size_t max_count, size_t count, size_t lines_per_world,
    size_t particles_per_world, size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / lines_per_world;
    const size_t line = i % lines_per_world;
    const size_t first_joint = lines_per_world - joint_count;
    if (line >= first_joint && !include_joints) return;
    const float k = (line >= first_joint ? alpha : 1.0f) * stiffness[line];
    if (!(k > 0.0f)) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[line];
    const glm::ivec4 point_particles = body_particles[pair.x] + offset;
    const glm::vec4& wp = point_weights[line];
    const glm::vec3 p = body_point(x, point_particles, wp);
    glm::vec3 a = end0[line];
    glm::vec3 b = end1[line];
    const glm::vec4& w0 = end0_weights[line];
    const glm::vec4& w1 = end1_weights[line];
    glm::ivec4 line_particles(0);
    if (pair.y >= 0) {
        line_particles = body_particles[pair.y] + offset;
        a = body_point(x, line_particles, w0);
        b = body_point(x, line_particles, w1);
    }
    const glm::vec3 r = p - a;
    const glm::vec3 d = b - a;
    const float dd = glm::dot(d, d);
    float t_raw = 0.0f;
    if (dd > 1e-12f) t_raw = glm::dot(r, d) / dd;
    const float t = fminf(fmaxf(t_raw, 0.0f), 1.0f);
    const bool interior = dd > 1e-12f && t_raw > 0.0f && t_raw < 1.0f;
    const glm::vec3 g = r - d * (t + t);
    int ids[8];
    float scales[8];
    glm::mat3 jacobians[8];
    int n = 0;
    for (int slot = 0; slot < 4; ++slot, ++n) {
        const float w = wp[slot];
        const float base = t * 0.0f + 0.0f - w;
        ids[n] = point_particles[slot];
        scales[n] = -w;
        jacobians[n] = interior ? glm::outerProduct(d, (d * w + g * 0.0f) / dd) + base * glm::mat3(1.0f)
                                : base * glm::mat3(1.0f);
    }
    if (pair.y >= 0) {
        for (int slot = 0; slot < 4; ++slot, ++n) {
            const float we0 = w0[slot], we1 = w1[slot];
            const float dw = we1 - we0;
            const float base = t * dw + we0;
            ids[n] = line_particles[slot];
            scales[n] = (we0 + we1) * 0.5f;
            jacobians[n] = interior ? glm::outerProduct(d, (d * (0.0f - we0) + g * dw) / dd) + base * glm::mat3(1.0f)
                                    : base * glm::mat3(1.0f);
        }
    }
    for (int ea = 0; ea < n; ++ea) {
        const glm::mat3 ja_t = glm::transpose(jacobians[ea]);
        const float s2 = scales[ea] * scales[ea];
        atomic_add(&diagonal[ids[ea]], k * (ja_t * jacobians[ea] - s2 * glm::mat3(1.0f)));
        for (int eb = ea + 1; eb < n; ++eb) {
            const glm::mat3 block = k * (ja_t * jacobians[eb] - scales[ea] * scales[eb] * glm::mat3(1.0f));
            add_pair_blocks(diagonal, row_count, entries, max_count, rows, ids[ea], ids[eb], block,
                            glm::transpose(block));
        }
    }
}

// Rotation frame of a revolute drive: axis u from the parent origin to the parent axis point, the parent and child
// reference directions projected perpendicular to u and normalised (ph, ch), and the child angle (sin, cos)
// relative to the parent. Returns false (the kernels skip the drive) for degenerate or non-finite frames.
struct AngleFrame {
    glm::vec3 u;
    float length;
    float projection_parent, projection_child;
    float norm_parent, norm_child;
    glm::vec3 parent, child;
    float sin, cos;
};

__device__ __forceinline__ bool angle_frame(const glm::vec3& parent_origin, const glm::vec3& parent_axis,
                                            const glm::vec3& parent_reference, const glm::vec3& child_origin,
                                            const glm::vec3& child_reference, AngleFrame& f)
{
    const glm::vec3 d = parent_axis - parent_origin;
    f.length = glm::length(d);
    if (!(f.length > 1e-8f) || !(f.length < INFINITY)) return false;
    f.u = d / f.length;
    const glm::vec3 ep = parent_reference - parent_origin;
    f.projection_parent = glm::dot(ep, f.u);
    const glm::vec3 perpendicular_parent = ep - f.u * f.projection_parent;
    const glm::vec3 ec = child_reference - child_origin;
    f.projection_child = glm::dot(f.u, ec);
    const glm::vec3 perpendicular_child = ec - f.u * f.projection_child;
    f.norm_parent = glm::length(perpendicular_parent);
    f.norm_child = glm::length(perpendicular_child);
    if (!(f.norm_parent > 1e-8f) || !(f.norm_child > 1e-8f) || !(f.norm_parent < INFINITY) ||
        !(f.norm_child < INFINITY))
        return false;
    f.parent = perpendicular_parent / f.norm_parent;
    f.child = perpendicular_child / f.norm_child;
    f.sin = glm::dot(f.u, glm::cross(f.parent, f.child));
    f.cos = glm::dot(f.parent, f.child);
    const float magnitude = f.cos * f.cos + f.sin * f.sin;
    return magnitude > 1e-12f && magnitude < INFINITY;
}

// The five drive points: parent origin / axis point / reference point (on the parent body, or fixed in world space
// when the parent index is negative) and child origin / reference point (on the child body).
struct DrivePoints {
    glm::vec3 parent_origin, parent_axis, parent_reference, child_origin, child_reference;
};

__device__ __forceinline__ DrivePoints drive_points(const glm::vec3* x, const glm::ivec4* body_particles,
                                                   const glm::ivec2& pair, const glm::vec3& po, const glm::vec3& pa,
                                                   const glm::vec3& pr, const glm::vec4& w_po, const glm::vec4& w_co,
                                                   const glm::vec4& w_pa, const glm::vec4& w_pr,
                                                   const glm::vec4& w_cr, int offset)
{
    DrivePoints points;
    if (pair.x >= 0) {
        const glm::ivec4 parent = body_particles[pair.x] + offset;
        points.parent_origin = body_point(x, parent, w_po);
        points.parent_axis = body_point(x, parent, w_pa);
        points.parent_reference = body_point(x, parent, w_pr);
    } else {
        points.parent_origin = po;
        points.parent_axis = pa;
        points.parent_reference = pr;
    }
    const glm::ivec4 child = body_particles[pair.y] + offset;
    points.child_origin = body_point(x, child, w_co);
    points.child_reference = body_point(x, child, w_cr);
    return points;
}

// After update_velocity: for revolute drives (type 1) store the current angle unwrapped to within half a turn of
// the stored angle (or as is on first use) and mark the state initialised.
__global__ void update_joint_drive_angle_state(const glm::vec3* x, float* angle, int* initialized,
                                               const glm::ivec4* body_particles, const int* types,
                                               const glm::ivec2* bodies, const glm::vec3* parent_origin,
                                               const glm::vec3* parent_axis, const glm::vec3* parent_reference,
                                               const glm::vec4* w_po, const glm::vec4* w_co, const glm::vec4* w_pa,
                                               const glm::vec4* w_pr, const glm::vec4* w_cr, size_t count,
                                               size_t drives_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / drives_per_world;
    const size_t drive = i % drives_per_world;
    if (types[drive] != 1) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const DrivePoints points = drive_points(x, body_particles, bodies[drive], parent_origin[drive],
                                            parent_axis[drive], parent_reference[drive], w_po[drive], w_co[drive],
                                            w_pa[drive], w_pr[drive], w_cr[drive], offset);
    AngleFrame f;
    if (!angle_frame(points.parent_origin, points.parent_axis, points.parent_reference, points.child_origin,
                     points.child_reference, f))
        return;
    const float theta = atan2f(f.sin, f.cos);
    const float reference = initialized[i] != 0 ? angle[i] : theta;
    const float two_pi = 6.28318548f;
    angle[i] = roundf((reference - theta) / two_pi) * two_pi + theta;
    initialized[i] = 1;
}

// Drive torque/force law shared by revolute and prismatic drives (q0, v0: start-of-step coordinate and velocity,
// dq = q - q0):
//   load = clamp(ke (q* - q0) [position modes] + kd (v* - v0) [velocity modes] or -kd v0 [mode 1], +-effort),
//   tau  = feed + load - c v0 - (kd_eff + c) (dq / h - v0)
// Modes: bit pattern (mode | 2) == 3 enables the position term, (mode | 1) == 3 the target velocity; without a
// mode array every drive is mode 3. kd_eff = kd for modes 1..3 (or without modes), else 0.
__device__ __forceinline__ float drive_load(float q0, float dq, float v0, int mode, bool has_modes, float target_q,
                                            float target_qd, float ke, float kd, float effort, float damping,
                                            float feed, float inverse_dt)
{
    float load = 0.0f;
    if ((mode | 2) == 3) load += (target_q - q0) * ke;
    if (mode == 1) load -= v0 * kd;
    else if ((mode | 1) == 3) load += (target_qd - v0) * kd;
    load = fminf(effort, fmaxf(-effort, load));
    float tau = feed + load - v0 * damping;
    const float kd_effective = !has_modes || (mode >= 1 && mode <= 3) ? kd : 0.0f;
    const float rate = dq * inverse_dt - v0;
    tau -= rate * (kd_effective + damping);
    return tau;
}

// Joint drive loads. Revolute drives (type != 0): q from atan2 of the angle frame, unwrapped against the stored
// start-of-step angle (initialised from the previous positions on first use), applied through the angle Jacobian
// of the child and parent reference points. Prismatic drives (type 0): q is the child-origin displacement along
// the parent axis, applied along the axis to the child and, with a parent body, through the axis-rotation lever.
// Gains, effort, mode and damping are indexed by the drive's dof; feed-forward and target velocity by the dof of
// the world, target position by the target index of the world; velocity and angle state by the drive instance.
__global__ void evaluate_joint_drive_load(
    const glm::vec3* x, const glm::vec3* previous, const float* qd, float* angle, int* initialized,
    const glm::ivec4* body_particles, const int* types, const glm::ivec2* bodies, const glm::vec3* parent_origin,
    const glm::vec3* parent_axis, const glm::vec3* parent_reference, const glm::vec4* w_po, const glm::vec4* w_co,
    const glm::vec4* w_pa, const glm::vec4* w_pr, const glm::vec4* w_cr, const int* dofs, const int* targets,
    const float* ke, const float* kd, const float* effort, const int* modes, const float* damping,
    const float* feed, const float* target_q, const float* target_qd, glm::vec3* force, size_t count,
    size_t drives_per_world, size_t particles_per_world, size_t dofs_per_world, size_t targets_per_world,
    float inverse_dt)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / drives_per_world;
    const size_t drive = i % drives_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[drive];
    const DrivePoints now = drive_points(x, body_particles, pair, parent_origin[drive], parent_axis[drive],
                                         parent_reference[drive], w_po[drive], w_co[drive], w_pa[drive],
                                         w_pr[drive], w_cr[drive], offset);
    const int dof = dofs[drive];
    const int world_dof = dof + static_cast<int>(world * dofs_per_world);
    const int world_target = targets[drive] + static_cast<int>(world * targets_per_world);
    const int mode = modes != nullptr ? modes[dof] : 3;
    const float c = damping != nullptr ? damping[dof] : 0.0f;
    const float v0 = qd[i];
    const glm::ivec4 child = body_particles[pair.y] + offset;
    if (types[drive] == 0) {
        const glm::vec3 axis = now.parent_axis - now.parent_origin;
        const float length = glm::length(axis);
        const glm::vec3 u = length > 0.0f ? axis / length : glm::vec3(0.0f);
        if (glm::length(u) <= 1e-8f) return;
        const glm::vec3 d = now.child_origin - now.parent_origin;
        const float displacement = glm::dot(d, u);
        const DrivePoints before = drive_points(previous, body_particles, pair, parent_origin[drive],
                                                parent_axis[drive], parent_reference[drive], w_po[drive],
                                                w_co[drive], w_pa[drive], w_pr[drive], w_cr[drive], offset);
        const glm::vec3 axis0 = before.parent_axis - before.parent_origin;
        const float length0 = std::sqrt(fmaf(axis0.z, axis0.z, fmaf(axis0.y, axis0.y, axis0.x * axis0.x)));
        const glm::vec3 u0 = length0 > 0.0f ? axis0 / length0 : glm::vec3(0.0f);
        if (glm::length(u0) <= 1e-8f) return;
        const float displacement0 = glm::dot(before.child_origin - before.parent_origin, u0);
        const float tau = drive_load(displacement0, displacement - displacement0, v0, mode, modes != nullptr,
                                     target_q[world_target], target_qd[world_dof], ke[dof], kd[dof], effort[dof], c,
                                     feed[world_dof], inverse_dt);
        if (!(std::abs(tau) < INFINITY) || !(std::abs(tau) > 1e-12f)) return;
        const glm::vec3 tu = tau * u;
        for (int slot = 0; slot < 4; ++slot) atomic_add(&force[child[slot]], tu * w_co[drive][slot]);
        if (pair.x < 0 || !(length > 1e-8f)) return;
        const glm::ivec4 parent = body_particles[pair.x] + offset;
        const glm::vec3 lever = (d - displacement * u) / length;
        const glm::vec3 an = (lever + u) * -tau;
        for (int slot = 0; slot < 4; ++slot) atomic_add(&force[parent[slot]], an * w_po[drive][slot]);
        const glm::vec3 et = lever * tau;
        for (int slot = 0; slot < 4; ++slot) atomic_add(&force[parent[slot]], et * w_pa[drive][slot]);
        return;
    }
    AngleFrame f;
    if (!angle_frame(now.parent_origin, now.parent_axis, now.parent_reference, now.child_origin,
                     now.child_reference, f))
        return;
    const float theta = atan2f(f.sin, f.cos);
    const glm::vec3 upc = glm::cross(f.u, f.parent);
    const glm::vec3 ucc = glm::cross(f.u, f.child);
    const float sp = f.projection_parent / f.norm_parent;
    const float sc = f.projection_child / f.norm_child;
    // The legacy PTX has mul; mul; sub here and ptxas fuses the subtrahend: fma(-sc, ucc, sp upc). Written out so
    // that LLVM cannot contract the other product instead.
    const glm::vec3 axis_term = glm::vec3(fmaf(-sc, ucc.x, sp * upc.x), fmaf(-sc, ucc.y, sp * upc.y),
                                          fmaf(-sc, ucc.z, sp * upc.z)) / f.length;
    const glm::vec3 gp = upc / f.norm_parent;
    const glm::vec3 gp_negative = -upc / f.norm_parent;
    const glm::vec3 gc_negative = -ucc / f.norm_child;
    const glm::vec3 gc = ucc / f.norm_child;
    const DrivePoints before = drive_points(previous, body_particles, pair, parent_origin[drive], parent_axis[drive],
                                            parent_reference[drive], w_po[drive], w_co[drive], w_pa[drive],
                                            w_pr[drive], w_cr[drive], offset);
    AngleFrame f0;
    if (!angle_frame(before.parent_origin, before.parent_axis, before.parent_reference, before.child_origin,
                     before.child_reference, f0))
        return;
    float theta0 = atan2f(f0.sin, f0.cos);
    if (initialized[i] != 0) {
        theta0 = angle[i];
    } else {
        angle[i] = theta0;
        initialized[i] = 1;
    }
    const float two_pi = 6.28318548f;
    const float q = roundf((theta0 - theta) / two_pi) * two_pi + theta;
    const float tau = drive_load(theta0, q - theta0, v0, mode, modes != nullptr, target_q[world_target],
                                 target_qd[world_dof], ke[dof], kd[dof], effort[dof], c, feed[world_dof],
                                 inverse_dt);
    if (!(std::abs(tau) < INFINITY) || !(std::abs(tau) > 1e-12f)) return;
    for (int slot = 0; slot < 4; ++slot)
        atomic_add(&force[child[slot]], tau * (gc_negative * w_co[drive][slot] + gc * w_cr[drive][slot]));
    if (pair.x < 0) return;
    const glm::ivec4 parent = body_particles[pair.x] + offset;
    const glm::vec3 difference = gp - axis_term;
    for (int slot = 0; slot < 4; ++slot)
        atomic_add(&force[parent[slot]], tau * (difference * w_po[drive][slot] + axis_term * w_pa[drive][slot] +
                                                gp_negative * w_pr[drive][slot]));
}

// Child and parent rows of the revolute drive Jacobian.
struct DriveJacobian {
    glm::vec3 child[4];
    glm::vec3 parent[4];
};

// These two drive kernels retain the explicit isfinite checks present in their legacy PTX.
// The load/state frame helper retains its existing arithmetic and comparison structure.
__device__ __forceinline__ bool drive_angle_frame(const glm::vec3& parent_origin, const glm::vec3& parent_axis,
                                            const glm::vec3& parent_reference, const glm::vec3& child_origin,
                                            const glm::vec3& child_reference, AngleFrame& f)
{
    const glm::vec3 d = parent_axis - parent_origin;
    f.length = glm::length(d);
    if (!(f.length > 1e-8f)) return false;
    if (!std::isfinite(f.length)) return false;
    f.u = d / f.length;
    const glm::vec3 ep = parent_reference - parent_origin;
    f.projection_parent = glm::dot(ep, f.u);
    const glm::vec3 perpendicular_parent = ep - f.u * f.projection_parent;
    const glm::vec3 ec = child_reference - child_origin;
    f.projection_child = glm::dot(f.u, ec);
    const glm::vec3 perpendicular_child = ec - f.u * f.projection_child;
    f.norm_parent = glm::length(perpendicular_parent);
    f.norm_child = glm::length(perpendicular_child);
    if (!(f.norm_parent > 1e-8f) || !(f.norm_child > 1e-8f)) return false;
    if (!std::isfinite(f.norm_parent) || !std::isfinite(f.norm_child)) return false;
    f.parent = perpendicular_parent / f.norm_parent;
    f.child = perpendicular_child / f.norm_child;
    f.sin = glm::dot(f.u, glm::cross(f.parent, f.child));
    f.cos = glm::dot(f.parent, f.child);
    const float magnitude = f.cos * f.cos + f.sin * f.sin;
    if (!(magnitude > 1e-12f)) return false;
    return std::isfinite(magnitude);
}

// Angle Jacobian rows, child slots before parent slots. Degenerate frames produce no rows.
__device__ __forceinline__ bool angle_jacobian(const DrivePoints& points, bool has_parent, const glm::vec4& w_po,
                                               const glm::vec4& w_co, const glm::vec4& w_pa, const glm::vec4& w_pr,
                                               const glm::vec4& w_cr, DriveJacobian& jacobian)
{
    AngleFrame f;
    if (!drive_angle_frame(points.parent_origin, points.parent_axis, points.parent_reference, points.child_origin,
                           points.child_reference, f))
        return false;
    const glm::vec3 upc = glm::cross(f.u, f.parent);
    const glm::vec3 ucc = glm::cross(f.u, f.child);
    const float sp = f.projection_parent / f.norm_parent;
    const float sc = f.projection_child / f.norm_child;
    const glm::vec3 axis_term = (sp * upc - sc * ucc) / f.length;
    const glm::vec3 gp = upc / f.norm_parent;
    const glm::vec3 gp_negative = -upc / f.norm_parent;
    const glm::vec3 gc_negative = -ucc / f.norm_child;
    const glm::vec3 gc = ucc / f.norm_child;
    for (int slot = 0; slot < 4; ++slot) jacobian.child[slot] = gc_negative * w_co[slot] + gc * w_cr[slot];
    if (has_parent) {
        const glm::vec3 difference = gp - axis_term;
        for (int slot = 0; slot < 4; ++slot)
            jacobian.parent[slot] = difference * w_po[slot] + axis_term * w_pa[slot] + gp_negative * w_pr[slot];
    }
    return true;
}

// Prismatic axis u = (axis point - origin) / |.| (zero for a zero-length axis).
// Keep the ordered <= rejection from legacy PTX, including its behavior for a non-finite normalized axis.
__device__ __forceinline__ bool prismatic_axis(const DrivePoints& points, glm::vec3& u, float& length)
{
    const glm::vec3 axis = points.parent_axis - points.parent_origin;
    length = glm::length(axis);
    u = length > 0.0f ? axis / length : glm::vec3(0.0f);
    return !(glm::length(u) <= 1e-8f);
}

// Derivative coefficient of the drive damping: (kd [if the mode uses it] + passive damping) / h; zero (drive
// skipped) unless positive and finite.
__device__ __forceinline__ float drive_tangent_scale(int dof, const int* modes, const float* damping, const float* kd,
                                                     float inverse_dt)
{
    const int mode = modes != nullptr ? modes[dof] : 3;
    const float kd_effective = modes == nullptr || (mode >= 1 && mode <= 3) ? kd[dof] : 0.0f;
    const float c = damping != nullptr ? damping[dof] : 0.0f;
    return (kd_effective + c) * inverse_dt;
}

// Drive damping preconditioner: s g g^T on the diagonal block of every Jacobian entry g (child slots, then parent
// slots). Prismatic rows: child w_co u, parent w_pa e - w_po (e + u) with the axis-rotation lever e.
__global__ void add_joint_drive_preconditioner(const glm::vec3* x, const glm::ivec4* body_particles, const int* types,
                                               const glm::ivec2* bodies, const glm::vec3* parent_origin,
                                               const glm::vec3* parent_axis, const glm::vec3* parent_reference,
                                               const glm::vec4* w_po, const glm::vec4* w_co, const glm::vec4* w_pa,
                                               const glm::vec4* w_pr, const glm::vec4* w_cr, const int* dofs,
                                               const int* modes, const float* damping, const float* kd,
                                               float inverse_dt, glm::mat3* preconditioner, size_t count,
                                               size_t drives_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / drives_per_world;
    const size_t drive = i % drives_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[drive];
    const DrivePoints points = drive_points(x, body_particles, pair, parent_origin[drive], parent_axis[drive],
                                            parent_reference[drive], w_po[drive], w_co[drive], w_pa[drive],
                                            w_pr[drive], w_cr[drive], offset);
    glm::vec3 u;
    float length;
    if (!prismatic_axis(points, u, length)) return;
    const float s = drive_tangent_scale(dofs[drive], modes, damping, kd, inverse_dt);
    if (!(s > 0.0f)) return;
    if (!std::isfinite(s)) return;
    const glm::ivec4 child = body_particles[pair.y] + offset;
    // Keep angular and prismatic atomic updates in their original divergent branches. Joining their
    // Jacobians before the writes changes the accumulation order when lanes share the same body.
    if (types[drive] != 0) {
        DriveJacobian jacobian;
        if (!angle_jacobian(points, pair.x >= 0, w_po[drive], w_co[drive], w_pa[drive], w_pr[drive], w_cr[drive],
                            jacobian)) return;
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot)
            atomic_add(&preconditioner[child[slot]], s * glm::outerProduct(jacobian.child[slot], jacobian.child[slot]));
        if (pair.x >= 0) {
            const glm::ivec4 parent = body_particles[pair.x] + offset;
            #pragma unroll
            for (int slot = 0; slot < 4; ++slot)
                atomic_add(&preconditioner[parent[slot]], s * glm::outerProduct(jacobian.parent[slot], jacobian.parent[slot]));
        }
        return;
    }
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
        const glm::vec3 row = w_co[drive][slot] * u;
        atomic_add(&preconditioner[child[slot]], s * glm::outerProduct(row, row));
    }
    if (pair.x < 0 || length <= 1e-8f) return;
    const glm::vec3 d = points.child_origin - points.parent_origin;
    const glm::vec3 lever = (d - glm::dot(d, u) * u) / length;
    const glm::vec3 a = lever + u;
    const glm::ivec4 parent = body_particles[pair.x] + offset;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
        const float wa = w_pa[drive][slot], wo = w_po[drive][slot];
        const glm::vec3 row = lever * wa - a * wo;
        atomic_add(&preconditioner[parent[slot]], s * glm::outerProduct(row, row));
    }
}

// Drive damping tangent J^T (s J p). Revolute: J p accumulated over child then parent rows from +0, skipped when
// s J p is not finite. Prismatic: J p = (dOc - dOp) . u [+ (dAp - dOp) . e with a parent].
__global__ void multiply_joint_drive_tangent(const glm::vec3* x, const glm::vec3* p, const glm::ivec4* body_particles,
                                             const int* types, const glm::ivec2* bodies,
                                             const glm::vec3* parent_origin, const glm::vec3* parent_axis,
                                             const glm::vec3* parent_reference, const glm::vec4* w_po,
                                             const glm::vec4* w_co, const glm::vec4* w_pa, const glm::vec4* w_pr,
                                             const glm::vec4* w_cr, const int* dofs, const int* modes,
                                             const float* damping, const float* kd, float inverse_dt,
                                             glm::vec3* product, size_t count, size_t drives_per_world,
                                             size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / drives_per_world;
    const size_t drive = i % drives_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec2 pair = bodies[drive];
    const DrivePoints points = drive_points(x, body_particles, pair, parent_origin[drive], parent_axis[drive],
                                            parent_reference[drive], w_po[drive], w_co[drive], w_pa[drive],
                                            w_pr[drive], w_cr[drive], offset);
    glm::vec3 u;
    float length;
    if (!prismatic_axis(points, u, length)) return;
    const float s = drive_tangent_scale(dofs[drive], modes, damping, kd, inverse_dt);
    if (!(s > 0.0f)) return;
    if (!std::isfinite(s)) return;
    const glm::ivec4 child = body_particles[pair.y] + offset;
    if (types[drive] == 0) {
        const glm::vec3 d_child = body_point(p, child, w_co[drive]);
        glm::vec3 d_origin(0.0f);
        glm::ivec4 parent(0);
        if (pair.x >= 0) {
            parent = body_particles[pair.x] + offset;
            d_origin = body_point(p, parent, w_po[drive]);
        }
        float jp = glm::dot(d_child - d_origin, u);
        // Preserve the legacy split: parented and parentless prismatic scatters occupy separate blocks.
        if (pair.x >= 0) {
            if (length <= 1e-8f) return;
            const glm::vec3 d_axis = body_point(p, parent, w_pa[drive]);
            const glm::vec3 d = points.child_origin - points.parent_origin;
            const glm::vec3 lever = (d - glm::dot(d, u) * u) / length;
            jp = jp + glm::dot(d_axis - d_origin, lever);
            const float y = s * jp;
            const glm::vec3 yu = y * u;
            for (int slot = 0; slot < 4; ++slot) atomic_add(&product[child[slot]], w_co[drive][slot] * yu);
            const glm::vec3 an = (lever + u) * -y;
            for (int slot = 0; slot < 4; ++slot) atomic_add(&product[parent[slot]], an * w_po[drive][slot]);
            const glm::vec3 ey = lever * y;
            for (int slot = 0; slot < 4; ++slot) atomic_add(&product[parent[slot]], ey * w_pa[drive][slot]);
            return;
        }
        const float y = s * jp;
        const glm::vec3 yu = y * u;
        for (int slot = 0; slot < 4; ++slot) atomic_add(&product[child[slot]], w_co[drive][slot] * yu);
        return;
    }
    DriveJacobian jacobian;
    const bool has_parent = pair.x >= 0;
    if (!angle_jacobian(points, has_parent, w_po[drive], w_co[drive], w_pa[drive], w_pr[drive], w_cr[drive],
                        jacobian))
        return;
    glm::ivec4 parent(0);
    if (has_parent) parent = body_particles[pair.x] + offset;
    float jp = 0.0f;
    for (int slot = 0; slot < 4; ++slot) jp = jp + glm::dot(jacobian.child[slot], p[child[slot]]);
    if (has_parent)
        for (int slot = 0; slot < 4; ++slot) jp = jp + glm::dot(jacobian.parent[slot], p[parent[slot]]);
    const float y = s * jp;
    if (!(std::abs(y) < INFINITY)) return;
    for (int slot = 0; slot < 4; ++slot) atomic_add(&product[child[slot]], y * jacobian.child[slot]);
    if (!has_parent) return;
    for (int slot = 0; slot < 4; ++slot) atomic_add(&product[parent[slot]], y * jacobian.parent[slot]);
}

// By-value joint geometry layout, shared by coordinate velocity, armature and angular-limit kernels.
struct JointCoordinateView {
    const glm::ivec4* body_particles;
    const int* types;
    const glm::ivec2* bodies;
    const glm::vec3* parent_origin;
    const glm::vec3* parent_axis;
    const glm::vec3* parent_reference;
    const glm::vec4* w_po;
    const glm::vec4* w_co;
    const glm::vec4* w_pa;
    const glm::vec4* w_pr;
    const glm::vec4* w_cr;
    const int* dofs;
    size_t joints_per_world;
    size_t count;
    size_t particles_per_world;
};
static_assert(sizeof(JointCoordinateView) == 120);
static_assert(offsetof(JointCoordinateView, joints_per_world) == 96);
static_assert(offsetof(JointCoordinateView, count) == 104);
static_assert(offsetof(JointCoordinateView, particles_per_world) == 112);

// Project particle velocity onto the joint coordinate. Rows accumulate child/parent interleaved for each slot;
// invalid geometry writes zero, whereas threads outside the view leave the output untouched.
__global__ void initialize_joint_coordinate_velocities(JointCoordinateView view, const glm::vec3* x,
                                                       const glm::vec3* velocity, float* coordinate_velocity)
{
    const size_t i = thread_index();
    if (i >= view.count) return;
    const size_t world = i / view.joints_per_world;
    const size_t joint = i % view.joints_per_world;
    const int offset = static_cast<int>(world * view.particles_per_world);
    const glm::ivec2 pair = view.bodies[joint];
    const DrivePoints points = drive_points(x, view.body_particles, pair, view.parent_origin[joint],
                                            view.parent_axis[joint], view.parent_reference[joint], view.w_po[joint],
                                            view.w_co[joint], view.w_pa[joint], view.w_pr[joint], view.w_cr[joint], offset);
    DriveJacobian jacobian;
    if (view.types[joint] != 0) {
        if (!angle_jacobian(points, pair.x >= 0, view.w_po[joint], view.w_co[joint], view.w_pa[joint],
                            view.w_pr[joint], view.w_cr[joint], jacobian)) {
            coordinate_velocity[i] = 0.0f;
            return;
        }
    } else {
        const glm::vec3 axis = points.parent_axis - points.parent_origin;
        const float length = glm::length(axis);
        if (length <= 1e-8f) {
            coordinate_velocity[i] = 0.0f;
            return;
        }
        const glm::vec3 u = axis / length;
        const glm::vec3 d = points.child_origin - points.parent_origin;
        const glm::vec3 lever = (d - glm::dot(d, u) * u) / length;
        const glm::vec3 a = u + lever;
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            jacobian.child[slot] = u * view.w_co[joint][slot];
            if (pair.x >= 0)
                jacobian.parent[slot] = lever * view.w_pa[joint][slot] - a * view.w_po[joint][slot];
        }
    }
    const glm::ivec4 child = view.body_particles[pair.y] + offset;
    glm::ivec4 parent(0);
    if (pair.x >= 0) parent = view.body_particles[pair.x] + offset;
    float projection = 0.0f;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
        projection = projection + glm::dot(jacobian.child[slot], velocity[child[slot]]);
        if (pair.x >= 0) projection = projection + glm::dot(jacobian.parent[slot], velocity[parent[slot]]);
    }
    coordinate_velocity[i] = projection;
}

// Armature Jacobians retain the angular axis-term contraction context of the coordinate/inertia kernels.
// This helper also returns the coordinate used by the force branch, avoiding a second current-frame evaluation.
__device__ __forceinline__ bool armature_rows(const JointCoordinateView& view, size_t joint,
                                              const DrivePoints& points, bool has_parent,
                                              DriveJacobian& jacobian, float& coordinate)
{
    if (view.types[joint] == 0) {
        const glm::vec3 axis = points.parent_axis - points.parent_origin;
        const float length = glm::length(axis);
        if (length <= 1e-8f) return false;
        const glm::vec3 u = axis / length;
        const glm::vec3 d = points.child_origin - points.parent_origin;
        coordinate = glm::dot(d, u);
        const glm::vec3 lever = (d - coordinate * u) / length;
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            jacobian.child[slot] = u * view.w_co[joint][slot];
            if (has_parent)
                jacobian.parent[slot] = lever * view.w_pa[joint][slot] - (u + lever) * view.w_po[joint][slot];
        }
        return true;
    }
    AngleFrame frame;
    if (!drive_angle_frame(points.parent_origin, points.parent_axis, points.parent_reference, points.child_origin,
                           points.child_reference, frame)) return false;
    coordinate = atan2f(frame.sin, frame.cos);
    const glm::vec3 upc = glm::cross(frame.u, frame.parent);
    const glm::vec3 ucc = glm::cross(frame.u, frame.child);
    const float sp = frame.projection_parent / frame.norm_parent;
    const float sc = frame.projection_child / frame.norm_child;
    // Emit the child product before the parent product, as in legacy PTX: the JIT contracts the latter.
    const glm::vec3 child_term = sc * ucc;
    const glm::vec3 parent_term = sp * upc;
    const glm::vec3 axis_term = (parent_term - child_term) / frame.length;
    const glm::vec3 gp = upc / frame.norm_parent;
    const glm::vec3 gp_negative = -upc / frame.norm_parent;
    const glm::vec3 gc = ucc / frame.norm_child;
    const glm::vec3 gc_negative = -ucc / frame.norm_child;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
        jacobian.child[slot] = gc_negative * view.w_co[joint][slot] + gc * view.w_cr[joint][slot];
        if (has_parent)
            jacobian.parent[slot] = (gp - axis_term) * view.w_po[joint][slot] +
                                    axis_term * view.w_pa[joint][slot] + gp_negative * view.w_pr[joint][slot];
    }
    return true;
}

// Previous joint coordinate. The prismatic length rejection is ordered, as in the legacy force path.
__device__ __forceinline__ bool armature_coordinate(const DrivePoints& points, int type, float& coordinate)
{
    if (type == 0) {
        const glm::vec3 axis = points.parent_axis - points.parent_origin;
        const float length = glm::length(axis);
        if (length <= 1e-8f) return false;
        coordinate = glm::dot(points.child_origin - points.parent_origin, axis / length);
        return true;
    }
    AngleFrame frame;
    if (!drive_angle_frame(points.parent_origin, points.parent_axis, points.parent_reference, points.child_origin,
                           points.child_reference, frame)) return false;
    coordinate = atan2f(frame.sin, frame.cos);
    return true;
}

// Reflected joint inertia with s = (a * inverse_dt) * inverse_dt: diagonal s J^T J, tangent s J^T J p,
// or force s J^T (qd / inverse_dt - delta(q)).
// Block output takes priority over direction. Diagonal rows interleave child/parent; vector scatters do not.
__global__ void evaluate_joint_armature(JointCoordinateView view, const float* armature, const glm::vec3* x,
                                        const glm::vec3* previous, const float* qd, float inverse_dt,
                                        const glm::vec3* direction, glm::vec3* force, glm::mat3* block)
{
    const size_t i = thread_index();
    if (i >= view.count) return;
    const size_t joint = i % view.joints_per_world;
    const float a = armature[view.dofs[joint]];
    if (!(a > 0.0f)) return;
    const size_t world = i / view.joints_per_world;
    const int offset = static_cast<int>(world * view.particles_per_world);
    const glm::ivec2 pair = view.bodies[joint];
    const DrivePoints points = drive_points(x, view.body_particles, pair, view.parent_origin[joint],
                                            view.parent_axis[joint], view.parent_reference[joint], view.w_po[joint],
                                            view.w_co[joint], view.w_pa[joint], view.w_pr[joint], view.w_cr[joint], offset);
    const bool has_parent = pair.x >= 0;
    DriveJacobian jacobian;
    float coordinate;
    if (!armature_rows(view, joint, points, has_parent, jacobian, coordinate)) return;
    const glm::ivec4 child = view.body_particles[pair.y] + offset;
    glm::ivec4 parent(0);
    if (has_parent) parent = view.body_particles[pair.x] + offset;
    const float s = (a * inverse_dt) * inverse_dt;
    if (block != nullptr) {
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            atomic_add(&block[child[slot]], s * glm::outerProduct(jacobian.child[slot], jacobian.child[slot]));
            if (has_parent)
                atomic_add(&block[parent[slot]], s * glm::outerProduct(jacobian.parent[slot], jacobian.parent[slot]));
        }
        return;
    }
    float delta = 0.0f;
    if (direction != nullptr) {
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            delta = delta + glm::dot(jacobian.child[slot], direction[child[slot]]);
            if (has_parent) delta = delta + glm::dot(jacobian.parent[slot], direction[parent[slot]]);
        }
    } else {
        const DrivePoints before = drive_points(previous, view.body_particles, pair, view.parent_origin[joint],
                                                view.parent_axis[joint], view.parent_reference[joint], view.w_po[joint],
                                                view.w_co[joint], view.w_pa[joint], view.w_pr[joint], view.w_cr[joint], offset);
        float previous_coordinate;
        if (!armature_coordinate(before, view.types[joint], previous_coordinate)) return;
        delta = qd[i] / inverse_dt - (coordinate - previous_coordinate);
        if (view.types[joint] == 1) {
            const float two_pi = 6.28318548f;
            const float turns = delta / two_pi;
            const float rounded = truncf(__fadd_rz(turns, copysignf(0.5f, turns)));
            delta = delta - rounded * two_pi;
        }
    }
    const float tau = s * delta;
    if (!std::isfinite(tau)) return;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[child[slot]], tau * jacobian.child[slot]);
    if (!has_parent) return;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[parent[slot]], tau * jacobian.parent[slot]);
}

// By-value angular stop arrays. Geometry and state remain in JointCoordinateView and the per-world state arrays.
struct AngularLimitView {
    const float* lower;
    const float* upper;
    const float* stiffness;
    const float* damping;
};
static_assert(sizeof(AngularLimitView) == 32);
static_assert(offsetof(AngularLimitView, stiffness) == 16);
static_assert(offsetof(AngularLimitView, damping) == 24);

// One-sided angular stops for type 1 only. A nonzero finite restoring torque activates all three modes;
// the diagonal output has priority over direction, and the tangent projection has no second finite-value guard.
__global__ void evaluate_angular_limits(JointCoordinateView view, AngularLimitView limits, const glm::vec3* x,
                                        const glm::vec3* previous, const float* angle, const int* initialized,
                                        float inverse_dt, const glm::vec3* direction, glm::vec3* force, glm::mat3* block)
{
    const size_t i = thread_index();
    if (i >= view.count) return;
    const size_t joint = i % view.joints_per_world;
    if (view.types[joint] != 1) return;
    const int dof = view.dofs[joint];
    const float ke = limits.stiffness[dof];
    const float kd = limits.damping[dof];
    if (ke == 0.0f && kd == 0.0f) return;
    const size_t world = i / view.joints_per_world;
    const int offset = static_cast<int>(world * view.particles_per_world);
    const glm::ivec2 pair = view.bodies[joint];
    const bool has_parent = pair.x >= 0;
    const DrivePoints points = drive_points(x, view.body_particles, pair, view.parent_origin[joint],
                                            view.parent_axis[joint], view.parent_reference[joint], view.w_po[joint],
                                            view.w_co[joint], view.w_pa[joint], view.w_pr[joint], view.w_cr[joint], offset);
    DriveJacobian jacobian;
    float theta;
    if (!armature_rows(view, joint, points, has_parent, jacobian, theta)) return;
    float theta0;
    if (initialized[i] != 0) {
        theta0 = angle[i];
    } else {
        const DrivePoints before = drive_points(previous, view.body_particles, pair, view.parent_origin[joint],
                                                view.parent_axis[joint], view.parent_reference[joint], view.w_po[joint],
                                                view.w_co[joint], view.w_pa[joint], view.w_pr[joint], view.w_cr[joint], offset);
        if (!armature_coordinate(before, 1, theta0)) return;
    }
    const float two_pi = 6.28318548f;
    const float turns = (theta0 - theta) / two_pi;
    const float rounded = truncf(__fadd_rz(turns, copysignf(0.5f, turns)));
    const float q = fmaf(rounded, two_pi, theta);
    const float velocity = (q - theta0) * inverse_dt;
    float tau;
    if (q < limits.lower[dof]) {
        tau = fmaxf(0.0f, ke * (limits.lower[dof] - q) - kd * velocity);
    } else if (q > limits.upper[dof]) {
        tau = fminf(0.0f, ke * (limits.upper[dof] - q) - kd * velocity);
    } else {
        return;
    }
    if (tau == 0.0f) return;
    if (!std::isfinite(tau)) return;
    const float s = fmaf(kd, inverse_dt, ke);
    const glm::ivec4 child = view.body_particles[pair.y] + offset;
    glm::ivec4 parent(0);
    if (has_parent) parent = view.body_particles[pair.x] + offset;
    if (block != nullptr) {
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            atomic_add(&block[child[slot]], s * glm::outerProduct(jacobian.child[slot], jacobian.child[slot]));
            if (has_parent)
                atomic_add(&block[parent[slot]], s * glm::outerProduct(jacobian.parent[slot], jacobian.parent[slot]));
        }
        return;
    }
    if (direction != nullptr) {
        float projection = 0.0f;
        #pragma unroll
        for (int slot = 0; slot < 4; ++slot) {
            projection = projection + glm::dot(jacobian.child[slot], direction[child[slot]]);
            if (has_parent) projection = projection + glm::dot(jacobian.parent[slot], direction[parent[slot]]);
        }
        tau = s * projection;
    }
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[child[slot]], tau * jacobian.child[slot]);
    if (!has_parent) return;
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) atomic_add(&force[parent[slot]], tau * jacobian.parent[slot]);
}

}  // namespace synreal::kernel
