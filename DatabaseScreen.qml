import QtQuick 2.0
import QtQuick.Controls 2.3

Item {
    width: 715
    height: 480

    Connections {
        target: mainView
        onPassDatabaseInfo: {
            textKeyFieldUPC.text = upc
            textKeyFieldName.text = name
        }
    }

    Text {
        id: elementAddItemToDatabase
        x: 108
        y: 8
        width: 499
        height: 67
        text: qsTr("Unknown Item - Please Add to Database")
        font.italic: true
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 22
    }

    TextKeyField {
        id: textKeyFieldUPC
        x: 220
        y: 88
        width: 430
        height: 40
    }

    TextKeyField {
        id: textKeyFieldName
        x: 220
        y: 148
        width: 430
        height: 40
    }

    Text {
        id: elementItemName
        x: 40
        y: 143
        width: 164
        height: 50
        text: qsTr("Name")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 26
    }

    Text {
        id: elementItemUPC
        x: 40
        y: 83
        width: 164
        height: 50
        text: qsTr("UPC")
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        font.pixelSize: 26
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WrapAnywhere
    }

    TextKeyField {
        id: textKeyFieldCompany
        x: 220
        y: 208
        width: 430
        height: 40
    }

    Text {
        id: elementItemCompany
        x: 40
        y: 203
        width: 164
        height: 50
        text: qsTr("Company")
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        font.pixelSize: 26
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WrapAnywhere
    }

    TextKeyField {
        id: textKeyFieldFoodGroup
        x: 220
        y: 268
        width: 430
        height: 40
    }

    Text {
        id: elementItemFoodGroup
        x: 40
        y: 263
        width: 164
        height: 50
        text: qsTr("Food Group")
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 26
        wrapMode: Text.WrapAnywhere
    }

    Dial {
        id: dialExtension
        x: 253
        y: 317
        width: 160
        height: 134
        stepSize: 0.01
        onValueChanged: {
            elementCurrentDial.text = Math.round(dialExtension.value * 365).toString()
        }

        Text {
            id: elementCurrentDial
            x: 50
            y: 48
            width: 60
            height: 38
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 23
        }
    }

    Text {
        id: elementItemExtension
        x: 40
        y: 322
        width: 164
        height: 123
        text: qsTr("Approximate Extension Period or Life After 'Expiration' Date (0-365)")
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    Button {
        id: buttonAddToDatabase
        x: 470
        y: 350
        width: 180
        height: 69
        text: qsTr("Add to Database")
        font.pointSize: 14
        onClicked: {
            var extensionString = Math.round(dialExtension.value * 365 / 2) + "," + Math.round(dialExtension.value * 365)
            foodList.addNewDatabaseEntry(textKeyFieldUPC.text, textKeyFieldName.text,
                                         textKeyFieldCompany.text, textKeyFieldFoodGroup.text, extensionString)
            textKeyFieldUPC.text = ""
            textKeyFieldName.text = ""
            textKeyFieldCompany.text = ""
            textKeyFieldFoodGroup.text = ""
        }
    }

    Text {
        id: elementZero
        x: 253
        y: 439
        width: 29
        height: 27
        text: qsTr("0")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
    }

    Text {
        id: elementThreeSixFive
        x: 374
        y: 439
        width: 49
        height: 27
        text: qsTr("365")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }
}
