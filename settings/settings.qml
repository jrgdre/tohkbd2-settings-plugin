import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import harbour.tohkbd2.settings 1.0

Page {
    id: self

    SilicaFlickable {

        anchors.fill: parent
        contentHeight: content.height

        Column {
            id: content

            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "tohkbd2 test"
            }
            
            Label
            {
                text: settings.test
            }
        }
    }
    
    Settings
    {
        id: settings
    }
}