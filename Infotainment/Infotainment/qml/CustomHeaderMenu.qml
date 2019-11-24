import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

RowLayout {
    id: customHeaderMenu

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
            text: "Menu"
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
        color: "#ef1010"
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        z: 0
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
