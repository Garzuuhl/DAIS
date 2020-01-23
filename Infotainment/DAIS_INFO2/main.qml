//Imports
import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.2
import QtLocation 5.12
import QtPositioning 5.6




// Make registered qmlmqttclient visible to qml
import MqttClient 1.0


ApplicationWindow {
    id: applicationWindow
    visible: true
    //Rahmenloses Fenster
    flags:  Qt.FramelessWindowHint
    width: 1080
    height: 1920
    color: "#ffffff"
    title: qsTr("Infotainment")






    //Daten des MQTT-Broker werden in dieser Klasse gespeichert. Eine Instanz  der Klasse ValueSource wird generiert
    ValueSource {
        id: valueSource
    }

    property var i:0;
    //#Musikspieler

    //Zur Überorüfung ob die Musik spielt oder nicht
    property var isPlayingMusic:false;
    //Songlänge in Minuten --> Konvertierung siehe hier : https://stackoverflow.com/questions/17624335/converting-milliseconds-to-minutes-and-seconds/49203864
    property int songDurationInMinutes:playmusic.duration/1000/60;
    //Songlänge in Sekunden
    property int songDurationInSeconds:(playmusic.duration/1000)%60;
    //Gesamtlänge des Songs
    property string songDuration:songDurationInMinutes+":"+songDurationInSeconds;
    //Momentane Länge des Songs in Minuten
    property int currentSongDurationInMinutes:playmusic.position/1000/60;
    //Momentane Länge des Songs in Sekunden
    property int currentSongDurationInSeconds:(playmusic.duration/1000)%60;
    //property string currentSongDuration:"0"+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;
    // Anzeige der momentanen Songlänge (links im Screen)
    property string currentSongDuration:"0:00";
    //songTitel
    property string songTitle:playmusic.metaData.title="Summer"

    //Songliste
    property var songList: ["music/bensound-summer.mp3","music/bensound-energy.mp3","music/bensound-tomorrow.mp3"]
    //Anzahl der Songs
    property int songCount:songList.length-1;
    // momentan gespielter Song
    property int curSong:0;
    //Songtitel
    property var songTitles: ["Summer","Energy","Tomorrow"]
    //Künstlername
    property var songArtist: ["BenSound","BenSound","BenSound"]
    property var isMainPlayButton:false
    //Mute/Unmute-Variable
    property var musictoggle:true

    //#Telefon
    //Maximale Anzahl an Stellen bei der Telefonnummer
    property int maxDigits:20
    //momentane Anzahl der Telefonnummerstellen
    property int curDigits:0
    //Counter für die Anrufanimation
    property int phonecallcounter:0;
    //Counter für die Länge des Anrufs (Sekunden)
    property int phonecalllengthcounter:0
    //#Navigation
    property int mapcounter:0
    //Länge und Breitengrad für die Navigation
    property var destinationlat:49.4472309
    property var destinationlon:7.7555738
    //Counter für das  Updaten der Routeninformation
    property var routeupdatecounter:0

    //#Heizungssteuerung
    // Sichtbarkeit für die Heizelemente (Bereich oben)
    property var heatdialog:true
    //Counter für die Lüftersteuerung
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
    //Hostname
    TextField {
        id: hostnameField
        text: "localhost"
        placeholderText: "<hostname>"
        visible: false
    }
    //Port , default ist 1883 für MQTT
    TextField {
        id: portField
        text: "1883"
        visible: false
    }
    //Benutzername
    TextField {
        id: usernameField
        text: ""
        placeholderText: "<username>"
        enabled: mqttclient.state !== MqttClient.Connected
        visible: false
    }
    //Passwort
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

    //Musik
    //Beinhaltet die eigentliche Musik im MP3-Format
    //Music von  © Bensound https://www.bensound.com/ , Lizenzinformation : https://www.bensound.com/licensing#tab
    Audio{
        id:playmusic
        source :"music/bensound-summer.mp3"

    }

    //Startet die Musik
    function startMusic()
    {

        //Spielt einen Song ab
        playmusic.play();
        //Startet die Aktualisierung der Musikanzeige
        songTimer.start();
        //Die Icons der Buttons werden  zu Stop-Icons getauscht , momentaner Zustand : Song wird gespielt
        imagePlayButton.source ="background/stop.png";
        miniplayButton.source  ="background/stop.png";


    }

    //Stoppt die Musik
    function stopMusic()
    {
        //Pausieren der Musik
        playmusic.pause()
        //Aktualisierung der Musikanzeige wird gestoppt
        songTimer.stop();
        //Die Icons der Buttons werden  zu Play-Icons getauscht , momentaner Zustand : Song ist gestoppt
        imagePlayButton.source = "background/play.svg";
        miniplayButton.source="background/play.svg";

    }

    function getLocationFromName(name)
    {

        //Quellen zur Funktionsimplementierung:
        //->https://forum.qt.io/topic/5626/parsing-json-with-qml/6
        //->https://stackoverflow.com/questions/35040737/parse-json-to-listview-in-qml



        //Nominatim API Doku
        //->https://nominatim.org/release-docs/develop/api/Overview/

        // API Call an die Nominatim-API
        var url ='https://nominatim.openstreetmap.org/search?q='+name+'&format=json&limit=1'
        //Eine XMLHttpRequest wird erzeugt.
        var doc= new XMLHttpRequest()
        //console.debug("test")

        //Wartet auf Response
        doc.onreadystatechange=function()  {

            if(doc.readyState == 4 && doc.status == 200)
            {
                console.debug("fertig");

                //JSON Object zum Testen
                //var json= '[{"place_id":17011844,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"node","osm_id":1674026139,"boundingbox":["48.6184485","48.9384485","9.0200132","9.3400132"],"lat":"48.7784485","lon":"9.1800132","display_name":"Stuttgart, Baden-Württemberg, 70173, Germany","class":"place","type":"city","importance":0.7964347124043025,"icon":"https://nominatim.openstreetmap.org/images/mapicons/poi_place_city.p.20.png"}]';

                // JSON-Object wird geparst. Eckige Klammern sind nötig um auf das erste Element zugreifen zu können!
                var json = JSON.parse('['+doc.responseText+']');
                //Das erste Element aus dem JSON-Objekt wird herausgefiltert. Das erste Object wurde genommen, da es den wahrscheinlichsten Treffer darstellt.
                var jsonArray = json[0];
                //Durchsuchen des Objects
                for (var key = 0; key < jsonArray.length; key++) {
                    var value = jsonArray[key];
                    //Extrahieren der Längen und Breitengrade vom Array
                    console.debug(value.lat, value.lon);
                    //Längen und Breitengrad des Ziels werden übernommen.
                    destinationlat=value.lat;
                    destinationlon=value.lon;
                    //Testanzeige
                    //albumName.text=destinationlat+ "    "+destinationlon;
                }
            }
        }


        //GET-Request wird an die API gestellt
        doc.open('GET',url,true)
        doc.send()


    }



    //Zeichnet die Route zwischen zwei Punkten(in Längen und Breitengrad)


    function drawMap(){

        //Löscht alle Wegpunkte
        aquery.clearWaypoints();
        //Löscht die alte Route
        routeModel.reset();
        //Fügt den Anfangspunkt hinzu
        aquery.addWaypoint(QtPositioning.coordinate(valueSource.latitude,valueSource.longitude));
        //Fügt das Ziel hinzu destinationlat und destinationlon wurden aus der getLocationFromName()- Methode erhalten
        aquery.addWaypoint(QtPositioning.coordinate(destinationlat,destinationlon));
        //Anzeigen der neuen Route
        routeModel.update();
        drawmaptimer.start();
    }




    //Globaler Header
    header: Item {
        // Drückt man auf die MouseArea wird das Hauptmenü geöffnet
        MouseArea{
            x:0
            y:0
            width:100
            height:100
            visible: true
            onPressed:{
                if(!mainmenu.visible)
                {mainmenu.visible = true;}
                else if(mainmenu.visible)
                {
                    mainmenu.visible = false;
                }
            }




            //linke Schaltfläche im Header , öffnet das Hauptmenü
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






                //Uhrzeit
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




                //Wifianzeige (Platzhalter), nicht umsetzbar seitens des Simulators (schwer messbar)
                Image {
                    id: wifiimage
                    x: 750
                    y: 0
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "background/wifi.svg"


                }

                //Telefonnetzanzeige (Platzhalter), nicht umsetzbar seitens des Simulators
                Image {
                    id: signalimage
                    x: 860
                    y: 0
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "background/signal.svg"
                }
                //Akkuanzeige   (Platzhalter), nicht umsetzbar seitens des Simulators
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

        }


    }
    //Hauptanzeige , SwipeView zum Anzeigen des Hauptinhalts, Steuerung durch Wischgeste

    SwipeView {
        //horizontales Layout
        orientation: Qt.Horizontal
        id: swipeView
        visible: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        //Musikspieler
        Page1Form {

            //Icon um den Song abzuspielen
            Image {
                id: imagePlayButton
                x: 440
                y: 1300
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                source: "background/play.svg"
            }

            //Icon um den letzten Song abzuspielen
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
            //Icon um den nächsten Song abzuspielen
            Image {
                id: imagenextSongButton
                x: 740
                y: 1300
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                source: "background/step-forward.svg"
            }


            //Implementierung der Interaktion mit dem Play-Button

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




            //Implementierung der Interaktion mit dem NextSong-Button
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

            //Implementierung der Interaktion mit dem LastSong-Button
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

            //Soll ursprünglich die Art des Mediums anzeigen: USB, Streaming usw...
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
            //momentane Stelle im Song
            Label {
                id: currentSongTime
                x: 34
                y: 1031
                width: 136
                height: 80
                text: currentSongDuration
                font.pointSize: 50
            }
            //Name des Albums
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
            //Name des Songs
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
            //Gesamtlänge des Songs
            Label {
                id: fullSongTime
                x: 904
                y: 1031
                width: 158
                height: 80
                text: songDuration
                font.pointSize: 50
            }
            //Simuliert den Fortschritt im Song
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
            //Umrandung für den Musikfortschritt
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
            //Zeigt den momentanen Fortschritt an , die property width wird hier benutzt um den Fortschritt zu simulieren
            Rectangle {
                id: progressbarRect
                x: 234
                y: 1047
                width: 0
                height: 49
                color: "#ef7d25"
                radius: 0
                border.width: 0
            }



            //Öffnet eine Musikliste aus der man auswählen kann
            Button{
                id:musicfolderbutton
                x: 974
                y: 753
                width: 200
                height: 200
                opacity:0
                onPressed: {  if(musicliste.visible==true)musicliste.visible=false; else if (musicliste.visible==false) musicliste.visible=true  ;   }

            }



            //Zeigt die Songliste an
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



            //Benutzt die Klasse MP3Model zum Darstellen der Inhalte
            // Das Beispiel der QML-Doku (https://doc.qt.io/qt-5/qml-qtquick-listview.html) wurde verwendet und angepasst
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
        //Telefon
        Page2Form {
            id: page2Form
            visible: true


            //Telefonnummer
            Label{
                id:phoneNumber
                text:""
                x:190
                y:160

                font.pointSize:40
            }

            //Taste 1
            Button {
                x: 124
                y: 281
                width: 200
                height: 200
                visible: true

                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"1";curDigits++}}
            }
            //Taste 2
            Button {
                x: 440
                y: 281
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"2";curDigits++}}
            }

            //Taste 3
            Button {
                x: 756
                y: 281
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"3";curDigits++}}

            }


            //Taste 4
            Button {
                x: 124
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"4";curDigits++}}

            }

            //Taste 5
            Button {
                x: 440
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"5";curDigits++}}

            }

            //Taste 6
            Button {
                x: 756
                y: 550
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"6";curDigits++}}
            }

            //Taste 7
            Button {
                x: 124
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"7";curDigits++}}

            }

            //Taste 8
            Button {
                x: 440
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"8";curDigits++}}

            }

            //Taste 9
            Button {
                x: 756
                y: 814
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"9";curDigits++}}

            }

            //Taste 0
            Button {
                x: 124
                y: 1111
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {if(curDigits<maxDigits){phoneNumber.text=phoneNumber.text+"0";curDigits++}}

            }

            //Telefonhörer
            Button {
                x: 440
                y: 1111
                width: 200
                height: 200
                visible: true
                opacity: 0
                onPressed: {phonecalltab.visible=true; call.text="Rufe Dieter Wallach an       "+phoneNumber.text ; phonecalltimer.start(); phonecallcounter=0; phonecalllengthcounter=0;}


            }

            // Updatet die Gesprächszeit und zeigt die Anrufanimation

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






            //Zeigt den Inhalt der Simulation an , wenn angerufen wird
            Rectangle{
                id:phonecalltab
                visible: false
                height: 1880
                width:1080

                //Zeigt die Nummer an , die angerufen wird.
                Label{id:call
                    x:100
                    y:100
                    text:qsTr("Rufe  "+phoneNumber.text+ " an")
                    font.pointSize:40


                }

                //Erster Kreis
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
                //Zweiter Kreis
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

                //Dritter Kreis
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


                //Telefonicon
                Image{id:phoneright
                    x:750
                    y:300
                    width:100
                    height:100
                    source:"background/phone.svg"
                }

                //Zeigt die Länge des Gesprächs an
                Label{
                    id:phonecalllength
                    x:450
                    y:200
                    font.pointSize:40
                    color:"#ef7d25"
                    text:"00:0"+phonecalllengthcounter


                }





            }

            //Löscht die Nummer (damit man eine neue Nummer  eingeben kann)
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
        //Autoeinstellungen
        Page3Form {
            //Autoinformationen
            visible: true
            //Reifendruck vorne links
            Label {
                id: pressurefrontleft
                x: 200
                y: 368
                font.pointSize: 40
                text: valueSource.tirePressureFrontLeft
            }
            //Reifendruck vorne rechts
            Label {
                id: pressurefrontright
                x: 800
                y: 368
                font.pointSize: 40
                text:valueSource.tirePressureFrontRight
            }
            //Reifendruck hinten links
            Label {
                id: pressurebackleft
                x: 200
                y: 950
                font.pointSize: 40
                text:valueSource.tirePressureBackLeft
            }
            //Reifendruck hinten rechts
            Label {
                id: pressurebackright
                x: 800
                y: 950
                font.pointSize: 40
                text: valueSource.tirePressureBackRight
            }


            //Kilometerstand
            Label {
                id: kilometer
                x: 100
                y: 1350
                font.pointSize: 30
                text:"Kilometerstand: "+(Math.round(valueSource.distance * 100) / 100) +" km"
            }

            //Geschwindigkeit, zum primären testen ob die MQTT-Implementierung funktioniert
            Label {
                id:strecke
                x: 100
                y: 1450
                font.pointSize: 30
                text:"Geschwindigkeit  "+Math.round(valueSource.kph) + "  km/ h"
            }



        }

        Page4Form {
//Karte und Navigation
            //Timer, der die Route updatet , teilweise buggy
            Timer{
                id:drawmaptimer
                interval:200
                running:false
                repeat:false
                triggeredOnStart:false
                onTriggered:{
                    routeModel.update();
                    routeupdatecounter++;
                    if(routeupdatecounter==5){routeupdatecounter=0; drawmaptimer.stop() ;};


                }
            }

//Zeigt die Karte an
            Map {


                Label {x:0;y:1800; width: 50;height:10; font.pointSize: 10;id:licenceinfo ; text:"Karte hergestellt aus OpenStreetMap-Daten | Lizenz: Open Database License (ODbL)" ;}


//Zeigt den aktuellen Standort anhand eines Kreises
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




//Auswahl an vordefinierten Zielorten selbes Konzept wie beim MP3Model
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












//Eigentlich war gedacht, dass man einen Begriff eingibt und die Nominatim-API den Namen in eine Geoposition umwandelt.
//Die API und Funktion getLocationFromName() funktioniert auch im Debug. Bei der Releaseversion gab es jedoch einige Probleme mit den OpenSSL-Bibliotheken
//Da ein HTTPS-Request versendet werden muss. Nominatim leitet einfache HTTP-Requests an ihre HTTPS-Seite weiter. QT benötigt OpenSSL-Bibliotheken  dafür.
//Quellen : https://www.youtube.com/watch?v=2u5wnrx6J-E
//https://doc.qt.io/qt-5/qml-qtlocation-maproute.html
//https://stackoverflow.com/questions/49943303/display-multiple-routes-on-a-map-using-routemap-qml-qt


                TextField{x:0;
                    y:100;
                    width:200;
                    height:100;
                    visible: false
                    id:suchleiste
                    onPressed: {}
                }

                // Route wird mit vordefinierten Orten berechnet. Gedacht war durch die Nominatim-API freie Orte zu wählen...

                Button{
                    id:suchbutton
                    x:980;
                    y:100;
                    width:100;
                    height:100;
                    text:"Route starten"

                    onClicked:  {
                        // getLocationFromName("'"+suchleiste.text+"'");
                        drawMap();
                    }

                }

                id: map
                anchors.fill: parent

                center: QtPositioning.coordinate(valueSource.latitude, valueSource.longitude)
                //Openstreetmap-API-Begrenzung
                zoomLevel: 17
                minimumZoomLevel: 10
                maximumZoomLevel: 17

                //Das Plugin "osm" wird benutzt (Openstreetmap-Karten, https://www.openstreetmap.de/)
                //Liste aller Tileserver : https://wiki.openstreetmap.org/wiki/Tile_servers

                plugin: Plugin
                {id:aPlugin
                    name: "osm"

                    PluginParameter
                    {
                        //Es wird ein Custom-Tileserver benutzt.
                        name: "osm.mapping.custom.host"
                        value:  "http://a.tile.openstreetmap.fr/hot/"
                    }

                }




//Beinhaltet die Routeninformationen (Routenquery wird anhand der OSM-Daten berechnet)

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

                    //Grafische Umsetzung der Routendaten
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

//Impressum
        Page5Form {
            visible: true

            //Überschrift
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

    //Timers

    //Aktualisiert die Uhrzeit
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
    //Musiktimer
    Timer{
        id: songTimer
        interval: 500
        repeat: true
        running: false

        onTriggered:
        {
            //Berechnung der momentanen Songlänge
            currentSongDurationInMinutes=playmusic.position/1000/60;
            currentSongDurationInSeconds=(playmusic.position/1000)%60;



            //Passt die Anzeige der Songlänge an
            if(currentSongDurationInMinutes>=10&&currentSongDurationInSeconds>=10)
                currentSongDuration=""+currentSongDurationInMinutes+":"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes<10&&currentSongDurationInSeconds>=10)
                currentSongDuration=""+currentSongDurationInMinutes+":"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes>=10&&currentSongDurationInSeconds<10)
                currentSongDuration=""+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;
            if(currentSongDurationInMinutes<10&&currentSongDurationInSeconds<10)
                currentSongDuration=""+currentSongDurationInMinutes+":0"+currentSongDurationInSeconds;
            //Zeigt die Songlänge anhand eines skalierbaren Balkens an
            progressbarRect.width=(playmusic.position/playmusic.duration)*600
        }

    }


    Rectangle {
        id: mainmenu
        x: 0
        y: 0
        width: 1080
        height: 1920
        color: "#888483"
        visible: false


//Fahrzeuginformationen
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
                onClicked: {mainmenu.visible=false;swipeView.currentIndex = swipeView.currentIndex=2}
            }
        }
