cmake_minimum_required(VERSION 3.16)

project(qml_gridview VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_gridview
    main.cpp
)

qt_add_qml_module(qml_gridview
    URI qml_gridview
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_GridViewBasic.qml
        Demo_GridViewFlow.qml
        Demo_GridViewHeaderFooter.qml
        Demo_GridViewTransition.qml
        Demo_GridViewDynamic.qml
        Demo_GridViewHighlight.qml
)

set_target_properties(qml_gridview PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_gridview
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_gridview
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
