import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangle
    color: "#00ffffff"
    clip: false
    transformOrigin: Item.Top
    z: 1
    border.color: "#00000000"
    border.width: 0
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    Rectangle
    {
       id: gearRing
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
        id: name
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

}







/*##^##
Designer {
    D{i:0;height:650;width:650}
}
##^##*/