//Kartenicon
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
                onClicked:{mainmenu.visible=false;swipeView.currentIndex = swipeView.currentIndex=3}
            }
        }
//Musikicon
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
                onClicked:{mainmenu.visible=false;swipeView.currentIndex = swipeView.currentIndex=0}
            }
        }
//Telefonicon
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
                onClicked:{mainmenu.visible=false;swipeView.currentIndex = swipeView.currentIndex=1 }
            }
        }
//Impressum (Zahnradicon)
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
                onClicked:{mainmenu.visible=false; swipeView.currentIndex = swipeView.currentIndex=4}
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



//Pfeil nach oben um das Hauptmenü schließen zu können
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
                onPressed: {mainmenu.visible=false;}

            }
        }



    }



//Footer

    Item{ id:footer; x:0;y:1820
//Minimusikbuttons
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

//Lautstärkeanzeige zum muten (Lautsprecher)
            Image{
                id: volumeimage
                x: 123
                y: 0
                width: 100
                height: 100
                source: "background/volume-up.svg"
                fillMode: Image.PreserveAspectFit
            }


//Muted den Song , drückt man nochmals drauf gelangt man wieder zu 50% der Lautstärke als Standardwert
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





// Lautstärkeregelung

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
// Zeigt die Lautstärke in Form eines Balkens an
            Rectangle{
                id:musicVolumeRectangle
                color:"#ef7d25"
                x: 259
                y:  30;
                width:200
                height: 40;
            }

            Image {
                id: stepforwardicon
                x: 850
                y: 0
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                source: "background/step-forward.svg"

            }
            //Nächster Song wird gewählt
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

                    curSong++;
                    if(curSong>songCount){curSong=0;playmusic.source=songList[curSong];songName.text=songTitles[curSong] ;startMusic()}
                    if(curSong<=songCount) {playmusic.source=songList[curSong];songName.text=songTitles[curSong];startMusic()}


                }

            }

            Image {
                id: stepbackwardicon
                x: 550
                y: 0
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                source: "background/step-backward.svg"

            }
            //der vorherige Song wird gespielt
            Button {
                id: miniplaybackButton
                x: 550
                y: 0
                width: 100
                height: 100
                text: "Button"
                visible: true
                opacity: 0

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


            //Rechter Pfeil im Footer
            Image {
                id: anglerighticon
                x: 980
                y: 0
                width: 100
                height: 100
                rotation: 180
                fillMode: Image.PreserveAspectFit
                source: "background/angle-left.svg"
            }

            //Linker Pfeil im Footer
            Image{
                id: anglelefticon
                x: 0
                y: 0
                width: 100
                height: 100
                source: "background/angle-left.svg"
                fillMode: Image.PreserveAspectFit

            }

            //Interaktion des linken Pfeils
            Button {
                id: angeleftbutton
                width: 100
                height: 100

                opacity: 0
                onPressed: {musiccontrol.visible=false;heatcontrol.visible=true;}
            }

            //Interaktion des rechten Pfeils
            Button {
                id: anglerightbutton
                x: 980
                y: 0
                width: 104
                height: 100

                opacity: 0
                onPressed: {musiccontrol.visible=false;heatcontrol.visible=true;}
            }

        }

