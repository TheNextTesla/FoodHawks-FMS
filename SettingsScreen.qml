import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    width: 715
    height: 480

    TextKeyField {
        id: textKeyFieldNotifications
        x: 68
        y: 158
        width: 579
        height: 40
    }

    Text {
        id: elementSettings
        x: 166
        y: 26
        width: 383
        height: 67
        text: qsTr("Settings & Configuration")
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    Text {
        id: elementAddUser
        x: 161
        y: 99
        width: 388
        height: 43
        text: qsTr("To Receive FMS Notifications, Enter Your Pushover User Code Below")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 19
    }

    Button {
        id: buttonAddUser
        x: 243
        y: 209
        width: 106
        height: 34
        text: qsTr("Add User")
        onClicked: {
            foodList.addUser(textKeyFieldNotifications.text)
            textKeyFieldNotifications.text = ""
        }
    }

    Text {
        id: elementRemoveUser
        x: 161
        y: 278
        width: 388
        height: 43
        text: qsTr("To Reset the List of FMS Message Recipients, Press the Button Below")
        font.pixelSize: 19
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: buttonRemoveUser
        x: 288
        y: 337
        width: 140
        height: 40
        text: qsTr("Clear All Users")
        onClicked: {
            foodList.removeAllUsers()
        }
    }

    Button {
        id: buttonTestMessage
        x: 379
        y: 209
        width: 115
        height: 34
        text: qsTr("Test Message")
        onClicked: {
            foodList.sendMessage("FMS Test Message Manually Requested")
        }
    }
}
