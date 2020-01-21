import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 1080
    height: 1920

    //---------------------------HEADER-------------------------------------------------
    header: Item {

        Rectangle {
            id: header
            width: 1080
            height: 50
            color: '#000000'


            /* Text {
                id:timeanddate
                anchors.centerIn: parent
                //text: Qt.formatDateTime(new Date(), "dd.MM.yyyy")
                text: Qt.formatTime(new Date(), "hh:mm:ss")
                color: '#FFFFFF'
            } */
        }
    }
    //----------------------------CONTENTANFANG--------------------------------------------------
    Rectangle {
        height: 1920
        width: 1080
        color: '#888483'

        Text {
            id: element
            x: 0
            y: 200
            width: 1080
            height: 1720
            color: "#ef7d25"
            text: qsTr("DAIS: Dashboard And Infotainment System   ---------------------------------------------------------------------------------------------------                                                               Dashboard:                                                                                                         Julian Frenzel, 870886, jufr0007@stud.hs-kl.de                                               Philipp Zimmermann, 870872, phzi0004@stud.hs-kl.de                          Infotainment:                                                                                        Marco Noll, 870529, mano0010@stud.hs-kl.de                                                   Jens Cedric Schug, 870886, jesc0030@stud.hs-kl.de --------------------------------------------------------------------------------------------------- Lizenzinformationen:                                                                                  Die Karteninformationen und Inhalte entstammen von  Openstreetmap       https://www.openstreetmap.de/                                                                  Die Tracks Summer , Energy  und Tomorrow des Musikplayers wurden von Ben Sound , https://www.bensound.com/ zur Verfügung gestellt.                                                                                                             Weitere Lizenzinformationen unter                                                             https://www.bensound.com/licensing#tab                                                            Diese Applikation benutzt (teilweise) die API von Nominatim                                                     https://nominatim.openstreetmap.org/  --------------------------------------------------------------------------------------------------- Haftungsausschluss                                                                                                                        Wir( Julian Frenzel , Phillip Zimmermann, Marco Noll und Jens Cedric Schug)  haften nicht für entstandene Schäden, Irrtümer oder Angebote Dritter, die in Folge der Nutzung dieser Applikation entstanden sind.                                 DAIS (Dashboard And Infotainment System) wurde im Rahmen des Moduls Frameworkbasierte UI Entwicklung an der Hochschule Kaiserslautern Standort Zweibrücken  entwickelt und soll als non-profit und  nicht kommerzielle Anwendung dienen.                            ")
            style: Text.Outline
            wrapMode: Text.WordWrap
            textFormat: Text.PlainText
            font.pixelSize: 30
        }
    }

    //----------------------------CONTENTENDE--------------------------------------------------
    //----------------------------FOOTER--------------------------------------------------


    /*  footer: Rectangle {
    id: rectangle
    height:100
    width:1080
    color: "#696969"
}*/
    Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    //--------------------------------------------------------------------------------
}
