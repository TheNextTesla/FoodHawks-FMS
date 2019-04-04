import QtQuick 2.0

Item {
    width: 715
    height: 480

    Text {
        id: elementScanItemBelow
        x: 166
        y: 26
        width: 383
        height: 67
        text: qsTr("Scan Your Item Below")
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    TextField {
        id: textFieldFoodName
        x: 369
        y: 118
        width: 318
        height: 61
        previewText: "Item Name"
        enterKeyAction: EnterKeyAction.Next
        onEnterKeyClicked: passwordField.focus = true
    }

    TextField {
        id: textFieldPurchaseDate
        x: 20
        y: 118
        width: 318
        height: 61
        enterKeyAction: EnterKeyAction.Next
        previewText: "Purchase Date"
        inputMethodHints: Qt.ImhFormattedNumbersOnly
        onEnterKeyClicked: digitsField.focus = true
    }

    Text {
        id: elementDateOfPurchase
        x: 56
        y: 88
        width: 246
        height: 24
        text: qsTr("Date of Purchase")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: elementFoodName
        x: 405
        y: 88
        width: 246
        height: 24
        text: qsTr("Item Name")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

}


