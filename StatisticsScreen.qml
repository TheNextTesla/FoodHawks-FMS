import QtQuick 2.0

Item {
    width: 715
    height: 480

    Text {
        id: elementStatScreenTitle
        x: 166
        y: 26
        width: 383
        height: 67
        text: qsTr("Waste Statistics Screen")
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }
}
