import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0


Item {
    id: gaugeRect
    property real speedMin: 0
    property real speedMax: 260
    property real speedMinAngle: 125
    property real speedMaxAngle: 250

    property real rpmMin: 0
    property real rpmMax: 8
    property real rpmMinAngle: -125
    property real rpmMaxAngle: -250

    property ValueSource values;



    CircularGauge {
        id: speedGauge
        width: parent.height
        height: width

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        minimumValue: speedMin
        maximumValue: speedMax
        value: valueSource.kph
        style: CircularGaugeStyle {

            id: speedGaugeStyle

            onNeedleRotationChanged: {
                gaugeCanvas.requestPaint()
            }

            labelInset: outerRadius * 0.15

            tickmarkLabel:
                Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: "#FFFFFF"
                antialiasing: true
            }

            tickmark: Rectangle {
                implicitWidth:  styleData.value%speedGaugeStyle.labelStepSize===0 ? speedGaugeStyle.outerRadius * 0.02 : speedGaugeStyle.outerRadius * 0.01

                antialiasing: true
                implicitHeight:  speedGaugeStyle.outerRadius * 0.05
                color: styleData.value%speedGaugeStyle.labelStepSize===0 ? "#FFFFFF" : "lightgray"
            }

            labelStepSize: 30
            tickmarkStepSize: 10
            minorTickmarkCount: 0
            maximumValueAngle: -20
            minimumValueAngle: -145

            foreground: null
            needle:
                Rectangle {
                y: outerRadius * 0.01
                implicitWidth: outerRadius * 0.02
                implicitHeight: outerRadius// * 0.9
                antialiasing: true
                color: "#81FFFE"
                smooth: true
            }
        }
    }

    CircularGauge {
        id: rpmGauge
        width: parent.height
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        minimumValue: 0
        maximumValue: valueSource.maxrpm / 1000
        value: valueSource.rpm/1000
        tickmarksVisible: true


        style:
            CircularGaugeStyle {
            id: rpmGaugeStyle

            onNeedleRotationChanged: {
                gaugeCanvas.requestPaint()
            }

            tickmark: Rectangle {
                implicitWidth:  styleData.value%rpmGaugeStyle.labelStepSize===0 ? rpmGaugeStyle.outerRadius * 0.02 : rpmGaugeStyle.outerRadius * 0.01
                antialiasing: true
                implicitHeight:  rpmGaugeStyle.outerRadius * 0.05
                color: styleData.value%rpmGaugeStyle.labelStepSize===0 ? "#FFFFFF" : "lightgray"
            }

            labelInset: outerRadius*0.15
            labelStepSize: 1
            maximumValueAngle: 20
            minimumValueAngle: 145
            tickmarkStepSize: 1
            minorTickmarkCount: 0
            foreground:  Image {
                id: innerRingRect
                height: parent.height*0.75
                width: height

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                source: "/pics/Tacho_Mitte.png"

                Text {
                    id: speeddigit
                    text: Math.ceil(valueSource.kph)
                    font.pixelSize: innerRingRect.height/4 //86
                    font.bold: true
                    font.family: "Eurostile"
                    y: parent.height*0.1
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "km/h"
                    font.pixelSize: speeddigit.font.pixelSize * 0.2  //16
                    font.family: "Eurostile"
                    y: parent.height*0.4
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {

                    color: "transparent"

                    width: innerRingRect.width*0.4 //innerRingRect.width*0.6
                    height: innerRingRect.height*0.07

                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height/2

                    Image {

                        source: "/icons/fuel.png"

                        height: /*parent.width * 0.15*/ fuelBar.height*1.05
                        fillMode: Image.PreserveAspectFit

                        anchors.verticalCenter: fuelBar.verticalCenter
                        anchors.right: fuelBar.left
                        anchors.rightMargin: fuelBar.height*0.25
                    }

                    ProgressBar {
                        id: fuelBar
                        width: parent.width * 0.85 //innerRingRect.width*0.6 //innerRingRect.width*0.6
                        height: parent.height //innerRingRect.height*0.1
                        minimumValue: 0
                        maximumValue: 1
                        antialiasing: true

                        anchors.right: parent.right

                        value: values.fuel

                        style: ProgressBarStyle {
                            id: gradientStyle
                            background: Rectangle {
                                radius: 5
                                color: "lightgray"
                                border.color: "gray"
                                border.width: 1
                                implicitWidth:  innerRingRect.width*0.6//100
                                implicitHeight: innerRingRect.height*0.1 //40
                                //transform: Rotation { origin.x: parent.x + parent.width/2; origin.y: parent.y + parent.height/2; axis { x:1; y:0; z:0} angle: 30 }
                            }

                            progress:
                                Rectangle {
                                id: fuelGradientRect
                                radius: 5
                                implicitHeight: fuelBar.height*0.7
                                //transform: Rotation { origin.x: parent.x + parent.width/2; origin.y: parent.y + parent.height/2; axis { x:1; y:0; z:0} angle: 30 }
                                antialiasing: true
                                border.color: fuelBar.value > 0.25 ? "#255235" : "#FF5235"

                                property string colorTop: "#255235"
                                property string colorMiddle: "#255235"
                                property string colorBottom: "#55AD63"

                                property string colorTopLowFuel: "#FF5235"
                                property string colorMiddleLowFuel: "#FF5235"
                                property string colorBottomLowFuel: "#FFAD63"

                                gradient: Gradient {
                                    GradientStop {position: 0.0; color: 'white' }
                                    GradientStop {position: 0.5; color: fuelBar.value > 0.25 ? fuelGradientRect.colorTop: fuelGradientRect.colorTopLowFuel}
                                    GradientStop {position: 0.6; color: fuelBar.value > 0.25 ? fuelGradientRect.colorMiddle: fuelGradientRect.colorMiddleLowFuel}
                                    GradientStop {position: 1.0; color: fuelBar.value > 0.25 ? fuelGradientRect.colorBottom: fuelGradientRect.colorBottomLowFuel}
                                }
                            }
                        }
                    }
                }

                Text {
                    text: values.estimatedRange//"209" // Abhängig vom Verbrauch
                    font.pixelSize: speeddigit.font.pixelSize * 0.4 //34
                    font.bold: true
                    font.family: "Eurostile"
                    y: parent.height /2 + parent.height*0.12
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Rated Range"
                    font.pixelSize: speeddigit.font.pixelSize * 0.2 //18
                    font.bold: false
                    font.family: "Eurostile"
                    y: parent.height /2 + parent.height*0.25
                    color: "#666666"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            needle:
                Rectangle {

                y: outerRadius * 0.01
                implicitWidth: outerRadius * 0.02
                implicitHeight: outerRadius// * 0.9
                antialiasing: true
                color: "#FFC73E"
                smooth: true


            }
        }

    }

    //Gear

    Text {
        id: gearDigit
        text: valueSource.gear
        font.pixelSize: (speedGauge.height*0.75)/8 //86
        font.bold: true
        font.family: "Eurostile"
        y: speedGauge.height*0.85
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        text: "Gear"
        font.pixelSize: gearDigit.font.pixelSize * 0.3  //16
        font.family: "Eurostile"
        anchors.top: gearDigit.bottom
        anchors.topMargin: font.pixelSize*0.4
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    /* Alternative mit altem Design: Hier müsste bekannt sein, wieviele Gänge es gibt
    Grid {
        id: drivingGrid
        anchors.horizontalCenter: parent.horizontalCenter
        y: speedGauge.height*0.9
        columns: 4
        rows: 2

        property real fontSize: gaugeRect.height/22
        property real fontSizeActive: fontSize*1.5

        Rectangle { color: "transparent"; width: letterP.font.pixelSize*1.5; height: 25
            Text {
                property bool active: speedGauge.value <= 0
                id: letterP
                text: " P "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: active ? drivingGrid.fontSizeActive : drivingGrid.fontSize
                color: active ? "white" : "darkgray"
                anchors.centerIn: parent
            } }
        Rectangle { color: "transparent"; width: letterR.font.pixelSize*1.5; height: 25
            Text {
                id: letterR
                text: " R "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: drivingGrid.fontSize //speedGauge.value > 0 ? drivingGrid.fontSize : drivingGrid.fontSizeActive
                color: "darkgray"
                anchors.centerIn: parent
            }}
        Rectangle { color: "transparent"; width: letterN.font.pixelSize*1.5; height: 25
            Text {
                id: letterN
                text: " N "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: speedGauge.value > 0 ? drivingGrid.fontSize : drivingGrid.fontSizeActive
                color: "darkgray"
                anchors.centerIn: parent
            }}
        Rectangle { color: "transparent"; width: letterD.font.pixelSize*1.5; height: 25
            Text {
                property bool active: speedGauge.value > 0

                id: letterD
                font.bold: true
                text: " D "
                font.family: "Eurostile";
                font.pixelSize: active ? drivingGrid.fontSizeActive : drivingGrid.fontSize
                color: active ? "white" : "darkgray"
                anchors.centerIn: parent
            }}
    }*/


    /*

    Grid {
        id: drivingGrid
        anchors.horizontalCenter: parent.horizontalCenter
        y: speedGauge.height*0.9
        columns: 4

        property real fontSize: gaugeRect.height/22
        property real fontSizeActive: fontSize*1.5

        Rectangle { color: "transparent"; width: letterP.font.pixelSize*1.5; height: 25
            Text {
                property bool active: speedGauge.value <= 0
                id: letterP
                text: " P "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: active ? drivingGrid.fontSizeActive : drivingGrid.fontSize
                color: active ? "white" : "darkgray"
                anchors.centerIn: parent
            } }
        Rectangle { color: "transparent"; width: letterR.font.pixelSize*1.5; height: 25
            Text {
                id: letterR
                text: " R "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: drivingGrid.fontSize //speedGauge.value > 0 ? drivingGrid.fontSize : drivingGrid.fontSizeActive
                color: "darkgray"
                anchors.centerIn: parent
            }}
        Rectangle { color: "transparent"; width: letterN.font.pixelSize*1.5; height: 25
            Text {
                id: letterN
                text: " N "
                font.bold: true
                font.family: "Eurostile";
                font.pixelSize: speedGauge.value > 0 ? drivingGrid.fontSize : drivingGrid.fontSizeActive
                color: "darkgray"
                anchors.centerIn: parent
            }}
        Rectangle { color: "transparent"; width: letterD.font.pixelSize*1.5; height: 25
            Text {
                property bool active: speedGauge.value > 0

                id: letterD
                font.bold: true
                text: " D "
                font.family: "Eurostile";
                font.pixelSize: active ? drivingGrid.fontSizeActive : drivingGrid.fontSize
                color: active ? "white" : "darkgray"
                anchors.centerIn: parent
            }}
    }

    */

    Canvas {

        anchors.fill: parent
        id: gaugeCanvas

        property var gaugePosX: parent.width/2;
        property var gaugePosY: parent.height/2;
        property var speedGaugeRadius: speedGauge.width * 0.5
        property var rpmGaugeRadius: rpmGauge.width * 0.5

        /*
         * value interpolation
         * val   | 0    | 240
         * ---------------------
         * angle | 125  | 250
         *
         * m * 0 + n = 125 ^ m * 240 + n = 250
         * n = 125         ^ m * 240 + 125 = 250
         *                 ^ m * 240 = 125
         *                 ^ m = 125/240
         *
         */
        function speedGaugeValueToAngle(value) {
            return (speedMinAngle/speedMax) * value + speedMinAngle;
        }

        function rpmGaugeValueToAngle(value) {
            return (rpmMinAngle/rpmMax) * value + rpmMinAngle;

        }


        function degreesToRadians(degrees) {
            return degrees * (Math.PI / 180);
        }

        onPaint: {
            //console.log("onPaint called");

            var ctx = getContext("2d");

            var speedGradient = ctx.createRadialGradient(gaugePosX,gaugePosY, 0, gaugePosX,gaugePosY, speedGaugeRadius);
            //speedGradient.addColorStop(0.98, "#81FFFE");   //oben
            //speedGradient.addColorStop(0.95, "#112478");   //mitte
            //speedGradient.addColorStop(0.5, "transparent");   //unten

            speedGradient.addColorStop(0.98, "#81FFFE");   //oben
            speedGradient.addColorStop(0.95, "transparent");   //mitte
            speedGradient.addColorStop(0.0, "transparent");   //unten


            var rpmGradient = ctx.createRadialGradient(gaugePosX,gaugePosY, 0, gaugePosX,gaugePosY, rpmGaugeRadius);
            //rpmGradient.addColorStop(0.98, "#FFB108");   //oben
            //rpmGradient.addColorStop(0.95, "#682E00");   //mitte
            //rpmGradient.addColorStop(0.5, "transparent");   //unten

            rpmGradient.addColorStop(0.98, "#FFB108");   //oben
            rpmGradient.addColorStop(0.95, "transparent");   //mitte
            rpmGradient.addColorStop(0.0, "transparent");   //unten


            ctx.clearRect(0, 0, parent.width, parent.height);

            ctx.beginPath();
            ctx.lineWidth = speedGaugeRadius;
            ctx.strokeStyle = speedGradient;

            ctx.arc(gaugePosX,gaugePosY, ctx.lineWidth/2, degreesToRadians(speedGaugeValueToAngle(0)), degreesToRadians(speedGaugeValueToAngle(speedGauge.value)), false);
            ctx.stroke();
            ctx.closePath();

            ctx.beginPath();
            ctx.lineWidth = rpmGaugeRadius;
            ctx.strokeStyle = rpmGradient;

            // Start is on (->), -180° => (<-) UND anticlockwise
            ctx.arc(gaugePosX,gaugePosY, ctx.lineWidth/2, degreesToRadians(rpmGaugeValueToAngle(0)-180), degreesToRadians(rpmGaugeValueToAngle(rpmGauge.value)-180), true);
            ctx.stroke();
            ctx.closePath();


        }
    }


}
