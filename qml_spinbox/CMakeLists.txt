cmake_minimum_required(VERSION 3.16)

project(qml_spinbox VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core5Compat)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_spinbox
    main.cpp
)

qt_add_qml_module(qml_spinbox
    URI qml_spinbox
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_BasicSpinBox.qml
        Demo_CustomStepSpinBox.qml
        Demo_SpinBox_BasicCustom.qml
        Demo_CustomSpinBox_Scale.qml
        Demo_CustomSpinBox_Roll.qml
        Demo_SpinBox_Material.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_spinbox PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_spinbox
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_spinbox
    PRIVATE Qt6::Quick Qt6::Core5Compat
)

include(GNUInstallDirs)
install(TARGETS qml_spinbox
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
