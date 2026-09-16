cmake_minimum_required(VERSION 3.16)

project(qml_lottie VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml_lottie
    main.cpp
)

qt_add_qml_module(qml_lottie
    URI qml_lottie
    VERSION 1.0
    QML_FILES
        Main.qml
        Demo_BasicControls.qml
        Demo_Scrubber.qml
        Demo_DirectionLoop.qml
        Demo_Gallery.qml
)

# 收集 Lottie 演示素材：Bodymovin/lottie JSON 文件，挂到 /lottie/<文件名> 下。
file(GLOB LOTTIE_JSONS CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/lottie/*.json")
foreach(_json ${LOTTIE_JSONS})
    get_filename_component(_name ${_json} NAME)
    set_source_files_properties(${_json} PROPERTIES QT_RESOURCE_ALIAS ${_name})
endforeach()
qt_add_resources(qml_lottie "lottie"
    PREFIX /lottie
    FILES ${LOTTIE_JSONS}
)

set_target_properties(qml_lottie PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# QtLottie 的 QML 类型由独立的 lottieqtplugin 插件提供，运行时按导入路径自动加载。
# 这里只需链接 QtQuick。
target_link_libraries(qml_lottie
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qml_lottie
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)