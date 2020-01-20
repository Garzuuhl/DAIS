import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Page {
    width: 1080
    height: 1920

    Rectangle {
        id: scene1
        height: 1920
        width: 1080
        color: '#888483'

        Rectangle {
            id: rectangle1
            x: 235
            y: 156
            width: 610
            height: 579
            color: "#ffffff"
        }

        Image {
            id: image
            x: 264
            y: 253
            width: 552
            height: 385
            visible: true
            fillMode: Image.PreserveAspectFit
            source: "background/usb.svg"
        }



        Image {
            id: image4
            x: 54
            y: 1648
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/radio.svg"
        }

        Image {
            id: image5
            x: 227
            y: 1648
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/usb.svg"
        }

        Image {
            id: image6
            x: 419
            y: 1648
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/spotify.svg"
        }

        Image {
            id: image7
            x: 643
            y: 1648
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/bluetooth.svg"
        }

        Image {
            id: image8
            x: 888
            y: 1648
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/cd.svg"
        }

        Image {
            id: image9
            x: 974
            y: 753
            width: 200
            height: 200
            source: "background/folder-open.svg"
            fillMode: Image.PreserveAspectFit
        }
    }

    //----------------------------CONTENTENDE--------------------------------------------------
    //----------------------------FOOTER--------------------------------------------------
    Label {
        text: qsTr("You are on Page 1.")
        visible: false
    }

    //--------------------------------------------------------------------------------
}
