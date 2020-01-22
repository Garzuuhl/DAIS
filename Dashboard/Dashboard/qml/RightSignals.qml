import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: rightSignals
    clip: false
    z: 1
    width: 700
    height: 250

    Image {
        id: turnSignal_right
        width: 50
        height: 50
        visible: false
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 25
        fillMode: Image.PreserveAspectFit
        source: "../background/turn-signal_right.svg"
    }

    Timer {
        id: rightBlinker_timer1
        interval: 500
        running: valueSource.rightBlinkerOn
        repeat: true
        onTriggered: {
            turnSignal_right.visible = true
            rightBlinker_timer2.start()
        }
    }

    Timer {
        id: rightBlinker_timer2
        interval: 500
        onTriggered: turnSignal_right.visible = false
    }

    Image {
        id: engine_warning
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.motor
        anchors.horizontalCenterOffset: -25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/malfunction-indicador.svg"
    }

    Image {
        id: brake_system_warning
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.handbrake
        anchors.horizontalCenterOffset: -175
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/brake-system-warning.svg"
    }

    Image {
        id: batterie_warning
        x: 325
        y: 168
        width: 50
        height: 50
        visible: valueSource.battery
        anchors.horizontalCenterOffset: 125
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/battery.svg"
    }

}
