cmake_minimum_required(VERSION 3.16)

project(qml_progressbar VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_progressbar
    main.cpp
)

qt_add_qml_module(qml_progressbar
    URI qml_progressbar
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_ProgressBar.qml
        Demo_Animation.qml
        Demo_RectProgress.qml
        Demo_MaterialProgress.qml
        Demo_IndeterminateProgress.qml
        Demo_CircleProgress.qml
        Demo_MultiRingBar.qml
        CircleProgress.qml
    RESOURCES
        res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_progressbar PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_progressbar
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_progressbar
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_progressbar
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
