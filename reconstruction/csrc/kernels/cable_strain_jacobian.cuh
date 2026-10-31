#pragma once
#include "cable_geometry.cuh"

namespace synreal::kernel {

// Preserve the authored zero products in each unit-axis cross derivative.
template<int Axis>
__device__ __forceinline__ glm::vec3 cable_axis_cross(const glm::vec3& v)
{
    if constexpr (Axis == 0)
        return glm::vec3(v.z * 0.0f - v.y * 0.0f, v.x * 0.0f - v.z, v.y - v.x * 0.0f);
    if constexpr (Axis == 1)
        return glm::vec3(v.z - v.y * 0.0f, v.x * 0.0f - v.z * 0.0f, v.y * 0.0f - v.x);
    return glm::vec3(v.z * 0.0f - v.y, v.x - v.z * 0.0f, v.y * 0.0f - v.x * 0.0f);
}

template<int Axis>
__device__ __forceinline__ float cable_axis_dot(const glm::vec3& v)
{
    if constexpr (Axis == 0) return fmaf(v.z, 0.0f, fmaf(v.y, 0.0f, v.x));
    if constexpr (Axis == 1) return fmaf(v.z, 0.0f, fmaf(v.x, 0.0f, v.y));
    return v.z + fmaf(v.x, 0.0f, v.y * 0.0f);
}

__device__ __forceinline__ glm::vec3 cable_bend_vector(const CableFrame& parent, const CableFrame& child)
{
    const glm::vec3 n = parent.basis[2], m = child.basis[2], cross = cable_cross(n, m);
    const float denominator = fmaxf(-1.0f, fminf(1.0f, contact_dot(n, m))) + 1.0f;
    if (denominator <= 1e-12f && contact_dot(cross, cross) <= 1e-12f)
        return cable_opposite_axis(n, parent.basis[0]) * 20.0f;
    glm::vec3 bend = cross * (2.0f / fmaxf(1e-12f, denominator));
    const float length = sqrtf(contact_dot(bend, bend));
    if (length > 20.0f) bend *= 20.0f / length;
    return bend;
}

template<bool Parent, int Axis>
__device__ __forceinline__ float cable_twist_derivative(const CableFrame& parent, const CableFrame& child,
    float denominator, const glm::vec3& dn, const glm::vec3& dm)
{
    const glm::vec3 n = parent.basis[2], m = child.basis[2];
    const float sign = Parent ? -1.0f : 1.0f;
    if (denominator <= 1e-8f) return Parent ? -cable_axis_dot<Axis>(n) : cable_axis_dot<Axis>(m);
    if (denominator > 0.02f) return sign * cable_axis_dot<Axis>((n + m) / denominator);

    // In the intermediate antiparallel region the native kernel differentiates
    // normalized parallel transport and atan2, rather than using the closed form.
    const glm::vec3 px = parent.basis[0], cx = child.basis[0];
    const glm::vec3 dpx = Parent ? cable_axis_cross<Axis>(px) : glm::vec3(0.0f);
    const glm::vec3 dcx = Parent ? glm::vec3(0.0f) : cable_axis_cross<Axis>(cx);
    const float numerator = contact_dot(m, px), quotient = numerator / denominator;
    const glm::vec3 sum = n + m, transported = px - sum * quotient;
    const float length = fmaxf(sqrtf(contact_dot(transported, transported)), 1e-12f);
    const glm::vec3 unit = transported / length;
    // Native transport derivatives separately round these products and sums.
    // Explicit rn prevents the compiler from fusing a different dot product.
    const float dc = __fadd_rn(__fadd_rn(__fmul_rn(m.z, dn.z),
        __fadd_rn(__fmul_rn(m.y, dn.y), __fmul_rn(m.x, dn.x))),
        __fadd_rn(__fadd_rn(__fmul_rn(n.x, dm.x), __fmul_rn(n.y, dm.y)), __fmul_rn(n.z, dm.z)));
    const float dnumerator = __fadd_rn(__fadd_rn(__fmul_rn(m.z, dpx.z),
        __fadd_rn(__fmul_rn(m.y, dpx.y), __fmul_rn(m.x, dpx.x))),
        __fadd_rn(__fadd_rn(__fmul_rn(dm.x, px.x), __fmul_rn(dm.y, px.y)), __fmul_rn(dm.z, px.z)));
    const float dquotient = (denominator * dnumerator - numerator * dc) / (denominator * denominator);
    const glm::vec3 dtransported = (dpx - sum * dquotient) - (dn + dm) * quotient;
    const glm::vec3 dunit = (dtransported - unit * contact_dot(unit, dtransported)) / length;
    const glm::vec3 cross = cable_cross(unit, cx);
    const float sine = contact_dot(m, cross), cosine = contact_dot(cx, unit);
    const float dsine = contact_dot(dm, cross) +
        contact_dot(m, cable_cross(dunit, cx) + cable_cross(unit, dcx));
    const float dcosine = contact_dot(dcx, unit) + contact_dot(cx, dunit);
    const float norm2 = fmaf(cosine, cosine, sine * sine);
    return (cosine * dsine - sine * dcosine) / fmaxf(1e-12f, norm2);
}

template<bool Parent, int Axis>
__device__ __forceinline__ glm::vec3 cable_angular_column(const CableFrame& parent, const CableFrame& child,
                                                        const glm::vec3& bend)
{
    const glm::vec3 n = parent.basis[2], m = child.basis[2];
    const glm::vec3 dn = Parent ? cable_axis_cross<Axis>(n) : glm::vec3(0.0f);
    const glm::vec3 dm = Parent ? glm::vec3(0.0f) : cable_axis_cross<Axis>(m);
    const glm::vec3 cross = cable_cross(n, m);
    const float denominator = fmaxf(-1.0f, fminf(1.0f, contact_dot(n, m))) + 1.0f;
    glm::vec3 derivative(0.0f);
    if (!(denominator <= 1e-12f) || !(contact_dot(cross, cross) <= 1e-12f)) {
        const float inverse = 1.0f / fmaxf(1e-12f, denominator), scale = inverse + inverse;
        const glm::vec3 uncapped = cross * scale;
        derivative = (cable_cross(dn, m) + cable_cross(n, dm)) * scale;
        if (denominator > 1e-12f)
            derivative = derivative - cross * ((contact_dot(m, dn) + contact_dot(dm, n)) * (inverse * scale));
        const float length = sqrtf(contact_dot(uncapped, uncapped));
        if (length > 20.0f)
            derivative = (20.0f / length) *
                (derivative - uncapped * (contact_dot(uncapped, derivative) / (length * length)));
    }
    if constexpr (Parent) derivative = derivative - cable_axis_cross<Axis>(bend);
    return glm::vec3(contact_dot(derivative, parent.basis[0]), contact_dot(derivative, parent.basis[1]),
        cable_twist_derivative<Parent, Axis>(parent, child, denominator, dn, dm));
}

template<bool Parent>
__device__ __forceinline__ glm::mat3 cable_angular_jacobian(const CableFrame& parent, const CableFrame& child)
{
    const glm::vec3 bend = cable_bend_vector(parent, child);
    return glm::mat3(cable_angular_column<Parent, 0>(parent, child, bend),
        cable_angular_column<Parent, 1>(parent, child, bend), cable_angular_column<Parent, 2>(parent, child, bend));
}

} // namespace synreal::kernel
