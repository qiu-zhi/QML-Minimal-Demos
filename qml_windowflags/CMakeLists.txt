cmake_minimum_required(VERSION 3.16)

project(qml_windowflags VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqml_windowflags
    main.cpp
)

qt_add_qml_module(appqml_windowflags
    URI qml_windowflags
    VERSION 1.0
    QML_FILES
        Main.qml
        Demo_PopupBasic.qml
        Demo_PopupDialog.qml
        Demo_PopupCustom.qml
        Demo_WindowFlags.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqml_windowflags PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqml_windowflags
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml_windowflags
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqml_windowflags
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
