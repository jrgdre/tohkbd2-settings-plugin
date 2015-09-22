TARGET = tohkbd2settings
PLUGIN_IMPORT_PATH = harbour/tohkbd2/settings
QT += dbus
QT -= gui

TEMPLATE = lib
CONFIG += qt plugin hide_symbols
QT += qml

INCLUDEPATH += ..
LIBS += -L.. -ltohkbd2settings-qt5
SOURCES += plugin.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH
qmldir.files += \
        $$_PRO_FILE_PWD_/qmldir
qmldir.path +=  $$target.path
INSTALLS += target qmldir

OTHER_FILES += qmldir
