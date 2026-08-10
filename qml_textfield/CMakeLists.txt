cmake_minimum_required(VERSION 3.16)

project(qml_textfield VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_textfield
    main.cpp
    image.qrc
)

qt_add_qml_module(qml_textfield
    URI qml_textfield
    VERSION 1.0
    QML_FILES
        Main.qml
        FadeInAnimation.qml
        TitleSeparator.qml
        Demo_TextFieldBase.qml
        Demo_TextFieldInputLimit.qml
        Demo_TextFieldAgeValidator.qml
        Demo_TextFieldEmailValidator.qml
        Demo_TextFieldPhoneValidator.qml
        Demo_TextFieldInputMask.qml
        Demo_TextFieldIpValidator.qml
        Demo_TextFieldIdCardValidator.qml
        Demo_TextFieldCustom.qml
        Demo_TextFieldIcon.qml
        Demo_TextFieldClearable.qml
        Demo_TextFieldMultipleTopic.qml
        Demo_TextFieldAutoMatch.qml
        Demo_TextFieldFormSubmission.qml
        tools/regex_utils.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_textfield PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_textfield
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_textfield
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_textfield
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
