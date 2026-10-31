#pragma once
#include "cable_spin_math.cuh"

namespace synreal::kernel {

struct CableSpin {
    glm::mat3 rotation;
    glm::mat3 maps[3];
    bool inertia_weighted;
};

// Prepare needs the full double polar result before float conversion to build rotation differentials.
// Its arithmetic follows the separately verified rotation helper and keeps the two kernel contexts independent.
__device__ __forceinline__ CableSpin cable_rotation_spin(const glm::vec3& a0, const glm::vec3& a1,
                                                       const glm::vec3& a2, const float* inertia)
{
    CableSpin result;
    const glm::dvec3 a[3] = {glm::dvec3(a0), glm::dvec3(a1), glm::dvec3(a2)};
    const double half = ((static_cast<double>(inertia[0]) + inertia[4]) + inertia[8]) * 0.5;
    const double zero = half * 0.0;
    double j[3][3], scale = 0.0;
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        #pragma unroll
        for (int column = 0; column < 3; ++column) {
            j[row][column] = (row == column ? half : zero) - inertia[row * 3 + column];
            scale = fmax(scale, fabs(j[row][column]));
        }
    bool valid = scale > 0.0 && isfinite(scale);
    glm::dvec3 initial[3], current[3];
    if (valid) {
        #pragma unroll
        for (int column = 0; column < 3; ++column) {
            #pragma unroll
            for (int row = 0; row < 3; ++row)
                initial[column][row] = fma(j[column][2] / scale, a[2][row],
                    fma(j[column][0] / scale, a[0][row], (j[column][1] / scale) * a[1][row]));
            current[column] = initial[column];
        }
        for (int iteration = 0; iteration < 8; ++iteration) {
            const double determinant = cable_determinant(current);
            if (!(determinant > 1e-30) || !isfinite(determinant)) {
                valid = false;
                break;
            }
            const glm::dvec3 inverse[3] = {cable_cross(current[1], current[2]) / determinant,
                cable_cross(current[2], current[0]) / determinant, cable_cross(current[0], current[1]) / determinant};
            const double gamma = sqrt(sqrt(cable_norm_squared(inverse) / cable_norm_squared(current)));
            glm::dvec3 next[3], difference[3];
            #pragma unroll
            for (int column = 0; column < 3; ++column) {
                #pragma unroll
                for (int row = 0; row < 3; ++row)
                    next[column][row] = fma(gamma, current[column][row], inverse[column][row] / gamma) * 0.5;
                difference[column] = next[column] - current[column];
            }
            const double change = cable_norm_squared(difference);
            #pragma unroll
            for (int column = 0; column < 3; ++column) current[column] = next[column];
            if (change <= 1e-24) break;
        }
        if (valid) {
            double product[3][3], symmetric[3][3];
            #pragma unroll
            for (int row = 0; row < 3; ++row)
                #pragma unroll
                for (int column = 0; column < 3; ++column)
                    product[row][column] = fma(initial[2][row], current[2][column],
                        fma(initial[0][row], current[0][column], initial[1][row] * current[1][column]));
            #pragma unroll
            for (int row = 0; row < 3; ++row)
                #pragma unroll
                for (int column = 0; column < 3; ++column)
                    symmetric[row][column] = (product[row][column] + product[column][row]) * 0.5;
            const double trace = (symmetric[0][0] + symmetric[1][1]) + symmetric[2][2];
            const double trace_zero = trace * 0.0;
            glm::dvec3 hessian[3];
            #pragma unroll
            for (int column = 0; column < 3; ++column)
                #pragma unroll
                for (int row = 0; row < 3; ++row)
                    hessian[column][row] = (row == column ? trace : trace_zero) - symmetric[row][column];
            valid = cable_determinant(hessian) > 1e-30;
            if (valid) cable_weighted_spin_maps(current, j, scale, hessian, result.maps);
        }
    }
    result.inertia_weighted = valid;
    if (valid) result.rotation = glm::mat3(glm::vec3(current[0]), glm::vec3(current[1]), glm::vec3(current[2]));
    else {
        result.rotation = nearest_rotation(a0, a1, a2);
        const glm::vec3 columns[3] = {a0, a1, a2};
        cable_fallback_spin_maps(columns, result.rotation, result.maps);
    }
    return result;
}

} // namespace synreal::kernel
