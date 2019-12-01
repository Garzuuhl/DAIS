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
        visible: true
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 25
        source: "../background/turn-signal_right.svg"
    }

}
