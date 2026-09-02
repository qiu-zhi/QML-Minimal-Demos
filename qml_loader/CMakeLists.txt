cmake_minimum_required(VERSION 3.16)

project(qml_loader VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_loader
    main.cpp
)

qt_add_qml_module(qml_loader
    URI qml_loader
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_LoaderFile.qml
        Demo_LoaderComponent.qml
        Demo_LoaderStatus.qml
        Demo_LoaderDynamicTab.qml
        Demo_LoaderCreateControls.qml
        Demo_LoaderDelay.qml
        Demo_LoaderSwitch.qml
        Demo_LoaderProps.qml
        component/ColorRect.qml
        component/MyComponent.qml
        component/ExistingComponent.qml
        component/HeavyComponent.qml
        component/Page1.qml
        component/Page2.qml
        component/Page3.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qml_loader PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qml_loader
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_loader
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_loader
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
