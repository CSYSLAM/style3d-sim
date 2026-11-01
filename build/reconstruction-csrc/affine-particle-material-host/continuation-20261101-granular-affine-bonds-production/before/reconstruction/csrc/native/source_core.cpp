// Build the recovered solver with the public Python extension name expected by the existing adapter.
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <cstdint>
#include <stdexcept>

namespace py = pybind11;
#include "source_api.h"

static void bind_source_core_api(py::module_& module)
{
    bind_api(module);
    // The adapter uses this compatibility hook before construction; the source backend has no account gate.
    module.def("is_logged_in", []() { return true; });
    module.def("login", [](py::args, py::kwargs) -> bool {
        throw std::runtime_error("The source solver does not use account login");
    });
}

#define bind_api bind_source_core_api
#define _source_solver _core
#include "source_solver.cpp"
