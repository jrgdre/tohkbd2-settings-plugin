TEMPLATE = lib
TARGET = tohkbd2settings-qt5
CONFIG += qt hide_symbols create_pc create_prl
QT += dbus
QT -= gui

SOURCES += settings.cpp

HEADERS += settings.h

target.path = $$[QT_INSTALL_LIBS]
pkgconfig.files = $$TARGET.pc
pkgconfig.path = $$target.path/pkgconfig
headers.files = settings.h
headers.path = /usr/include/tohkbd2settings-qt5

QMAKE_PKGCONFIG_NAME = lib$$TARGET
QMAKE_PKGCONFIG_DESCRIPTION = Tohkbd2 Settings
QMAKE_PKGCONFIG_LIBDIR = $$target.path
QMAKE_PKGCONFIG_INCDIR = $$headers.path
QMAKE_PKGCONFIG_DESTDIR = pkgconfig

INSTALLS += target headers pkgconfig
