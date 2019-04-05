import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Imagine 2.3
import Qt.labs.calendar 1.0

Window {
    id: windowMain
    visible: true
    width: 800
    height: 480
    title: qsTr("FoodManagementSystem")

    Item {
        id: appContainer
        width: Screen.width < Screen.height ? parent.height : parent.width
        height: Screen.width < Screen.height ? parent.width : parent.height
        anchors.centerIn: parent
        rotation: Screen.width < Screen.height ? 90 : 0
        MainView {
            id: virtualKeyboard
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: inputPanel.top
        }

        /*  Handwriting input panel for full screen handwriting input.

            This component is an optional add-on for the InputPanel component, that
            is, its use does not affect the operation of the InputPanel component,
            but it also can not be used as a standalone component.

            The handwriting input panel is positioned to cover the entire area of
            application. The panel itself is transparent, but once it is active the
            user can draw handwriting on it.
        */
        HandwritingInputPanel {
            z: 79
            id: handwritingInputPanel
            anchors.fill: parent
            inputPanel: inputPanel
            Rectangle {
                z: -1
                anchors.fill: parent
                color: "black"
                opacity: 0.10
            }
        }

        /*  Keyboard input panel.

            The keyboard is anchored to the bottom of the application.
        */
        InputPanel {
            id: inputPanel
            z: 89
            y: appContainer.height
            anchors.left: parent.left
            anchors.right: parent.right
            states: State {
                name: "visible"
                /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                    but then the handwriting input panel and the keyboard input panel can be visible
                    at the same time. Here the visibility is bound to InputPanel.active property instead,
                    which allows the handwriting panel to control the visibility when necessary.
                */
                when: inputPanel.active
                PropertyChanges {
                    target: inputPanel
                    y: appContainer.height - inputPanel.height
                }
            }
            transitions: Transition {
                id: inputPanelTransition
                from: ""
                to: "visible"
                reversible: true
                enabled: true
                ParallelAnimation {
                    NumberAnimation {
                        properties: "y"
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Binding {
                target: InputContext
                property: "animating"
                value: inputPanelTransition.running
            }
        }
    }
}
