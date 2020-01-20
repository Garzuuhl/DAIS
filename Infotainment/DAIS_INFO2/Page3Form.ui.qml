import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    width: 1080
    height: 1920

 //---------------------------HEADER-------------------------------------------------
 /*   header: Item {

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
            }







        }
    } */
    //----------------------------CONTENTANFANG--------------------------------------------------
    Rectangle{
        height:1920
        width:1080
        color:'#888483'

Image {
    id: image
    x: 40
    y: 284
    width: 1000
    height: 717
    rotation: 90
    source: "background/car-top-view-icon.png"
    fillMode: Image.PreserveAspectFit
}


}














//----------------------------CONTENTENDE--------------------------------------------------
//----------------------------FOOTER--------------------------------------------------
 /*   footer: Rectangle {
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
