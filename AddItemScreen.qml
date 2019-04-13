import QtQuick 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 1.4

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

    TextKeyField {
        id: textFieldFoodName
        x: 370
        y: 130
        width: 318
        height: 61
        previewText: "Item Name"
        //enterKeyAction: TODO: Add Enter Key Action
        onEnterKeyClicked: textFieldFoodName.focus = true
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

    Calendar {
        id: calendar
        x: 56
        y: 118
        width: 250
        height: 235
    }

    Button {
        id: buttonAddItem
        x: 416
        y: 234
        width: 225
        height: 66
        text: "Add Item"
        checkable: false
        onClicked: {
            foodList.addItem(textFieldFoodName.text, "", calendar.selectedDate);
            textFieldFoodName.text = ""
            textFieldFoodName.focus = false
        }
    }

    Rectangle {
        id: rectangleScanBelow
        x: 236
        y: 374
        width: 244
        height: 85
        color: "#73d216"

        Text {
            id: elementTextScanBelow
            x: 57
            y: 8
            width: 130
            height: 47
            text: qsTr("Scan Below")
            font.italic: false
            font.bold: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Verdana"
            fontSizeMode: Text.VerticalFit
            elide: Text.ElideLeft
            wrapMode: Text.WordWrap
            font.pixelSize: 20
        }

        Text {
            id: elementTextScanBelowArrow
            x: 110
            y: 51
            width: 24
            height: 26
            text: qsTr("▼")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
        }
    }

}