//Steuerung der Heizung
        Item{

            id: heatcontrol
            width: 1080
            height: 100
            z: 0
            visible: false

            //Zeigt den Bereich der Heizungssteuerung an
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

           //Rechter Pfeil im Footer
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

            //Linker Pfeil im Footer
            Image {
                id: heatcontrolarrowleft
                x: 0
                y: 0
                width: 100
                height: 100
                source: "background/angle-left.svg"
                fillMode: Image.PreserveAspectFit
            }

             //Interaktion des rechten Pfeils
            Button {
                id: heatcontrolleftbutton
                width: 100
                height: 100
                text: qsTr("Button")
                opacity: 0
                onPressed: {heatcontrol.visible=false; musiccontrol.visible=true}
            }

             //Interaktion des linken Pfeils
            Button {
                id: heatcontrolrightbutton
                x: 980
                y: 0
                width: 100
                height: 100
                opacity: 0
                onPressed: {heatcontrol.visible=false; musiccontrol.visible=true}

            }

 // Zeigt die linke Sitzheizung an
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

// Lüftericon
            Image {
                id: heatcontrolfan
                x: 515
                y: 25
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                source: "background/ventilating-fan.svg"
            }


// Zeigt die rechte Sitzheizung an
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
// Zeigt die Leiste unter der linken Sitzheizung an
            Rectangle {
                id: heatcontrolleftseatbar
                x: 245
                y: 85
                width: 100
                height: 15
                color: "#ef7d25"
            }

 // Zeigt die Leiste unter der rechten Sitzheizung an
            Rectangle {
                id: heatcontrolrightseatbar
                x: 735
                y: 85
                width: 100
                height: 15
                color: "#ef7d25"
            }

// Zeigt den Pfeil an um die Heizungssteuerung zu erweitern
            Image {
                id: heatcontrollarrowup
                x:490
                y:0
                width:  100
                height: 25
                fillMode: Image.PreserveAspectFit
                source: "background/angle-up.svg"
            }
//Plusicon
            Image {
                id: heatcontrolplusimage
                x: 624
                y: 25
                width: 75
                height: 75
                fillMode: Image.PreserveAspectFit
                source: "background/plus.svg"
            }
//Minusicon
            Image {
                id: heatcontrolminusimage
                x: 381
                y: 25
                width: 75
                height: 75
                fillMode: Image.PreserveAspectFit
                source: "background/minus.svg"
            }

//linke Temperaturanzeige
            Label {
                id: temperaturleft
                color:"#ef7d25"
                x: 100
                y: 20
                width: 75
                height: 75
                text:Math.round(valueSource.temp*10)/10+"°"
                font.pointSize: 40
            }
//rechte Temperaturanzeige
            Label {
                id: temperaturright
                color:"#ef7d25"
                x: 850
                y: 20
                width: 75
                height: 75
                text:Math.round(valueSource.temp*10)/10+"°"
                font.pointSize: 40
            }
//Interaktion des Pfeils um die Heizungssteuerung zu erweitern
            Button {
                id: heatcontrolarrowupbutton
                x: 515
                width: 50
                height: 25
                text: qsTr("Button")
                opacity: 0
                onPressed: {if(heatdialog){heatcontrollarrowuprectangle.visible=true;heatdialog=false; } else {heatcontrollarrowuprectangle.visible=false;heatdialog=true} }
            }
//Erweitere Heizsteuerung
            Rectangle {
                id: heatcontrollarrowuprectangle
                x: 0
                y: -300
                width: 1080
                height: 300
                visible: false
                color: "#000000"
//Frontscheibenheizung
                Image{
                    id:heatcontrollarrowupfrontdefrost
                    x:490
                    y:0
                    width:100
                    height:50
                    source:"background/windshield-defrost.svg"
                    fillMode: Image.PreserveAspectFit
                }
//Frontscheibenheizung aktivieren/deaktivieren
                Button{
                    id:heatcontrollarrowupfrontdefrostbutton
                    x:490
                    y:0
                    opacity: 0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupfronstdefrostbar.visible){heatcontrollarrowupfronstdefrostbar.visible=false}else if (!heatcontrollarrowupfronstdefrostbar.visible){heatcontrollarrowupfronstdefrostbar.visible=true;}}
                }
