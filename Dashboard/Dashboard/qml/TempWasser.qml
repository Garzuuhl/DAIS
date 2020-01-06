import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


Item {
    id: waterTemp
    width: 650
    height: 30
    clip: false
    z: 1

    Rectangle {
        id: coolant_bar
        width: 200
        height: 30
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
        id: coolant_icon
        x: 149
        y: -5
        height: 40
        fillMode: Image.PreserveAspectFit
        source: "../background/engine-coolant.svg"
    }


    Timer {
        id: coolant_icon_timer1
        interval: 500
        running: valueSource.coolantWarning
        repeat: true
        onTriggered: {
            coolant_icon.visible = false
            coolant_icon_timer2.start()
        }
    }

    Timer {
        id: coolant_icon_timer2
        interval: 500
        onTriggered: coolant_icon.visible = true
    }

    Text {
        id: waterTempInput
        x: 465
        y: -1
        color: "#ef7d25"
        text: qsTr("%1 °C").arg(valueSource.coolantTemp)
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
        id: coolant_anzeige_0
        width: coolant_bar.width/8
        height: 30
        anchors.left: coolant_bar.left
        anchors.leftMargin: 0
        visible: valueSource.coolantTemp >= steps
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
        id: coolant_anzeige_1
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 2
        anchors.left: coolant_anzeige_0.right
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
        id: coolant_anzeige_2
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 3
        anchors.left: coolant_anzeige_1.right
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
        id: coolant_anzeige_3
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 4
        anchors.left: coolant_anzeige_2.right
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
        id: coolant_anzeige_4
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 5
        anchors.left: coolant_anzeige_3.right
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
        id: coolant_anzeige_5
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 6
        anchors.left: coolant_anzeige_4.right
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
        id: coolant_anzeige_6
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 7
        anchors.left: coolant_anzeige_5.right
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
        id: coolant_anzeige_7
        width: coolant_bar.width/8
        height: 30
        visible: valueSource.coolantTemp >= steps * 8
        anchors.left: coolant_anzeige_6.right
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





