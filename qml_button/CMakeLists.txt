cmake_minimum_required(VERSION 3.16)

project(qml_button VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_button
    main.cpp
)

qt_add_qml_module(qml_button
    URI qml_button
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        CustomButton.qml
        Demo_Button.qml
        Demo_RoundButton.qml
        Demo_DelayButton.qml
        Demo_Switch.qml
        Demo_CheckBox.qml
        Demo_RadioButton.qml
        Demo_ToolButton.qml
        Demo_TabButton.qml
        Demo_ItemDelegate.qml
        Demo_CustomButton.qml
    RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_button PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_button
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_button
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_button
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
