'********************************************************************
'
' C-Control/BASIC       NET1.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Systemvoraussetzungen:
'
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
'
' Schwerpunkte:
'
' - Netzwerkkonfiguration
' - Zugriff auf die 8 Digitalports des Power Line Modems
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254
network self=100

' Die Netzwerkadresse dient dazu, das Modem mit seiner C-Control
' Station im Netzwerk eindeutig zu identifizieren

' Definition der Digitalports (einzeln)
define p1 port[1] at 100
define p2 port[2] at 100
define p3 port[3] at 100
define p4 port[4] at 100
define p5 port[5] at 100
define p6 port[6] at 100
define p7 port[7] at 100
define p8 port[8] at 100

' als Byteport
define p byteport[1] at 100

' Die Definition der Digitalports als Bit- bzw. Byteport dient
' zum vereinfachten Auslesen bzw. Einstellen von einzelnen bzw.
' allen Ports.

' eine Variable
define x byte

' Modeminitialisierung,
' bei Fehler (kein Modem angeschlossen) Programmende
if not initmodem then end

' Ports schalten und lesen wie herkoemmlich
p1 = ON
p6 = OFF
p = &B10101010
x = p2
x = p
if p4 then goto xyz
'...

#xyz

' Berechnen und Verknuepfen von Ports wie herkoemmlich
p3 = p7 and p8
p6 = not p6
p = p + 1

' Deaktivieren wie herkoemmlich
deact p1
deact p

' die Befehle TOG und PULSE werden fuer Ports im
' Netzwerk nicht unterstuetzt!

