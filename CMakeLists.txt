cmake_minimum_required(VERSION 3.16)

# QML 示例项目集合
project(QML_Minimal_Demos VERSION 1.0.0 LANGUAGES CXX)

# Option to build all examples or select specific ones
option(BUILD_ALL_EXAMPLES "Build all example projects" ON)

# Collect all subdirectories that contain CMakeLists.txt
file(GLOB subdirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *)
set(EXAMPLE_PROJECTS)

foreach(subdir ${subdirs})
    if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${subdir})
        if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/CMakeLists.txt)
            # Skip root CMakeLists.txt itself
            if(NOT ${subdir} STREQUAL ".")
                list(APPEND EXAMPLE_PROJECTS ${subdir})
            endif()
        endif()
    endif()
endforeach()

# Sort projects alphabetically
list(SORT EXAMPLE_PROJECTS)

message(STATUS "Found example projects:")
foreach(project ${EXAMPLE_PROJECTS})
    message(STATUS "  - ${project}")
endforeach()

# Add subprojects
if(BUILD_ALL_EXAMPLES)
    foreach(project ${EXAMPLE_PROJECTS})
        message(STATUS "Adding subdirectory: ${project}")
        add_subdirectory(${project})
    endforeach()
else()
    # Individual project options
    foreach(project ${EXAMPLE_PROJECTS})
        string(TOUPPER ${project} PROJECT_UPPER)
        string(REPLACE "-" "_" PROJECT_OPTION "BUILD_${PROJECT_UPPER}")
        option(${PROJECT_OPTION} "Build ${project}" OFF)
        if(${PROJECT_OPTION})
            add_subdirectory(${project})
        endif()
    endforeach()
endif()
