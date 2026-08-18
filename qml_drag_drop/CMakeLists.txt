cmake_minimum_required(VERSION 3.16)

project(qml_drag_drop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_drag_drop
    main.cpp
)

qt_add_qml_module(qml_drag_drop
    URI qml_drag_drop
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_DragBasic.qml
        Demo_DragAxis.qml
        Demo_DropAreaBasic.qml
        Demo_DropAreaColorSwap.qml
        Demo_DragListReorder.qml
        Demo_DragKanban.qml
        Demo_DragGridPuzzle.qml
        Demo_DragSnap.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_drag_drop PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_drag_drop
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_drag_drop
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_drag_drop
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
