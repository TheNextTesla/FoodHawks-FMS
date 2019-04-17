import QtQuick 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Imagine 2.3

Item {
    width: 715
    height: 480

    function updateRemovalList() {
        var current_text = textFieldFoodNameSearch.text
        if(isNumeric(current_text)) {
            var data_find = foodList.findItemNameByUPC(current_text)
            if(data_find !== "") {
                var items_containing = foodList.getFoodItemsContaining(data_find)
                var index_inner = 0;
                removeListModel.clear()
                for (index_inner = 0; index_inner < items_containing.length; index_inner++) {
                    removeListModel.append({"name":items_containing[index_inner]})
                    console.debug(items_containing[index_inner])
                }
            }
            else {
                var request_url = "https://api.nal.usda.gov/ndb/search/?format=json&q="
                request_url += current_text
                request_url += "&max=1&offset=0&api_key=BScWLcJjXHdIQVrvZNxKWhNznrdiGBI4jNdHimzU"
                getData(request_url, [], [], function(api_val){
                    var json_obj = JSON.parse(api_val)
                    var name = json_obj.list.item[0].name
                    var itemsContaining = foodList.getFoodItemsContaining(name)
                    var index = 0;
                    removeListModel.clear()
                    for (index = 0; index < itemsContaining.length; index++) {
                        removeListModel.append({"name":itemsContaining[index]})
                        console.debug(itemsContaining[index])
                    }
                })
            }
        }
        else {
            var itemsContaining = foodList.getFoodItemsContaining(current_text)
            var index = 0;
            removeListModel.clear()
            for (index = 0; index < itemsContaining.length; index++) {
                removeListModel.append({"name":itemsContaining[index]})
                console.debug(itemsContaining[index])
            }
        }
    }

    function removeItem() {
        if(listView.currentIndex != -1) {
            var current_text = textFieldFoodNameSearch.text
            var foodDateStrings = []
            if(isNumeric(current_text)) {
                var data_find = foodList.findItemNameByUPC(current_text)
                if(data_find !== "") {
                    foodDateStrings = foodList.getFoodItemsContaining(data_find)
                }
                else {
                    foodDateStrings = foodList.getFoodItemsContaining("")
                }
            }
            else {
                foodDateStrings = foodList.getFoodItemsContaining(current_text)
            }

            var foodDateString = foodDateStrings[listView.currentIndex]
            console.debug("Removing " + foodDateString)
            var split = foodDateString.split(" | ")
            var split_length = split.length

            if(split_length === 2) {
                foodList.removeItem(split[0], split[1], sliderFoodRating.value)
            }
            else if(split_length > 2) {
                var temp_index = 0
                var temp_str = split[0]
                for(temp_index = 1; temp_index < split_length - 2; temp_index++) {
                    temp_str += " | " + split[temp_index]
                }
                foodList.removeItem(temp_str, split(split_length - 1), sliderFoodRating.value)
            }
            else {
                console.debug("Remove Button Too Few Parameters")
            }
            updateRemovalList()
        }
        else {
            console.debug("Remove Button Nothing Selected")
        }
    }

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
        //TODO: Add Response to UPC Code Being Scanned In
        onEnterKeyClicked: {
            console.debug("Enter Pressed")
            textFieldFoodNameSearch.focus = true
            updateRemovalList()
        }
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
        x: 15
        y: 318
        width: 278
        height: 40
        orientation: Slider.SnapAlways
        clip: false
        stepSize: 0.1
        value: 0.5
    }

    Text {
        id: elementRateFoodUse
        x: 22
        y: 208
        text: qsTr("Rate Amount Remaining")
        font.pixelSize: 24
    }

    Text {
        id: elementNone
        x: 14
        y: 276
        text: qsTr("None (0)")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 21
    }

    Text {
        id: elementNone1
        x: 220
        y: 276
        text: qsTr("All (10)")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 21
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: buttonRemoveItem
        x: 274
        y: 393
        width: 168
        height: 64
        text: qsTr("Remove Item")
        font.weight: Font.Medium
        font.bold: false
        font.pointSize: 15
        spacing: 6
        onClicked: {
            removeItem()
        }
    }

    Text {
        id: elementFindExactFood
        x: 467
        y: 208
        text: qsTr("Select Item")
        font.pixelSize: 24
    }

    ListView {
        id: listView
        x: 321
        y: 241
        width: 366
        height: 124
        currentIndex: 0
        clip: true
        highlight: Rectangle {
            color: 'green'
        }
        highlightFollowsCurrentItem: true

        delegate: Item {
            x: 5
            width: 366
            height: 40
            Row {
                id: row1
                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
            MouseArea {
                anchors.fill: parent
                onClicked: listView.currentIndex = index
            }
        }
        model: ListModel {
            id: removeListModel
        }
    }
}
