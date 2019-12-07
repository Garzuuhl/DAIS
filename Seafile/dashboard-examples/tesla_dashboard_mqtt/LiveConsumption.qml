import QtQuick 2.0
import QtCharts 2.2

Item {
    id: consumption
    property ValueSource values
    property real counter: lastXKm

    property int lastXKm: values.cC_LAST_X_KM
    property double stepSize: values.cC_STEP_SIZE
    property double stepMultiplicator: values.cC_STEP_MULTIPLICATOR

    property real avgCounter: 0//lastXKm
    //property variant avgNumbers: [] //[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]

    property real avgConsumption: 0.0 // We don't use the value from the datasource because it contains the overall avg value

    Component.onCompleted: {
        //values.onCurrentConsumptionChanged.connect(addValuesToChart)
        //values.onAvgConsumptionChanged.connect(addValuesToChart)

        for(var kmValueIndex=0,
            xValueCounter=(lastXKm-(values.cC_lastXKmValues.length/stepMultiplicator)-stepSize); kmValueIndex<values.cC_lastXKmValues.length; kmValueIndex++) {
            //console.log("Adding: " + xValueCounter + ", " + values.cC_lastXKmValues[kmValueIndex]);
            currentConsumptionSeries.append(xValueCounter, values.cC_lastXKmValues[kmValueIndex]);
            xValueCounter+=stepSize;
        }

        /*for(var avgKmValueIndex=0; avgKmValueIndex<values.cC_last30KmAvgValues.length; avgKmValueIndex++) {
            console.log("Adding: " + avgKmValueIndex + ", " + values.cC_last30KmAvgValues[avgKmValueIndex]);
            avgConsumptionSeries.append(lastXKm - avgKmValueIndex, values.cC_last30KmAvgValues[avgKmValueIndex]);
        }*/

        chart.update();

        //values.onDistanceChanged.connect(addValuesToChart)
        values.onPlottableConsumptionChanged.connect(addValuesToChart);
        //values.cC_last30KmAvgValues.connect();
        chart.legend.visible = false;

    }

    Component.onDestruction: {
        //values.onCurrentConsumptionChanged.disconnect(addValuesToChart)
        //values.onAvgConsumptionChanged.disconnect(addValuesToChart)
        //values.onDistanceChanged.disconnect(addValuesToChart)
        values.onPlottableConsumptionChanged.disconnect(addValuesToChart);
        //values.onAvgConsumptionChanged.disconnect();


    }

    /* function updateAvgLine() {
        avgConsumption = values.cC_last30KmAvgValues[values.cC_last30KmAvgValues.length-1];
    }*/

    function addValuesToChart(consumption) {

        currentConsumptionSeries.append(counter, consumption)
        xAxis.max= counter
        xAxis.min = counter < lastXKm ? 0 : counter-lastXKm
        counter+=stepSize;

        /*
        if((parseFloat(values.distance*10) === parseInt(values.distance*10)) && !isNaN(values.distance*10)){
            currentConsumptionSeries.append(counter, values.currentConsumption)

            if((parseFloat(values.distance) === parseInt(values.distance)) && !isNaN(values.distance)){
                avgNumbers[avgCounter] = consumption.values.currentConsumption
                avgCounter = (avgCounter+1)%avgNumbers.length
            }
            var addedConsumptionVals = 0;
            for (var i=0; i<avgNumbers.length; i++) {
                addedConsumptionVals+=avgNumbers[i];
            }

            avgConsumption = addedConsumptionVals/avgNumbers.length;
            addedConsumptionVals = 0;

            //avgConsumptionSeries.append(counter,avgConsumption)
            xAxis.max= counter// < lastXKm ? 30 : counter;
            xAxis.min = counter < lastXKm ? 0 : counter-lastXKm

            xAxisAvg.max= xAxis.max
            xAxisAvg.min = xAxis.min

            counter+=stepSize;
        }
        */
    }

    Rectangle {

        width: parent.width
        height: parent.height

        color: "transparent"

        Text {
            color: "white"
            font.pixelSize: chart.plotArea*0.15
            font.bold: true
            x: chart.plotArea.x
            text: "Current milage: " + Math.round(values.currentConsumption*10)/10 + " l/km"
        }

        ChartView {
            id: chart
            title: "Milage"
            titleColor: "#FFFFFF"
            titleFont.family: "Eurostile"
            titleFont.bold: true
            width: parent.width*0.5
            height: width

            x: parent.width * 0.025
            anchors.verticalCenter: parent.verticalCenter
            //anchors.centerIn: parent
            //theme: ChartView.ChartThemeDark
            animationOptions:ChartView.SeriesAnimations

            antialiasing: true

            backgroundColor: "black"

            ValueAxis {
                id: yAxis

                gridVisible: true
                labelsFont.family: "Eurostile"
                labelsColor: "#FFFFFF"
                min: 0
                max: 20
            }

            ValueAxis {
                id: xAxis

                labelsVisible: false
                gridVisible: true
                tickCount: 4

                min: 0.0
                max: values.cC_LAST_X_KM //1.0
            }

            ValueAxis {
                id: xAxisAvg

                labelsVisible: false
                gridVisible:false

                lineVisible: false
                min: 0
                //max: 1
                max: values.cC_LAST_X_KM
            }

            AreaSeries {
                id: areaSeries
                name: "LineSeries"


                color: "#A9C14409"
                borderColor: "#F3CA81"
                borderWidth: 1

                axisY: yAxis
                axisX: xAxis

                upperSeries:  LineSeries {
                    id: currentConsumptionSeries
                }

            }

            /*LineSeries {
                id: avgConsumptionSeries

                style: Qt.DashLine

                color: "white"

                width: 1
                axisX: xAxisAvg
                axisY: yAxis
            }*/

            Rectangle {
                id: avgConsumptionLine
                x: chart.plotArea.x
                y: (chart.plotArea.y + chart.plotArea.height) - (chart.plotArea.height * (values.avgConsumption/20)) - height/2
                width: chart.plotArea.width*1.1
                height: 3
                color: "#FFFFFF"
            }

            Rectangle {
                radius: 5
                width: chart.plotArea.width/8
                height: width //childrenRect.height

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#92B7D4" }
                    GradientStop { position: 0.5; color: "#202F4D" }
                    GradientStop { position: 1.0; color: "#7998B6" }
                }

                x: chart.plotArea.x + chart.plotArea.width + width/4
                anchors.verticalCenter: avgConsumptionLine.verticalCenter
                Text {
                    anchors.centerIn: parent
                    text:"Avg. \n" + Math.round(values.avgConsumption * 10)/10
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: chart.plotArea.width/19
                    color: "white"
                }
            }

            Text {
                y: chart.plotArea.y + chart.plotArea.height + height/2
                x: chart.plotArea.x - width/2
                color: "white"

                text: "30"

            }

            Text {
                y: chart.plotArea.y + chart.plotArea.height + height/2
                x: chart.plotArea.x + chart.plotArea.width*0.33 - width/2
                color: "white"

                text: "20"
            }

            Text {
                y: chart.plotArea.y + chart.plotArea.height + height/2
                x: chart.plotArea.x + chart.plotArea.width*0.66 - width/2
                color: "white"

                text: "10"
            }

            Text {
                y: chart.plotArea.y + chart.plotArea.height + height/2
                x: chart.plotArea.x + chart.plotArea.width - width/2
                color: "white"
                text: "0"
            }
        }

        Text {
            anchors.horizontalCenter: chart.horizontalCenter
            anchors.top: chart.bottom

            font.family: "Eurostile";
            color: "white";
            font.bold: true
            font.pixelSize: chart.height * 0.05
            text: "Past " + lastXKm + " km"
        }


    }
}
