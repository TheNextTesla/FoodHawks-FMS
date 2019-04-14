import QtQuick 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 1.4

Item {
    width: 715
    height: 480

    function addItem() {
        var current_text = textFieldFoodName.text
        var current_date = calendar.selectedDate
        if(isNumeric(current_text)) {
            var request_url = "https://api.nal.usda.gov/ndb/search/?format=json&q="
            request_url += current_text
            request_url += "&max=1&offset=0&api_key=BScWLcJjXHdIQVrvZNxKWhNznrdiGBI4jNdHimzU"
            getData(request_url, function(api_val) {
                var json_obj = JSON.parse(api_val)
                var name = json_obj.list.item[0].name
                if(name !== "") {
                    foodList.addItem(name, current_text, current_date);
                }
                else {
                    foodList.addItem("", current_text, current_date);
                }
                textFieldFoodName.text = ""
                textFieldFoodName.focus = false
            })
        }
        else {
            foodList.addItem(current_text, "", calendar.selectedDate);
            textFieldFoodName.text = ""
            textFieldFoodName.focus = false
        }
    }

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
        text: qsTr("Printed Date or Date of Purchase")
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
            addItem()
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
