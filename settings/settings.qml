/*
    tohkbd2-settings-u, The Otherhalf Keyboard 2 settings UI
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import harbour.tohkbd2.settings 1.0
import "../components"

Page
{
    id: page

    property var settings

    Component.onCompleted: updateModifiers()

    Settings
    {
        id: settingsui

        onSettingsChanged:
        {
            settings = settingsui.getCurrentSettings()
        }
    }

    SystemSettings
    {
        id: systemsettings

        Component.onCompleted:
        {
            /* if the keyboard open event is not triggering actions
               set them to trigger when no proximity. Always is also ok, do not change that */
            if (value("/system/osso/dsm/locks/keyboard_open_trigger") == 0)
                setValue("/system/osso/dsm/locks/keyboard_open_trigger", 2)

            /* Set the keyboard close event to trigger always
             * This is needed for proper operation */
            if (value("/system/osso/dsm/locks/keyboard_close_trigger") != 1)
                setValue("/system/osso/dsm/locks/keyboard_close_trigger", 1)
        }

        /* Todo: change comboBox index if a setting is changed, onSettingChanged(path) */
    }

    ListModel
    {
        id: modifierModes
    }

    ListModel
    {
        id: modifiers
    }

    function updateModifiers()
    {
        modifierModes.clear()
        modifiers.clear()

        //% "Normal"
        modifierModes.append({ "name": qsTrId("mod-mode-normal"), "code": "Normal" })
        //% "Sticky"
        modifierModes.append({ "name": qsTrId("mod-mode-sticky"), "code": "Sticky" })
        //% "Lock"
        modifierModes.append({ "name": qsTrId("mod-mode-lock"), "code": "Lock" })
        //% "Cycle"
        modifierModes.append({ "name": qsTrId("mod-mode-cycle"), "code": "Cycle" })

        //: Modifier Shift mode selector combo-box label
        //% "Shift mode"
        modifiers.append({ "combolabel": qsTrId("mod-shift-mode"), "key": "modifierShiftMode" })
        //: Modifier Ctrl mode selector combo-box label
        //% "Ctrl mode"
        modifiers.append({ "combolabel": qsTrId("mod-ctrl-mode"), "key": "modifierCtrlMode" })
        //: Modifier Alt mode selector combo-box label
        //% "Alt mode"
        modifiers.append({ "combolabel": qsTrId("mod-alt-mode"), "key": "modifierAltMode" })
        //: Modifier Sym mode selector combo-box label
        //% "Sym mode"
        modifiers.append({ "combolabel": qsTrId("mod-sym-mode"), "key": "modifierSymMode" })
    }

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent

        contentHeight: column.height

        PullDownMenu
        {
            MenuItem
            {
                text: qsTrId("reset-to-defaults")
                onClicked:
                {
                    settingsui.setSettingsToDefault()
                    systemsettings.setValue(blankInhibitCB.path, 0)
                    systemsettings.setValue(openActionCB.path, 1)
                    systemsettings.setValue(closeActionCB.path, 2)
                    pageStack.pop()
                }
            }
        }

        Column
        {
            id: column

            width: page.width

            PageHeader
            {
                title: qsTrId("general-settings")
            }

            SectionHeader
            {
                //: Section header for backlight settings
                //% "Backlight"
                text: qsTrId("backlight-sect-header")
            }
            TextSwitch
            {
                id: alwaysOn
                //: Backlight always on switch text
                //% "Always on"
                text: qsTrId("bg-always-on-sw")
                //: Backlight always on description
                //% "Backlight is always on when keyboard attached and phone's display is on"
                description: qsTrId("bg-always-on-desc")
                onCheckedChanged: if (checked !== settings["forceBacklightOn"]) settingsui.setSetting("forceBacklightOn", checked)
                width: parent.width - 2*Theme.paddingLarge
                Component.onCompleted:
                {
                    checked = settings["forceBacklightOn"]
                    /* Update to restore if overridden with key-combo Sym+Home */
                    if (!checked && !settings["forceBacklightOn"])
                        settingsui.setSetting("forceBacklightOn", false)
                }
            }
            TextSwitch
            {
                id: automatic
                //: Backlight automatic switch text
                //% "Automatic"
                text: qsTrId("bg-automatic-sw")
                //: Backlight automatic description
                //% "Automatic backlight enable or always off"
                description: qsTrId("bg-automatic-desc")
                onCheckedChanged: if (checked !== settings["backlightEnabled"]) settingsui.setSetting("backlightEnabled", checked)
                width: parent.width - 2*Theme.paddingLarge
                Component.onCompleted: checked = settings["backlightEnabled"]
                enabled: !alwaysOn.checked
            }
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                //: Backlight timeout slider name
                //% "Backlight timeout"
                label: qsTrId("bg-timeout-slider")
                minimumValue: 100
                maximumValue: 30000
                value: settings["backlightTimeout"]
                valueText: Number(value/1000).toFixed(1) + " s"
                stepSize: 100
                enabled: !alwaysOn.checked && automatic.checked
                opacity: enabled ? 1.0 : 0.4

                property bool wasChanged: false
                onValueChanged: wasChanged = true
                onReleased:
                {
                    if (wasChanged)
                    {
                        wasChanged = false
                        settingsui.setSetting("backlightTimeout", value)
                    }
                }
            }
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                //: Backlight brightness threshold slider
                //% "Brightness threshold"
                label: qsTrId("bg-brightness-slider")
                minimumValue: 1
                maximumValue: 50
                value: settings["backlightLuxThreshold"]
                valueText: value + " lux"
                stepSize: 1
                enabled: !alwaysOn.checked && automatic.checked
                opacity: enabled ? 1.0 : 0.4

                property bool wasChanged: false
                onValueChanged: wasChanged = true
                onReleased:
                {
                    if (wasChanged)
                    {
                        wasChanged = false
                        settingsui.setSetting("backlightLuxThreshold", value)
                    }
                }
            }

            SectionHeader
            {
                //: Section header for display related settings
                //% "Display"
                text: qsTrId("orientation-sect-header")
            }
            TextSwitch
            {
                //: Force landscape switch text
                //% "Force Landscape"
                text: qsTrId("orientation-force-landscape-sw")
                //: Force landscape switch description
                //% "Force landscape orientation when keyboard attached"
                description: qsTrId("orientation-force-landscape-desc")
                onCheckedChanged: settingsui.setSetting("forceLandscapeOrientation", checked)
                width: parent.width - 2*Theme.paddingLarge
                Component.onCompleted: checked = settings["forceLandscapeOrientation"]
            }
            ComboBox
            {
                id: blankInhibitCB
                property string path: "/system/osso/dsm/display/kbd_slide_inhibit_blank_mode"
                width: parent.width
                //: Keep display on when connected switch text
                //% "Display mode"
                label: qsTrId("keep-display-on-when-connected-sw") + " "
                menu: ContextMenu
                {
                    MenuItem { text: "Normal";   onClicked: systemsettings.setValue(blankInhibitCB.path, 0); }
                    MenuItem { text: "Stay on";  onClicked: systemsettings.setValue(blankInhibitCB.path, 1); }
                    MenuItem { text: "Stay dim"; onClicked: systemsettings.setValue(blankInhibitCB.path, 2); }
                }
                Component.onCompleted: currentIndex = systemsettings.value(blankInhibitCB.path)
            }
            Label
            {
                //: Keep display on when connected switch description
                //% "Display mode when keyboard is connected. Normally display will blank when phone is not used for a specified time, but you can force it to stay on or allow just to dim when keyboard is connected."
                text: qsTrId("keep-display-on-when-connected-desc")
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                width: parent.width - 4*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ComboBox
            {
                id: openActionCB
                property string path: "/system/osso/dsm/locks/keyboard_open_actions"
                width: parent.width
                //: blaa
                //% "Action when connected"
                label: qsTrId("action-when-connected-cb") + " "
                menu: ContextMenu
                {
                    MenuItem { text: "No action"; onClicked: systemsettings.setValue(openActionCB.path, 0); }
                    MenuItem { text: "Unblank";   onClicked: systemsettings.setValue(openActionCB.path, 1); }
                    MenuItem { text: "Unlock";    onClicked: systemsettings.setValue(openActionCB.path, 2); }
                }
                Component.onCompleted: currentIndex = systemsettings.value(blankInhibitCB.path)
            }
            Label
            {
                //: blaa
                //% "Select action when keyboard is attached."
                text: qsTrId("action-when-connected-desc")
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                width: parent.width - 4*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ComboBox
            {
                id: closeActionCB
                property string path: "/system/osso/dsm/locks/keyboard_close_actions"
                width: parent.width
                //: blaa
                //% "Action when removed"
                label: qsTrId("action-when-removed-cb") + " "
                menu: ContextMenu
                {
                    MenuItem { text: "No action"; onClicked: systemsettings.setValue(closeActionCB.path, 0); }
                    MenuItem { text: "Blank";     onClicked: systemsettings.setValue(closeActionCB.path, 1); }
                    MenuItem { text: "Lock";      onClicked: systemsettings.setValue(closeActionCB.path, 2); }
                }
                Component.onCompleted: currentIndex = systemsettings.value(closeActionCB.path)
            }
            Label
            {
                //: blaa
                //% "Select action when keyboard is removed."
                text: qsTrId("action-when-removed-desc")
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                width: parent.width - 4*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            SectionHeader
            {
                //: Section header for repeat settings
                //% "Repeat"
                text: qsTrId("repeat-sect-header")
            }
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                //: Keyboard repeat start delay slider
                //% "Repeat start delay"
                label: qsTrId("repeat-delay-slider")
                minimumValue: 50
                maximumValue: 500
                value: settings["keyRepeatDelay"]
                valueText: value + " ms"
                stepSize: 10

                property bool wasChanged: false
                onValueChanged: wasChanged = true
                onReleased:
                {
                    if (wasChanged)
                    {
                        wasChanged = false
                        settingsui.setSetting("keyRepeatDelay", value)
                    }
                }
            }
            Slider
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                //: Keyboard repeat rate slider
                //% "Repeat rate"
                label: qsTrId("repeat-rate-slider")
                minimumValue: 25
                maximumValue: 100
                value: settings["keyRepeatRate"]
                valueText: value + " ms"
                stepSize: 1

                property bool wasChanged: false
                onValueChanged: wasChanged = true
                onReleased:
                {
                    if (wasChanged)
                    {
                        wasChanged = false
                        settingsui.setSetting("keyRepeatRate", value)
                    }
                }
            }
            TextField
            {
                width: parent.width - 2*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                //: Placeholder text for textfield to test repeat settings
                //% "Test here"
                placeholderText: qsTrId("test-here")
                onFocusChanged:
                {
                    /* Restore focus back to keyboard handler */
                    if (!focus)
                        kbdif.focus = true
                }
            }

            SectionHeader
            {
                //: Section header for sticky and locking settings
                //% "Sticky and locking modifier keys"
                text: qsTrId("sticky-sect-header")
            }
            Label
            {
                //: Description text for sticky and locking modifier keys
                //% "In Sticky mode, modifier key will stay on after pressed once and released after pressing again or any other key. In Lock mode modifier key will lock on double-press and released on third. In Cycle mode Sticky and Lock modes are both active, after first press is Sticky and second press is Lock. In all modes you can also use them as normal modifier keys."
                text: qsTrId("sticky-desc")
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                width: parent.width - 4*Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Repeater
            {
                model: modifiers

                ComboBox
                {
                    width: parent.width
                    label: "   " + combolabel + " "
                    menu: ContextMenu
                    {
                        id: modifierCBmenu
                        Repeater
                        {
                            model: modifierModes
                            MenuItem { text: name; onClicked: settingsui.setSetting(key, code); }
                        }
                    }
                    Component.onCompleted:
                    {
                        var i
                        for (i=0 ; i < modifierModes.count ; i++)
                        {
                            var item = modifierModes.get(i)
                            if (settings[key] === item["code"])
                            {
                                currentIndex = i
                                return
                            }
                        }
                    }
                }
            }

            SectionHeader
            {
                //: Section header for Debug settings
                //% "Debug"
                text: qsTrId("debug-sect-header")
            }
            TextSwitch
            {
                //: Enable verbose mode to print more stuff on journal
                //% "Verbose mode"
                text: qsTrId("verbose-mode-sw")
                //: Verbose mode switch description
                //% "Print more information in Journal logs. Use 'devel-su journalctl -fa | grep toh' to see output."
                description: qsTrId("verbose-mode-desc")
                onCheckedChanged: if (checked !== settings["verboseMode"]) settingsui.setSetting("verboseMode", checked)
                width: parent.width - 2*Theme.paddingLarge
                Component.onCompleted: checked = settings["verboseMode"]
            }

            TextSwitch
            {
                id: nodeadkeysSwitch
                //: Switch to set 'nodeadkeys' in keymap variant
                //% "No deadkeys"
                text: qsTrId("nodeadkeys-sw")
                //: No deadkeys switch description
                //% "Set 'nodeadkeys' to keymap variant. Required for some keyboard layouts, e.g. fi, de."
                description: qsTrId("nodeadkeys-desc")
                width: parent.width - 2*Theme.paddingLarge
                automaticCheck: false
                onClicked:
                {
                    if (keymapVariant.value !== "nodeadkeys")
                        keymapVariant.value = "nodeadkeys"
                    else
                        keymapVariant.value = ""
                }
                Component.onCompleted: checked = (keymapVariant.value === "nodeadkeys")
            }
        }
    }

    ConfigurationValue
    {
        id: keymapVariant
        key: "/desktop/lipstick-jolla-home/variant"
        defaultValue: ""

        onValueChanged:
            nodeadkeysSwitch.checked = (value === "nodeadkeys")
    }
}

