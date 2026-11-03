cmake_minimum_required(VERSION 3.20)

# Prebuilt mode only installs files, so do not require a compiler at the top
# level. The source subproject enables C++ and CUDA when it is selected.
project(PySynrealSolver LANGUAGES NONE)

# Auto set default value for SYNREAL_SOLVER_USE_PREBUILT
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/synreal-solver/CMakeLists.txt")
    set(_SYNREAL_SOLVER_PREBUILT_DEFAULT OFF)
else()
    set(_SYNREAL_SOLVER_PREBUILT_DEFAULT ON)
endif()

# CMake build option
option(
    SYNREAL_SOLVER_USE_PREBUILT
    "Install the extension from style3d-sim-bin instead of building it from source"
    ${_SYNREAL_SOLVER_PREBUILT_DEFAULT}
)

option(
    SYNREAL_SOLVER_USE_RECONSTRUCTED_SOURCE
    "Build the recovered CUDA/C++ extension without using the reference solver image"
    OFF
)

# Add subdirectory
if(SYNREAL_SOLVER_USE_RECONSTRUCTED_SOURCE)
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
        message(FATAL_ERROR "The recovered source build currently requires Linux; use WSL2 on Windows.")
    endif()
    find_package(Python 3.11 COMPONENTS Interpreter Development.Module REQUIRED)
    set(SYNREAL_RECONSTRUCTION_NVCC "${CMAKE_CURRENT_SOURCE_DIR}/build/toolchains/cuda-12.4/bin/nvcc"
        CACHE FILEPATH "CUDA 12.4 nvcc used by the recovered source build")
    set(SYNREAL_RECONSTRUCTION_GLM "${CMAKE_CURRENT_SOURCE_DIR}/build/third_party/glm-1.0.1"
        CACHE PATH "GLM 1.0.1 include root used by the recovered source build")
    set(SYNREAL_RECONSTRUCTION_CXX "c++" CACHE STRING "C++17 compiler used by the recovered source build")
    execute_process(
        COMMAND "${Python_EXECUTABLE}" -c "import sysconfig; print(sysconfig.get_config_var('EXT_SUFFIX'))"
        OUTPUT_VARIABLE _RECONSTRUCTION_EXTENSION_SUFFIX
        OUTPUT_STRIP_TRAILING_WHITESPACE
        COMMAND_ERROR_IS_FATAL ANY
    )
    file(GLOB_RECURSE _RECONSTRUCTION_SOURCES CONFIGURE_DEPENDS
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/kernels/*.cu"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/kernels/*.cuh"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/library/*.cu"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/library/*.cuh"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/revisions/*.cu"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/native/*.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/native/*.cu"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/native/*.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/native/*.json"
    )
    set(_RECONSTRUCTION_BUILDERS
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/build_recovered_extension.py"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/build_standalone.py"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/build_host.py"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/build_native.py"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/library_entries.py"
        "${CMAKE_CURRENT_SOURCE_DIR}/reconstruction/csrc/ptx_compare.py"
    )
    set(_RECONSTRUCTION_EXTENSION "${CMAKE_CURRENT_BINARY_DIR}/_core${_RECONSTRUCTION_EXTENSION_SUFFIX}")
    add_custom_command(
        OUTPUT "${_RECONSTRUCTION_EXTENSION}"
        COMMAND "${Python_EXECUTABLE}" -B "${CMAKE_CURRENT_SOURCE_DIR}/scripts/build_recovered_extension.py"
            --project "${CMAKE_CURRENT_SOURCE_DIR}"
            --build-dir "${CMAKE_CURRENT_BINARY_DIR}/recovered-source"
            --target "${_RECONSTRUCTION_EXTENSION}"
            --nvcc "${SYNREAL_RECONSTRUCTION_NVCC}"
            --glm "${SYNREAL_RECONSTRUCTION_GLM}"
            --cxx "${SYNREAL_RECONSTRUCTION_CXX}"
        DEPENDS ${_RECONSTRUCTION_SOURCES} ${_RECONSTRUCTION_BUILDERS}
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        VERBATIM
    )
    add_custom_target(style3d_sim_extension ALL DEPENDS "${_RECONSTRUCTION_EXTENSION}")
    install(FILES "${_RECONSTRUCTION_EXTENSION}" DESTINATION style3d_sim)
elseif(SYNREAL_SOLVER_USE_PREBUILT)
    if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/style3d-sim-bin/CMakeLists.txt")
        message(FATAL_ERROR "SYNREAL_SOLVER_USE_PREBUILT=ON, but style3d-sim-bin is not initialized.")
    endif()
    add_subdirectory(style3d-sim-bin)
else()
    if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/synreal-solver/CMakeLists.txt")
        message(FATAL_ERROR "SYNREAL_SOLVER_USE_PREBUILT=OFF, but synreal-solver is not initialized.")
    endif()
    # Keep the standalone solver's install layout separate from the Python package.
    add_subdirectory(synreal-solver EXCLUDE_FROM_ALL)
    add_custom_target(style3d_sim_extension ALL DEPENDS _core)
    install(TARGETS _core DESTINATION style3d_sim)
    if(MSVC)
        install(
            FILES "$<TARGET_PDB_FILE:_core>"
            CONFIGURATIONS Debug
            DESTINATION style3d_sim
            OPTIONAL
        )
    endif()
endif()
