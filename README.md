# DAIS - Dashboard and Infotainment System
<dl><b>DAIS</b> ist ein aufeinander abgestimmtes Dashboard- und Infotainmentsystem welches Daten von einem MQTT-Bus-System bezieht. Dieses Bus-System bezieht seine Daten wiederum von der <a href="https://www.hs-kl.de/">Hochschule Kaiserslautern (Standort Zweibrücken)</a> entwickelten Fahrsimulatoren.</dl>  
<dl>Die Inhalte in den Kapiteln <a href="#FUNC">Grundfunktionalitäten</a> und<a href="#Z_FUNC">Zusätzliche Funktionalitäten</a> nehmen Bezug auf die im <a href="https://github.com/Garzuuhl/DAIS/blob/master/Konzeptpapier/Konzeptpapier_Gruppe7.pdf">Konzeptpapier</a> festgelegten Stichpunkte.</dl>  
<dl>Die tatsächlich umgesetzten Funktionalitäten werden im Kapitel <a href="#IMPL_FUNC">Implementierte Funktionalitäten</a> behandelt.</dl>  
<dl>Die <b>ausführbare Datei (.exe-Datei)</b> für das <b>Dashboard</b> befinden sich in einem <a href="https://github.com/Garzuuhl/DAIS/tree/master/Dashboard">.zip-Archiv</a>(Nach dem Entpacken des Archivs zu finden unter "release" &rarr; "Dashboard.exe")</dl>  
<dl>Die <b>ausführbare Datei (.exe-Datei)</b> für das <b>Infotainment</b> befindet sich im Verzeichnis <a href="https://github.com/Garzuuhl/DAIS/tree/master/Infotainment/Infotainment_Release/release">Infotainment_Release &rarr; release</a> und heißt <b>DAIS_INFO2.exe</b>.</dl>

# Inhalt  

