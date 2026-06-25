cmake_minimum_required(VERSION 3.16)

project(qml_container VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

set(COMMON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../common)

qt_add_executable(qml_container
    main.cpp
)

qt_add_qml_module(qml_container
    URI qml_container
    VERSION 1.0
    QML_FILES
        Main.qml
        ${COMMON_DIR}/TitleSeparator.qml
        ${COMMON_DIR}/FadeInAnimation.qml
        Demo_Pane.qml
        Demo_Frame.qml
        Demo_GroupBox.qml
        Demo_CustomGroupBox.qml
        Demo_ScrollView.qml
        Demo_Nested.qml
)

set_source_files_properties(
    ${COMMON_DIR}/TitleSeparator.qml
    ${COMMON_DIR}/FadeInAnimation.qml
    PROPERTIES QT_RESOURCE_ALIAS "/"
)

set_target_properties(qml_container PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_container
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_container
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
