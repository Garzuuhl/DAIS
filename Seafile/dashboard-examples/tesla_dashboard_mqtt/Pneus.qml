import QtQuick 2.0

import QtQuick 2.0

import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {

    property ValueSource values

    Rectangle {
        id: pneus
        width: parent.width*0.6
        height: parent.height

        color: "transparent"

        Text {
            id: frontLeft
            anchors.top: carImage.top
            anchors.right: carImage.left
            anchors.topMargin: 20
            anchors.rightMargin: 10
            text: values.tirePressureFrontLeft + " bar"
            font.family: "Eurostile";
            color: "white";
            font.bold: true
        }
        Text {
            id: backLeft
            anchors.bottom: carImage.bottom
            anchors.right: carImage.left
            anchors.bottomMargin: 20
            anchors.rightMargin: 10
            text: values.tirePressureBackLeft + " bar"
            font.family: "Eurostile";
            color: "white";
            font.bold: true
        }

        RadialGradient {
            height: carImage.width*1.5
            width: carImage.height*0.8
            anchors.verticalCenter: carImage.verticalCenter
            anchors.horizontalCenter: carImage.horizontalCenter

            gradient: Gradient {
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 0.5; color: "black" }
            }
        }


        /*Rectangle {
            radius: 90
            //color: "#22FFFFFF"
            height: carImage.width*1.3
            width: carImage.height*0.6
            anchors.verticalCenter: carImage.verticalCenter
            anchors.horizontalCenter: carImage.horizontalCenter
        }*/

        Image {
            id: carImage
            height: parent.height*0.5
            width: height/2
            //fillMode: Image.PreserveAspectFit
            source: "pics/apps/pneu_car.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

        }

        Text {
            id: frontRight
            anchors.top: carImage.top
            anchors.left: carImage.right
            anchors.topMargin: 20
            anchors.leftMargin: 10
            text: values.tirePressureFrontRight + " bar"
            font.family: "Eurostile";
            color: "white";
            font.bold: true
        }
        Text {
            id: backRight
            anchors.bottom: carImage.bottom
            anchors.left: carImage.right
            anchors.bottomMargin: 20
            anchors.leftMargin: 10
            text: values.tirePressureBackRight + " bar"

            font.family: "Eurostile";
            color: "white";
            font.bold: true
        }
    }


}
