import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0
import QtQuick.Layouts 1.3

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
        username: usernameField.text
        password: passwordField.text
        port: portField.text

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

            Item {
                id: leftSignals
                anchors.top: parent.top
                anchors.topMargin: 125
                width: 700
                height: 200
            }

            TachoMeter{
                id: tachoMeter;
                x: 25
                y: 0
                width: 650
                height: 650
                anchors.verticalCenterOffset: 110
                anchors.horizontalCenterOffset: 25
                clip: false
            }

            TempOil {
                id: tempOil
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 900
                width: 650
                height: 30
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
        }

        Item {
            id: rightPart
            x: 1220
            Layout.preferredHeight: 1080
            Layout.preferredWidth: 700
            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Item {
                id: rightSignals
                anchors.top: parent.top
                anchors.topMargin: 125
                width: 700
                height: 200
                clip: false
                transformOrigin: Item.TopLeft
            }

            SpeedMeter {
                id: speedMeter
                x: 25
                y: 0
                width: 650
                height: 650
                anchors.verticalCenterOffset: 110
                anchors.horizontalCenterOffset: -25
                clip: false
            }
        }
    }

    Image {
        id: background
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        z: 100
        smooth: true
        antialiasing: false
        enabled: false
        fillMode: Image.Stretch
        source: "../background/frame.svg"

    }





}

/*##^##
Designer {
    D{i:0;height:1080;width:1920}D{i:2;anchors_height:100;anchors_width:100}D{i:11;invisible:true}
}
##^##*/
