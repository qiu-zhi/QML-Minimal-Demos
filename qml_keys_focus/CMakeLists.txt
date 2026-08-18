cmake_minimum_required(VERSION 3.16)

project(qml_keys_focus VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_keys_focus
    main.cpp
)

qt_add_qml_module(qml_keys_focus
    URI qml_keys_focus
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_KeysBasic.qml
        Demo_KeyModifiers.qml
        Demo_ForceActiveFocus.qml
        Demo_FocusScope.qml
        Demo_TabNavigation.qml
        Demo_KeyNavigation.qml
        Demo_KeyPropagation.qml
        Demo_GameControlKeys.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_keys_focus PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_keys_focus
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_keys_focus
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_keys_focus
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
