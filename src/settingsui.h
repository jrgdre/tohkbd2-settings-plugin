/*
    tohkbd2-settings-u, The Otherhalf Keyboard 2 settings UI
*/

#ifndef SETTINGSUI_H
#define SETTINGSUI_H
#include <QObject>
#include <QVariantList>
#include <QTimer>
#include <QMap>
#include "daemonInterface.h"

class Q_DECL_EXPORT SettingsUi : public QObject
{
    Q_OBJECT

public:
    explicit SettingsUi(QObject *parent = 0);
    virtual ~SettingsUi();

    Q_INVOKABLE QVariantMap getCurrentSettings();
    Q_INVOKABLE void setSettingsToDefault();
    Q_INVOKABLE void setSetting(QString key, QVariant value);

signals:
    void settingsChanged();

private:

    ComKimmoliTohkbd2Interface *tohkbd2daemon;
};


#endif // SETTINGSUI_H

