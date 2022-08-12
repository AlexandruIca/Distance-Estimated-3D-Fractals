find_package(OpenGL REQUIRED)
find_package(X11 REQUIRED)

function(build_example example_name)
    add_executable(${example_name}
        ${CMAKE_CURRENT_SOURCE_DIR}/${example_name}.c
        ${CMAKE_CURRENT_SOURCE_DIR}/sokol.c
    )
    target_compile_definitions(${example_name} PRIVATE GRAPHICS_BACKEND_OPENGL33)
    if(UNIX)
        target_compile_options(${example_name} PRIVATE -pthread)
    endif()
    target_include_directories(${example_name} PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/
    )
    target_link_libraries(${example_name} PRIVATE
        project_options project_warnings
        -ldl
        OpenGL::GL
        X11::X11 X11::Xcursor X11::Xi
        -pthread
    )
endfunction()

build_example(distorted_sphere)
