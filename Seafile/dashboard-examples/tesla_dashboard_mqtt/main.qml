import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0


ApplicationWindow {
    id: appWindow
    flags: Qt.FramelessWindowHint
    title: qsTr("Tesla Model S Speedometer")
    width: 1920
    height: 1080
    visible: true
    color: "black"

    property string dateString
    property string timeString


    // Resizing QML window: https://stackoverflow.com/questions/18927534/qtquick2-dragging-frameless-window
    MouseArea {
        anchors.fill: parent

        property variant clickPos: "1,1"

        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            var new_x = appWindow.x + delta.x;
            var new_y = appWindow.y + delta.y;

            if (new_y <= 0) {
                appWindow.visibility = Window.Maximized;
            }
            else
            {
                if (appWindow.visibility === Window.Maximized) {
                    appWindow.visibility = Window.Windowed
                }
                appWindow.x = new_x
                appWindow.y = new_y
            }
        }


    }

    Rectangle {
        z: 2
        id: configPane
        width: parent.width / 2
        height: parent.height * 0.05

        color: configPaneMouseArea.containsMouse
               || mouseArea.containsMouse ? "#161616" : "transparent"

        MouseArea {
            id: configPaneMouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        Rectangle {
            visible: configPaneMouseArea.containsMouse
                     || mouseArea.containsMouse
            color: "#161616"
            width: parent.width
            height: childrenRect.height
            anchors.centerIn: parent

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            Row {
                spacing: configPane.width * 0.02

                Row {
                    spacing: configPane.width * 0.02

                    TextField {
                        id: hostnameField
                        text: "localhost"
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
                        enabled: mqttclient.state !== MqttClient.Connected
                    }
                    TextField {
                        id: passwordField
                        echoMode: 2
                        text: ""
                        placeholderText: "<password>"
                        enabled: mqttclient.state !== MqttClient.Connected
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
                            if(mqttclient.hostname.length > 0 && portField.text.length > 0) {
                                mqttclient.connectToHost();
                            } else {
                                console.log('Please enter hostname and port')
                                //alert('Please enter hostname and port')
                            }
                        }
                    }
                }
            }
        }
    }

    ValueSource {
        id: valueSource
    }

    // Different properties holding Subscriptions of type QMqttTopicFilter*
    property var kphSubscription: 0
    property var gearSubscription: 0
    property var rpmSubscription: 0
    property var maxrpmSubscription: 0
    property var fuelSubscription: 0
    property var tempSubscription: 0
    property var distanceSubscription: 0
    property var tirePressureFrontLeftSubscription: 0
    property var tirePressureFrontRightSubscription: 0
    property var tirePressureBackLeftSubscription: 0
    property var tirePressureBackRightSubscription: 0
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

    property var currentConsumptionSubscription: 0
    property var avgConsumptionSubscription: 0
    property var estimatedRangeSubscription: 0
    property var longitudeSubscription: 0
    property var latitudeSubscription: 0
    property var navigationBearingSubscription: 0

    // Infotainment

    // |__ Music
    property var playerActiveSubscription: 0
    property var songTitleSubscription: 0
    property var songPerformerSubscription: 0
    property var songDurationSubscription: 0
    property var currentPlaytimeSubscription: 0
    property var playerStatusSubscription: 0
    property var musicImageSubscription: 0

    // |__ Phone
    property var phoneActiveSubscription: 0
    property var callerNameSubscription: 0
    property var callerNumberSubscription: 0
    property var callDurationSubscription: 0
    property var callerImageSubscription: 0

    // |__ Navigation data

    property var routeInProgressSubscription:0
    property var targetLatitudeSubscription:0
    property var targetLongitudeSubscription:0


    // Menu navigation
    property var navAxisSubscription: 0
    property var navButtonSubscription: 0
    property var navZeroPositionSubscription: 0


    // Parse received messages from subscription and set values
    function setSpeed(payload) {
        valueSource.kph = Math.floor(Math.abs(parseFloat(payload)))
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
    function setDistance(payload) {
        valueSource.distance = parseFloat(payload)
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

    function setOilLevelWarning(payload) {
        valueSource.lowOil = (payload === 'True'
                              || payload === 'true') ? true : false
    }

    function setTirePressureFrontLeft(payload) {
        valueSource.tirePressureFrontLeft = parseFloat(payload);
    }

    function setTirePressureFrontRight(payload) {
        valueSource.tirePressureFrontRight = parseFloat(payload);
    }
    function setTirePressureBackLeft(payload) {
        valueSource.tirePressureBackLeft = parseFloat(payload);
    }
    function setTirePressureBackRight(payload) {
        valueSource.tirePressureBackRight = parseFloat(payload);
    }

    function setBlink(payload) {
        var blink = parseInt(payload)
        valueSource.leftBlinkerOn = (blink < 0)
        valueSource.rightBlinkerOn = (blink > 0)

    }

    function setCurrentConsumption(payload) {
        valueSource.currentConsumption = parseFloat(payload)
    }

    function setAvgConsumption(payload) {
        valueSource.avgConsumption = parseFloat(payload)
    }

    function setEstimatedRange(payload) {
        valueSource.estimatedRange = parseFloat(payload)
    }

    function setLongitude(payload) {
        valueSource.longitude = parseFloat(payload)
    }

    function setLatitude(payload) {
        valueSource.latitude = parseFloat(payload)
    }

    // Music

    function setSongTitle(payload) {
        valueSource.songTitle = payload
    }

    function setSongPerformer(payload) {
        valueSource.songPerformer = payload
    }

    function setSongDuration(payload) {
        valueSource.songDuration = parseInt(payload)
    }

    function setCurrentPlaytime(payload) {
        valueSource.currentPlaytime = parseInt(payload)
    }

    function setPlayerStatus(payload) {
        valueSource.playerStatus = payload
    }

    function setPlayerActive(payload) {
        valueSource.playerActive = (payload === 'True'
                                    || payload === 'true') ? true : false
    }

    function setMusicImage(payload) {
        valueSource.musicImage = payload
    }


    // |__ Phone

    function setPhoneActive(payload) {
        valueSource.phoneActive = (payload === 'True'
                                   || payload === 'true') ? true : false
    }

    function setCallerName(payload) {
        valueSource.callerName = payload
    }

    function setCallerNumber(payload) {
        valueSource.callerNumber = payload
    }

    function setCallDuration(payload) {
        valueSource.callDuration = parseInt(payload)
    }

    function setCallerImage(payload) {
        valueSource.callerImage = payload
    }

    function setNavAxis(payload) {
        valueSource.navAxisValue = parseFloat(payload)
    }

    function setNavButton(payload) {
        valueSource.navButtonValue = parseFloat(payload)
    }

    function setNavZeroPos(payload) {
        valueSource.navZeroPos = (payload === 'True'
                                  || payload === 'true') ? true : false
    }

    function setNavigationBearing(payload) {
        valueSource.navigationBearing = parseFloat(payload)
    }

    function setRouteInProgress(payload) {
        valueSource.routeInProgress = (payload === 'True'
                                       || payload === 'true') ? true : false
    }

    function setTargetLatitude(payload) {
        valueSource.targetLatitude = parseFloat(payload)
    }

    function setTargetLongitude(payload) {
        valueSource.targetLongitude = parseFloat(payload)
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

            distanceSubscription = mqttclient.subscribe("car/Distance")//
            distanceSubscription.messageReceived.connect(setDistance)

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

            tirePressureFrontLeftSubscription = mqttclient.subscribe("car/TirePressureFrontLeft")
            tirePressureFrontLeftSubscription.messageReceived.connect(setTirePressureFrontLeft)

            tirePressureFrontRightSubscription = mqttclient.subscribe("car/TirePressureFrontRight")
            tirePressureFrontRightSubscription.messageReceived.connect(setTirePressureFrontRight)

            tirePressureBackLeftSubscription = mqttclient.subscribe("car/TirePressureBackLeft")
            tirePressureBackLeftSubscription.messageReceived.connect(setTirePressureBackLeft)

            tirePressureBackRightSubscription = mqttclient.subscribe("car/TirePressureBackRight")
            tirePressureBackRightSubscription.messageReceived.connect(setTirePressureBackRight)

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

            currentConsumptionSubscription = mqttclient.subscribe("car/FuelConsumption")
            currentConsumptionSubscription.messageReceived.connect(setCurrentConsumption)

            avgConsumptionSubscription = mqttclient.subscribe("car/AvgConsumption")
            avgConsumptionSubscription.messageReceived.connect(setAvgConsumption)

            estimatedRangeSubscription = mqttclient.subscribe("car/EstimatedRange")
            estimatedRangeSubscription.messageReceived.connect(setEstimatedRange)

            longitudeSubscription = mqttclient.subscribe("car/Longitude")
            longitudeSubscription.messageReceived.connect(setLongitude)

            latitudeSubscription = mqttclient.subscribe("car/Latitude")
            latitudeSubscription.messageReceived.connect(setLatitude)

            navigationBearingSubscription = mqttclient.subscribe("car/Bearing")
            navigationBearingSubscription.messageReceived.connect(setNavigationBearing)

            // Route navigationBearingSubscription



            // Infotainment

            playerActiveSubscription = mqttclient.subscribe("car/infotainment/music/PlayerActive")
            playerActiveSubscription.messageReceived.connect(setPlayerActive)

            songTitleSubscription = mqttclient.subscribe("car/infotainment/music/SongTitle")
            songTitleSubscription.messageReceived.connect(setSongTitle)

            songPerformerSubscription = mqttclient.subscribe("car/infotainment/music/SongPerformer")
            songPerformerSubscription.messageReceived.connect(setSongPerformer)

            songDurationSubscription = mqttclient.subscribe("car/infotainment/music/SongDuration")
            songDurationSubscription.messageReceived.connect(setSongDuration)

            currentPlaytimeSubscription = mqttclient.subscribe("car/infotainment/music/CurrentPlaytime")
            currentPlaytimeSubscription.messageReceived.connect(setCurrentPlaytime)

            musicImageSubscription = mqttclient.subscribe("car/infotainment/music/MusicImage")
            musicImageSubscription.messageReceived.connect(setMusicImage)

            playerStatusSubscription = mqttclient.subscribe("car/infotainment/music/PlayerStatus")
            playerStatusSubscription.messageReceived.connect(setPlayerStatus)

            // Phone

            phoneActiveSubscription = mqttclient.subscribe("car/infotainment/phone/PhoneActive")
            phoneActiveSubscription.messageReceived.connect(setPhoneActive)

            callerNumberSubscription = mqttclient.subscribe("car/infotainment/phone/CallerNumber")
            callerNumberSubscription.messageReceived.connect(setCallerNumber)

            callerNameSubscription = mqttclient.subscribe("car/infotainment/phone/CallerName")
            callerNameSubscription.messageReceived.connect(setCallerName)

            callDurationSubscription = mqttclient.subscribe("car/infotainment/phone/CallDuration")
            callDurationSubscription.messageReceived.connect(setCallDuration)

            callerImageSubscription = mqttclient.subscribe("car/infotainment/phone/CallerImage")
            callerImageSubscription.messageReceived.connect(setCallerImage)

            routeInProgressSubscription = mqttclient.subscribe("car/infotainment/navigation/RouteInProgress")
            routeInProgressSubscription.messageReceived.connect(setRouteInProgress)

            targetLatitudeSubscription = mqttclient.subscribe("car/infotainment/navigation/TargetLatitude")
            targetLatitudeSubscription.messageReceived.connect(setTargetLatitude)

            targetLongitudeSubscription = mqttclient.subscribe("car/infotainment/navigation/TargetLongitude")
            targetLongitudeSubscription.messageReceived.connect(setTargetLongitude)

            // Menu navigation

            navAxisSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/RX")
            navAxisSubscription.messageReceived.connect(setNavAxis)

            navButtonSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/TY")
            navButtonSubscription.messageReceived.connect(setNavButton)

            navZeroPositionSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/Zero")
            navZeroPositionSubscription.messageReceived.connect(setNavZeroPos)


        }
    }

    //GUI


    LeftElement {
        //y: 50
        x: speedMeter.left - width/2
        width: parent.width/2 //parent.width*0.25 //parent.width / 2
        height: parent.height//*0.25 // 450
        values: valueSource
        anchors.verticalCenter: parent.verticalCenter
    }


    Telephone {
        id: rightRect
        values: valueSource
        x: parent.width - ((parent.width - speedMeter.width)/4) - width/2
        width: parent.width*0.25
        height: parent.height*0.25 //475
        anchors.verticalCenter: parent.verticalCenter

    }

    Image {
        width: parent.width
        height: parent.height
        source: "/pics/Background.png"
    }

    //Leiste oben
    Rectangle {
        width: parent.width
        height: parent.height*0.19

        property real iconSize: width/35
        property real iconSizeMargin: iconSize*0.6
        color: "transparent"

        // Icons links
        Image {
            visible: false
            id: airbagsystemErrorIcon
            source: "icons/airbagsystemError.png"
            width: parent.iconSize
            height: width*0.8
            x: seatbeltIcon.x - parent.iconSizeMargin - parent.iconSize
            y: foglightIcon.y - parent.iconSizeMargin/2
        }


        Image {
            visible: valueSource.seatbelt
            id: seatbeltIcon
            source: "icons/seatbelt.png"
            width: parent.iconSize
            height: width*0.8
            x: foglightIcon.x - parent.iconSizeMargin - parent.iconSize
            y: foglightIcon.y
        }

        Image {
            visible: valueSource.fogbeam
            id: foglightIcon
            source: "icons/foglamp.png"
            antialiasing: true
            width: parent.iconSize
            height: width*0.8
            x: rearfoglightIcon.x - parent.iconSizeMargin - parent.iconSize
            y: parklightIcon.y - parent.iconSizeMargin/2
        }

        Image {
            visible: valueSource.fogbeam
            id: rearfoglightIcon
            source: "icons/rearfoglight.png"
            antialiasing: true
            width: parent.iconSize
            height: width*0.8
            x: parklightIcon.x - parent.iconSizeMargin - parent.iconSize
            y: parklightIcon.y
        }

        Image {
            visible: false
            id: parklightIcon
            source: "icons/parklight.png"
            antialiasing: true
            width: parent.iconSize
            height: width*0.8
            x: headlightIcon.x - parent.iconSizeMargin - parent.iconSize
            y: fullbeamIcon.y - parent.iconSizeMargin/2
        }

        Image {
            visible: valueSource.lightOn
            id: headlightIcon
            source: "icons/headlight.png"
            width: parent.iconSize
            antialiasing: true
            height: width*0.8
            x: fullbeamIcon.x - parent.iconSizeMargin - parent.iconSize
            y: fullbeamIcon.y
        }

        Image {
            visible: valueSource.fullbeamOn
            id: fullbeamIcon
            source: "icons/fullbeam.png"
            width: parent.iconSize
            antialiasing: true
            height: width*0.8
            x: parent.width*0.35
            y: parent.height*0.5
        }

        // Icons rechts
        Image {
            visible: false
            id: stabilityErrorIcon
            source: "icons/stabilityError.png"
            width: parent.iconSize
            height: width*0.8
            x: parent.width*0.65
            y: parent.height*0.5
        }

        Image {
            visible: false
            id: suspensionErrorIcon
            source: "icons/suspensionError.png"
            width: parent.iconSize
            height: width*0.8
            x: stabilityErrorIcon.x + parent.iconSizeMargin + parent.iconSize
            y: stabilityErrorIcon.y
        }

        Image {
            visible: valueSource.handbrake
            id: handbrakeIcon
            source: "icons/handbrake.png"
            width: parent.iconSize
            height: width*0.8
            x: suspensionErrorIcon.x + parent.iconSizeMargin + parent.iconSize
            y: suspensionErrorIcon.y - parent.iconSizeMargin/2
        }

        Image {
            visible: valueSource.abs
            id: absIcon
            source: "icons/absError.png"
            width: parent.iconSize
            height: width*0.8
            x: handbrakeIcon.x + parent.iconSizeMargin + parent.iconSize
            y: handbrakeIcon.y
        }

        Image {
            visible: false
            id: brakesystemErrorIcon
            source: "icons/brakesystemError.png"
            width: parent.iconSize
            height: width*0.8
            x: absIcon.x + parent.iconSizeMargin + parent.iconSize
            y: absIcon.y - parent.iconSizeMargin/2
        }

        Image {
            visible: valueSource.tirePressureWarning
            id: tirePressureErrorIcon
            source: "icons/tirepressureError.png"
            width: parent.iconSize
            height: width*0.8
            x: brakesystemErrorIcon.x + parent.iconSizeMargin + parent.iconSize
            y: brakesystemErrorIcon.y
        }

        Image {
            visible: valueSource.doorOpen
            id: dooropenIcon
            source: "icons/dooropen.png"
            width: parent.iconSize
            height: width*0.8
            x: tirePressureErrorIcon.x + parent.iconSizeMargin + parent.iconSize
            y: brakesystemErrorIcon.y - parent.iconSizeMargin/2
        }


    }

    //Leiste unten
    Rectangle {
        id: lowerBar
        y: parent.height - height
        height: appWindow.height/6 //
        width: parent.width

        property real textSize: appWindow.width * 0.02
        property real textposition: ((lowerBar.height * 0.6) + textSize) > lowerBar.height ? (lowerBar.height - textSize) : lowerBar.height * 0.6

        color: "transparent"
        RowLayout {
            y: lowerBar.textposition //50
            x: parent.width*0.1
            Text {
                text: (Math.round(valueSource.distance * 100) / 100)
                font.pixelSize: lowerBar.textSize
                font.bold: true
                color: "white"
            }
            Text {
                text: "km"
                font.pixelSize: lowerBar.textSize
                font.bold: false
                color: "darkgray"
            }
        }

        RowLayout {
            y: lowerBar.textposition
            x: parent.width*0.25
            Text {
                text: (Math.round(valueSource.temp * 10) / 10) + " º"
                font.pixelSize: lowerBar.textSize
                font.bold: true
                color: "white"
            }
            Text {
                text: "C"
                font.pixelSize: lowerBar.textSize
                font.bold: false
                color: "darkgray"
            }
        }

        Timer {

            interval: 5000
            repeat: true
            running: true

            onTriggered:
            {
                var date = new Date();

                var dayString = date.toLocaleDateString(Qt.locale(),"ddd") + ", "
                var dateString = date.toLocaleDateString(Qt.locale(),"MMM d")

                dayDisplay.text = dayString
                dateDisplay.text = dateString
                console.log("Updated date to: " + dayString + dateString)


                var timeString = date.toLocaleTimeString(Qt.locale(),"h:mm")
                var timeSuffixString = date.toLocaleTimeString(Qt.locale(),"AP")
                timeDisplay.text = timeString
                timeSuffixDisplay.text = timeSuffixString

                console.log("Updated time to: " + timeString + timeSuffixString)

            }
        }


        RowLayout {
            y: lowerBar.textposition
            x: parent.width*0.65

            Text {
                id: dayDisplay
                text: new Date().toLocaleDateString(Qt.locale(),"ddd") + ", " //ddd MMM d //h:mm AP
                font.pixelSize: lowerBar.textSize
                font.bold: true
                color: "white"
            }
            Text {
                id: dateDisplay
                text: new Date().toLocaleDateString(Qt.locale(),"MMM d") //ddd MMM d //h:mm AP
                font.pixelSize: lowerBar.textSize
                font.bold: false
                color: "darkgray"
            }
        }

        RowLayout {
            y: lowerBar.textposition
            x: parent.width*0.85

            Text {
                id: timeDisplay
                text: new Date().toLocaleTimeString(Qt.locale(),"h:mm") //ddd MMM d //h:mm AP
                font.pixelSize: lowerBar.textSize
                font.bold: false
                color: "darkgray"
            }
            Text {
                id: timeSuffixDisplay
                text: new Date().toLocaleTimeString(Qt.locale(),"AP") //ddd MMM d //h:mm AP
                font.pixelSize: lowerBar.textSize
                font.bold: true
                color: "white"
            }
        }
    }

    //Tacho

    Image {
        id: background
        height: parent.height*0.8
        width: height

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        //scale: 1.14
        source: "/pics/Tacho-Ohne-Zahlen.png"
        fillMode: Image.PreserveAspectFit

        // Blinkers
        Image {
            id: leftBlinker
            height: parent.height*0.09
            width: height*0.7
            visible: valueSource.leftBlinkerOn
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.left
            antialiasing: true

            property bool flashing: false

            source: flashing ? "pics/blink_left_arrow.png" : "pics/blink_left.png"

            Timer {
                interval: 250
                running: valueSource.leftBlinkerOn
                repeat: true
                onTriggered: leftBlinker.flashing = !leftBlinker.flashing
            }
        }

        Image {
            id: rightBlinker
            height: parent.height*0.09
            width: height*0.7

            x: parent.width
            visible: valueSource.rightBlinkerOn
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -2
            antialiasing: true

            property bool flashing: false

            source: flashing ? "pics/blink_right_arrow.png" : "pics/blink_right.png"

            Timer {
                interval: 250
                running: valueSource.rightBlinkerOn
                repeat: true
                onTriggered: rightBlinker.flashing = !rightBlinker.flashing
            }
        }

    }

    SpeedMeter {
        id: speedMeter
        width: background.width*0.82
        height: width

        values: valueSource

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


    }

    /*Rectangle {
        id: glass
        width: background.width
        height: width
        radius: width/2
        opacity: 0.2
        color: "#40FFFFFF"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        FastBlur {
            id: blur
            source: glass
            x: -glass.x; y: -glass.y
            width: glass.width; height: glass.height
            radius: 40
        }

    }*/

}