//Leiste unter der Frontscheibenheizung
                Image{
                    id:heatcontrollarrowupfronstdefrostbar
                    x:490
                    y:60
                    width:100
                    height:30
                    visible: false
                    source:"background/minus.svg"
                    fillMode: Image.PreserveAspectFit
                }
//Heckscheibenheizung
                Image{
                    id:heatcontrollarrowupbackdefrost
                    x:490
                    y:100
                    width:100
                    height:50
                    source:"background/rear-window-defrost.svg"
                    fillMode: Image.PreserveAspectFit
                }
//Heckscheibenheizung  aktivieren /deaktivieren
                Button{
                    id:heatcontrollarrowupbackdefrostbutton
                    x:490
                    y:100
                    opacity: 0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupbackdefrostbar.visible){heatcontrollarrowupbackdefrostbar.visible=false}else if (!heatcontrollarrowupbackdefrostbar.visible){heatcontrollarrowupbackdefrostbar.visible=true;}}
                }
//Leiste unter der Heckscheibenheizung
                Image{
                    id:heatcontrollarrowupbackdefrostbar
                    x:490
                    y:160
                    width:100
                    height:30
                    visible: false
                    source:"background/minus.svg"
                    fillMode: Image.PreserveAspectFit

                }
//Raumlüftung
                Image{
                    id:heatcontrollarrowupcoolingcaricon
                    x:490
                    y:200
                    width:100
                    height:50
                    source:"background/recirculation.svg"
                    fillMode: Image.PreserveAspectFit

                }
