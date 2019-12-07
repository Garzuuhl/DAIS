/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

// Make registered qmlmqttclient visible to qml
import MqttClient 1.0

Window {
    id: root
    visible: true
    width: 1920
    height: 1080
    color: "black"
    visibility: "FullScreen"
    title: "Dashboard"

    // Different properties holding Subscriptions of type QMqttTopicFilter*
    property var kphSubscription: 0
    property var gearSubscription: 0
    property var rpmSubscription: 0
    property var maxrpmSubscription: 0
    property var fuelSubscription: 0
    property var tempSubscription: 0
    property var blinkSubscription: 0
    property var maxkphSubscription: 0
    property var lightOnSubscription: 0
    property var fullbeamSubscription: 0
    property var warningSubscription: 0
    property var absSubscription: 0
    property var handbrakeSubscription: 0
    property var seatbeltSubscription: 0
    property var doorOpenSubscription: 0
    property var fogbeamSubscription: 0
    property var motorSubscription: 0
    property var batterySubscription: 0
    property var tpmsSubscription: 0
    property var coolantSubscription: 0
    property var warnsignalOilLevelSubscription: 0

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
    function setFuel(payload) {
        valueSource.fuel = parseFloat(payload)
    }
    function setTemp(payload) {
        valueSource.temp = parseFloat(payload)
    }
    function setMaxKph(payload) {
        valueSource.maxkph = parseInt(payload)
    }
    function setLight(payload) {
        valueSource.lightOn = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setFullbeam(payload) {
        valueSource.fullbeamOn = (payload === 'True'
                                  || payload === 'true') ? true : false
    }
    function setWarning(payload) {
        valueSource.warning = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setAbs(payload) {
        valueSource.abs = (payload === 'True'
                           || payload === 'true') ? true : false
    }
    function setHandbrake(payload) {
        valueSource.handbrake = (payload === 'True'
                                 || payload === 'true') ? true : false
    }
    function setSeatbelt(payload) {
        valueSource.seatbelt = (payload === 'True'
                                || payload === 'true') ? true : false
    }
    function setDoor(payload) {
        valueSource.doorOpen = (payload === 'True'
                                || payload === 'true') ? true : false
    }
    function setFogbeam(payload) {
        valueSource.fogbeam = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setMotor(payload) {
        valueSource.motor = (parseInt(payload) !== 0) ? true : false
    }
    function setBattery(payload) {
        valueSource.battery = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setTirepressure(payload) {
        valueSource.tpms = (payload === 'True'
                            || payload === 'true') ? true : false
    }
    function setCoolant(payload) {
        valueSource.coolant = (payload === 'True'
                               || payload === 'true') ? true : false
    }

    function setBlink(payload) {
        var blink = parseInt(payload)
        leftIndicator.on = blink === -1
        leftIndicator.direction = Qt.LeftArrow
        rightIndicator.on = blink === 1
        rightIndicator.direction = Qt.RightArrow
    }

    function setOilLevelWarning(payload) {
        valueSource.lowOil = (payload === 'True'
                               || payload === 'true') ? true : false
    }

    // Instantiation of qmlmqttclient
    MqttClient {
        id: mqttclient
        clientId: "Dashboard"
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

            fuelSubscription = mqttclient.subscribe("car/Fuel")//
            fuelSubscription.messageReceived.connect(setFuel)

            blinkSubscription = mqttclient.subscribe("car/Blink")//
            blinkSubscription.messageReceived.connect(setBlink)

            tempSubscription = mqttclient.subscribe("car/OutsideTemperature")//
            tempSubscription.messageReceived.connect(setTemp)

            maxkphSubscription = mqttclient.subscribe("car/MaxSpeed")//
            maxkphSubscription.messageReceived.connect(setMaxKph)

            lightOnSubscription = mqttclient.subscribe("car/Light")//
            lightOnSubscription.messageReceived.connect(setLight)

            fullbeamSubscription = mqttclient.subscribe("car/Fullbeam")//
            fullbeamSubscription.messageReceived.connect(setFullbeam)

            warningSubscription = mqttclient.subscribe("car/Warnsignal")//
            warningSubscription.messageReceived.connect(setWarning)

            absSubscription = mqttclient.subscribe("car/WarnSignalABS")//
            absSubscription.messageReceived.connect(setAbs)

            handbrakeSubscription = mqttclient.subscribe(
                        "car/HandbrakeActivated")//
            handbrakeSubscription.messageReceived.connect(setHandbrake)

            seatbeltSubscription = mqttclient.subscribe(
                        "car/WarnSignalSeatbelt")//
            seatbeltSubscription.messageReceived.connect(setSeatbelt)

            doorOpenSubscription = mqttclient.subscribe(
                        "car/WarnSignalDoorlock")//
            doorOpenSubscription.messageReceived.connect(setDoor)

            fogbeamSubscription = mqttclient.subscribe("car/FogLamp")//
            fogbeamSubscription.messageReceived.connect(setFogbeam)

            motorSubscription = mqttclient.subscribe("car/ErrorCode")//
            motorSubscription.messageReceived.connect(setMotor)

            batterySubscription = mqttclient.subscribe(
                        "car/WarnSignalGenerator")//
            batterySubscription.messageReceived.connect(setBattery)

            tpmsSubscription = mqttclient.subscribe(
                        "car/WarnSignalTirePressure")//
            tpmsSubscription.messageReceived.connect(setTirepressure)

            coolantSubscription = mqttclient.subscribe(
                        "car/WarnSignalCoolantTemperature")
            coolantSubscription.messageReceived.connect(setCoolant)

            warnsignalOilLevelSubscription = mqttclient.subscribe("car/WarnSignalOilLevel")
            warnsignalOilLevelSubscription.messageReceived.connect(setOilLevelWarning)

            //valueSource.allLightsOn();
        }
    }

    Rectangle {
        id: keyboardArea
        focus: true

        // Press escape key to quit application
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape)
                Qt.quit()
        }
    }
    Image {
        id: background
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height - Image.height
        anchors.bottomMargin: 100
        x: 0
        y: 100
        visible: true
        source: "qrc:/images/dasboard_Background.png"
    }
    Canvas {
        x: 0
        y: -100
        width: 1920
        height: 1080

        ValueSource {
            id: valueSource
        }

        Column {
            x: 0
            y: 530
            anchors.verticalCenterOffset: -420
            anchors.horizontalCenterOffset: 0
            spacing: 10
            anchors.centerIn: parent
            Rectangle {
                z: 2
                id: configPane
                y: 0
                width: root.width
                height: 20
                color: "#161616"

                MouseArea {
                    id: configPaneMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }

                Rectangle {
                    visible: configPaneMouseArea.containsMouse
                             || mouseArea.containsMouse
                    color: "#161616"
                    anchors.fill: parent

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                    }

                    Row {
                        spacing: container.width * 0.02

                        Row {
                            spacing: parent.width * 0.02

                            TextField {
                                id: hostnameField
                                text: ""
                                placeholderText: "<hostname>"
                            }

                            TextField {
                                id: portField
                                text: "1883"
                            }

                            TextField {
                                id: usernameField
                                text: ""
                                placeholderText: "<username>"
                                enabled: mqttclient.state === MqttClient.Disconnected
                            }
                            TextField {
                                id: passwordField
                                echoMode: 2
                                text: ""
                                placeholderText: "<password>"
                                enabled: mqttclient.state === MqttClient.Disconnected
                            }
                        }
                        Button {
                            id: connectButton
                            text: mqttclient.state
                                  === MqttClient.Connected ? "Disconnect" : "Connect"
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
            }
        }
        // Dashboards are typically in a landscape orientation, so we need to ensure
        // our height is never greater than our width.
        Item {
            id: container
            width: root.width
            height: Math.min(root.width, root.height)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: fuel
                x: 1748
                y: 794
                source: "qrc:/images/fuel-filling.png"
                visible: valueSource.fuel <= 0.2
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: battery
                x: 660
                source: "qrc:/images/battery.png"
                anchors.horizontalCenterOffset: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -185
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.battery
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: lowOil
                x: 660
                source: "qrc:/images/low-oil.png"
                anchors.horizontalCenterOffset: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -250
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.lowOil
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: enginecoolant
                source: "qrc:/images/engine-coolant.png"
                anchors.horizontalCenterOffset: 224
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -233
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.coolant
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: highBeam
                source: "qrc:/images/high-beam.png"
                anchors.horizontalCenterOffset: -853
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 476
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.fullbeamOn
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: lowBeam
                source: "qrc:/images/low-beam.png"
                anchors.horizontalCenterOffset: -814
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 382
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.lightOn
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: fogLight
                source: "qrc:/images/fog-light.png"
                anchors.horizontalCenterOffset: -748
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 476
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.fogbeam
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: warning
                source: "qrc:/images/warning.png"
                anchors.horizontalCenterOffset: 873
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 476
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.warning
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: seatbelt
                source: "qrc:/images/seatbelt.png"
                anchors.horizontalCenterOffset: 723
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 468
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.seatbelt
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: malfuncionIndicator
                source: "qrc:/images/malfunction-indicador.png"
                anchors.horizontalCenterOffset: 110
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -233
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.motor
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: doors
                source: "qrc:/images/doors.png"
                anchors.horizontalCenterOffset: 809
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 388
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.doorOpen
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: absWarning
                source: "qrc:/images/abs-warning.png"
                anchors.horizontalCenterOffset: -112
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -233
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.abs
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: brakesWarning
                source: "qrc:/images/brake-system-warning.png"
                anchors.horizontalCenterOffset: -822
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 287
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.handbrake
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: tpms
                source: "qrc:/images/tpms.png"
                anchors.horizontalCenterOffset: -248
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -233
                anchors.verticalCenter: parent.verticalCenter
                visible: valueSource.tpms
                width: 75
                height: 75
                z: 3
            }
            Image {
                id: fuelIcon
                source: "qrc:/images/fuel-icon.png"
                anchors.horizontalCenterOffset: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 451
                anchors.verticalCenter: parent.verticalCenter
                visible: true
                width: 25
                height: 25
                z: 3
            }

            Row {
                id: instrumentsRow
                width: 1920
                height: 1080
                visible: true
                z: 2
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                spacing: container.width * 0.02
                anchors.centerIn: parent

                Image {
                    id: warningBackgroundLeft
                    width: 320
                    height: 360
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.verticalCenterOffset: -300
                    source: "qrc:/images/dashboard_warnings.png"
                    visible: true
                }

                Image {
                    id: upper_instrument
                    x: 545
                    width: Image.width
                    height: Image.height
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: -215
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/images/gui_upper_dashboard.png"
                    visible: true
                }

                Image {
                    id: warningBackgroundRight
                    width: 320
                    height: 360
                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    source: "qrc:/images/dashboard_warnings.png"
                    visible: true
                    mirror: true
                }
            }
            Item {
                id: fuelRow
                width: 200
                height: 200
                anchors.verticalCenterOffset: 517
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                CircularGauge {
                    id: fuelGauge
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    value: valueSource.fuel
                    maximumValue: 1
                    width: 200
                    height: 200
                    anchors.verticalCenterOffset: -47
                    anchors.horizontalCenterOffset: 0

                    style: IconGaugeStyle {
                        id: fuelGaugeStyle

                        icon: "qrc:/images/fuel-icon.png"
                        minWarningColor: "red"

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0
                                     || styleData.value === 1
                            font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        }
                    }
                }
            }

            Row {

                id: gaugeRow
                width: 1473
                height: 650
                spacing: 230
                anchors.verticalCenterOffset: 188
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent

                CircularGauge {
                    id: tachometer
                    width: 600
                    height: 600
                    value: valueSource.rpm / 1000
                    //maximumValue: 8
                    maximumValue: valueSource.maxrpm / 1000
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter - (height / 2)
                    anchors.left: parent.left
                    style: TachometerStyle {
                    }
                }

                CircularGauge {
                    id: speedometer
                    value: valueSource.kph
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter - (height / 2)
                    anchors.right: parent.right
                    maximumValue: 280
                    // We set the width to the height, because the height will always be
                    // the more limited factor. Also, all circular controls letterbox
                    // their contents to ensure that they remain circular. However, we
                    // don't want to extra space on the left and right of our gauges,
                    // because they're laid out horizontally, and that would create
                    // large horizontal gaps between gauges on wide screens.
                    width: 600
                    height: 600
                    style: DashboardGaugeStyle {
                    }
                    Item {
                        id: showKMH
                        width: 100
                        height: 100
                        anchors.verticalCenterOffset: -24
                        anchors.horizontalCenterOffset: 0
                        anchors.verticalCenter: speedometer.verticalCenter
                        anchors.horizontalCenter: speedometer.horizontalCenter
                        Text {
                            id: speedText
                            text: kphInt
                            font.pixelSize: 100
                            color: "white"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.centerIn: parent.verticalCenter

                            readonly property int kphInt: valueSource.kph
                        }
                        Text {
                            text: "km/h"
                            font.pixelSize: 40
                            color: "white"
                            anchors.top: speedText.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
            Row {
                id: indicatorRow
                width: 403
                height: 119
                anchors.verticalCenterOffset: -52
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
                TurnIndicator {
                    id: leftIndicator
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    width: 65
                    height: 60
                    direction: Qt.LeftArrow
                    on: valueSource.turnSignal === Qt.LeftArrow
                }
                TurnIndicator {
                    id: rightIndicator
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    width: 65
                    height: 60
                    direction: Qt.RightArrow
                    on: valueSource.turnSignal === Qt.RightArrow
                }
            }

            Column {
                id: navigationRow
                width: 200
                height: 450
                anchors.verticalCenterOffset: 122
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
                Rectangle {
                    width: parent.width - border.width
                    height: 350
                    color: "#282828"
                    border.color: "#383838"
                    border.width: 2
                }
                Rectangle {
                    width: parent.width - border.width
                    height: 50
                    color: "#282828"
                    border.color: "#383838"
                    border.width: 2
                }
                Rectangle {
                    width: parent.width - border.width
                    height: 50
                    color: "#282828"
                    border.color: "#383838"
                    border.width: 2
                }
                Item {
                    id: showNavigation
                    x: 56
                    y: 64
                    width: 100
                    height: 100
                    z: 5
                    anchors.verticalCenterOffset: -24
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenter: speedometer.verticalCenter
                    anchors.horizontalCenter: speedometer.horizontalCenter
                    Row {
                        id: distanceText
                        y: -100
                        width: 128
                        height: 50
                        Text {
                            id: navValue
                            text: valueSource.navDouble != 0 ? Math.round(
                                                                   navDouble * 10) / 10 : null
                            font.pixelSize: 40
                            color: "white"
                            readonly property double navDouble: valueSource.navDouble
                            anchors.left: parent.left
                            width: 30
                            height: 50
                        }
                        Text {
                            id: navDistance
                            text: valueSource.navDouble != 0 ? "km" : null
                            font.pixelSize: 40
                            color: "white"
                            anchors.right: parent.right
                        }
                    }
                }
            }
            Item {
                id: tempTime
                x: 758
                y: 995
                width: 438
                height: 42
                Text {
                    id: temp
                    text: tempInt + "°C"
                    anchors.left: parent.left
                    font.pixelSize: 40
                    color: "white"
                    readonly property int tempInt: valueSource.temp
                }
                Text {
                    id: time
                    text: Qt.formatTime(new Date(), "hh:mm")
                    anchors.right: parent.right
                    font.pixelSize: 40
                    color: "white"
                }
            }

            Item {
                id: arrowContainer
                width: root.width
                height: Math.min(root.width, root.height)
                anchors.centerIn: parent
                opacity: 1
                Image {
                    id: arrowRight
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenterOffset: 92
                    source: "qrc:/images/Arrow_Right.png"
                    scale: 0.4
                    opacity: 0
                }
                Image {
                    id: arrowUp
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenterOffset: 92
                    source: "qrc:/images/Arrow_Up.png"
                    scale: 0.4
                    opacity: 0
                }
                Image {
                    id: arrowLeft
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenterOffset: 92
                    source: "qrc:/images/Arrow_Left.png"
                    scale: 0.4
                    opacity: 0
                }
            }

            Item {
                id: signsContainer
                width: root.width
                height: Math.min(root.width, root.height)
                anchors.centerIn: parent
                opacity: 1

                Image {
                    id: sign30
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 257
                    anchors.verticalCenterOffset: -134
                    source: "qrc:/images/30.png"
                    scale: 0.25
                    visible: valueSource.maxkph == 30 ? true : false
                }

                Image {
                    id: sign50
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 257
                    anchors.verticalCenterOffset: -134
                    source: "qrc:/images/50.png"
                    scale: 0.25
                    visible: valueSource.maxkph == 50 ? true : false
                }

                Image {
                    id: sign70
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 257
                    anchors.verticalCenterOffset: -134
                    source: "qrc:/images/70.png"
                    scale: 0.25
                    visible: valueSource.maxkph == 70 ? true : false
                }

                Image {
                    id: sign100
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 257
                    anchors.verticalCenterOffset: -134
                    source: "qrc:/images/100.png"
                    scale: 0.25
                    visible: valueSource.maxkph == 100 ? true : false
                }

                Image {
                    id: sign130
                    width: Image.width
                    height: Image.height
                    z: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 257
                    anchors.verticalCenterOffset: -134
                    source: "qrc:/images/130.png"
                    scale: 0.25
                    visible: valueSource.maxkph == 130 ? true : false
                }
            }
        }
    }
}
