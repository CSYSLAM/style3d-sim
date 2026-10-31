cmake_minimum_required(VERSION 3.20)

# Use the interpreter selected by pip/uv so the installed extension matches
# the environment's CPython ABI exactly.
find_package(Python REQUIRED COMPONENTS Interpreter)

# Get extension suffix
execute_process(
    COMMAND "${Python_EXECUTABLE}" -c "import sysconfig; print(sysconfig.get_config_var('EXT_SUFFIX') or '')"
    OUTPUT_VARIABLE SYNREAL_SOLVER_EXTENSION_SUFFIX
    RESULT_VARIABLE _SYNREAL_SOLVER_SUFFIX_RESULT
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_VARIABLE _SYNREAL_SOLVER_SUFFIX_ERROR
)

if(NOT _SYNREAL_SOLVER_SUFFIX_RESULT EQUAL 0 OR SYNREAL_SOLVER_EXTENSION_SUFFIX STREQUAL "")
    message(
        FATAL_ERROR
        "Could not determine the Python extension suffix.\n"
        "${_SYNREAL_SOLVER_SUFFIX_ERROR}"
    )
endif()

set(SYNREAL_SOLVER_PREBUILT_EXTENSION
    "${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_SYSTEM_NAME}/$<CONFIG>/_core${SYNREAL_SOLVER_EXTENSION_SUFFIX}"
)

message(STATUS "Using prebuilt synreal-solver extension: ${SYNREAL_SOLVER_PREBUILT_EXTENSION}")

# Installed modules
install(FILES "${SYNREAL_SOLVER_PREBUILT_EXTENSION}" DESTINATION style3d_sim)

# Keep the binary license with the installed extension.
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE" DESTINATION style3d_sim/licenses/style3d-sim-bin)
