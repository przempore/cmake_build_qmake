# Minimum required version of CMake
cmake_minimum_required(VERSION 3.10)

# Project name
project(HelloWorld)

# create a compile_commands.json file 
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# link it to the build directory
execute_process(
COMMAND ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_SOURCE_DIR}/compile_commands.json
)

file(COPY ${CMAKE_SOURCE_DIR}/lib DESTINATION ${CMAKE_BINARY_DIR})

# Set the output directory for the library
set(LIBRARY_OUTPUT_DIR ${CMAKE_BINARY_DIR}/lib)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_program(QT_QMAKE_EXECUTABLE qmake REQUIRED)

# Add a custom target to invoke qmake and build the .pro file
add_custom_target(build_qt_library ALL
    COMMAND ${QT_QMAKE_EXECUTABLE} untitled_cli.pro
    COMMAND make
    WORKING_DIRECTORY ${LIBRARY_OUTPUT_DIR}
    COMMENT "Building Qt library using qmake"
    VERBATIM
    BYPRODUCTS ${LIBRARY_OUTPUT_DIR}/libuntitled_cli.so
)

# Specify the path to the resulting library
set(QT_LIBRARY_PATH ${LIBRARY_OUTPUT_DIR}/libuntitled_cli.so)

# Add the library to the CMake project
add_library(untitled_cli SHARED IMPORTED)
set_target_properties(untitled_cli PROPERTIES
    IMPORTED_LOCATION ${QT_LIBRARY_PATH}
)

# Link the library to your target (example target)
add_executable(hello_world main.cpp)
add_dependencies(hello_world build_qt_library)
target_link_libraries(hello_world PRIVATE untitled_cli Qt6::Core)

