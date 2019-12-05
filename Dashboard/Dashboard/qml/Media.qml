import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: media
    width: 500
    height: 650

    Rectangle {
        id: music_cover
        width: 300
        height: 300
        color: "#bfefa46f"
        border.color: "#00000000"
        border.width: 0
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

/*##^##
Designer {
    D{i:0;height:650;width:500}
}
##^##*/