1. [Grundfunktionalität](#FUNC)
   * [Dashboard](#Dashboard_FUNC)
   * [Infotainment](#Infotainment_FUNC)
2. [Zusätzliche Funktionalitäten](#Z_FUNC)
   * [Dashboard](#Dashboard_Z_FUNC)
   * [Infotainment](#Infotainment_Z_FUNC)  
3. [Implementierte Funktionalitäten](#IMPL_FUNC)  
   * [Dashboard](#Dashboard_IMPL_FUNC)  
   * [Infotainment](#Infotainment_IMPL_FUNC)  
4. [ToDo´s](#ToDo)  
   * [Dashboard](#Dashboard_ToDo)  
   * [Infotainment](#Infotainment_ToDo)
5. [Verwendete Technologie und Frameworks](#TechnoFrame)
6. [Projektteam](#TEAM)  
  
<a name="FUNC"/>  

# Grundfunktionalität  
<a name ="Dashboard_FUNC"/>  

## Dashboard  
* Tacho/Drehzahlmesser  
* Aktueller Gang  
* Blinker  
* Warnleuchten  
  * Kontrollleuchte  
  * Gurte  
  * Türen etc. geöffnet
* Lichter  
  * Abblendlicht
  * Fernlicht
  * Nebelschlussleuchte  
* Fahrzeugdaten  
  * Verbrauch   
* Gesamt-/Tageskilometer  
* Tankfüllung & Reichweite  
* Temperaturen (Öl/Außen)  
* Uhrzeit & Datum
<a name="Infotainment_FUNC"/>  

## Infotainment  
* Musik  
  * USB  
  * Streaming  
  * Radio
* Autoeinstellungen  
* Klimasteuerung  
* Telefon  
<a name ="Z_FUNC"/>  

# Zusätzliche Funktionalitäten
<dl>Anpassbarkeit der Materialien, wie z.B. verschiedene Styles oder ein Dark-/Lightmode, der das Aussehen des DAIS aufgrund der äußeren Lichtbedingungen verändert.</dl>  
<a name="Dashboard_Z_FUNC"/>  

## Dashboard  
* Bedienung des Autos
* Navigation  
* Medienanzeige  
<a name="Infotainment_Z_FUNC"/>  

## Infotainment  
* Fahrtenbuch  
* Browser  
* Navigation  
* Kalender  
  * (Synchronisation über das Smartphone)  
<a name="IMPL_FUNC"/>  

# Implementierte Funktionalitäten  
<dl>In den folgenden Unterkapiteln werden stichpunktartig alle implementierten Funktionalitäten aufgelistet. Eine ausführlichere Beschreibung finden Sie in der <a href="https://github.com/Garzuuhl/DAIS/tree/master/Dokumentation">Dokumentation</a> des Projektes.</dl>
<a name="Dashboard_IMPL_FUNC"/>  

## Dashboard  
* Tacho/Drehzahlmesser
* Aktueller Gang  
* Blinker  
* Warnleuchte  
  * Kontrollleuchte  
* Lichter  
  * Abblendlicht  
  * Fernlicht  
  * Nebelschlussleuchte 
* Fahrzeugdaten  
  * Verbrauch 
* Gesamt-/Tageskilometer  
* Tankfüllung & Reichweite  
* Temperatur (Öl/Außen)  
* Uhrzeit  
* Medienanzeige  
<a name="Infotainment_IMPL_FUNC"/>  

## Infotainment  
* Musik ([Nur durch lokale Musikstücke im Ordner "music"](https://github.com/Garzuuhl/DAIS/tree/master/Infotainment/DAIS_INFO2/music))  
* Autoeinstellungen  
* Klimasteuerung 
* Telefon (Nur eine Eingabe durch ein Tastenfeld und anschließende Ausführung eines simulierten Anrufs)  
* Navigation  
<a name ="ToDo"/>  

# ToDo´s  
<dl>Es folgen nun zwei (jeweils eine für das Dashboard und das Infotainment System) ToDo Listen. Diese Listen enthalten Inhalte aus dem Kapitel <a href="#Z_FUNC">Zusätzliche Funtionalitäten</a> und <a href="#FUNC">Grundfunktionalitäten</a>. Dass heißt es werden Punkte genannt, die entweder in der vorgegebenen Zeit nicht umgesetzt werden konnten, oder die nicht als Grundfunktionalitäten festgelegt wurden.</dl>  
<a name="Dashboard_ToDo"/>  

## Dashboard  
* Datumsanzeige  
* Warnleuchte zum Anzeigen von geöffneten Türen, etc.  
* Navigation  
* Bedienung des Autos  
<a name ="Infotainment_ToDo"/>  

## Infotainment  
* Mehrere Szenarien im Telefon Screen. Zum Beispiel: Kontakt- und Favoritenliste  
* Mehrere Szenarien im Music Player Screen. Zum Beispiel: Einbindung einer Musik Streaming oder (Web)Radio Schnittstelle  
* Fahrtenbuch  
* Browser  
* Kalender (inkl. Synchronisation durch das Smartphone)  
<a name="TechnoFrame"/>  

# Verwendete Technologie und Frameworks  
<dl>Das DAIS wurde mithilfe von qml in der IDE Qt Creator umgesetzt. Die Wahl fiel auf qml, da die erstellten Anwendungen auf jede Plattform portiert werden können. Ein weiteres Argument, dass für die Entwicklung mit qml sprach war, dass es bereits ein <a href="https://github.com/Garzuuhl/DAIS/tree/master/Seafile/dashboard-examples/tesla_dashboard_mqtt">Anbindungsszenario</a> mit dem Bus-System von MQTT gab.</dl>  
<dl>Außerdem wurde das Plugin "osm", dass Karten Daten von <a href="https://www.openstreetmap.de/">OpenStreetMap</a> überträgt im Infotainment System genutzt.</dl>  
<a name="TEAM"/>  

# Projektteam  
## Dashboard  
<dl><a href="https://github.com/Garzuuhl">Philipp Zimmermann</a></dl>  
<dl><a href="https://github.com/JulianFre">Julian Frenzel</a></dl>  

## Infotainment  
<dl><a href="https://github.com/MarcoMN">Marco Miles Noll</a></dl>  
<dl><a href="https://github.com/Anker13">Jens Cedric Schug</a></dl>
