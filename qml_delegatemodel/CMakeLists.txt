cmake_minimum_required(VERSION 3.16)

project(qml_delegatemodel VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_delegatemodel
    main.cpp
)

qt_add_qml_module(qml_delegatemodel
    URI qml_delegatemodel
    VERSION 1.0
    QML_FILES
        Main.qml
        TitleSeparator.qml
        FadeInAnimation.qml
        Demo_DelegateModel.qml
        Demo_DelegateModelGroup.qml
        Demo_Package.qml
        Demo_ObjectModel.qml
        Demo_Instantiator.qml
)

set_target_properties(qml_delegatemodel PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qml_delegatemodel
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_delegatemodel
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
