find_package(OpenGL REQUIRED)
find_package(X11 REQUIRED)

add_library(sokol STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/sokol.c
)
target_compile_definitions(sokol PRIVATE
    GRAPHICS_BACKEND_OPENGL33
)
target_include_directories(sokol PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/
)
target_link_libraries(sokol PUBLIC
    -pthread
    -ldl
    OpenGL::GL
    X11::X11 X11::Xcursor X11::Xi
    -pthread
)

function(build_example example_name)
    add_executable(${example_name}
        ${CMAKE_CURRENT_SOURCE_DIR}/${example_name}.c
    )
    target_include_directories(${example_name} PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/
    )
    target_link_libraries(${example_name} PRIVATE
        project_options project_warnings sokol
    )
endfunction()

build_example(distorted_sphere)
