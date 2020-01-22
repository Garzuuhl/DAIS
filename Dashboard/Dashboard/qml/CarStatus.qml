import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: carstatus
    width: 500
    height: 650

    Text {
        id: kmzaehler_aktuell_text
        text: qsTr("Tageskilometer")
        anchors.bottom: kmzaehler_gesamt_text.top
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 50
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: kmzaehler_aktuell_value
        text: qsTr("560 km")
        anchors.bottom: kmzaehler_gesamt_value.top
        anchors.bottomMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 50
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: kmzaehler_gesamt_text
        text: qsTr("Kilometerstand")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 50
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: kmzaehler_gesamt_value
        text: qsTr("120000 km")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 50
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: verbrauch_text
        text: qsTr("Verbrauch")
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.bottom: kmzaehler_aktuell_text.top
        anchors.bottomMargin: 25
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Text {
        id: verbrauch_value
        text: qsTr("10 l/km")
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.bottom: kmzaehler_aktuell_value.top
        anchors.bottomMargin: 25
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    Image {
        id: car_image
        anchors.top: parent.top
        anchors.topMargin: 0
        scale: 0.5
        rotation: 90
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../background/car-top-view-icon.png"
    }

    //Reifendruck Vorne Links
    Text {
        id: reifen_vl
        text: Math.round(valueSource.tirePressureFrontLeft * 100) / 100
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.left: parent.left
        anchors.leftMargin: 75
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    //Reifendruck Vorne Rechts
    Text {
        id: reifen_vr
        text: Math.round(valueSource.tirePressureFrontRight * 100) / 100
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.right: parent.right
        anchors.rightMargin: 75
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    //Reifendruck Hinten Links
    Text {
        id: reifen_hl
        text: Math.round(valueSource.tirePressureFrontLeft * 100) / 100
        anchors.top: parent.top
        anchors.topMargin: 300
        anchors.left: parent.left
        anchors.leftMargin: 75
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }

    //Reifendruck Hinten Rechts
    Text {
        id: reifen_hr
        text: Math.round(valueSource.tirePressureBackRight * 100) / 100
        anchors.top: parent.top
        anchors.topMargin: 300
        anchors.right: parent.right
        anchors.rightMargin: 75
        color: "#ef7d25"
        font.pointSize: 20
        style: Text.Raised
        font.weight: Font.Bold
        font.family: "Roboto"
    }
}

/*##^##
Designer {
    D{i:0;height:650;width:500}
}
##^##*/
