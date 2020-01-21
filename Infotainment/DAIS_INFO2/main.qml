import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.2
import QtLocation 5.12
import QtPositioning 5.6


//


// Make registered qmlmqttclient visible to qml
import MqttClient 1.0


ApplicationWindow {
    id: applicationWindow
    visible: true
    flags: flags | Qt.FramelessWindowHint
    width: 1080
    height: 1920
    color: "#ffffff"
    title: qsTr("Infotainment")

/*
    // Resizing QML window: https://stackoverflow.com/questions/18927534/qtquick2-dragging-frameless-window
    MouseArea {
        anchors.fill: parent

        property variant clickPos: "1,1"

        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            var new_x = applicationWindow.x + delta.x;
            var new_y = applicationWindow.y + delta.y;

            if (new_y <= 0) {
                applicationWindow.visibility = Window.Maximized;
            }
            else
            {
                if (applicationWindow.visibility === Window.Maximized) {
                    applicationWindow.visibility = Window.Windowed
                }
                applicationWindow.x = new_x
                applicationWindow.y = new_y
            }
        }


    }

*/


    //Variablen
    ValueSource {
        id: valueSource
    }

    property var i:0;
    //Musikspieler
    property var isPlayingMusic:false;
    property int songDurationInMinutes:playmusic.duration/1000/60;
    property int songDurationInSeconds:(playmusic.duration/1000)%60;
    property string songDuration:songDurationInMinutes+":"+songDurationInSeconds;
    property int currentSongDurationInMinutes:playmusic.position/1000/60;
    property int currentSongDurationInSeconds:(playmusic.duration/1000)%60;
    //property string currentSongDuration:"0"+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;
    property string currentSongDuration:"0:00";
    property string songTitle:playmusic.metaData.title="Summer"

    property var songList: ["music/bensound-summer.mp3","music/bensound-energy.mp3","music/bensound-tomorrow.mp3"]
    property int songCount:songList.length-1;
    property int curSong:0;
    property var songTitles: ["Summer","Energy","Tomorrow"]
    property var songArtist: ["BenSound","BenSound","BenSound"]
    property var isMainPlayButton:false
    property var musictoggle:true
    //Telefon
    property int maxDigits:20
    property int curDigits:0
    property int phonecallcounter:0;
    property int phonecalllengthcounter:0
    //Navigation
    property int mapcounter:0
    property var destinationlat:0.0
    property var destinationlon:0.0
    property var routeupdatecounter:0

    //Heizung
    property var heatdialog:true
    property int heatfan:0

    //------------------------------------------------------------------------------------------
    // Different properties holding Subscriptions of type QMqttTopicFilter*
    property var kphSubscription: 0
    property var gearSubscription: 0
    property var rpmSubscription: 0
    property var maxrpmSubscription: 0
    property var fuelSubscription: 0
    property var tempSubscription: 0
    property var distanceSubscription: 0
    property var tirePressureFrontLeftSubscription: 0
    property var tirePressureFrontRightSubscription: 0
    property var tirePressureBackLeftSubscription: 0
    property var tirePressureBackRightSubscription: 0
    property var blinkSubscription: 0
    property var maxkphSubscription: 0
    property var lightOnSubscription: 0
    property var fullbeamSubscription: 0
    property var warningSubscription: 0
    property var absSubscription: 0
    property var handbrakeSubscription: 0
    property var seatbeltSubscription: 0
    property var doorOpenSubscription: 0
    property var fogbeamSubscription: 0
    property var motorSubscription: 0
    property var batterySubscription: 0
    property var tpmsSubscription: 0
    property var coolantSubscription: 0
    property var warnsignalOilLevelSubscription: 0

    property var currentConsumptionSubscription: 0
    property var avgConsumptionSubscription: 0
    property var estimatedRangeSubscription: 0
    property var longitudeSubscription: 0
    property var latitudeSubscription: 0
    property var navigationBearingSubscription: 0

    // Infotainment

    // |__ Music
    property var playerActiveSubscription: 0
    property var songTitleSubscription: 0
    property var songPerformerSubscription: 0
    property var songDurationSubscription: 0
    property var currentPlaytimeSubscription: 0
    property var playerStatusSubscription: 0
    property var musicImageSubscription: 0

    // |__ Phone
    property var phoneActiveSubscription: 0
    property var callerNameSubscription: 0
    property var callerNumberSubscription: 0
    property var callDurationSubscription: 0
    property var callerImageSubscription: 0

    // |__ Navigation data

    property var routeInProgressSubscription:0
    property var targetLatitudeSubscription:0
    property var targetLongitudeSubscription:0


    // Menu navigation
    property var navAxisSubscription: 0
    property var navButtonSubscription: 0
    property var navZeroPositionSubscription: 0



    // Parse received messages from subscription and set values
    function setSpeed(payload) {
        valueSource.kph = Math.floor(Math.abs(parseFloat(payload)))
    }
    function setGear(payload) {
        valueSource.gear = payload
    }
    function setRpm(payload) {
        valueSource.rpm = parseFloat(payload)
    }
    function setMaxRpm(payload) {
        valueSource.maxrpm = parseFloat(payload)
    }
    function setFuel(payload) {
        valueSource.fuel = parseFloat(payload)
    }
    function setTemp(payload) {
        valueSource.temp = parseFloat(payload)
    }
    function setMaxKph(payload) {
        valueSource.maxkph = parseInt(payload)
    }
    function setDistance(payload) {
        valueSource.distance = parseFloat(payload)
    }
    function setLight(payload) {
        valueSource.lightOn = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setFullbeam(payload) {
        valueSource.fullbeamOn = (payload === 'True'
                                  || payload === 'true') ? true : false
    }
    function setWarning(payload) {
        valueSource.warning = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setAbs(payload) {
        valueSource.abs = (payload === 'True'
                           || payload === 'true') ? true : false
    }
    function setHandbrake(payload) {
        valueSource.handbrake = (payload === 'True'
                                 || payload === 'true') ? true : false
    }
    function setSeatbelt(payload) {
        valueSource.seatbelt = (payload === 'True'
                                || payload === 'true') ? true : false
    }
    function setDoor(payload) {
        valueSource.doorOpen = (payload === 'True'
                                || payload === 'true') ? true : false
    }
    function setFogbeam(payload) {
        valueSource.fogbeam = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setMotor(payload) {
        valueSource.motor = (parseInt(payload) !== 0) ? true : false
    }
    function setBattery(payload) {
        valueSource.battery = (payload === 'True'
                               || payload === 'true') ? true : false
    }
    function setTirepressure(payload) {
        valueSource.tpms = (payload === 'True'
                            || payload === 'true') ? true : false
    }
    function setCoolant(payload) {
        valueSource.coolant = (payload === 'True'
                               || payload === 'true') ? true : false
    }

    function setOilLevelWarning(payload) {
        valueSource.lowOil = (payload === 'True'
                              || payload === 'true') ? true : false
    }

    function setTirePressureFrontLeft(payload) {
        valueSource.tirePressureFrontLeft = parseFloat(payload);
    }

    function setTirePressureFrontRight(payload) {
        valueSource.tirePressureFrontRight = parseFloat(payload);
    }
    function setTirePressureBackLeft(payload) {
        valueSource.tirePressureBackLeft = parseFloat(payload);
    }
    function setTirePressureBackRight(payload) {
        valueSource.tirePressureBackRight = parseFloat(payload);
    }

    function setBlink(payload) {
        var blink = parseInt(payload)
        valueSource.leftBlinkerOn = (blink < 0)
        valueSource.rightBlinkerOn = (blink > 0)

    }

    function setCurrentConsumption(payload) {
        valueSource.currentConsumption = parseFloat(payload)
    }

    function setAvgConsumption(payload) {
        valueSource.avgConsumption = parseFloat(payload)
    }

    function setEstimatedRange(payload) {
        valueSource.estimatedRange = parseFloat(payload)
    }

    function setLongitude(payload) {
        valueSource.longitude = parseFloat(payload)
    }

    function setLatitude(payload) {
        valueSource.latitude = parseFloat(payload)
    }

    // Music

    function setSongTitle(payload) {
        valueSource.songTitle = payload
    }

    function setSongPerformer(payload) {
        valueSource.songPerformer = payload
    }

    function setSongDuration(payload) {
        valueSource.songDuration = parseInt(payload)
    }

    function setCurrentPlaytime(payload) {
        valueSource.currentPlaytime = parseInt(payload)
    }

    function setPlayerStatus(payload) {
        valueSource.playerStatus = payload
    }

    function setPlayerActive(payload) {
        valueSource.playerActive = (payload === 'True'
                                    || payload === 'true') ? true : false
    }

    function setMusicImage(payload) {
        valueSource.musicImage = payload
    }


    // |__ Phone

    function setPhoneActive(payload) {
        valueSource.phoneActive = (payload === 'True'
                                   || payload === 'true') ? true : false
    }

    function setCallerName(payload) {
        valueSource.callerName = payload
    }

    function setCallerNumber(payload) {
        valueSource.callerNumber = payload
    }

    function setCallDuration(payload) {
        valueSource.callDuration = parseInt(payload)
    }

    function setCallerImage(payload) {
        valueSource.callerImage = payload
    }

    function setNavAxis(payload) {
        valueSource.navAxisValue = parseFloat(payload)
    }

    function setNavButton(payload) {
        valueSource.navButtonValue = parseFloat(payload)
    }

    function setNavZeroPos(payload) {
        valueSource.navZeroPos = (payload === 'True'
                                  || payload === 'true') ? true : false
    }

    function setNavigationBearing(payload) {
        valueSource.navigationBearing = parseFloat(payload)
    }

    function setRouteInProgress(payload) {
        valueSource.routeInProgress = (payload === 'True'
                                       || payload === 'true') ? true : false
    }

    function setTargetLatitude(payload) {
        valueSource.targetLatitude = parseFloat(payload)
    }

    function setTargetLongitude(payload) {
        valueSource.targetLongitude = parseFloat(payload)
    }


    Component.onCompleted:{mqttclient.connectToHost();




    }




    //Components for MQTT Connection , invisible
    TextField {
        id: hostnameField
        text: "localhost"
        placeholderText: "<hostname>"
        visible: false
    }

    TextField {
        id: portField
        text: "1883"
        visible: false
    }

    TextField {
        id: usernameField
        text: ""
        placeholderText: "<username>"
        enabled: mqttclient.state !== MqttClient.Connected
        visible: false
    }
    TextField {
        id: passwordField
        //echoMode: 2
        text: ""
        placeholderText: "<password>"
        //enabled: mqttclient.state !== MqttClient.Connected
        visible: false
    }



    //--------------------------------------------------------------------------------------------

    // Instantiation of qmlmqttclient
    MqttClient {
        id: mqttclient
        hostname: hostnameField.text
        username: usernameField.text
        password: passwordField.text
        port: portField.text

        cleanSession: true

        //missing: Distance, WiperLevel, ErrorMessage, ESPActive
        //      DriverSeatbeltUnlocked, CoDriverSeatbeltUnlocked, BackseatSeatbeltUnlocked (currently not necessary)
        //      WarnSignalAirbag (not yet available in OnSide), CoolantTemperature (only necessary if displayed),
        //      TirePressureFrontLeft, TirePressureFrontRight, TirePressureBackLeft, TirePressureBackRight (currently not necessary),
        //      WarnSignalOilPressure, OilPressure, OilLevel (currently not necessary)
        //      DoorOpenFrontLeft, DoorOpenFrontRight, DoorOpenBackLeft, DoorOpenBackRight, DoorOpenTrunk (currently not necessary)
        // topics will be subscribed on successfull connection
        // Notice: parameters of .connect are always the address of the function
        onConnected: {
            kphSubscription = mqttclient.subscribe("car/Speed")//
            kphSubscription.messageReceived.connect(setSpeed)

            gearSubscription = mqttclient.subscribe("car/Gear")//
            gearSubscription.messageReceived.connect(setGear)

            rpmSubscription = mqttclient.subscribe("car/RPM")//
            rpmSubscription.messageReceived.connect(setRpm)

            maxrpmSubscription = mqttclient.subscribe("car/MaxRPM")//
            maxrpmSubscription.messageReceived.connect(setMaxRpm)

            distanceSubscription = mqttclient.subscribe("car/Distance")//
            distanceSubscription.messageReceived.connect(setDistance)

            fuelSubscription = mqttclient.subscribe("car/Fuel")//
            fuelSubscription.messageReceived.connect(setFuel)

            blinkSubscription = mqttclient.subscribe("car/Blink")//
            blinkSubscription.messageReceived.connect(setBlink)

            tempSubscription = mqttclient.subscribe("car/OutsideTemperature")//
            tempSubscription.messageReceived.connect(setTemp)

            maxkphSubscription = mqttclient.subscribe("car/MaxSpeed")//
            maxkphSubscription.messageReceived.connect(setMaxKph)

            lightOnSubscription = mqttclient.subscribe("car/Light")//
            lightOnSubscription.messageReceived.connect(setLight)

            fullbeamSubscription = mqttclient.subscribe("car/Fullbeam")//
            fullbeamSubscription.messageReceived.connect(setFullbeam)

            warningSubscription = mqttclient.subscribe("car/Warnsignal")//
            warningSubscription.messageReceived.connect(setWarning)

            absSubscription = mqttclient.subscribe("car/WarnSignalABS")//
            absSubscription.messageReceived.connect(setAbs)

            tirePressureFrontLeftSubscription = mqttclient.subscribe("car/TirePressureFrontLeft")
            tirePressureFrontLeftSubscription.messageReceived.connect(setTirePressureFrontLeft)

            tirePressureFrontRightSubscription = mqttclient.subscribe("car/TirePressureFrontRight")
            tirePressureFrontRightSubscription.messageReceived.connect(setTirePressureFrontRight)

            tirePressureBackLeftSubscription = mqttclient.subscribe("car/TirePressureBackLeft")
            tirePressureBackLeftSubscription.messageReceived.connect(setTirePressureBackLeft)

            tirePressureBackRightSubscription = mqttclient.subscribe("car/TirePressureBackRight")
            tirePressureBackRightSubscription.messageReceived.connect(setTirePressureBackRight)

            handbrakeSubscription = mqttclient.subscribe(
                        "car/HandbrakeActivated")//
            handbrakeSubscription.messageReceived.connect(setHandbrake)

            seatbeltSubscription = mqttclient.subscribe(
                        "car/WarnSignalSeatbelt")//
            seatbeltSubscription.messageReceived.connect(setSeatbelt)

            doorOpenSubscription = mqttclient.subscribe(
                        "car/WarnSignalDoorlock")//
            doorOpenSubscription.messageReceived.connect(setDoor)

            fogbeamSubscription = mqttclient.subscribe("car/FogLamp")//
            fogbeamSubscription.messageReceived.connect(setFogbeam)

            motorSubscription = mqttclient.subscribe("car/ErrorCode")//
            motorSubscription.messageReceived.connect(setMotor)

            batterySubscription = mqttclient.subscribe(
                        "car/WarnSignalGenerator")//
            batterySubscription.messageReceived.connect(setBattery)

            tpmsSubscription = mqttclient.subscribe(
                        "car/WarnSignalTirePressure")//
            tpmsSubscription.messageReceived.connect(setTirepressure)

            coolantSubscription = mqttclient.subscribe(
                        "car/WarnSignalCoolantTemperature")
            coolantSubscription.messageReceived.connect(setCoolant)

            warnsignalOilLevelSubscription = mqttclient.subscribe("car/WarnSignalOilLevel")
            warnsignalOilLevelSubscription.messageReceived.connect(setOilLevelWarning)

            currentConsumptionSubscription = mqttclient.subscribe("car/FuelConsumption")
            currentConsumptionSubscription.messageReceived.connect(setCurrentConsumption)

            avgConsumptionSubscription = mqttclient.subscribe("car/AvgConsumption")
            avgConsumptionSubscription.messageReceived.connect(setAvgConsumption)

            estimatedRangeSubscription = mqttclient.subscribe("car/EstimatedRange")
            estimatedRangeSubscription.messageReceived.connect(setEstimatedRange)

            longitudeSubscription = mqttclient.subscribe("car/Longitude")
            longitudeSubscription.messageReceived.connect(setLongitude)

            latitudeSubscription = mqttclient.subscribe("car/Latitude")
            latitudeSubscription.messageReceived.connect(setLatitude)

            navigationBearingSubscription = mqttclient.subscribe("car/Bearing")
            navigationBearingSubscription.messageReceived.connect(setNavigationBearing)

            // Route navigationBearingSubscription



            // Infotainment

            playerActiveSubscription = mqttclient.subscribe("car/infotainment/music/PlayerActive")
            playerActiveSubscription.messageReceived.connect(setPlayerActive)

            songTitleSubscription = mqttclient.subscribe("car/infotainment/music/SongTitle")
            songTitleSubscription.messageReceived.connect(setSongTitle)

            songPerformerSubscription = mqttclient.subscribe("car/infotainment/music/SongPerformer")
            songPerformerSubscription.messageReceived.connect(setSongPerformer)

            songDurationSubscription = mqttclient.subscribe("car/infotainment/music/SongDuration")
            songDurationSubscription.messageReceived.connect(setSongDuration)

            currentPlaytimeSubscription = mqttclient.subscribe("car/infotainment/music/CurrentPlaytime")
            currentPlaytimeSubscription.messageReceived.connect(setCurrentPlaytime)

            musicImageSubscription = mqttclient.subscribe("car/infotainment/music/MusicImage")
            musicImageSubscription.messageReceived.connect(setMusicImage)

            playerStatusSubscription = mqttclient.subscribe("car/infotainment/music/PlayerStatus")
            playerStatusSubscription.messageReceived.connect(setPlayerStatus)

            // Phone

            phoneActiveSubscription = mqttclient.subscribe("car/infotainment/phone/PhoneActive")
            phoneActiveSubscription.messageReceived.connect(setPhoneActive)

            callerNumberSubscription = mqttclient.subscribe("car/infotainment/phone/CallerNumber")
            callerNumberSubscription.messageReceived.connect(setCallerNumber)

            callerNameSubscription = mqttclient.subscribe("car/infotainment/phone/CallerName")
            callerNameSubscription.messageReceived.connect(setCallerName)

            callDurationSubscription = mqttclient.subscribe("car/infotainment/phone/CallDuration")
            callDurationSubscription.messageReceived.connect(setCallDuration)

            callerImageSubscription = mqttclient.subscribe("car/infotainment/phone/CallerImage")
            callerImageSubscription.messageReceived.connect(setCallerImage)

            routeInProgressSubscription = mqttclient.subscribe("car/infotainment/navigation/RouteInProgress")
            routeInProgressSubscription.messageReceived.connect(setRouteInProgress)

            targetLatitudeSubscription = mqttclient.subscribe("car/infotainment/navigation/TargetLatitude")
            targetLatitudeSubscription.messageReceived.connect(setTargetLatitude)

            targetLongitudeSubscription = mqttclient.subscribe("car/infotainment/navigation/TargetLongitude")
            targetLongitudeSubscription.messageReceived.connect(setTargetLongitude)

            // Menu navigation

            navAxisSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/RX")
            navAxisSubscription.messageReceived.connect(setNavAxis)

            navButtonSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/TY")
            navButtonSubscription.messageReceived.connect(setNavButton)

            navZeroPositionSubscription = mqttclient.subscribe("devices/input/navigation/SpaceNavigator/Zero")
            navZeroPositionSubscription.messageReceived.connect(setNavZeroPos)


        }
    }


    //-----------------------------------------MQTTENDE-------------------------------------------------------------------------------------

    //------------------------------|Audio

    Audio{
        id:playmusic
        source :"music/bensound-summer.mp3"

    }

    function startMusic()
    {



        playmusic.play();
        imagePlayButton.source = "background/stop.png";
        miniplayButton.source="background/stop.png";


    }


    function stopMusic()
    {
        playmusic.pause()
        imagePlayButton.source = "background/play.svg";
        miniplayButton.source="background/play.svg";



    }


    function getLocationFromName(name)
    {
        //api call
        var url ='https://nominatim.openstreetmap.org/search?q='+name+'&format=json&limit=1'
        //   var url2='http://www.google.com'
        var doc= new XMLHttpRequest()
        //console.debug("test")



        doc.onreadystatechange=function()  {

            if(doc.readyState == 4 && doc.status == 200)
            {
                console.debug("fertig");
                //schon im json format
                //   var result = JSON.parse(doc.responseText);

                //var json= '[{"place_id":17011844,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"node","osm_id":1674026139,"boundingbox":["48.6184485","48.9384485","9.0200132","9.3400132"],"lat":"48.7784485","lon":"9.1800132","display_name":"Stuttgart, Baden-Württemberg, 70173, Germany","class":"place","type":"city","importance":0.7964347124043025,"icon":"https://nominatim.openstreetmap.org/images/mapicons/poi_place_city.p.20.png"}]';
                var json = JSON.parse('['+doc.responseText+']');
                var jsonArray = json[0];
                for (var key = 0; key < jsonArray.length; key++) {
                    var value = jsonArray[key];
                    console.debug(value.lat, value.lon);
                    destinationlat=value.lat;
                    destinationlon=value.lon;
                    albumName.text=destinationlat+ "    "+destinationlon;
                }


                //  albumName.text="";

            }
        }


        doc.open('GET',url,true)
        doc.send()


    }




function drawMap(){


aquery.clearWaypoints();
routeModel.reset();
aquery.addWaypoint(QtPositioning.coordinate(valueSource.latitude,valueSource.longitude));
aquery.addWaypoint(QtPositioning.coordinate(destinationlat,destinationlon));
map.center=QtPositioning.coordinate(destinationlat,destinationlon);
mapcircle1.center=QtPositioning.coordinate(destinationlat,destinationlon);
routeModel.update();
drawmaptimer.start();

//albumName.text=routeModel.status;
}




    //------------------------------
    header: Item {
        MouseArea{
            x:0
            y:0
            width:200
            height:100
            visible: true
            onPressed:{

                flickable.interactive=true;

            }





            Rectangle {
                id: header
                width: 1080
                height: 100
                color: '#000000'

                Image {
                    id: image13
                    x: 0
                    y: 0
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "background/bars.svg"


                }







                Text {
                    id:timeanddate
                    x:454
                    y:12
                    width: 173
                    height: 80


                    //text: Qt.formatDateTime(new Date(), "dd.MM.yyyy")
                    text: Qt.formatTime(new Date(), "hh:mm")
                    font.pointSize: 50
                    color: '#ef7d25'
                }





                Image {
                    id: image9
                    x: 750
                    y: 0
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "background/wifi.svg"


                }

                Image {
                    id: image10
                    x: 860
                    y: 0
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "background/signal.svg"
                }

                Image {
                    id: image11
                    x: 980
                    y: 0
                    width: 100
                    height:100
                    fillMode: Image.PreserveAspectFit
                    source: "background/battery-three-quarters.svg"
                }


            }



            Text {
                id: element22
                text: qsTr("Text")
                font.pixelSize: 12
            }


        }







        Flickable {
            id: flickable2
            x: 0
            y: 7
            width: 1080
            height: 1920
            visible: true
            interactive: false
            boundsMovement: Flickable.FollowBoundsBehavior
            contentY: 1920
            contentX: 0
            contentHeight:2*1920
            contentWidth:1080
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick



        }




    }



    //------------------------------------------------------------------------------------------------------------

    SwipeView {
        orientation: Qt.Horizontal
        id: swipeView
        visible: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Page1Form {

            Image {
                id: imagePlayButton
                x: 440
                y: 1300
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                source: "background/play.svg"
            }


            Image {
                id: imagelastSongButton
                x: 140
                y: 1300
                width: 200
                height: 200
                opacity: 1
                fillMode: Image.PreserveAspectFit
                source: "background/step-backward.svg"
            }

            Image {
                id: imagenextSongButton
                x: 740
                y: 1300
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                source: "background/step-forward.svg"
            }



            Button {
                id: playSongButton
                x: 445
                y: 1305
                width: 179
                height: 191
                text: "Button"
                visible: true
                opacity: 0
                //Spielt Musik bzw. pausiert Musik
                onPressed:{
                    if(!isPlayingMusic)
                    {isMainPlayButton=true;
                        startMusic();isPlayingMusic=true}
                    else if(isPlayingMusic)
                    {isMainPlayButton=true;
                        stopMusic();
                        isPlayingMusic=false;}
                }

            }


            //------------------------------|Musicplayerbutton



            Button {
                id: nextSongButton
                x: 764
                y: 1305
                width: 148
                height: 191
                text: "Button"
                opacity: 0
                visible: true
                onPressed: {

                    curSong++


                    if(curSong>songCount){curSong=0;playmusic.source=songList[curSong];songName.text=songTitles[curSong] ;startMusic()}
                    if(curSong<=songCount) {playmusic.source=songList[curSong];songName.text=songTitles[curSong] ; startMusic()}}
            }

            Button {
                id: songSelectButton
                x: 985
                y: 762
                width: 95
                height: 183
                text: "Button"
                opacity: 0
                visible: true
            }

            Button {
                id: lastSongButton
                x: 169
                y: 1305
                width: 141
                height: 191
                text: "Button"
                opacity: 0
                visible: true
                onPressed: {
                    curSong--;
                    if(curSong<0){curSong=songCount;playmusic.source=songList[curSong];songName.text=songTitles[curSong] ; startMusic();}
                    if(curSong=>0){playmusic.source=songList[curSong];songName.text=songTitles[curSong];startMusic()}
                }
            }

            Label {
                id: mediaName
                x: 234
                y: 762
                width: 613
                height: 76
                text: valueSource.songTitle
                font.pointSize: 40
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: currentSongTime
                x: 34
                y: 1031
                width: 136
                height: 80
                text: currentSongDuration
                font.pointSize: 50
            }

            Label {
                id: albumName
                x: 234
                y: 831
                width: 613
                height: 76
                text: qsTr("Album")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 40
            }

            Label {
                id: songName
                x: 234
                y: 898
                width: 613
                height: 76
                text: songTitle
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 40
            }

            Label {
                id: fullSongTime
                x: 904
                y: 1031
                width: 158
                height: 80
                text: songDuration
                font.pointSize: 50
            }

            ProgressBar {
                id: progressBar
                x: 234
                y: 1047
                width: 600
                height: 54
                opacity: 0
                font.pointSize: 8
                value: 0
            }

            Rectangle {
                id: progressbarBorder
                x: 230
                y: 1043
                width: 608
                height: 57
                color: "#ffffff"
                radius: 1
                border.width: 4
            }

            Rectangle {
                id: progressbarRect
                x: 234
                y: 1047
                width: 600
                height: 49
                color: "#ef7d25"
                radius: 0
                border.width: 0
            }




            Button{
                id:musicfolderbutton
                x: 974
                y: 753
                width: 200
                height: 200
                opacity:0
onPressed: {  if(musicliste.visible==true)musicliste.visible=false; else if (musicliste.visible==false) musicliste.visible=true  ;   }

            }




            Component {
                id: musicselectDelegate
                Button{
                    text:(index+1)+" "+name

                    width:250
                    onPressed:
                    {
                    songName.text=name;
                    songArtist.text=artist;
                    playmusic.source=source;
                    curSong=index;
                    startMusic();



                     }

                }
            }




            ListView {
                id:musicliste
                x: 844
                y: 153
                width:250
                height:600
                visible:false


                model: MP3Model {}
                delegate: musicselectDelegate
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true


            }






        }
        //#####################################################################################################################
        Page2Form {
            id: page2Form
            visible: true



            Label{
                id:phoneNumber
                text:""
                x:190
                y:160

                font.pointSize:40
            }

            //1
            Button {
                x: 185
                y: 281
                width: 200
                height: 200
                visible: true

                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"1";curDigits++}}
            }

            //2
            Button {
                x: 440
                y: 281
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"2";curDigits++}}
            }

            //3
            Button {
                x: 724
                y: 281
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"3";curDigits++}}

            }

            //4
            Button {
                x: 185
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"4";curDigits++}}

            }


            //5
            Button {
                x: 440
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"5";curDigits++}}

            }

            //6
            Button {
                x: 724
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"6";curDigits++}}
            }

            //7
            Button {
                x: 185
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"7";curDigits++}}

            }

            //8
            Button {
                x: 440
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"8";curDigits++}}

            }

            //9
            Button {
                x: 724
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"9";curDigits++}}

            }

            //0
            Button {
                x: 185
                y: 1111
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"0";curDigits++}}

            }

            //phonebutton
            Button {
                x: 440
                y: 1111
                width: 200
                height: 200
                visible: true
                opacity: 0
                 onPressed: {phonecalltab.visible=true; call.text="Rufe Dieter Wallach an       "+phoneNumber.text ; phonecalltimer.start(); phonecallcounter=0; phonecalllengthcounter=0;}


            }

