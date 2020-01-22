import QtQuick 2.0

Item {
    id: valueSource

    property real kph: 0
    property real rpm: 0
    property string gear: "0"
    //property real maxrpm: 10000
    property real fuel: 0.5
    property int blinker: 0     // left: -1 | right: 1
    property bool warning: false
    property bool handbrake: false
    property bool light: false
    property bool highbeam: false
    property bool foglight: false
    property real outsideTemp: 20
    property real oilTemp: 75
    property real coolantTemp: 80
    property bool motor: false
    property bool battery: false
    property bool oilWarning: false
    property real tirePressureFrontLeft: 0
    property real tirePressureFrontRight: 0
    property real tirePressureBackLeft: 0
    property real tirePressureBackRight: 0



    function allLightsOn() {
        console.log("allLightsOn")
        valueSource.kph = 130.5
        valueSource.rpm = 5000
        valueSource.gear = "10"
        //valueSource.maxrpm = 10000
        valueSource.fuel = 0.1
        valueSource.blinker = -1
        valueSource.warning = true
        valueSource.handbrake = true
        valueSource.light = true
        valueSource.highbeam = true
        valueSource.foglight = true
        valueSource.outsideTemp = 70.5
        valueSource.oilTemp = 300.5
        valueSource.coolantTemp = 200.5
        valueSource.motor = true
        valueSource.battery = true
        valueSource.oilWarning = true
        valueSource.coolantWarning = true
        valueSource.tirePressureFrontLeft = 100.5
        valueSource.tirePressureFrontRight = 100.5
        valueSource.tirePressureBackLeft = 100.5
        valueSource.tirePressureBackRight = 100.5
    }

    function allLightsOff() {
        console.log("allLightsOff")
        valueSource.kph = 0
        valueSource.rpm = 0
        valueSource.gear = "0"
        //valueSource.maxrpm = 10000
        valueSource.fuel = 0.5
        valueSource.blinker = 0
        valueSource.warning = false
        valueSource.handbrake = false
        valueSource.light = false
        valueSource.highbeam = false
        valueSource.foglight = false
        valueSource.outsideTemp = 20
        valueSource.oilTemp = 80
        valueSource.coolantTemp = 75
        valueSource.motor = false
        valueSource.battery = false
        valueSource.oilWarning = false
        valueSource.coolantWarning = false
        valueSource.tirePressureFrontLeft = 0
        valueSource.tirePressureFrontRight = 0
        valueSource.tirePressureBackLeft = 0
        valueSource.tirePressureBackRight = 0
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
