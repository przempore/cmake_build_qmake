cmake_minimum_required(VERSION 3.10)

project(HelloWorld)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

execute_process(
COMMAND ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_SOURCE_DIR}/compile_commands.json
)

set(LIBRARY_OUTPUT_DIR ${CMAKE_SOURCE_DIR}/lib)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_program(QT_QMAKE_EXECUTABLE qmake REQUIRED)

add_custom_target(build_qt_library ALL
    COMMAND ${QT_QMAKE_EXECUTABLE} untitled_cli.pro
    COMMAND make
    WORKING_DIRECTORY ${LIBRARY_OUTPUT_DIR}
    COMMENT "Building Qt library using qmake"
    VERBATIM
    BYPRODUCTS ${LIBRARY_OUTPUT_DIR}/libuntitled_cli.so
)

set(QT_LIBRARY_PATH ${LIBRARY_OUTPUT_DIR}/libuntitled_cli.so)

add_library(untitled_cli SHARED IMPORTED)
set_target_properties(untitled_cli PROPERTIES
    IMPORTED_LOCATION ${QT_LIBRARY_PATH}
)

add_executable(hello_world main.cpp)
add_dependencies(hello_world build_qt_library)
target_link_libraries(hello_world PRIVATE untitled_cli Qt6::Core)

