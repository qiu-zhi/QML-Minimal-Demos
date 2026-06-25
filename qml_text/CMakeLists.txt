cmake_minimum_required(VERSION 3.16)

project(qml_text VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

set(COMMON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../common)

qt_add_executable(qml_text
    main.cpp
)

qt_add_qml_module(qml_text
    URI qml_text
    VERSION 1.0
    QML_FILES
        Main.qml
        ${COMMON_DIR}/TitleSeparator.qml
        ${COMMON_DIR}/FadeInAnimation.qml
        Demo_TextBasic.qml
        Demo_TextFont.qml
        Demo_TextStyle.qml
        Demo_TextAlignment.qml
        Demo_TextWrap.qml
        Demo_TextElide.qml
        Demo_TextRich.qml
        Demo_TextMarkdown.qml
        Demo_TextLink.qml
        Demo_TextFit.qml
        Demo_TextClickable.qml
        Demo_LabelBasic.qml
        Demo_LabelBackground.qml
        Demo_LabelPadding.qml
        Demo_TextVsLabel.qml
)

foreach(_file TitleSeparator.qml FadeInAnimation.qml)
    set_source_files_properties(${COMMON_DIR}/${_file} PROPERTIES QT_RESOURCE_ALIAS ${_file})
endforeach()

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_text PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_text
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_text
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_text
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
