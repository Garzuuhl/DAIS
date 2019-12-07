import QtQuick 2.0
import QtGraphicalEffects 1.0
import "Helper.js" as Helper

Rectangle {
    id: telephone
    width: parent.width
    height: parent.height

    property ValueSource values

    property bool active: values.phoneActive
    property string imageSource: active? ("data:image/png;base64," + values.callerImage) : "/pics/apps/telephone_noCall.png"
    //property string callTimeString: values.callDuration
    property string callerNameString: values.callerName!==null || values.callerName!=="" ? values.callerName : values.callerNumber

    color: "transparent"

    Rectangle {
        id: callerPicture
        radius: 5
        color: "transparent"
        border.color: active ? "white" : "transparent"
        border.width: 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.4
        height: width
        antialiasing: true
        Image {
            opacity: active? 1 : 0.5
            fillMode: Image.PreserveAspectFit
            source: imageSource
            width: parent.width-2
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


            Image {
                visible: active
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width*0.33
                height: width
                fillMode: Image.PreserveAspectFit
                source: "pics/apps/telephone_small.png" //values.playerStatus==="paused" ? "pics/apps/music_paused.png" : values.playerStatus==="muted" ? "pics/apps/music_muted.png" : ""
            }



            Image {
                visible: active
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width*0.33
                height: width
                fillMode: Image.PreserveAspectFit
                //source: values.phoneStatus==="muted" ? "/pics/apps/music_muted.png" : "/pics/apps/telephone_small.png"
                source: "/pics/apps/telephone_small.png"
            }
        }
    }

    Text {
        id: callerName
        visible: active
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: callerPicture.bottom
        anchors.topMargin: 10

        font.family: "Eurostile";
        color: "white";
        font.bold: true
        font.pixelSize: callerPicture.height * 0.1
        text: callerNameString
    }

    Text {
        id:description
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: active? callerName.bottom : callerPicture.bottom
        anchors.topMargin: 10

        font.family: "Eurostile";
        color: "lightgrey";
        font.pixelSize: callerName.font.pixelSize*0.9
        text: active ? "Active Call" : "No Active Call"
    }

    Text {
        id:callTime
        visible: active
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: description.bottom
        anchors.topMargin: 10

        font.family: "Eurostile";
        color: "white";
        font.pixelSize: callerName.font.pixelSize*0.9
        text: {
            return Helper.secondsToHoursString(values.callDuration);
        }
    }

}

