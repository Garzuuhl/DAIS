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

Item {
    id: valueSource
    property real kph: 0
    property real rpm: 1
    property real fuel: 0
    property bool lightOn: false
    property bool fullbeamOn: false
    property bool warning: false
    property string gear: "0"
    property real temp: 0
    property bool abs: false
    property bool handbrake: false
    property bool seatbelt: false
    property bool doorOpen: false
    property bool fogbeam: false
    property bool motor: false
    property bool battery: false
    property bool tpms: false
    property bool coolant: false
    property int maxkph: 0
    property real maxrpm: 10000
    property bool lowOil: false
    property double navDouble: 0
    property var maxValArray: [30, 50, 70, 100, 130]

    function allLightsOn() {
        valueSource.kph = 100
        valueSource.rpm = 5000
        valueSource.fuel = 100//instead of 0
        valueSource.lightOn = true
        valueSource.fullbeamOn = true
        valueSource.gear = 100
        valueSource.temp = 100
        valueSource.abs = true
        valueSource.handbrake = true
        valueSource.seatbelt = true
        valueSource.doorOpen = true
        valueSource.fogbeam = true
        valueSource.motor = true
        valueSource.battery = true
        valueSource.tpms = true
        valueSource.coolant = true
        valueSource.maxkph = 100
        valueSource.maxrpm = 10000
        valueSource.lowOil = true
    }

    function randomValue(array) {
        maxkph = maxValArray[Math.floor(Math.random() * maxValArray.length)]
        console.log("maxkph: " + maxkph)
        return 0
    }

    function randomArrow(string) {
        if (string === "right") {
            arrowRight.visible = true
            return 0
        }
        if (string === "up") {
            arrowUp.visible = true
            return 0
        }
        if (string === "left") {
            arrowLeft.visible = true
            return 0
        }
    }
    SequentialAnimation {
        running: true
        SequentialAnimation {
            loops: Animation.Infinite
            NumberAnimation {
                target: valueSource
                property: "maxkph"
                to: 50
                duration: 10
            }
            ParallelAnimation {
                NumberAnimation {
                    target: arrowLeft
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 100
                }
                NumberAnimation {
                    target: valueSource
                    property: "navDouble"
                    from: 5
                    to: 0
                    duration: 100000
                }
            }
            NumberAnimation {
                target: arrowLeft
                property: "opacity"
                from: 1
                to: 0
                duration: 100
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "maxkph"
                    to: 130
                    duration: 10
                }
                NumberAnimation {
                    target: arrowUp
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 100
                }
                NumberAnimation {
                    target: valueSource
                    property: "navDouble"
                    from: 7
                    to: 0
                    duration: 30000
                }
            }
            NumberAnimation {
                target: arrowUp
                property: "opacity"
                from: 1
                to: 0
                duration: 100
            }
            NumberAnimation {
                target: valueSource
                property: "maxkph"
                to: 70
                duration: 10
            }
            NumberAnimation {
                target: valueSource
                property: "maxkph"
                to: 130
                duration: 10
            }
            ParallelAnimation {
                NumberAnimation {
                    target: arrowRight
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 100
                }
                NumberAnimation {
                    target: valueSource
                    property: "navDouble"
                    from: 9
                    to: 0
                    duration: 50000
                }
            }
            NumberAnimation {
                target: arrowRight
                property: "opacity"
                from: 1
                to: 0
                duration: 100
            }

            NumberAnimation {
                target: valueSource
                property: "maxkph"
                to: 100
                duration: 10
            }
        }
    }
}
