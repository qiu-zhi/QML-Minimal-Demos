cmake_minimum_required(VERSION 3.16)

project(qml_mousearea VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_mousearea
    main.cpp
)

qt_add_qml_module(qml_mousearea
    URI qml_mousearea
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_MouseAreaBase.qml
        Demo_ClickPosition.qml
        Demo_DoubleClick.qml
        Demo_PressAndHold.qml
        Demo_MouseButtons.qml
        Demo_DragMove.qml
        Demo_MouseWheel.qml
        Demo_EventPropagation.qml
        Demo_CustomButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_mousearea PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_mousearea
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_mousearea
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_mousearea
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
