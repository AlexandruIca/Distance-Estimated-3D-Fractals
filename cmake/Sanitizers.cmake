function(enable_sanitizers project_name)
    if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
        set(SANITIZERS "")

        option(ENABLE_SANITIZER_ADDRESS "Enable address sanitizer." FALSE)
        option(ENABLE_SANITIZER_UNDEFINED "Enable undefined behavior sanitizer." FALSE)
        option(ENABLE_SANITIZER_MEMORY "Enable memory sanitizer." FALSE)
        option(ENABLE_SANITIZER_THREAD "Enable thread sanitizer." FALSE)

        if(ENABLE_SANITIZER_ADDRESS)
            list(APPEND SANITIZERS "address")
        endif()
        if(ENABLE_SANITIZER_UNDEFINED)
            list(APPEND SANITIZERS "undefined")
        endif()
        if(ENABLE_SANITIZER_MEMORY)
            list(APPEND SANITIZERS "memory")
        endif()
        if(ENABLE_SANITIZER_THREAD)
            list(APPEND SANITIZERS "thread")
        endif()

        list(JOIN SANITIZERS "," LIST_OF_SANITIZERS)

        if(LIST_OF_SANITIZERS)
            if(NOT "${LIST_OF_SANITIZERS}" STREQUAL "")
                target_compile_options(${project_name} INTERFACE
                    -fsanitize=${LIST_OF_SANITIZERS} -fno-omit-frame-pointer)
                target_link_libraries(${project_name} INTERFACE
                    -fsanitize=${LIST_OF_SANITIZERS})
            endif()
        endif()
    endif()
endfunction()
