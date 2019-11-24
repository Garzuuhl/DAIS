import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

RowLayout {
    id: customFooterMenu

    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        z: 2
        anchors.fill: parent


        ToolButton {
            text: qsTr("‹")
            onClicked: stack.pop()
        }

        Label {
            text: "Footer Menu"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.family: "Roboto"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }

        ToolButton {
            text: qsTr("⋮")
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            onClicked: menu.open()
        }
    }

    Rectangle {
        id: rectangle
        color: "#1059ef"
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        z: 0
        anchors.fill: parent
    }
}
