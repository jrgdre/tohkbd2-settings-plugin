#include "settings.h"


SettingsData::SettingsData()
{
}

class SettingsPrivate : public SettingsData
{
    friend class Settings;

    SettingsPrivate()
        : SettingsData()
    {
    }

    SettingsPrivate(const SettingsData &data)
        : SettingsData(data)
    {
    }

};

Settings::Settings(QObject *parent) :
    QObject(parent),
    d_ptr(new SettingsPrivate)
{
}

Settings::Settings(const SettingsData &data, QObject *parent) :
    QObject(parent),
    d_ptr(new SettingsPrivate(data))
{
}

Settings::~Settings()
{
    delete d_ptr;
}
QString Settings::test() const
{
    return "kissa";
}

void Settings::setTest(const QString &test)
{
    if (test != this->test()) {
        emit testChanged();
    }
}
