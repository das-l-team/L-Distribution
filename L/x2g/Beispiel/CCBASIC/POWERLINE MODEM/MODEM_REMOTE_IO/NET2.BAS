'********************************************************************
'
' C-Control/BASIC       NET2.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Systemvoraussetzungen:
'
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - zweites Modem als Remote-IO (Modem-Bruecke offen,
'   Adressbruecken auf Adresse 2 gesetzt)
'
' Schwerpunkte:
'
' - Netzwerkkonfiguration
' - Zugriff auf entfernte Ports ueber die Netzleitung
' - Uebertragungsfehler werden ignoriert
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254
network self=100

' Definition der entfernten Digitalports (einzeln)
define p1 port[1] at 2  '2 ist die Netzwerkadresse der C-Control 
define p2 port[2] at 2  ' Remote I/O
define p3 port[3] at 2
define p4 port[4] at 2
define p5 port[5] at 2
define p6 port[6] at 2
define p7 port[7] at 2
define p8 port[8] at 2

' als Byteport
define p byteport[1] at 2

' Die Netzwerkadresse 2 muﬂ an der C-Control Remote-I/O seperat
' eingestellt werden.

' weiter z.B. wie in NET1.BAS
' ...
