cmake_minimum_required(VERSION 3.16)

project(qml_combobox VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickDialogs2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_combobox
    main.cpp
)

qt_add_qml_module(qml_combobox
    URI qml_combobox
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_BaseComboBox.qml
        Demo_ListModel.qml
        Demo_DisplayText.qml
        Demo_DisableItem.qml
        Demo_Editable.qml
        Demo_Dynamic.qml
        Demo_Group.qml
        Demo_MultiColumn.qml
        Demo_LargeData.qml
        Demo_CustomStyle.qml
        Demo_MaterialStyle.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_combobox PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_combobox
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_combobox
    PRIVATE Qt6::Quick Qt6::QuickDialogs2
)

include(GNUInstallDirs)
install(TARGETS qml_combobox
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
