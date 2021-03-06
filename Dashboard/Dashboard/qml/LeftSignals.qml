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
        visible: false
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 25
        fillMode: Image.PreserveAspectFit
        source: "../background/turn-signal_left.svg"
    }

    Timer {
        id: leftBlinker_timer1
        interval: 500
        running: valueSource.leftBlinkerOn
        repeat: true
        onTriggered: {
            turnSignal_left.visible = true
            leftBlinker_timer2.start()
        }
    }

    Timer {
        id: leftBlinker_timer2
        interval: 500
        onTriggered: turnSignal_left.visible = false
    }

    Image {
        id: high_beam
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.highbeam
        anchors.horizontalCenterOffset: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/high-beam.svg"
    }

    Image {
        id: fog_light
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.foglight
        anchors.horizontalCenterOffset: -125
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/fog-light.svg"
    }

    Image {
        id: low_beam
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.light
        anchors.horizontalCenterOffset: 175
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/low-beam.svg"
    }
}
