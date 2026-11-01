#include <cstdint>
#include <cstddef>
#include <iostream>
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
int main() {
std::cout << sizeof(RollingView) << "\n";
std::cout << "count " << offsetof(RollingView, count) << "\n";
std::cout << "capacity " << offsetof(RollingView, capacity) << "\n";
std::cout << "shape0 " << offsetof(RollingView, shape0) << "\n";
std::cout << "shape1 " << offsetof(RollingView, shape1) << "\n";
std::cout << "point0 " << offsetof(RollingView, point0) << "\n";
std::cout << "point1 " << offsetof(RollingView, point1) << "\n";
std::cout << "offset0 " << offsetof(RollingView, offset0) << "\n";
std::cout << "offset1 " << offsetof(RollingView, offset1) << "\n";
std::cout << "normal " << offsetof(RollingView, normal) << "\n";
std::cout << "margin0 " << offsetof(RollingView, margin0) << "\n";
std::cout << "margin1 " << offsetof(RollingView, margin1) << "\n";
std::cout << "shape_body " << offsetof(RollingView, shape_body) << "\n";
std::cout << "shape_type " << offsetof(RollingView, shape_type) << "\n";
std::cout << "transform " << offsetof(RollingView, transform) << "\n";
std::cout << "scale " << offsetof(RollingView, scale) << "\n";
std::cout << "ke " << offsetof(RollingView, ke) << "\n";
std::cout << "kd " << offsetof(RollingView, kd) << "\n";
std::cout << "rolling " << offsetof(RollingView, rolling) << "\n";
std::cout << "torsional " << offsetof(RollingView, torsional) << "\n";
std::cout << "local_shapes " << offsetof(RollingView, local_shapes) << "\n";
std::cout << "shapes_per_world " << offsetof(RollingView, shapes_per_world) << "\n";
std::cout << "worlds " << offsetof(RollingView, worlds) << "\n";
std::cout << "body_ids " << offsetof(RollingView, body_ids) << "\n";
std::cout << "body_indices " << offsetof(RollingView, body_indices) << "\n";
std::cout << "body_com " << offsetof(RollingView, body_com) << "\n";
std::cout << "inertia " << offsetof(RollingView, inertia) << "\n";
std::cout << "body_count " << offsetof(RollingView, body_count) << "\n";
std::cout << "particles_per_world " << offsetof(RollingView, particles_per_world) << "\n";
std::cout << "x " << offsetof(RollingView, x) << "\n";
std::cout << "previous " << offsetof(RollingView, previous) << "\n";
std::cout << "inverse_dt " << offsetof(RollingView, inverse_dt) << "\n";
std::cout << "epsilon " << offsetof(RollingView, epsilon) << "\n";
}
