cmake_minimum_required(VERSION 3.16)

project(qml_treeview VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
# RESOURCES 里传了 .qrc，必须 AUTORCC 才会把它编译进资源，否则运行期报 Cannot open
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_treeview
    main.cpp
)

qt_add_qml_module(qml_treeview
    URI qml_treeview
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        TreeArrow.qml
        Demo_BasicTree.qml
        Demo_CustomDelegate.qml
        Demo_Sort.qml
        Demo_Filter.qml
    SOURCES
        treemodel.h
        treemodel.cpp
        treeproxymodel.h
        treeproxymodel.cpp
    RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_treeview PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_treeview
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_treeview
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_treeview
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
