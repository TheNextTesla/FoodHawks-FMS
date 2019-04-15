import QtQuick 2.0
import QtCharts 2.0
import QtGraphicalEffects 1.0

Item {
    width: 715
    height: 480

    Text {
        id: elementStatScreenTitle
        x: 166
        y: 26
        width: 383
        height: 67
        text: qsTr("Your Waste Statistics")
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    ChartView {
        id: chartViewPie
        x: 8
        y: 90
        width: 699
        height: 382
        titleColor: "#bc1515"
        title: "Most Wasted Items"
        theme: ChartView.ChartThemeBrownSand
        antialiasing: true

        PieSeries {
            id: pieSeries
        }
    }

    Connections {
        target: mainView
        onRefreshAll: {
            console.debug("Updating StatViewChart")
            pieSeries.clear()
            var waste_list = foodList.getRemovedFoodItems();
            var waste_ratings = foodList.getRemovedFoodWaste();

            var index = 0
            for(index = 0; index < waste_list.length; index++) {
               pieSeries.append(waste_list[index], waste_ratings[index])
            }
        }
    }
}
