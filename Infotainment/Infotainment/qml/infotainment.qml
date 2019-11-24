import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0

ApplicationWindow {
    id: root
    flags: Qt.FramelessWindowHint
    visible: true
    visibility: Window.Windowed
    width: screen.width
    height: screen.height
    color: "#393939"
    title: "DAIS - Infotainment"

    // Top Header Menu
    header: CustomHeaderMenu {}

    // Bottom Footer Menu
    footer: CustomFooterMenu{}

    // Content


    // Instantiation of qmlmqttclient

    MqttClient {
        id: mqttclient
        clientId: "DAIS - Dashboard"
        hostname: hostnameField.text
        username: usernameField.text
        password: passwordField.text
        port: portField.text

        cleanSession: true
    }

}

/*##^##
Designer {
    D{i:0;height:1920;width:1080}
}
##^##*/
