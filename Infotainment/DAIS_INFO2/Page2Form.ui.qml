import QtQuick 2.12
import QtQuick.Controls 2.5
//Telefondesgin
Page{
    width: 1080
    height: 1920

    //---------------------------HEADER-------------------------------------------------

    //----------------------------CONTENTANFANG--------------------------------------------------

    Rectangle{
        height:1920
        width:1080
        color:'#888483'

        Rectangle {
            id: rectangle1
            x: 185
            y: 281
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("1")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle2
            x: 440
            y: 281
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label1
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("2")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle3
            x: 724
            y: 281
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label2
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("3")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle4
            x: 185
            y: 550
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label3
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("4")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle5
            x: 440
            y: 550
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label4
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("5")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle6
            x: 724
            y: 550
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label5
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("6")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle7
            x: 185
            y: 814
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label6
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("7")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle8
            x: 440
            y: 814
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label7
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("8")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle9
            x: 724
            y: 814
            width: 200
            height: 200
            color: "#000000"

            Label {
                id: label8
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("9")
                font.pointSize: 100
            }
        }

        Rectangle {
            id: rectangle10
            x: 185
            y: 149
            width: 746
            height: 81
            color: "#ffffff"
        }

        Image {
            id: image
            x: 440
            y: 1111
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "background/phone.svg"
        }

        Image {
            id: image1
            x: 724
            y: 1111
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "background/backspace.svg"
        }

        Rectangle {
            id: rectangle11
            x: 185
            y: 1111
            width: 200
            height: 200
            color: "#000000"
            radius: 0
            antialiasing: false

            Label {
                id: label9
                x: 64
                y: 20
                color: "#ffffff"
                text: qsTr("0")
                font.pointSize: 100
            }
        }

        Image {
            id: image2
            x: 147
            y: 1583
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "background/th.svg"
        }

        Image {
            id: image3
            x: 407
            y: 1633
            width: 100
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/clock.svg"
        }

        Image {
            id: image4
            x: 549
            y: 1583
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "background/user-friends.svg"
        }

        Image {
            id: image5
            x: 762
            y: 1583
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "background/star.svg"
        }

    }
















    //----------------------------CONTENTENDE--------------------------------------------------
    //----------------------------FOOTER--------------------------------------------------
   /* footer: Rectangle {
        id: rectangle
        height:100
        width:1080
        color: "#696969"
    } */



    Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("You are on Page 1.")
        opacity: 0
        visible: true
        anchors.centerIn: parent
    }



    //--------------------------------------------------------------------------------


}
