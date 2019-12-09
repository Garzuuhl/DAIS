import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: oilTemp
    clip: false
    z: 1

    Rectangle {
        width: 200
        height: 30
        color: "#efa46f"
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
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#272727"
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: oilcan
        x: 119
        y: -20
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/oil.svg"
    }

    Text {
        id: oilTempInput
        x: 465
        y: -1
        color: "#ef7d25"
        text: qsTr("%1 °C").arg(valueSource.oilTemp)
        styleColor: "#272727"
        style: Text.Raised
        horizontalAlignment: Text.AlignLeft
        font.family: "Roboto"
        font.weight: Font.Bold
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 22

    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:30;width:650}
}
##^##*/
