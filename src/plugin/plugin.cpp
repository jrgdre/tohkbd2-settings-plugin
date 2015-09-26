#include <QtGlobal>
#include <QtQml>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include "settingsui.h"
#include "systemsettings.h"

class Q_DECL_EXPORT Tohkbd2SettingsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
#if QT_VERSION >= QT_VERSION_CHECK(5, 0, 0)
    Q_PLUGIN_METADATA(IID "harbour.tohkbd2.settings")
#endif
public:
    Tohkbd2SettingsPlugin()
    {
    }

    virtual ~Tohkbd2SettingsPlugin()
    {
    }

    void registerTypes(const char *uri)
    {
        Q_ASSERT(uri == QLatin1String("harbour.tohkbd2.settings"));

        qmlRegisterType<SettingsUi>(uri, 1, 0, "Settings");
        qmlRegisterType<SystemSettings>(uri, 1, 0, "SystemSettings");
    }
};

#include "plugin.moc"
