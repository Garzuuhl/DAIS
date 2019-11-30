import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: oilTemp
    color: "transparent"
    clip: false
    z: 1

    Rectangle {
        width: 200
        height: 30
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#efa46f"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#00000000"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: oilcan
        x: 119
        y: -20
        height: 70
        fillMode: Image.PreserveAspectFit
        source: "../background/oil.svg"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:30;width:650}
}
##^##*/
