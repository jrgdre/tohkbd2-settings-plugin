TEMPLATE = aux

entries.path = /usr/share/jolla-settings/entries
entries.files = harbour-tohkbd2-settings.json

pages.path = /usr/share/jolla-settings/pages/harbour-tohkbd2-settings
pages.files = settings.qml

OTHER_FILES += \
    harbour-tohkbd2-settings.json
    settings.qml
    
INSTALLS = entries pages
    