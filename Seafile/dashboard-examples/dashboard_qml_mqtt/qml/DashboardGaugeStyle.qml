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
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    tickmarkInset: 0
    minorTickmarkInset: 0
    labelStepSize: 20
    labelInset: toPixels(0.2)

    property real xCenter: outerRadius
    property real yCenter: outerRadius
    property real needleLength: outerRadius  * 0.75
    property real needleTipWidth: toPixels(0.02)
    property real needleBaseWidth: toPixels(0.06)
    property bool halfGauge: false

    function toPixels(percentage) {
        return percentage * outerRadius;
    }

    function degToRad(degrees) {
        return degrees * (Math.PI / 180);
    }

    function radToDeg(radians) {
        return radians * (180 / Math.PI);
    }

    function paintBackground(ctx) {
        if (halfGauge) {
            ctx.beginPath();
            ctx.rect(0, 0, ctx.canvas.width, ctx.canvas.height / 2);
            ctx.clip();
        }

        ctx.beginPath();
        ctx.fillStyle = "black";
        ctx.ellipse(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.fill();
    }

    function paintInnerCircle(ctx) {
        if (halfGauge == false){
            ctx.beginPath();
            ctx.fillStyle = "#282828";
            ctx.moveTo(xCenter, yCenter)
            ctx.ellipse(xCenter / 2, yCenter / 2, ctx.canvas.width / 2, ctx.canvas.height / 2);
            ctx.fill();
        }


    }



    foreground: Canvas{
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            paintInnerCircle(ctx);
        }
    }

    background: Canvas {
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            paintBackground(ctx);
        }

        Rectangle {
            id : colorRing
            width: 625
            height: 625
            radius: width/2
            anchors.centerIn: parent
            color: Qt.rgba(0, 0.6, 0.8, 1)
            //Animation: Fade von Blau zu Rot wenn RPM > 6000 und andersrum
            Behavior on color {

                ColorAnimation { duration: 200 }
            }
            states: [
                State {
                    name: "BlueState"
                    when: valueSource.kph > valueSource.maxkph
                    PropertyChanges {
                        target: colorRing
                        color: "red"
                    }
                },
                State {
                    name: "RedState"
                    when: valueSource.kph < valueSource.maxkph
                    PropertyChanges {
                        target: colorRing
                        color: Qt.rgba(0, 0.6, 0.8, 1)
                    }
                }
            ]
        }
        Rectangle {
            width: 600
            height: 600
            radius: width/2
            anchors.centerIn: parent
            color: "black"
        }

    }

    needle: Canvas {
        implicitWidth: needleBaseWidth
        implicitHeight: needleLength

        property real xCenter: width
        property real yCenter: height

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.beginPath();
            ctx.moveTo(xCenter, height - 10);
            ctx.lineTo(xCenter - needleBaseWidth, height - 10);
            ctx.lineTo(xCenter - needleTipWidth, 0);
            ctx.lineTo(xCenter, yCenter - needleLength);
            ctx.lineTo(xCenter, 0);
            ctx.closePath();
            ctx.fillStyle = Qt.rgba(0, 0.6, 0.8, 1);
            ctx.fill();
        }
    }
}
