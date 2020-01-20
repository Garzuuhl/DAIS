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
    flags: flags | Qt.FramelessWindowHint
    visible: true
    visibility: Window.Windowed
    width: 1920 // screen.width
    height: 1080 // screen.height
    color: "#393939"
    title: "DAIS - Dashboard"

    // Resizing QML window: https://stackoverflow.com/questions/18927534/qtquick2-dragging-frameless-window
    MouseArea {
        anchors.fill: parent

        property variant clickPos: "1,1"

        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            var new_x = root.x + delta.x;
            var new_y = root.y + delta.y;

            if (new_y <= 0) {
                root.visibility = Window.Maximized;
            }
            else
            {
                if (root.visibility === Window.Maximized) {
                    root.visibility = Window.Windowed
                }
                root.x = new_x
                root.y = new_y
            }
        }


    }

    // Different properties holding Subscriptions of type QMqttTopicFilter*
    property var kphSubscription: 0
    property var gearSubscription: 0
    property var rpmSubscription: 0
    property var maxrpmSubscription: 0
    property var fuelSubscription: 0
    property var blinkerSubscription: 0
    property var warnsignalSubscription: 0
    property var handbrakeSubscription: 0
    property var lightSubscription: 0
    property var highbeamSubscription: 0
    property var foglightSubscription: 0
    property var outsideTempSubscription: 0
    property var oilTempSubscription: 0
    property var coolantTempSubscription: 0
    property var motorSubscription: 0
    property var batterySubscription: 0
    property var oilSubscription: 0
    property var coolantSubscription: 0

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

    function setFuel(payload) {
        valueSource.fuel = parseFloat(payload)
    }

    function setBlinker(payload) {
        var blink = parseInt(payload)
        leftSignals.turnSignal_left.visible = blink === -1
        rightSignals.turnSignal_right.visible = blink === 1
    }

    function setHandbrake(payload) {
        valueSource.handbrake =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setLight(payload) {
        valueSource.light =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setHighbeam(payload) {
        valueSource.highbeam =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setFoglight(payload) {
        valueSource.foglight =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setOutsideTemp(payload) {
        valueSource.outsideTemp = parseFloat(payload)
    }

    function setOilTemp(payload) {
        valueSource.oilTemp = parseFloat(payload)
    }

    function setCoolantTemp(payload) {
        valueSource.coolantTemp = parseFloat(payload)
    }

    function setWarnsignal(payload) {
        valueSource.waning =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setMotorWarning(payload) {
        valueSource.motor =
                (parseInt(payload) !== 0) ? true : false
    }

    function setBatteryWarning(payload) {
        valueSource.battery =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setOilWarning(payload) {
        valueSource.oilWarning =
                (payload === 'True' || payload === 'true') ? true : false
    }

    function setCoolantWarning(payload) {
        valueSource.coolantWarning =
                (payload === 'True' || payload === 'true') ? true : false
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

            fuelSubscription = mqttclient.subscribe("car/Fuel")//
            fuelSubscription.messageReceived.connect(setFuel)

            blinkerSubscription = mqttclient.subscribe("car/Blink")//
            blinkerSubscription.messageReceived(setBlinker)

            handbrakeSubscription = mqttclient.subscribe("car/HandbrakeActivated")//
            handbrakeSubscription.messageReceived.connect(setHandbrake)

            // Lights
            lightSubscription = mqttclient.subscribe("car/Light")//
            lightSubscription.messageReceived.connect(setLight)

            highbeamSubscription = mqttclient.subscribe("car/Fullbeam")//
            highbeamSubscription.messageReceived(setHighbeam)

            foglightSubscription = mqttclient.subscribe("car/FogLamp")//
            foglightSubscription.messageReceived.connect(setFoglight)

            // Temps
            outsideTempSubscription = mqttclient.subscribe("car/OutsideTemperature")//
            outsideTempSubscription.messageReceived.connect(setOutsideTemp)

            oilTempSubscription = mqttclient.subscribe("car/OilTemperature")//
            oilTempSubscription.messageReceived.connect(setOilTemp)

            coolantTempSubscription = mqttclient.subscribe("car/CoolantTemperature")//
            coolantTempSubscription.messageReceived.connect(setCoolantTemp)

            // Warnings
            warnsignalSubscription = mqttclient.subscribe("car/Warnsignal")//
            warnsignalSubscription.messageReceived.connect(setWarnsignal)

            oilSubscription = mqttclient.subscribe("car/WarnSignalOilLevel")//
            oilSubscription.messageReceived.connect(setOilWarning)

            coolantSubscription = mqttclient.subscribe("car/WarnSignalCoolantTemperature")//
            coolantSubscription.messageReceived.connect(setCoolantWarning)






            // Test
            //valueSource.allLightsOn();
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
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 28
                    style: Text.Raised
                    font.weight: Font.Bold
                    font.family: "Roboto"
                    function set() {
                        time.text = qsTr("%1").arg(new Date().toLocaleTimeString(Qt.locale("de_DE"), "hh:mm"))
                    }
                }

                Timer {
                    id: timeUpdate
                    interval: 1000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: time.set()
                }
            }

            //Changable to Media.qml or CarStatus.qml
            CarStatus {
                id: carstatus
                visible: true
                x: 0
                y: 0
                width: 500
                height: 650
                anchors.top: parent.top
                anchors.topMargin: 225
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Media {
                id: media
                visible: false
                x: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 225
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

            RowLayout {
                id: rowLayout1
                x: 0
                width: 200
                height: 100
                Layout.fillHeight: false
                transformOrigin: Item.Center
                Layout.fillWidth: false
                spacing: 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Button {
                    id: connectButton
                    width: 70
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

                Button {
                    id: closeButton
                    width: 70
                    text: qsTr("Close")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: {
                        mqttLogin.visible = false
                    }
                }
            }



        }
    }

    Shortcut {
        sequence: "Ctrl+L"
        context: Qt.ApplicationShortcut
        onActivated: mqttLogin.visible = !mqttLogin.visible
    }

    Shortcut {
        sequence: "Ctrl+D"
        context: Qt.ApplicationShortcut
        onActivated: valueSource.allLightsOn()
    }

    Shortcut {
        sequence: "Ctrl+F"
        context: Qt.ApplicationShortcut
        onActivated: valueSource.allLightsOff()
    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    Shortcut {
        sequences: ["Ctrl+Left", "Ctrl+Right"]
        context: Qt.ApplicationShortcut
        onActivated: {
            carstatus.visible = !carstatus.visible
            media.visible = !media.visible
        }
    }

    ValueSource {
        id: valueSource
    }



}

/*##^##
Designer {
    D{i:0;height:1080;width:1920}D{i:2;anchors_height:100;anchors_width:100}D{i:18;anchors_y:267;invisible:true}
D{i:22;invisible:true}D{i:23;invisible:true}
}
##^##*/
