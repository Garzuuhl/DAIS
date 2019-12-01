import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: rectangle
    clip: false
    transformOrigin: Item.Left
    z: 1
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
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

       Text {
           id: gearStatus
           color: "#ef7d25"
           text: qsTr("D1")
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           style: Text.Raised
           font.family: "Roboto"
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           font.weight: Font.Bold
           font.pointSize: 60
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
        id: tacho_drehzahl
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
        source: "../background/tachometer_drehzahl.svg"
    }

    Text {
        id: drehzahl_einheit
        x: 282
        color: "#ef7d25"
        text: qsTr("1/MIN x 1000")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 175
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 14
    }

    Text {
        id: drehzahl_0
        color: "#ef7d25"
        text: qsTr("0")
        anchors.top: parent.top
        anchors.topMargin: 420
        anchors.left: parent.left
        anchors.leftMargin: 115
        transformOrigin: Item.Left
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_1
        color: "#ef7d25"
        text: qsTr("1")
        anchors.top: parent.top
        anchors.topMargin: 300
        anchors.left: parent.left
        anchors.leftMargin: 80
        transformOrigin: Item.Left
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_2
        color: "#ef7d25"
        text: qsTr("2")
        anchors.top: parent.top
        anchors.topMargin: 175
        anchors.left: parent.left
        anchors.leftMargin: 115
        transformOrigin: Item.Left
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_3
        color: "#ef7d25"
        text: qsTr("3")
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 200
        transformOrigin: Item.Left
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_4
        x: 311
        color: "#ef7d25"
        text: qsTr("4")
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        scale: 1
        transformOrigin: Item.Top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_5
        x: 426
        color: "#ef7d25"
        text: qsTr("5")
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.right: parent.right
        anchors.rightMargin: 200
        transformOrigin: Item.Center
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_6
        x: 511
        color: "#ef7d25"
        text: qsTr("6")
        anchors.top: parent.top
        anchors.topMargin: 175
        anchors.right: parent.right
        anchors.rightMargin: 115
        transformOrigin: Item.Center
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_7
        x: 546
        color: "#ef7d25"
        text: qsTr("7")
        anchors.top: parent.top
        anchors.topMargin: 300
        anchors.right: parent.right
        anchors.rightMargin: 80
        transformOrigin: Item.Center
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

    Text {
        id: drehzahl_8
        x: 506
        color: "#ef7d25"
        text: qsTr("8")
        anchors.top: parent.top
        anchors.topMargin: 420
        anchors.right: parent.right
        anchors.rightMargin: 120
        transformOrigin: Item.Center
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
        font.pointSize: 32
    }

}







/*##^##
Designer {
    D{i:0;height:650;width:650}D{i:7;anchors_x:115;anchors_y:420}D{i:8;anchors_x:80;anchors_y:295}
D{i:9;anchors_x:115;anchors_y:175}D{i:10;anchors_x:200;anchors_y:100}D{i:11;anchors_y:70}
D{i:12;anchors_y:100}D{i:13;anchors_y:175}D{i:14;anchors_y:295}D{i:15;anchors_y:420}
}
##^##*/
