import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import "MathHelper.js" as MathHelper



Item {
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

       Text {
           id: speedStatus
           color: "#ef7d25"
           text: Math.round(valueSource.kph)
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
        enabled: true
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        source: "../background/tachometer.svg"
    }

    // Fill-begin

    Image {
        id: tacho_fill
        visible: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "../background/tachometer_fill.svg"
        sourceSize: Qt.size(parent.width, parent.height)
    }

    ConicalGradient {
        id: tacho_mask_grad
        visible: false
        anchors.fill: tacho_fill
        angle: -135.0

/*

0 = 0.040000006
160 = 0.708333333
*/



        gradient:
            Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: MathHelper.map_range(valueSource.kph, 0, 160, 0.040000006, 0.708333333); color: "transparent" }
                GradientStop { position: MathHelper.map_range(valueSource.kph, 0, 160, 0.040000006, 0.708333333) + 0.000000001; color: "white" }
                GradientStop { position: 1.0; color: "white" }
            }

    }


    OpacityMask {
        invert: true
        anchors.fill: tacho_mask_grad
        source: tacho_fill
        maskSource: tacho_mask_grad
    }


    // Fill-end

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

    Text {
        id: geschwindigkeit_einheit
        x: 282
        color: "#ef7d25"
        text: qsTr("km/h")
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
        id: geschwindigkeit_0
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
        id: geschwindigkeit_1
        color: "#ef7d25"
        text: qsTr("20")
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
        id: geschwindigkeit_2
        color: "#ef7d25"
        text: qsTr("40")
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
        id: geschwindigkeit_3
        color: "#ef7d25"
        text: qsTr("60")
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
        id: geschwindigkeit_4
        x: 311
        color: "#ef7d25"
        text: qsTr("80")
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
        id: geschwindigkeit_5
        x: 426
        color: "#ef7d25"
        text: qsTr("100")
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
        id: geschwindigkeit_6
        x: 511
        color: "#ef7d25"
        text: qsTr("120")
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
        id: geschwindigkeit_7
        x: 546
        color: "#ef7d25"
        text: qsTr("140")
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
        id: geschwindigkeit_8
        x: 506
        color: "#ef7d25"
        text: qsTr("160")
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



