import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: leftSignals
    clip: false
    z: 1
    width: 700
    height: 250

    Image {
        id: turnSignal_left
        width: 50
        height: 50
        visible: true
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 25
        fillMode: Image.PreserveAspectFit
        source: "../background/turn-signal_left.svg"
    }

    Image {
        id: high_beam
        x: 325
        y: 168
        width: 50
        height: 50
        anchors.horizontalCenterOffset: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        fillMode: Image.PreserveAspectFit
        source: "../background/high-beam.svg"
    }

    Image {
        id: fog_light
        x: 325
        y: 168
        width: 50
        height: 50
        anchors.horizontalCenterOffset: -125
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        fillMode: Image.PreserveAspectFit
        source: "../background/fog-light.svg"
    }

    Image {
        id: low_beam
        x: 325
        y: 168
        width: 50
        height: 50
        anchors.horizontalCenterOffset: 175
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        fillMode: Image.PreserveAspectFit
        source: "../background/low-beam.svg"
    }
}
