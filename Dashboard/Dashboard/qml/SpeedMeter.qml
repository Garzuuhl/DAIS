import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: rectangle
    width: 600
    height: 600
    color: "#00ffffff"
    z: 1
    border.color: "#00000000"
    border.width: 0
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    Rectangle
    {
       id: speedRing
       x: 175
       y: 175
       width: 200
       height: 200
       z: 1
       radius: Math.max(width, height) / 2
       border.width: 3
       visible: true
       clip: false
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.verticalCenter: parent.verticalCenter
       color: "transparent"
       border.color: "#ef7d25"
    }

    Image {
        id: name
        z: 1
        anchors.fill: parent
        enabled: true
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        source: "../background/speedmeter.svg"
    }

}
