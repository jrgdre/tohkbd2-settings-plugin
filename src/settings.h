#ifndef SETTINGS_H
#define SETTINGS_H

#include <QStringList>
#include <QDateTime>
#include <QVariantHash>
#include <QDBusArgument>

struct SettingsData
{
    SettingsData();

    QString test;
};

class SettingsPrivate;

class Q_DECL_EXPORT Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString test READ test WRITE setTest NOTIFY testChanged)

public:
    explicit Settings(QObject *parent = 0);
    virtual ~Settings();

    QString test() const;
    void setTest(const QString &test);

signals:
    void testChanged();

private:
    SettingsPrivate * const d_ptr;
    Q_DECLARE_PRIVATE(Settings)

    Settings(const SettingsData &data, QObject *parent = 0);

    static Settings *createSettings(const SettingsData &data, QObject *parent = 0);
};

Q_DECLARE_METATYPE(SettingsData)
Q_DECLARE_METATYPE(QList<SettingsData>)

#endif // SETTINGS_H