//Raumlüftung aktivieren/deaktivieren
                Button{
                    id:heatcontrollarrowupcoolingcarbutton
                    x:490
                    y:200
                    opacity:0
                    width:100
                    height:50
                    onPressed: { if(heatcontrollarrowupcoolingcariconbar.visible){heatcontrollarrowupcoolingcariconbar.visible=false}else if (!heatcontrollarrowupcoolingcariconbar.visible){heatcontrollarrowupcoolingcariconbar.visible=true;}}
                }
//Leiste unter der Raumlüftung
                Image{
                    id:heatcontrollarrowupcoolingcariconbar
                    x:490
                    y:260
                    visible: false
                    width:100
                    height:30
                    source:"background/minus.svg"
                    fillMode: Image.PreserveAspectFit
                }
            }
//Anzeige der Lüftersteuerung , Segment 1
            Rectangle {
                id: heatcontrolfanbar1
                x: 490
                y: 75
                width: 33
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }
//Anzeige der Lüftersteuerung , Segment 2
            Rectangle {
                id: heatcontrolfanbar2
                x: 523
                y: 75
                width: 33
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }
//Anzeige der Lüftersteuerung , Segment 3
            Rectangle {
                id: heatcontrolfanbar3
                x: 556
                y: 75
                width: 34
                height: 25
                color: "#ffffff"
                border.color: "#ffffff"
            }
//Interaktion mit der Minustaste
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

//Interaktion mit der Plustaste
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

//Schnelles Beenden der Applikation
    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

}


