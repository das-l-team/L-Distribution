'********************************************************************
'
' C-Control/BASIC       NET3.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Systemvoraussetzungen:
'
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - zweites Modem als Remote-IO (Modem-Bruecke offen,
'   Adressbruecken auf Adresse 2 gesetzt) an gleicher oder
'   angekoppelter Netzleitungsphase
'
' Schwerpunkte:
'
' - Netzwerkkonfiguration
' - Zugriff auf entfernte Ports ueber die Netzleitung
' - Wiederholung von Anweisungen bei Uebertragungsfehlern
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254
network self=100

' Definition eines entfernten Digitalports
define p1 port[1] at 2

' eine Variable
define x byte

' Modeminitialisierung
if not initmodem then end

'Falls Modem nicht initialisiert werden kann, wird Programm
'beendet

' Port setzen ohne Ruecksicht auf Uebertragungsfehler,
' bei gestoertem Netzzugriff wird die aktuelle BASIC-Zeile
' uebersprungen, der Endzustand von p (ON oder OFF)
' ist somit nicht vorhersehbar
for x = 1 to 10
  p1 = ON
  p1 = OFF
next
'Ohne RETRY versucht die C-Control Station bei Übertragungsfehlern
'den Befehl auszuführen. Danach läuft das Programm weiter.
'Mit RETRY wiederholt die C-Control Station solange den Befehl
'auszuführen bis er erfolgreich ausgeführt wurde.
'(vielleicht sogar unendlich lange)

' Port setzen mit Wiederholung der Anweisung bei
' Uebertragungsfehlern,
' Achtung: ggf. endlos, wenn Remote IO mit Adresse 2
' ueberhaupt nicht erreichbar ist!
for x = 1 to 10
  retry p1 = ON
  retry p1 = OFF
next

' das Schluesselwort RETRY kann vor jeder Basic-Anweisung mit
' Netzwerkzugriff stehen

