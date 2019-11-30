import QtQuick 2.2

Item {
    id: navAnimations
    property real navValue : 0
    property real maxKph : 0



    SequentialAnimation {

        running: false
        loops: 1

        // We want a small pause at the beginning, but we only want it to happen once.
        PauseAnimation {
            duration: 1000
        }

        PropertyAction {
            target: navAnimations
            property: "start"
            value: false
        }

        SequentialAnimation {
            loops: Animation.Infinite

            ParallelAnimation {
                NumberAnimation {
                    target: navAnimations
                    property: "navValue"
                    easing.type: Easing.InOutSine
                    from: 2
                    to: 0
                    duration: 3000
                }
                NumberAnimation {
                    target: navAnimations
                    property: "maxKph"
//                    easing.type: Easing.InOutSine
//                    from: 1
                    to: 7
                    duration: 3000
                }
            }
        }
    }


}
