import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.11


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0

ApplicationWindow {
    id: root
    flags: Qt.FramelessWindowHint
    visible: true
    visibility: Window.Windowed
    width: screen.width
    height: screen.height
    color: "#393939"
    title: "DAIS - Dashboard"

    // Different properties holding Subscriptions of type QMqttTopicFilter*
    property var kphSubscription: 0
    property var gearSubscription: 0
    property var rpmSubscription: 0
    property var maxrpmSubscription: 0

    // Parse received messages from subscription and set values
    function setSpeed(payload) {
        valueSource.kph = Math.abs(parseFloat(payload))
        console.log(valueSource.kph)
    }
    function setGear(payload) {
        valueSource.gear = payload
    }
    function setRpm(payload) {
        valueSource.rpm = parseFloat(payload)
    }
    function setMaxRpm(payload) {
        valueSource.maxrpm = parseFloat(payload)
    }

    // Instantiation of qmlmqttclient

    MqttClient {
        id: mqttclient
        clientId: "DAIS - Dashboard"
        hostname: hostnameField.text
        port: portField.text
        username: usernameField.text
        password: passwordField.text


        cleanSession: true

        //missing: Distance, WiperLevel, ErrorMessage, ESPActive
        //      DriverSeatbeltUnlocked, CoDriverSeatbeltUnlocked, BackseatSeatbeltUnlocked (currently not necessary)
        //      WarnSignalAirbag (not yet available in OnSide), CoolantTemperature (only necessary if displayed),
        //      TirePressureFrontLeft, TirePressureFrontRight, TirePressureBackLeft, TirePressureBackRight (currently not necessary),
        //      WarnSignalOilPressure, OilPressure, OilLevel (currently not necessary)
        //      DoorOpenFrontLeft, DoorOpenFrontRight, DoorOpenBackLeft, DoorOpenBackRight, DoorOpenTrunk (currently not necessary)
        // topics will be subscribed on successfull connection
        // Notice: parameters of .connect are always the address of the function
        onConnected: {
            kphSubscription = mqttclient.subscribe("car/Speed")//
            kphSubscription.messageReceived.connect(setSpeed)

            gearSubscription = mqttclient.subscribe("car/Gear")//
            gearSubscription.messageReceived.connect(setGear)

            rpmSubscription = mqttclient.subscribe("car/RPM")//
            rpmSubscription.messageReceived.connect(setRpm)

            maxrpmSubscription = mqttclient.subscribe("car/MaxRPM")//
            maxrpmSubscription.messageReceived.connect(setMaxRpm)

        }
    }



    /*
*
*
*
*
*          Design
*
*
*
*
*/
    RowLayout {
        id: rowLayout
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        visible: true

        Item {
            id: leftPart

            Layout.preferredHeight: 1080
            transformOrigin: Item.Center
            Layout.preferredWidth: 700
            Layout.fillHeight: false
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            LeftSignals {
                id: leftSignals
                anchors.top: parent.top
                anchors.topMargin: 125
                width: 700
                height: 250
            }

            TachoMeter{
                id: tachoMeter;
                x: 25
                y: 0
                width: 650
                height: 650
                anchors.verticalCenterOffset: 160
                anchors.horizontalCenterOffset: 25
                clip: false
            }

            TempOil {
                id: tempOil
                anchors.right: parent.right
                anchors.rightMargin: 0
                width: 650
                height: 30
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
            }
        }

        Item {
            id: centerPart

            x: 700
            transformOrigin: Item.Top
            Layout.preferredHeight: 1080
            Layout.preferredWidth: 520
            Layout.fillHeight: false
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Shape {
                id: time_frame
                y: 138
                width: 250
                height: 50
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                ShapePath {
                    id: time_frame_path
                    strokeColor: "#40272727"
                    miterLimit: 2
                    strokeWidth: 4
                    capStyle: ShapePath.RoundCap

                    property int joinStyleIndex: 0

                    property variant styles: [
                        ShapePath.BevelJoin,
                        ShapePath.MiterJoin,
                        ShapePath.RoundJoin
                    ]

                    fillColor: "#80272727"

                    joinStyle: styles[joinStyleIndex]

                    dashPattern: [ 1, 4 ]
                    startX: 0; startY: 0
                    PathLine { x: 0; y: 0 }
                    PathLine { x: 25; y: 50 }
                    PathLine { x: 225; y: 50 }
                    PathLine { x: 250; y: 0 }
                }

                Text {
                    id: time
                    x: 0
                    y: 0
                    color: "#ef7d25"
                    text: qsTr("20:30")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 28
                    style: Text.Raised
                    font.weight: Font.Bold
                    font.family: "Roboto"
                }
            }

            Media {
                id: media
                x: 0
                y: 0
                width: 500
                height: 650
                anchors.top: parent.top
                anchors.topMargin: 225
                anchors.horizontalCenter: parent.horizontalCenter
            }

            FuelSystem {
                id: fuelSystem
                x: 135
                y: 962
                width: 250
                height: 75
                anchors.horizontalCenterOffset: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: rightPart

            x: 1220
            Layout.preferredHeight: 1080
            Layout.preferredWidth: 700
            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            RightSignals {
                id: rightSignals
                anchors.top: parent.top
                anchors.topMargin: 125
                width: 700
                height: 250
                clip: false
                transformOrigin: Item.TopLeft
            }

            SpeedMeter {
                id: speedMeter
                x: 25
                y: 0
                width: 650
                height: 650
                anchors.verticalCenterOffset: 160
                anchors.horizontalCenterOffset: -25
                clip: false
            }

            TempWasser {
                id: tempWasser
                anchors.left: parent.left
                anchors.leftMargin: 0
                width: 650
                height: 30
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
            }
        }
    }

    Image {
        id: background
        anchors.fill: parent
        z: 100
        smooth: true
        antialiasing: false
        enabled: false
        fillMode: Image.Stretch
        source: "../background/frame.svg"

    }

    Item {
        id: mqttLogin
        visible: false
        width: 250
        height: 350
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: loginBackground
            color: "#161616"
            border.color: "#ef7d25"
            anchors.fill: parent

        }

/*
        DropShadow {
            id: loginBackgroundDS
            anchors.fill: loginBackground
            horizontalOffset: 0
            verticalOffset: 0
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: loginBackground
            transparentBorder: true
        }
*/
        ColumnLayout {
            id: loginLayout
            width: 300
            height: 300
            spacing: 0
            anchors.fill: parent

            TextField {
                id: hostnameField
                text: ""
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                placeholderText: "<Host>"
            }

            TextField {
                id: portField
                text: ""
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                placeholderText: "<Port>"
            }

            TextField {
                id: usernameField
                text: ""
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                placeholderText: "<Username>"
                enabled: mqttclient.state === MqttClient.Disconnected
            }

            TextField {
                id: passwordField
                text: ""
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                placeholderText: "<Password>"
                enabled: mqttclient.state === MqttClient.Disconnected
            }

            Button {
                id: connectButton
                text: mqttclient.state === MqttClient.Connected ? "Disconnect" : "Connect"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: {
                    if (mqttclient.state === MqttClient.Connected)
                        mqttclient.disconnectFromHost()
                    else {
                        mqttclient.connectToHost()
                    }
                }
            }


        }
    }

    Rectangle {
        id: keyboardArea
        focus: true

        // Press escape key to quit application
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape)
                Qt.quit()

            if ((event.modifiers & Qt.ControlModifier) && (event.key === Qt.Key_L))
                mqttLogin.visible = !mqttLogin.visible

        }
    }



}

/*##^##
Designer {
    D{i:0;height:1080;width:1920}D{i:2;anchors_height:100;anchors_width:100}D{i:21;invisible:true}
}
##^##*/
