import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0

Item {
    width: 715
    height: 480

    Text {
        id: elementInFridge
        x: 46
        y: 36
        width: 347
        height: 39
        text: qsTr("Currently in Your Fridge...")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.AutoText
        font.pixelSize: 26
        font.family: "Arial"
        lineHeight: 1.5
    }

    ListView {
        id: listViewInFridge
        x: 179
        y: 107
        width: 485
        height: 328
        clip: true
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
        }
        model: ListModel {
            id: homeListModel
        }
    }

    Rectangle {
        id: rectangleRed
        x: 32
        y: 101
        width: 120
        height: 85
        color: "#fb6f00"

        Text {
            id: elementRed
            x: 0
            y: 8
            width: 120
            height: 69
            color: "#000000"
            text: qsTr("Should Use As Soon As Possible")
            font.bold: false
            lineHeight: 0.8
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 19
        }
    }

    Rectangle {
        id: rectangleYellow
        x: 32
        y: 209
        width: 120
        height: 85
        color: "#fbfb2d"

        Text {
            id: elementYellow
            x: 0
            y: 8
            width: 120
            height: 69
            text: qsTr("Passing Peak Quality")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rectangleGreen
        x: 32
        y: 321
        width: 120
        height: 85
        color: "#10ef03"

        Text {
            id: elementGreen
            x: 0
            y: 8
            width: 120
            height: 69
            text: qsTr("Good for a While")
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 19
        }
    }

    Connections {
        target: mainView
        onRefreshAll: {
            console.debug("Updating HomeListModel")
            homeListModel.clear()

            var food_colors = foodList.getFoodItemColors()
            var food_names = foodList.getFoodItemNames()
            var index = 0

            for (index = 0; index < food_names.length; index++) {
                if(index < food_colors.length) {
                    homeListModel.append({"name":food_names[index], "colorCode":food_colors[index]})
                }
                else {
                    homeListModel.append({"name":food_names[index], "colorCode":"blue"})
                }
            }
        }
    }

    RoundButton {
        id: roundButtonRecipeSuggestion
        x: 425
        y: 17
        width: 45
        height: 45
        text: "🍲"
        font.pointSize: 21
        onClicked: {
            var url_recipe_search = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?number=1&limitLicense=true&ranking=1&ignorePantry=false&ingredients="
            var food_item_names = foodList.getFoodItemNames()
            var food_item_colors = foodList.getFoodItemColors()

            var index = 0
            for(index = 0; index < food_item_names.length; index++) {
                if(index < food_item_colors.length && food_item_colors[index] === "Red") {
                    var orig_string = food_item_names[index]
                    var comma_string = orig_string.replace(/,/g, '%2C')
                    var html_string = comma_string.replace(/ /g, '+')
                    url_recipe_search += html_string + "%2C"
                }
            }
            url_recipe_search = url_recipe_search.substring(0, url_recipe_search.length - 3)

            var headers = ["X-RapidAPI-Host", "X-RapidAPI-Key"]
            var header_vals = ["spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", "46611bcfaamsh1f155f49dd69dacp1fc022jsn02ac67384551"]
            getData(url_recipe_search, headers, header_vals, function(api_val) {
                var json_obj = JSON.parse(api_val)
                var id = json_obj[0].id
                var url_recipe_info = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/"
                url_recipe_info += id + "/information"
                getData(url_recipe_info, headers, header_vals, function(api_val) {
                    var json_obj2 = JSON.parse(api_val)
                    var result_url = json_obj2.sourceUrl
                    var result_title = json_obj2.title
                    var result_instruction = json_obj2.instructions
                    var message = "Food Management System: Recommended Recipe:\n"
                    message += result_title + "\n"
                    message += result_instruction + "\n"
                    message += "For More Information, See: " + result_url
                    foodList.sendMessage(message)
                })
            })
        }
    }

    Text {
        id: elementRecipeSuggestions
        x: 412
        y: 68
        width: 71
        height: 27
        text: qsTr("Send Recipe Suggestion")
        font.italic: true
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    RoundButton {
        id: roundButtonListFoodsToUseSoon
        x: 515
        y: 17
        width: 45
        height: 45
        text: "🍏"
        font.pointSize: 21
        onClicked: {
            console.debug("Foods to Use Soon Button")
            var food_item_names = foodList.getFoodItemNames()
            var food_item_colors = foodList.getFoodItemColors()

            var index = 0
            var final_array = []
            for(index = 0; index < food_item_names.length; index++) {
                if(index < food_item_colors.length && food_item_colors[index] === "Red") {
                    final_array.push(food_item_names[index])
                }
            }
            var str_message = "Food Management System: Food to Use Soon:\n"

            for(index = 0; index < final_array.length; index++) {
                str_message += final_array[index] + "\n"
            }
            foodList.sendMessage(str_message)
        }
    }

    Text {
        id: elementFoodsToUseSoon
        x: 498
        y: 68
        width: 71
        height: 27
        text: qsTr("Send Foods to Use Soon")
        font.italic: true
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    RoundButton {
        id: roundButtonListAllFoods
        x: 605
        y: 17
        width: 45
        height: 45
        text: "🍴"
        font.pointSize: 21
        onClicked: {
            console.debug("List All Foods Button Pressed")
            var total_food_list_w_dates = foodList.getFoodItemsContaining("")
            var str_message = "Food Management System: Current Inventory:\n"
            var index = 0
            for(index = 0; index < total_food_list_w_dates.length; index++) {
                str_message += total_food_list_w_dates[index] + "\n"
            }
            foodList.sendMessage(str_message)
        }
    }

    Text {
        id: elementAllFoods
        x: 593
        y: 68
        width: 71
        height: 27
        text: "Send All Foods List"
        font.italic: true
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
