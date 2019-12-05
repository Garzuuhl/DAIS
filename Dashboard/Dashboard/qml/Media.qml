import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: media
    width: 500
    height: 650

    //https://emby.media/community/uploads/inline/355992/5c1cc71abf1ee_genericcoverart.jpg
    //Bild Album Cover
    Image {
        id: music_cover
        width: 300
        height: 300
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../background/random_music_cover.jpg"
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#272727"
        }
    }

    Text {
        id: interpret
        text: qsTr("Interpret")
        anchors.top: music_cover.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        font.pointSize: 28
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: album
        text: qsTr("Album")
        anchors.top: interpret.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        font.pointSize: 28
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: title
        text: qsTr("Titel")
        anchors.top: album.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        font.pointSize: 28
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Item {
        id: music_time
        height: 30
        anchors.top: title.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: title_timebar
            width: 150
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
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
        }

        Text {
            id: title_playtime
            text: qsTr("0:00")
            horizontalAlignment: Text.AlignRight
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: title_timebar.left
            anchors.rightMargin: 25
            color: "#ffffff"
            font.pointSize: 16
            style: Text.Raised
            font.weight: Font.Bold
            font.family: "Roboto"
        }

        Text {
            id: title_timeleft
            text: qsTr("0:00")
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: title.bottom
            anchors.topMargin: 15
            anchors.left: title_timebar.right
            anchors.leftMargin: 25
            color: "#ffffff"
            font.pointSize: 16
            style: Text.Raised
            font.weight: Font.Bold
            font.family: "Roboto"
        }

    }
}

/*##^##
Designer {
    D{i:0;height:650;width:500}
}
##^##*/
