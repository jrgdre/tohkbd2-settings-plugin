/*
    tohkbd2-settings-u, The Otherhalf Keyboard 2 settings UI
*/

#include "settingsui.h"
#include <QDir>
#include <QVariantMap>
#include <QVariantList>
#include <QThread>
#include <QSettings>
#include <QDebug>
#include <QtDBus/QtDBus>
#include <QtSystemInfo/QDeviceInfo>
#include <QtAlgorithms>
#include <linux/input.h>
#include "defaultSettings.h"


SettingsUi::SettingsUi(QObject *parent) :
    QObject(parent)
{
    tohkbd2daemon = new ComKimmoliTohkbd2Interface("com.kimmoli.tohkbd2", "/", QDBusConnection::systemBus(), this);
    tohkbd2daemon->setTimeout(2000);
}

SettingsUi::~SettingsUi()
{
}

QVariantMap SettingsUi::getCurrentSettings()
{
    QVariantMap map;

    QSettings settings("harbour-tohkbd2", "tohkbd2");

    settings.beginGroup("generalsettings");
    map.insert("backlightTimeout", settings.value("backlightTimeout", BACKLIGHT_TIMEOUT).toInt());
    map.insert("backlightLuxThreshold", settings.value("backlightLuxThreshold", BACKLIGHT_LUXTHRESHOLD).toInt());
    map.insert("keyRepeatDelay", settings.value("keyRepeatDelay", KEYREPEAT_DELAY).toInt());
    map.insert("keyRepeatRate", settings.value("keyRepeatRate", KEYREPEAT_RATE).toInt());
    map.insert("backlightEnabled", settings.value("backlightEnabled", BACKLIGHT_ENABLED).toBool());
    map.insert("forceLandscapeOrientation", settings.value("forceLandscapeOrientation", FORCE_LANDSCAPE_ORIENTATION).toBool());
    map.insert("forceBacklightOn", settings.value("forceBacklightOn", FORCE_BACKLIGHT_ON).toBool());
    map.insert("modifierShiftMode", settings.value("modifierShiftMode", MODIFIER_SHIFT_MODE).toString());
    map.insert("modifierCtrlMode", settings.value("modifierCtrlMode", MODIFIER_CTRL_MODE).toString());
    map.insert("modifierAltMode", settings.value("modifierAltMode", MODIFIER_ALT_MODE).toString());
    map.insert("modifierSymMode", settings.value("modifierSymMode", MODIFIER_SYM_MODE).toString());
    map.insert("verboseMode", settings.value("verboseMode", VERBOSE_MODE_ENABLED).toBool());
    settings.endGroup();

    return map;
}


void SettingsUi::setSetting(QString key, QVariant value)
{
    qDebug() << "setting" << key << "to" << value;

    tohkbd2daemon->setSetting(key, QDBusVariant(value));

    QThread::msleep(200);

    emit settingsChanged();
}

void SettingsUi::setSettingsToDefault()
{
    setSetting("backlightTimeout", BACKLIGHT_TIMEOUT);
    setSetting("backlightLuxThreshold", BACKLIGHT_LUXTHRESHOLD);
    setSetting("keyRepeatDelay", KEYREPEAT_DELAY);
    setSetting("keyRepeatRate", KEYREPEAT_RATE);
    setSetting("backlightEnabled", BACKLIGHT_ENABLED);
    setSetting("forceLandscapeOrientation", FORCE_LANDSCAPE_ORIENTATION);
    setSetting("forceBacklightOn", FORCE_BACKLIGHT_ON);
    setSetting("modifierShiftMode", MODIFIER_SHIFT_MODE);
    setSetting("modifierCtrlMode", MODIFIER_CTRL_MODE);
    setSetting("modifierAltMode", MODIFIER_ALT_MODE);
    setSetting("modifierSymMode", MODIFIER_SYM_MODE);
    setSetting("verboseMode", VERBOSE_MODE_ENABLED);

    QThread::msleep(200);

    emit settingsChanged();
}

