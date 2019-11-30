import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item{
    id: rectangle
    width: 600
    height: 600
    z: 1
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    clip: false
    transformOrigin: Item.Top

    Rectangle
    {
       id: speedRing
       x: 175
       y: 175
       width: 200
       height: 200
       z: 1
       radius: Math.max(width, height) / 2
       border.color: "#272727"
       visible: true
       clip: false
       color: "transparent"
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.verticalCenter: parent.verticalCenter
       layer.effect: DropShadow {
           transparentBorder: true
           radius: 6.0
       }
    }

    Image {
        id: tacho_hintergrund
        width: 650
        height: 650
        anchors.fill: parent
        visible: true
        clip: false
        z: 1
        enabled: true
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        source: "../background/tachometer.svg"
    }

    Image {
        id: tacho_gewschwindigkeit
        x: 0
        y: 0
        width: 650
        height: 650
        anchors.rightMargin: 7
        anchors.leftMargin: 7
        anchors.bottomMargin: 68
        anchors.topMargin: -18
        anchors.fill: parent
        visible: true
        clip: false
        z: 1
        enabled: true
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        source: "../background/tachometer_geschwindigkeit.svg"
    }

}



