import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: container
    width: parent.width
    height: parent.height
    color: "black"

    property ValueSource values;

    signal doAnimateHoverSignal
    signal doDeanimateHoverSignal

    Rectangle {
        anchors.centerIn: parent
        id: appWindow
        width: parent.width
        height: parent.height// + 20
        y: parent.height// + 20
        color: "transparent"
        Loader {
            id: appWindowLoader
            anchors.fill: parent
            asynchronous: false
        }

    }

    PathView {
        id: menu
        width: childrenRect.width
        height: container.height

        offset: Math.floor(count/2)

        model: LElementsModel {}
        delegate: Rectangle {
            id: delegate
            height: (parent.height/menu.count) //parent.height /7// 150;
            width: height;
            //color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            color: "transparent"

            Image {
                id: hoverIcon
                visible: index === (delegate.PathView.view.currentIndex+Math.floor(menu.count/2))%menu.count
                height: parent.height
                width: height
                anchors.centerIn: parent
                source: "/pics/Tile.png"
            }

            Component.onCompleted: {
                doAnimateHoverSignal.connect(doAnimateHover)
                doDeanimateHoverSignal.connect(doDeanimateHover)
            }

            function doAnimateHover() {
                animateHover.start();
            }

            function doDeanimateHover() {
                deanimateHover.start();
            }

            NumberAnimation {
                id: animateHover; target: hoverIcon; properties: "opacity"; from: 1.00; to: 0.0; duration: 50
            }
            NumberAnimation {
                id: deanimateHover; target: hoverIcon; properties: "opacity"; from: 0.0; to: 1.0; duration: 500
            }



            Image {
                id: image
                source: isource;
                height: parent.height*0.8
                fillMode: Image.PreserveAspectFit;
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id:desc;
                    text: name
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: parent.height * 0.85
                    font.pixelSize: image.height*0.15//18;
                    font.family: "Eurostile";
                    font.bold: true;
                    color: "black";
                }

            }
        }

        Component.onCompleted: {
            values.onMenuMoveUp.connect(incrementCurrentIndex)
            values.onMenuMoveDown.connect(decrementCurrentIndex)
            values.onMenuButtonPressed.connect(triggerDisplay)
        }

        path: Path {
            startX: container.width * 0.3 //250
            startY: (container.height/menu.count) /2//container.height * 0.1//600//pathMargin

            PathLine {
                x:  container.width * 0.3 //250;
                y: container.height// * 0.9//menu.height - pathMargin
            }
        }

        focus: true


        Keys.onDownPressed: decrementCurrentIndex()
        Keys.onUpPressed: incrementCurrentIndex()

        Keys.onReturnPressed: {
            triggerDisplay();
        }

        function triggerDisplay() {
            if(menu.opacity == 1) {
                var index  = Math.floor((menu.currentIndex+Math.floor(menu.count)/2)%menu.count)
                console.log("Opening App: " + index)
                selectApp(index)
            } else {
                appWindowLoader.setSource("")
                hideApp()
            }
        }

    }

    Component {
        id: liveConsumption
        LiveConsumption {
            values: valueSource
        }
    }

    function selectApp(ind) {
        switch(ind) {

            // 0: Route
            // 1: Trips
            // 2: Range
            // 3: Energy
            // 4: Media
            // 5: Empty
            // 6: -


        case 0:
            appWindowLoader.sourceComponent = undefined;
            appWindowLoader.setSource("Route.qml", {"values": valueSource});
            showApp()
            break;

        case 1:
            appWindowLoader.sourceComponent = undefined;
            appWindowLoader.setSource("Pneus.qml", {"values": valueSource})
            showApp()
            break;

        case 2:
            appWindowLoader.sourceComponent = undefined;
            appWindowLoader.sourceComponent = liveConsumption;

            showApp()
            break;

        case 3:

            appWindowLoader.sourceComponent = undefined;
            appWindowLoader.setSource("Music.qml", {"values": valueSource});
            showApp()
            break;

        case 4:
            appWindowLoader.sourceComponent = undefined; //"/pics/Music.png";
            showApp()
            break;


        default:
            break;
        }
    }

    function showApp() {
        doAnimateHoverSignal()
        animateOpacity.start()
        appWindow.opacity = 1
        animateWindow.start()
    }

    function hideApp() {
        deanimateOpacity.start()
        doDeanimateHoverSignal()
        //deanimateHover.start()
        deanimateWindow.start()
    }

    NumberAnimation {
        id: animateOpacity; target: menu; properties: "opacity"; from: 1.00; to: 0.0; duration: 50
    }
    NumberAnimation {
        id: deanimateOpacity; target: menu; properties: "opacity"; from: 0.0; to: 1.0; duration: 500
    }

    NumberAnimation {
        id: animateWindow; target: appWindow; properties: "y"; from: parent.height; to: 0.0; duration: 1000; easing.type: Easing.OutExpo
    }
    NumberAnimation {
        id: deanimateWindow; target: appWindow; properties: "opacity"; from: 1.00; to: 0.0; duration: 500
    }
}

