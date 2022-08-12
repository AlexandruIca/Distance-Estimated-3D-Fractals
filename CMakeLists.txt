cmake_minimum_required(VERSION 3.16)

project(DistanceEstimated3DFractals LANGUAGES C)

include(cmake/CompilerWarnings.cmake)
include(cmake/Sanitizers.cmake)
include(cmake/StandardProjectSettings.cmake)

add_library(project_options INTERFACE)
add_library(project_warnings INTERFACE)

target_compile_features(project_options INTERFACE c_std_11)
set_project_warnings(project_warnings)
enable_sanitizers(project_options)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/)
