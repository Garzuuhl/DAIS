import QtQuick 2.5
import QtPositioning 5.5
import QtLocation 5.6

Item {

    property ValueSource values

    Component.onCompleted: {
        values.navigationTargetChanged.connect(setRoute);
        values.navigationEnded.connect(endRoute);

        if(values.routeInProgress) setRoute();

    }

    Component.onDestruction: {
        values.navigationTargetChanged.disconnect(setRoute);
        values.navigationEnded.disconnect(endRoute);

    }

    function endRoute() {

        console.log("Route ended")
        aQuery.clearWaypoints();
        routeModel.reset();
    }

    function setRoute() {

        console.log("Route started");
        console.log("Start: " + values.latitude + ", " + values.longitude);
        console.log("Endpoint: " + values.targetLatitude + ", " + values.targetLongitude);


        aQuery.addWaypoint(QtPositioning.coordinate(values.latitude, values.longitude));
        aQuery.addWaypoint(QtPositioning.coordinate(values.targetLatitude, values.targetLongitude));
        aQuery.travelModes = RouteQuery.CarTravel;
        routeModel.update();

    }


    Timer {
        running: values.debugMode
        interval: 100
        repeat: true
        onTriggered: {

            values.latitude+= 0.0000101;
            values.longitude+= 0.0000101;

            values.navigationBearing+=10;

            map.center = QtPositioning.coordinate(values.latitude, values.longitude);
            marker.coordinate = QtPositioning.coordinate(values.latitude, values.longitude);
        }
    }

    Rectangle {

        width: parent.width * 0.75
        height: parent.height

        clip: true

        Plugin {
            id: mapPlugin

            name: "osm"
        }

        Map {
            id:map
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(values.latitude, values.longitude);

            bearing: values.navigationBearing

            RouteQuery {
                id: aQuery
            }

            RouteModel {
                id: routeModel
                plugin: mapPlugin
                query: aQuery
                autoUpdate: false
            }

            MapItemView {
                model: routeModel
                delegate: routeDelegate
            }

            Component {
                id: routeDelegate

                MapRoute {
                    route: routeData
                    line.color: "blue"
                    line.width: 5
                    smooth: true
                    opacity: 0.5

                }
            }

            zoomLevel: maximumZoomLevel

            MapQuickItem {
                id: marker

                coordinate: QtPositioning.coordinate(values.latitude, values.longitude);

                sourceItem:
                    Image {
                    source: "pics/apps/navi_pointer.png"
                    width: map.width*0.05
                    height: width
                    fillMode: Image.PreserveAspectFit
                }

                anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)

            }
        }

    }
}
