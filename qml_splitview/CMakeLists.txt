cmake_minimum_required(VERSION 3.16)

project(qml_splitview VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_splitview
    main.cpp
)

# 声明 Theme 为 QML singleton，使 qmldir 生成 singleton 条目
set_source_files_properties(Theme.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(qml_splitview
    URI qml_splitview
    VERSION 1.0
    QML_FILES
        Main.qml
        FadeInAnimation.qml
        Theme.qml
        CustomButton.qml
        CustomRect.qml
        Demo_BasicSplitView.qml
        Demo_CustomHandle.qml
        Demo_NestedSplitView.qml
        Demo_StatePersistence.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_splitview PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_splitview
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_splitview
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_splitview
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
