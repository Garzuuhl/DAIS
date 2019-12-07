import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "Helper.js" as Helper

Item {
    property ValueSource values

    Rectangle {
        visible: values.playerActive
        id: musicPlayer
        width: parent.width*0.6
        height: parent.height

        color: "transparent"

        Rectangle {
            id: albumImage
            color: "transparent"
            border.color: "white"
            border.width: 2
            //y: music.height * 0.3
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.3
            height: width
            antialiasing: true
            Image {
                fillMode: Image.Stretch
                source: values.musicImage===null || values.musicImage==="" ? "pics/Media.png" : ("data:image/png;base64," + values.musicImage)
                width: parent.width-2
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    visible: values.playerStatus!=="playing"
                    anchors.horizontalCenter: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width*0.33
                    height: width
                    fillMode: Image.PreserveAspectFit
                    source: values.playerStatus==="paused" ? "pics/apps/music_paused.png" : values.playerStatus==="muted" ? "pics/apps/music_muted.png" : ""
                }
            }

        }

        Text {
            id: interpret
            visible: values.playerActive
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: albumImage.bottom
            anchors.topMargin: 10

            font.family: "Eurostile";
            color: "white";
            font.bold: true
            font.pixelSize: albumImage.height/6
            text: values.songPerformer //"Die Ärzte"
        }

        Text {
            id:songTitle
            visible: values.playerActive
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: interpret.bottom
            anchors.topMargin: 10

            font.family: "Eurostile";
            color: "lightgrey";
            font.pixelSize: interpret.font.pixelSize*0.9
            text: values.songTitle //musicPlayer.songNameString
        }

        ProgressBar {
            id: songProgress
            visible: values.playerActive
            anchors.horizontalCenter: parent.horizontalCenter

            width: musicPlayer.width * 0.5
            height: albumImage.height*0.1
            from: 0.0
            to: values.songDuration
            value: values.currentPlaytime

            anchors.topMargin: 10
            anchors.top: songTitle.bottom

            contentItem: Rectangle {
                implicitWidth: songProgress.width
                implicitHeight: songProgress.height
                anchors.left: songProgress.left
                anchors.verticalCenter: songProgress.verticalCenter
                radius: 5

                gradient: Gradient {
                    GradientStop {position: 0.0; color: '#75383C56' }
                    GradientStop {position: 0.5; color: '#75626689'}
                    GradientStop {position: 0.1; color: '#75383C56'}
                }

            }


            background:
                Rectangle {
                anchors.left: songProgress.left
                anchors.verticalCenter: songProgress.verticalCenter
                width: songProgress.visualPosition *  songProgress.width
                height: songProgress.height
                radius: 5
                gradient: Gradient {
                    GradientStop {position: 0.0; color: '#B9BFD6' }
                    GradientStop {position: 0.4; color: '#B9BFD6'}
                    GradientStop {position: 0.6; color: '#9399BB'}
                    GradientStop {position: 1.0; color: '#697193'}
                }
            }

        }

        Text {
            visible: values.playerActive
            anchors.top: songProgress.bottom
            anchors.topMargin: height/2
            anchors.left: songProgress.left
            color: "white";

            text: {
                return Helper.secondsToMinutesString(values.currentPlaytime);

            }
        }



        Text {
            visible: values.playerActive
            anchors.top: songProgress.bottom
            anchors.topMargin: height/2
            anchors.right: songProgress.right
            color: "white";
            text: {
                return  "- " + Helper.secondsToMinutesString(values.songDuration);
            }

        }

    }
}

