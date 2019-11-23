import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0

ApplicationWindow {
    id: root
    flags: Qt.FramelessWindowHint
    visible: true
    visibility: Window.Windowed
    width: screen.width
    height: screen.height
    color: "black"
    title: "DAIS - Dashboard"

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

    Column {
        id: column
        anchors.fill: parent
    }
}
