import QtQuick 2.0

Item {
    id: valueSource
    property real kph: 0
    property real rpm: 1
    property string gear: "0"
    property real maxrpm: 10000

    function allLightsOn() {
        valueSource.kph = 100
        valueSource.rpm = 5000
        valueSource.gear = 100
        valueSource.maxrpm = 10000
    }
}
