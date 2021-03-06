/*
 * This file was generated by qdbusxml2cpp version 0.8
 * Command line was: qdbusxml2cpp mce.xml -p ../dbus/src/mceInterface
 *
 * qdbusxml2cpp is Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
 *
 * This is an auto-generated file.
 * Do not edit! All changes made to it will be lost.
 */

#ifndef MCEINTERFACE_H_1443197937
#define MCEINTERFACE_H_1443197937

#include <QtCore/QObject>
#include <QtCore/QByteArray>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QVariant>
#include <QtDBus/QtDBus>

/*
 * Proxy class for interface com.nokia.mce.request
 */
class ComNokiaMceRequestInterface: public QDBusAbstractInterface
{
    Q_OBJECT
public:
    static inline const char *staticInterfaceName()
    { return "com.nokia.mce.request"; }

public:
    ComNokiaMceRequestInterface(const QString &service, const QString &path, const QDBusConnection &connection, QObject *parent = 0);

    ~ComNokiaMceRequestInterface();

public Q_SLOTS: // METHODS
    inline QDBusPendingReply<QDBusVariant> get_config(const QDBusObjectPath &path)
    {
        QList<QVariant> argumentList;
        argumentList << QVariant::fromValue(path);
        return asyncCallWithArgumentList(QLatin1String("get_config"), argumentList);
    }

    inline QDBusPendingReply<bool> set_config(const QDBusObjectPath &path, const QDBusVariant &value)
    {
        QList<QVariant> argumentList;
        argumentList << QVariant::fromValue(path) << QVariant::fromValue(value);
        return asyncCallWithArgumentList(QLatin1String("set_config"), argumentList);
    }

Q_SIGNALS: // SIGNALS
};

/*
 * Proxy class for interface com.nokia.mce.signal
 */
class ComNokiaMceSignalInterface: public QDBusAbstractInterface
{
    Q_OBJECT
public:
    static inline const char *staticInterfaceName()
    { return "com.nokia.mce.signal"; }

public:
    ComNokiaMceSignalInterface(const QString &service, const QString &path, const QDBusConnection &connection, QObject *parent = 0);

    ~ComNokiaMceSignalInterface();

public Q_SLOTS: // METHODS
Q_SIGNALS: // SIGNALS
    void config_change_ind(const QString &key, const QDBusVariant &value);
};

namespace com {
  namespace nokia {
    namespace mce {
      typedef ::ComNokiaMceRequestInterface request;
      typedef ::ComNokiaMceSignalInterface signal;
    }
  }
}
#endif
