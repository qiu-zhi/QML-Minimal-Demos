cmake_minimum_required(VERSION 3.16)

project(qml_navigation_layout VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_navigation_layout
    main.cpp
)

qt_add_qml_module(qml_navigation_layout
    URI qml_navigation_layout
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_SidebarNavigation.qml
        Demo_DrawerNavigation.qml
        Demo_TopNavigation.qml
        Demo_BottomNavigation.qml
)

qt_add_resources(qml_navigation_layout "icons"
    PREFIX "/"
    FILES
        icons/home.svg
        icons/search.svg
        icons/message.svg
        icons/user.svg
)

set_target_properties(qml_navigation_layout PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_navigation_layout
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_navigation_layout
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
