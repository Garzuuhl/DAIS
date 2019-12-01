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
        source: "../background/turn-signal_left.svg"
    }
}
