import QtQuick 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Imagine 2.3

Item {
    width: 715
    height: 480

    Text {
        id: elementRemoveItemBelow
        x: 166
        y: 26
        width: 383
        height: 67
        text: qsTr("Remove Item")
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    TextKeyField {
        id: textFieldFoodNameSearch
        x: 369
        y: 118
        width: 318
        height: 61
        previewText: "Item Name"
        //enterKeyAction: TODO: Add Enter Key Action
        onEnterKeyClicked: textFieldFoodName.focus = true
    }

    Text {
        id: elementFoodNameSearch
        x: 405
        y: 88
        width: 246
        height: 24
        text: qsTr("Find by Name")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        id: rectangleScanBelow
        x: 32
        y: 99
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

    Text {
        id: elementOR
        x: 289
        y: 106
        width: 68
        height: 71
        text: qsTr("OR")
        lineHeight: 0.8
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 26
    }

    Slider {
        id: sliderFoodRating
        x: 219
        y: 259
        width: 278
        height: 40
        orientation: Slider.SnapAlways
        clip: false
        stepSize: 0.1
        value: 0.5
    }

    Text {
        id: elementRateFoodUse
        x: 225
        y: 211
        text: qsTr("Rate Amount Remaining")
        font.pixelSize: 24
    }

    Text {
        id: elementNone
        x: 88
        y: 267
        text: qsTr("None (0)")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 21
    }

    Text {
        id: elementNone1
        x: 537
        y: 267
        text: qsTr("All (10)")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 21
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: buttonRemoveItem
        x: 274
        y: 345
        width: 168
        height: 64
        text: qsTr("Remove Item")
        font.weight: Font.Medium
        font.bold: false
        font.pointSize: 15
        spacing: 6
    }

}
