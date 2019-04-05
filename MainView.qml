import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Imagine 2.3
import Qt.labs.calendar 1.0

Item {
    width: 800
    height: 480

    Rectangle {
        id: rectangle
        x: 716
        y: 0
        width: 85
        height: 480
        color: "#b0eb98"

        RoundButton {
            id: roundButtonAdd
            x: 10
            y: 27
            width: 65
            height: 65
            text: "+"
            font.pointSize: 32
            onClicked: swapView.currentIndex = 1
        }

        RoundButton {
            id: roundButtonRemove
            x: 10
            y: 127
            width: 65
            height: 65
            text: "-"
            font.pointSize: 32
        }

        RoundButton {
            id: roundButtonStat
            x: 10
            y: 236
            width: 65
            height: 65
            text: "\u2139"
            font.pointSize: 32
        }

        RoundButton {
            id: roundButtonHome
            x: 10
            y: 370
            width: 65
            height: 65
            text: "\u2302"
            font.pointSize: 32
            onClicked: swapView.currentIndex = 0
        }
    }

    SwapView {
        id: swapView
        x: 0
        y: 0
        width: 715
        height: 480

        //https://stackoverflow.com/questions/45308023/how-to-use-qml-stackview

        HomeScreen {}
        AddItemScreen {}

    }
}