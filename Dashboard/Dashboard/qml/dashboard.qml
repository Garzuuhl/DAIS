import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

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
        anchors.topMargin: 325
        visible: true

        Rectangle {
            id: leftPart
            color: "#00ffffff"
            Layout.preferredWidth: 600
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            TachoMeter{ id: tachoMeter; width: 600; height: 600; anchors.top: parent.top; anchors.topMargin: 0; anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.leftMargin: 50; }
        }

        Rectangle {
            id: centerPart
            color: "#00ffffff"
            Layout.preferredWidth: 250
            Layout.rowSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Rectangle {
            id: rightPart
            color: "#00ffffff"
            Layout.preferredWidth: 600
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            SpeedMeter {
                id: speedMeter
                anchors.rightMargin: 40
                anchors.fill: parent
            }
        }

    }

    Image {
        id: background
        z: 100
        smooth: true
        antialiasing: false
        enabled: false
        anchors.fill: parent
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
            else if ((event.modifiers & Qt.ControlModifier) && (event.key === Qt.Key_L)){
                mqttLogin.visible = !mqttLogin.visible
            }
        }
    }



}

/*##^##
Designer {
    D{i:0;height:1080;width:1920}D{i:4;anchors_height:639;anchors_width:764;anchors_y:0}
D{i:2;anchors_height:100;anchors_width:100}D{i:8;invisible:true}D{i:10;anchors_height:200;anchors_width:200}
}
##^##*/
