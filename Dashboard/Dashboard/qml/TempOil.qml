import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: oilTemp
    clip: false
    z: 1

    Rectangle {
        id: oil_bar
        width: 200
        height: 30
        color: "#efa46f"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#efa46f"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#272727"
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: oilcan
        x: 119
        y: -20
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "../background/oil.svg"
    }

    Timer {
        id: oil_icon_timer1
        interval: 500
        running: valueSource.oilWarning
        repeat: true
        onTriggered: {
            oilcan.visible = false
            oil_icon_timer2.start()
        }
    }

    Timer {
        id: oil_icon_timer2
        interval: 500
        onTriggered: oilcan.visible = true
    }

    Text {
        id: oilTempInput
        x: 465
        y: -1
        color: "#ef7d25"
        text: qsTr("%1 °C").arg(Math.round(valueSource.oilTemp))
        styleColor: "#272727"
        style: Text.Raised
        horizontalAlignment: Text.AlignLeft
        font.family: "Roboto"
        font.weight: Font.Bold
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 22

    }

    property var steps: 150/8

    Rectangle {
        id: oil_anzeige_0
        width: oil_bar.width/8
        height: 30
        anchors.left: oil_bar.left
        anchors.leftMargin: 0
        visible: valueSource.oilTemp >= steps
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_1
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 2
        anchors.left: oil_anzeige_0.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_2
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 3
        anchors.left: oil_anzeige_1.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_3
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 4
        anchors.left: oil_anzeige_2.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_4
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 5
        anchors.left: oil_anzeige_3.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_5
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 6
        anchors.left: oil_anzeige_4.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_6
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 7
        anchors.left: oil_anzeige_5.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }

    Rectangle {
        id: oil_anzeige_7
        width: oil_bar.width/8
        height: 30
        visible: valueSource.oilTemp >= steps * 8
        anchors.left: oil_anzeige_6.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7d25"
            }

            GradientStop {
                position: 1
                color: "#785238"
            }
        }
        border.color: "#393939"
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:30;width:650}
}
##^##*/
