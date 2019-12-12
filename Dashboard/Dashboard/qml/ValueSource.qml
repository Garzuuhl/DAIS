import QtQuick 2.0

Item {
    id: valueSource

    property real kph: 0
    property real rpm: 0
    property string gear: "0"
    property real maxrpm: 10000
    property real fuel: 0.5
    property int blinker: 0     // left: -1 | right: 1
    property bool warning: false
    property bool handbrake: false
    property bool light: false
    property bool highbeam: false
    property bool foglight: false
    property real outsideTemp: 0
    property real oilTemp: 0
    property real coolantTemp: 0
    property bool motor: false
    property bool battery: false
    property bool oilWarning: false
    property bool coolantWarning: false



    function allLightsOn() {
        console.log("allLightsOn")
        valueSource.kph = 130
        valueSource.rpm = 5000
        valueSource.gear = "10"
        //valueSource.maxrpm = 10000
        valueSource.fuel = 0.1
        valueSource.warning = true
        valueSource.handbrake = true
        valueSource.light = true
        valueSource.highbeam = true
        valueSource.foglight = true
        valueSource.outsideTemp = 70
        valueSource.oilTemp = 300
        valueSource.coolantTemp = 200
        valueSource.motor = true
        valueSource.battery = true
        valueSource.oilWarning = true
        valueSource.coolantWarning = true
    }

    function allLightsOff() {
        console.log("allLightsOff")
        valueSource.kph = 0
        valueSource.rpm = 0
        valueSource.gear = "0"
        //valueSource.maxrpm = 10000
        valueSource.fuel = 0.5
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
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
