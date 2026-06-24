cmake_minimum_required(VERSION 3.16)

project(qml_text VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqml_text
    main.cpp
)

qt_add_qml_module(appqml_text
    URI qml_text
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
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
        Demo_TextSelectable.qml
        Demo_TextClickable.qml
        Demo_LabelBasic.qml
        Demo_LabelBackground.qml
        Demo_LabelPadding.qml
        Demo_TextVsLabel.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqml_text PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqml_text
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml_text
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS appqml_text
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