Timer{
id:phonecalltimer
interval:1000
repeat:true
onTriggered:{

if(phonecallcounter==0)
{
phonecallbubble1.color="#ffffff" ;
phonecallbubble2.color="#ffffff" ;
phonecallbubble3.color="#ffffff" ;

}
else if (phonecallcounter==1)
{
phonecallbubble1.color="#ef7d25" ;
phonecallbubble2.color="#ffffff" ;
phonecallbubble3.color="#ffffff" ;


}
else if (phonecallcounter==2)
{
phonecallbubble1.color="#ef7d25" ;
phonecallbubble2.color="#ef7d25" ;
phonecallbubble3.color="#ffffff" ;


}
else if (phonecallcounter==3)
{
phonecallbubble1.color="#ef7d25" ;
phonecallbubble2.color="#ef7d25" ;
phonecallbubble3.color="#ef7d25" ;
phonecallcounter=-1;


}
phonecallcounter++;
phonecalllengthcounter++;
phonecalllength.text="00:"+phonecalllengthcounter;


if (phonecalllengthcounter<10)
{

phonecalllength.text="00:0"+phonecalllengthcounter;
}



if (phonecalllengthcounter>=10)
{

phonecalltimer.stop();
phonecalltab.visible=false;
phonecallcounter=0;
phonecalllengthcounter=0;
phonecalllength.text="00:"+phonecalllengthcounter;
}




}

}






            //Phonecalling
            Rectangle{
                id:phonecalltab
                visible: false
                height: 1880
                width:1080
Label{id:call
x:100
y:100
text:qsTr("Rufe Dieter Wallach an   "+phoneNumber.text)
font.pointSize:40


}

Rectangle{
id:phonecallbubble1
x:300
y:300
width:100
height:100
radius:width*0.5
color:"#ef7d25"
border.color: "#000000"
border.width: 1


}

Rectangle{
id:phonecallbubble2
x:450
y:300
width:100
height:100
radius:width*0.5
color:"#ef7d25"
border.color: "#000000"
border.width: 1


}


Rectangle{
id:phonecallbubble3
x:600
y:300
width:100
height:100
radius:width*0.5
color:"#ef7d25"
border.color: "#000000"
border.width: 1


}



Image{id:phoneright
x:750
y:300
width:100
height:100
source:"background/phone.svg"
}

Label{
id:phonecalllength
x:450
y:200
font.pointSize:40
color:"#ef7d25"
text:"00:0"+phonecalllengthcounter


}





            }












            //return-button
            Button {
                id: deletephonebutton
                x: 724
                y: 1111
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {phoneNumber.text=""; curDigits=0;}

            }





        }
        //#####################################################################################################################
        Page3Form {
            //Carsettings
            visible: true
            Label {
                id: pressurefrontleft
                x: 200
                y: 368
                font.pointSize: 40
                text: valueSource.tirePressureFrontLeft
            }
            Label {
                id: pressurefrontright
                x: 800
                y: 368
                font.pointSize: 40
                text:valueSource.tirePressureFrontRight
            }
            Label {
                id: pressurebackleft
                x: 200
                y: 950
                font.pointSize: 40
                text:valueSource.tirePressureBackLeft
            }
            Label {
                id: pressurebackright
                x: 800
                y: 950
                font.pointSize: 40
                text: valueSource.tirePressureBackRight
            }

            Label {
                id: consumption
                x: 100
                y: 1250
                font.pointSize: 10
                /* text: "Verbrauch: "
+"Verbrauch"+valueSource.currentConsumption
+"Temperatur" +valueSource.temp
+"Abs"+valueSource.abs
+"handbremser" +valueSource.handbrake
+"gurt" +valueSource.seatbelt
+"türr" +valueSource.doorOpen
+"nebelscheinwerfer" +valueSource.fogbeam
+"Temperatur" +valueSource.motor
+"Temperatur" +valueSource.battery
+"Temperatur"  +valueSource.tpms
+"Temperatur" +valueSource.coolant
+"ölstand" +valueSource.lowOil
*/
                text:""
            }


            Label {
                id: kilometer
                x: 100
                y: 1350
                font.pointSize: 30
                text:"Kilometerstand: "+(Math.round(valueSource.distance * 100) / 100) +"km"
            }


            Label {
                id:strecke
                x: 100
                y: 1450
                font.pointSize: 30
                text:valueSource.kph
            }



        }

        Page4Form {
Timer{
id:drawmaptimer
interval:1000
running:false
repeat:false
triggeredOnStart:false
onTriggered:{
routeModel.update();
routeupdatecounter++;
if(routeupdatecounter==5){routeupdatecounter=0; drawmaptimer.stop() ;};


}
}


            Map {


                Label {x:0;y:1800; width: 50;height:10; font.pointSize: 10;id:licenceinfo ; text:"Karte hergestellt aus OpenStreetMap-Daten | Lizenz: Open Database License (ODbL)" ;}



MapCircle {
id:mapcircle1
       center {
           latitude: valueSource.latitude
           longitude: valueSource.longitude
       }
       radius: 10.0
       color: "#ef7d25"
       border.width: 3
   }





                Component {
                    id: addressDelegate
                    Button{
                        text:name
                        onPressed:
                        {
                        suchleiste.text=address;
                        destinationlat=lat;
                        destinationlon=lon;

                         }

                    }
                }




                ListView {
                    id:list1
                    x: 0
                    y: 100
                    width:200
                    height:600


                    model: AddressModel {}
                    delegate: addressDelegate
                    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                    focus: true


                }













                TextField{x:0;
                    y:100;
                    width:200;
                    height:100;
                    visible: false
                    id:suchleiste
                    onPressed: {}
                }
                Button{
                    id:suchbutton
                    x:980;
                    y:100;
                    width:100;
                    height:100;
                    text:"Route starten"


                    onPressed: {
                      // getLocationFromName("'"+suchleiste.text+"'");
                       drawMap();





                    }

                }






                id: map
                anchors.fill: parent
                // center: QtPositioning.coordinate(49.2605522, 7.3601991)

                //center: QtPositioning.coordinate(26.328045523310905, 50.080033033011546)
                center: QtPositioning.coordinate(valueSource.latitude, valueSource.longitude)
                //Api-Begrenzung
                zoomLevel: 17
                minimumZoomLevel: 10
                maximumZoomLevel: 17

                //center:QtPositioning.coordinate(59.930, 10)
                //@49.2605522,7.3601991
                plugin: Plugin
                {id:aPlugin
                    name: "osm"

                    //name: "osm.mapping.custom.host"
                    PluginParameter
                    {
                        name: "osm.mapping.custom.host"
                        value:  "http://a.tile.openstreetmap.fr/hot/"
                        //value:"http://a.tile.stamen.com/toner/"

                    }

                }






                RouteModel {
                    id: routeModel
                    plugin: aPlugin
                    query: RouteQuery{id:aquery}

                    Component.onCompleted: {}





                }


                MapItemView {
                    model: routeModel
                    delegate: routeDelegate
                }

                Component {
                    id: routeDelegate

                    MapRoute {

                        route: routeData
                        line.color: "#ef7d25"
                        line.width: 6
                        smooth: false
                        opacity: 1
                    }
                }
                activeMapType: supportedMapTypes[supportedMapTypes.length - 1]
            }








        }







        Page5Form {
            visible: true

            Label{

            id:impressumheader
            x:420
            y:100
            width: 100
            height: 100
            font.bold: true
            text: "Impressum"
            font.pointSize: 30;
            color:"#ef7d25"
            style: Text.Outline

            }








        }
    }


    //------------------------------|Seite1-ENDE


    //Timers

    //Clockrefresh
    Timer{
        id: timer
        interval: 3000
        repeat: true
        running: true

        onTriggered:
        {
            timeanddate.text =  Qt.formatTime(new Date(),"hh:mm")

        }

    }


    //Dropdownmenutimer


    Timer{
        id: dropDownTimer
        interval: 1000
        repeat: true
        running: false

        onTriggered:
        {


        }

    }




    //Musictimer
    Timer{
        id: songTimer
        interval: 500
        repeat: true
        running: true

        onTriggered:
        {
            currentSongDurationInMinutes=playmusic.position/1000/60;
            currentSongDurationInSeconds=(playmusic.position/1000)%60;



            if(currentSongDurationInMinutes>=10&&currentSongDurationInSeconds>=10)
                currentSongDuration=""+currentSongDurationInMinutes+":"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes<10&&currentSongDurationInSeconds>=10)
                currentSongDuration=""+currentSongDurationInMinutes+":"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes>=10&&currentSongDurationInSeconds<10)
                currentSongDuration=""+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes<10&&currentSongDurationInSeconds<10)
                currentSongDuration=""+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;



            //  else  currentSongDuration=""+currentSongDurationInMinutes+":"+currentSongDurationInSeconds;

            //progressBar.value=playmusic.position/playmusic.duration;
            progressbarRect.width=(playmusic.position/playmusic.duration)*600
        }

    }

    Flickable {
        id: flickable
        x: 0
        y: 7
        width: 1080
        height: 1920
        boundsMovement: Flickable.FollowBoundsBehavior
        Rectangle {
            id: borderImage1e
            x: 0
            y: -3
            width: 1080
            height: 1920
            color: "#888483"



            Image {
                id: image1
                x: 90
                y: 208
                width: 318
                height: 296
                fillMode: Image.PreserveAspectFit
                source: "background/car.svg"

                Button {
                    id: carSelectButton
                    x: -22
                    y: 0
                    width: 403
                    height: 337
                    text: qsTr("Button")
                    opacity: 0
                    onClicked: {flickable.interactive=false; flickable.contentY=1920;flickable.contentX=0;swipeView.currentIndex = swipeView.currentIndex=2}
                }
            }

            Image {
                id: mapicon
                x: 617
                y: 252
                width: 359
                height: 264
                fillMode: Image.PreserveAspectFit
                source: "background/map-marked-alt.svg"

                Button {
                    id: button
                    x: 11
                    y: -10
                    width: 364
                    height: 284
                    text: qsTr("Button")
                    opacity: 0
                      onClicked:{flickable.interactive=false; flickable.contentY=1920;flickable.contentX=0;swipeView.currentIndex = swipeView.currentIndex=3}
                }
            }

            Image {
                id: musicicon
                x: 104
                y: 699
                width: 340
                height: 321
                fillMode: Image.PreserveAspectFit
                source: "background/music.svg"


                Button {
                    id: button2
                    x: 0
                    y: 9
                    width: 368
                    height: 344
                    text: qsTr("Button")
                    opacity: 0
                    onClicked:{flickable.interactive=false; flickable.contentY=1920;flickable.contentX=0;swipeView.currentIndex = swipeView.currentIndex=0}
                }
            }

            Image {
                id: phoneicon
                x: 578
                y: 708
                width: 338
                height: 324
                fillMode: Image.PreserveAspectFit
                source: "background/phone.svg"

                Button {
                    id: button3
                    x: 0
                    y: -18
                    width: 354
                    height: 360
                    text: qsTr("Button")
                    opacity: 0
                    onClicked:{flickable.interactive=false; flickable.contentY=1920;flickable.contentX=0;swipeView.currentIndex = swipeView.currentIndex=1 }
                }
            }

            Image {
                id: cogsicon
                x: 105
                y: 1148
                width: 329
                height: 336
                fillMode: Image.PreserveAspectFit
                source: "background/cogs.svg"

                Button {
                    id: button4
                    x: -1
                    y: 10
                    width: 330
                    height: 300
                    text: qsTr("Button")
                    opacity: 0
                }
            }




            Rectangle {
                id: rectangle
                x: 0
                y: 1720
                width: 1080
                height: 200
                color: "#696969"
                border.color: "#000000"
            }












            visible: true
        }

        Image {
            id: angleupimage
            x: 0
            y: 1720
            width: 1080
            height: 100
            fillMode: Image.PreserveAspectFit
            source: "background/angle-up.svg"

            Button {
                id: angleupbutton
                x: 440
                y: 0
                width: 180
                height:100
                text: qsTr("Button")
                opacity: 0
                onPressed: {flickable.interactive=false; flickable.contentY=1920;flickable.contentX=0;}

            }
        }
        interactive: false
        contentX: 0
        contentHeight: 2*1920
        contentY: 1920
        visible: true
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: 1080
    }

    //---------------------------------------------------------------------------------------
    /*  header:Item {





Text {
id:timeanddate
x:540
y:50


//text: Qt.formatDateTime(new Date(), "dd.MM.yyyy")
text: Qt.formatTime(new Date(), "hh:mm")
font.pointSize: 20
color: '#FFFFFF'
}










} */

    //--------------------FOOTER------------------------------------------------------

    Item{ id:footer; x:0;y:1820

        Item{
            id: musiccontrol
            width: 1080
            height: 100

            Rectangle{
                id: musiccontrols
                height: 100
                width: 1080
                color: "#000000"
                visible:true

            }





            Image{
                id: volumeimage
                x: 123
                y: 0
                width: 100
                height: 100
                source: "background/volume-up.svg"
                fillMode: Image.PreserveAspectFit
            }



            Button{
                id: volumebutton
                x: 123
                y: 0
                width: 100
                height: 100
                opacity: 0
                onPressed: {


                    if(musictoggle)
                    {
                        musictoggle=false;
                        playmusic.volume=0;
                        musicVolumeSlider.value=0;
                        volumeimage.source="background/volumemute.png"
                    }
                    else if(!musictoggle)
                    {
                        playmusic.volume=0.5;
                        musicVolumeSlider.value=0.5;
                        volumeimage.source="background/volume-up.svg"
                        musictoggle=true;
                    }


                }
            }







            Slider{
                id:musicVolumeSlider;
                x: 259
                y:  30 ;
                width:200
                height: 40 ;
                snapMode: Slider.SnapAlways
                opacity: 0;
                value: 1;
                onValueChanged: {playmusic.volume=musicVolumeSlider.value; musicVolumeRectangle.width=musicVolumeSlider.value*200; }
            }
            Rectangle{
                id:musicVolumeRectangle
                color:"#ef7d25"
                x: 259
                y:  30;
                width:200
                height: 40;
            }

            Image {
                id: image2
                x: 850
                y: 0
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                source: "background/step-forward.svg"

            }
            Button {
                id: miniforwardSongButton
                x: 850
                y: 0
                width: 100
                height: 100
                text: "Button"
                visible: true
                opacity: 0
                //Spielt Musik bzw. pausiert Musik
                onPressed: {

                    curSong++


                    if(curSong>songCount){curSong=0;playmusic.source=songList[curSong];songName.text=songTitles[curSong] ;startMusic()}
                    if(curSong<=songCount) {playmusic.source=songList[curSong];songName.text=songTitles[curSong];startMusic()}


                }

            }

            Image {
                id: image123
                x: 550
                y: 0
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                source: "background/step-backward.svg"

            }
            Button {
                id: miniplaybackButton
                x: 550
                y: 0
                width: 100
                height: 100
                text: "Button"
                visible: true
                opacity: 0
                //Spielt Musik bzw. pausiert Musik
                onPressed: {
                    curSong--;
                    if(curSong<0){curSong=songCount;playmusic.source=songList[curSong];songName.text=songTitles[curSong] ;startMusic();}
                    if(curSong=>0){playmusic.source=songList[curSong];songName.text=songTitles[curSong];startMusic()}




                }


            }

            Image {
                id: miniplayButton
                x: 700
                y: 0
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                source: "background/play.svg"

            }
            Button {
                id: miniplaySongButton
                x: 700
                y: 0
                width: 100
                height: 100
                text: "Button"
                visible: true
                opacity: 0
                //Spielt Musik bzw. pausiert Musik
                onPressed:{
                    if(!isPlayingMusic)
                    {startMusic(); isPlayingMusic=true;}
                    else if(isPlayingMusic)
                    { stopMusic();isPlayingMusic=false;}
                }

            }


            Image {
                id: image24
                x: 980
                y: 0
                width: 100
                height: 100
                rotation: 180
                fillMode: Image.PreserveAspectFit
                source: "background/angle-left.svg"
            }

            Image{
                id: image23
                x: 0
                y: 0
                width: 100
                height: 100
                source: "background/angle-left.svg"
                fillMode: Image.PreserveAspectFit

            }

            Button {
                id: button23
                width: 104
                height: 100
                text: qsTr("Button")
                opacity: 0
                onPressed: {musiccontrol.visible=false;heatcontrol.visible=true;}
            }

            Button {
                id: button1
                x: 978
                y: 0
                width: 104
                height: 100
                text: qsTr("Button")
                opacity: 0
                onPressed: {musiccontrol.visible=false;heatcontrol.visible=true;}
            }

        }















        Item{

            id: heatcontrol
            width: 1080
            height: 100
            z: 0
            visible: false

            Rectangle {
                id: heatcontrolrectangle
                x: 0
                y: 0
                width: 1080
                height: 100
                color: "#000000"
                opacity: 1
                visible: true
            }

            Image {
                id: heatcontrolarrowright
                x: 980
                y: 0
                width: 100
                height: 100
                rotation: 180
                source: "background/angle-left.svg"
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: heatcontrolarrowleft
                x: 0
                y: 0
                width: 100
                height: 100
                source: "background/angle-left.svg"
                fillMode: Image.PreserveAspectFit
            }

            Button {
                id: heatcontrolleftbutton
                width: 100
                height: 100
                text: qsTr("Button")
                opacity: 0
                onPressed: {heatcontrol.visible=false; musiccontrol.visible=true}
            }

            Button {
                id: heatcontrolrightbutton
                x: 980
                y: 0
                width: 100
                height: 100
                text: qsTr("Button")
                opacity: 0
                onPressed: {heatcontrol.visible=false; musiccontrol.visible=true}

            }


            Image {
                id: heatcontrolseatleft
                x: 245
                y: 0
                width: 100
                height: 75
                fillMode: Image.PreserveAspectFit
                rotation: 0
                source: "background/heat.svg"
            }

            Image {
                id: heatcontrolfan
                x: 515
                y: 25
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: "background/ventilating-fan.svg"
            }


            Image {
                id: heatcontrolseatright
                x: 735
                y: 0
                width: 100
                height: 75
                rotation: 0
                source: "background/co-driver-heat.svg"
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                id: heatcontrolleftseatbar
                x: 245
                y: 85
                width: 100
                height: 15
                color: "#ef7d25"
            }

            Rectangle {
                id: heatcontrolrightseatbar
                x: 735
                y: 85
                width: 100
                height: 15
                color: "#ef7d25"
            }

            Image {
                id: heatcontrollarrowup
                x:490
                y:0
                width:  100
                height: 25
                fillMode: Image.PreserveAspectFit
                source: "background/angle-up.svg"
            }

            Image {
                id: heatcontrolplusimage
                x: 624
                y: 25
                width: 75
                height: 75
                fillMode: Image.PreserveAspectFit
                source: "background/plus.svg"
            }

            Image {
                id: heatcontrolminusimage
                x: 381
                y: 25
                width: 75
                height: 75
                fillMode: Image.PreserveAspectFit
                source: "background/minus.svg"
            }


            Label {
                id: temperaturleft
                color:"#ef7d25"
                x: 101
                y: 20
                width: 75
                height: 75
                text:valueSource.temp+"°"
                font.pointSize: 50
            }


            Label {
                id: temperaturright
                color:"#ef7d25"
                x: 881
                y: 20
                width: 75
                height: 75
                text:valueSource.temp+"°"
                font.pointSize: 50

            }

            Button {
                id: heatcontrolarrowupbutton
                x: 515
                width: 50
                height: 25
                text: qsTr("Button")
                opacity: 0
                onPressed: {if(heatdialog){heatcontrollarrowuprectangle.visible=true;heatdialog=false; } else {heatcontrollarrowuprectangle.visible=false;heatdialog=true} }
            }


            Rectangle {
                id: heatcontrollarrowuprectangle
                x: 0
                y: -300
                width: 1080
                height: 300
                visible: false
                color: "#000000"

                Image{
                    id:heatcontrollarrowupfrontdefrost
                    x:490
                    y:0
                    width:100
                    height:50
                    source:"background/windshield-defrost.svg"
                }

                Button{
                    id:heatcontrollarrowupfrontdefrostbutton
                    x:490
                    y:0
                    opacity: 0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupfronstdefrostbar.visible){heatcontrollarrowupfronstdefrostbar.visible=false}else if (!heatcontrollarrowupfronstdefrostbar.visible){heatcontrollarrowupfronstdefrostbar.visible=true;}}
                }

                Image{
                    id:heatcontrollarrowupfronstdefrostbar
                    x:490
                    y:60
                    width:100
                    height:30
                    visible: false
                    source:"background/minus.svg"

                }


                Image{
                    id:heatcontrollarrowupbackdefrost
                    x:490
                    y:100
                    width:100
                    height:50
                    source:"background/rear-window-defrost.svg"
                }
                Button{
                    id:heatcontrollarrowupbackdefrostbutton
                    x:490
                    y:100
                    opacity: 0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupbackdefrostbar.visible){heatcontrollarrowupbackdefrostbar.visible=false}else if (!heatcontrollarrowupbackdefrostbar.visible){heatcontrollarrowupbackdefrostbar.visible=true;}}
                }

                Image{
                    id:heatcontrollarrowupbackdefrostbar
                    x:490
                    y:160
                    width:100
                    height:30
                    visible: false
                    source:"background/minus.svg"
                }


                Image{
                    id:heatcontrollarrowupcoolingcaricon
                    x:490
                    y:200
                    width:100
                    height:50
                    source:"background/recirculation.svg"
                }
                Button{
                    id:heatcontrollarrowupcoolingcarbutton
                    x:490
                    y:200
                    opacity:0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupcoolingcariconbar.visible){heatcontrollarrowupcoolingcariconbar.visible=false}else if (!heatcontrollarrowupcoolingcariconbar.visible){heatcontrollarrowupcoolingcariconbar.visible=true;}}
                }
                Image{
                    id:heatcontrollarrowupcoolingcariconbar
                    x:490
                    y:260
                    visible: false
                    width:100
                    height:30
                    source:"background/minus.svg"
                }







            }







            Rectangle {
                id: heatcontrolfanbar1
                x: 490
                y: 75
                width: 33
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }






            Rectangle {
                id: heatcontrolfanbar2
                x: 523
                y: 75
                width: 33
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }

            Rectangle {
                id: heatcontrolfanbar3
                x: 556
                y: 75
                width: 34
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }

            Button {
                id: heatcontrolminusbutton
                x: 381
                y: 25
                width: 75
                height: 75
                opacity: 0
                onPressed: {

                    heatfan--;
                    switch(heatfan){
                    case 0:heatcontrolfanbar1.color="#ffffff";break;
                    case 1:heatcontrolfanbar2.color="#ffffff";break;
                    case 2:heatcontrolfanbar3.color="#ffffff";break;
                    case -1:heatfan=0;break;

                    }

                }
            }
            Button {
                id: heatcontrolplusbutton
                x: 624
                y: 25
                width: 75
                height: 75
                opacity: 0


                onPressed:{

                    heatfan++;
                    switch(heatfan){
                    case 1:heatcontrolfanbar1.color="#ef7d25" ;break;
                    case 2:heatcontrolfanbar2.color="#ef7d25" ;break;
                    case 3:heatcontrolfanbar3.color="#ef7d25";break;
                    case 4:heatfan=3;break;
                    }
                }
            }
        }

    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
