function(build_example example_name)
    add_executable(${example_name}
        ${CMAKE_CURRENT_SOURCE_DIR}/${example_name}.c
    )

    target_link_libraries(${example_name} PRIVATE project_options project_warnings)
endfunction()

build_example(distorted_sphere)
