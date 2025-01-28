QT = core

CONFIG += c++17 cmdline

TEMPLATE = lib

CONFIG += compile_commands

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
        main_qt.hpp

SOURCES += \
        main_qt.cpp

