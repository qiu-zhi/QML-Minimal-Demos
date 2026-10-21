cmake_minimum_required(VERSION 3.16)

project(qml_styles VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

# 六种样式各自是一个独立模块，想用哪个就得显式找出来、链进来
find_package(Qt6 REQUIRED COMPONENTS
    Quick
    QuickControls2
    QuickControls2Basic
    QuickControls2Fusion
    QuickControls2Imagine
    QuickControls2Material
    QuickControls2Universal
    QuickControls2Windows
)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_styles
    main.cpp
    stylehelper.h
    stylehelper.cpp
)

qt_add_qml_module(qml_styles
    URI qml_styles
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_StyleSwitcher.qml
        Demo_StyleControls.qml
        Demo_StyleCustom.qml
    SOURCES
        stylehelper.h
        stylehelper.cpp
)

set_target_properties(qml_styles PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_styles
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::QuickControls2Basic
        Qt6::QuickControls2Fusion
        Qt6::QuickControls2Imagine
        Qt6::QuickControls2Material
        Qt6::QuickControls2Universal
        Qt6::QuickControls2Windows
)

include(GNUInstallDirs)
install(TARGETS qml_styles
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
