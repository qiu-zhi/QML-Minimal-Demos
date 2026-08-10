cmake_minimum_required(VERSION 3.16)

project(qml_textarea VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_textarea
    main.cpp
)

qt_add_qml_module(qml_textarea
    URI qml_textarea
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        TextAreaItem.qml
        Demo_Base.qml
        Demo_FontColor.qml
        Demo_Rich.qml
        Demo_Wrap.qml
        Demo_Style.qml
        Demo_Theme.qml
        Demo_Material.qml
        Demo_Search.qml
        Demo_LineNum.qml
        Demo_Markdown.qml
        Demo_Scroll.qml
        Demo_VirtualText.qml
    RESOURCES
        白话史记.txt
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_textarea PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_textarea
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_textarea
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS qml_textarea
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
