cmake_minimum_required(VERSION 3.16)

project(qml_windowflags VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_windowflags
    main.cpp
)

qt_add_qml_module(qml_windowflags
    URI qml_windowflags
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_PopupBasic.qml
        Demo_PopupDialog.qml
        Demo_PopupCustom.qml
        Demo_WindowTool.qml
        Demo_WindowToolTip.qml
        Demo_WindowSplash.qml
        Demo_WindowFrameless.qml
        Demo_WindowStayOnTop.qml
        Demo_WindowDialog.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_windowflags PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_windowflags
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_windowflags
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_windowflags
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
