TEMPLATE = aux

entries.path = /usr/share/jolla-settings/entries
entries.files = harbour-tohkbd2-settings.json

pages.path = /usr/share/jolla-settings/pages/harbour-tohkbd2-settings
pages.files = settings.qml \
              icon-m-tohkbd2-settings.png

OTHER_FILES += \
    harbour-tohkbd2-settings.json \
    icon-m-tohkbd2-settings.png
    settings.qml
    
INSTALLS = entries pages
    
