import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: fuelSystem
    width: 250
    height: 75

    Item {
        id: fuelLabel
        height: 45
        width: 250

        Image {
            id: fuelIcon
            height: 35
            x: ((parent.width-(fuelIcon.width + 25 + fuelStatus.width))/2)
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../background/fuel-filling.svg"
        }

        Timer {
            id: fuel_icon_timer1
            interval: 500
            running: valueSource.fuel <= 0.2
            repeat: true
            onTriggered: {
                fuelIcon.visible = false
                fuel_icon_timer2.start()
            }
        }

        Timer {
            id: fuel_icon_timer2
            interval: 500
            onTriggered: fuelIcon.visible = true
        }

        Text {
            id: fuelStatus
            y: 7
            color: "#ef7d25"
            text: qsTr("750km")
            anchors.left: fuelIcon.left
            anchors.leftMargin: 55
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
            font.pointSize: 20
            font.weight: Font.Bold
            style: Text.Raised
        }
    }

    Rectangle {
        id: fuel_anzeige
        width: 250
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
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
    }

    Rectangle {
        id: fuel_anzeige_0
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.125
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
        id: fuel_anzeige_1
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.25
        anchors.left: fuel_anzeige_0.right
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
        id: fuel_anzeige_2
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.375
        anchors.left: fuel_anzeige_1.right
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
        id: fuel_anzeige_3
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.5
        anchors.left: fuel_anzeige_2.right
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
        id: fuel_anzeige_4
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.625
        anchors.left: fuel_anzeige_3.right
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
        id: fuel_anzeige_5
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.75
        anchors.left: fuel_anzeige_4.right
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
        id: fuel_anzeige_6
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 0.875
        anchors.left: fuel_anzeige_5.right
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
        id: fuel_anzeige_7
        width: 250/8
        height: 30
        visible: valueSource.fuel >= 1
        anchors.left: fuel_anzeige_6.right
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
    D{i:0;height:75;width:250}
}
##^##*/
