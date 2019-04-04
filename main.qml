import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.VirtualKeyboard 2.3

Window {
    id: windowMain
    visible: true
    width: 800
    height: 480
    title: qsTr("FoodManagementSystem")

    Rectangle {
        id: rectangle
        x: 716
        y: 0
        width: 85
        height: 480
        color: "#b0eb98"
    }

    SwapView {
        id: swapView
        x: 0
        y: 0
        width: 715
        height: 480
    }
}
