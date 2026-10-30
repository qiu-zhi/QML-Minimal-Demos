cmake_minimum_required(VERSION 3.16)

project(qml_layout_advanced VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_layout_advanced
    main.cpp
)

qt_add_qml_module(qml_layout_advanced
    URI qml_layout_advanced
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_LayoutMirroring.qml
        Demo_AnchorChanges.qml
        Demo_FlexboxLayout.qml
        Demo_LayoutItemProxy.qml
)

set_target_properties(qml_layout_advanced PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_layout_advanced
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_layout_advanced
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
