import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Imagine 2.3

Item {
    width: 715
    height: 480

    Rectangle {
        id: rectangleDisclaimer
        x: 8
        y: 55
        width: 699
        height: 252
        color: "#bdbdbd"

        Text {
            id: elementDisclaimerTitle
            x: 226
            y: 26
            width: 248
            height: 35
            text: qsTr("Disclaimer")
            font.italic: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 21
        }

        Text {
            id: elementDisclaimerText
            x: 74
            y: 67
            width: 552
            height: 121
            text: qsTr("This device is meant to help reduce household food waste by showing the typical lengths at which a particular type of food may still be good after its 'printed date'.  However, the lifespan of an individual food item varies for each individual item and how well it has been preserved before finally ending up in your refridgerator.  Always use your best judgement when deciding when to consume or throw out a particular food.  For common tips on how to tell when a food is going to spoil, go to :")
            font.family: "Times New Roman"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.pixelSize: 16
        }

        Text {
            id: elementDisclaimerLink
            x: 232
            y: 185
            width: 236
            height: 34
            text: qsTr("www.eatbydate.com")
            font.family: "Courier"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 19
        }
    }

    Rectangle {
        id: rectangleHomeButtonText
        x: 162
        y: 342
        width: 392
        height: 89
        color: "#b5eab7"

        RoundButton {
            id: roundButtonSettings
            x: 20
            y: 12
            width: 65
            height: 65
            text: "\u2699"
            font.pointSize: 29
            onClicked: {
                swapView.currentIndex = 5
            }
        }

        Text {
            id: elementGoToSettings
            x: 91
            y: 12
            width: 293
            height: 65
            text: qsTr("Press Here to Configure the FMS, or Press Home to Start")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 20
        }
    }

}
