'********************************************************************
'
' C-Control/BASIC                               Haus1.bas
'
' Programmierer: B./C. Kluth
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Systemvoraussetzungen:
'
'
' Schwerpunkte:
'
' -
' -
'
'
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254
network self=100

' Definition der nahen Digitalports (einzeln)
define p1 port[1] at 100
define p2 port[2] at 100
define p3 port[3] at 100
define p4 port[4] at 100
define p5 port[5] at 100
define p6 port[6] at 100
define p7 port[7] at 100
define p8 port[8] at 100

' Definition der Analogports (Sensoren)
define sensor1 ad[1]
define sensor2 ad[2]

' als Byteport
define remoteio1 byteport[1] at 2
define remoteio2 byteport[2] at 3
define schalter byte[1]
define bitsensoren byte[2]
define sensor1_wert byte[3]
define sensor2_wert byte[3]

' Modeminitialisierung
if not initmodem then end

#loop
  ' Einmalige Abfrage der Schalter für den Garten/Licht/Garage/Rollos/Markise
  ' und somit auch nur ein Zugriff auf das Netzwerk
  schalter = remoteio1
  if (schalter and &B10000000) then p1 = ON else p1 = OFF
  ' usw.
  ' Einmalige Abfrage der Sensoren(Licht,Regen,Wind
  sensoren = remoteio2
  if (sensoren and &B10000000) then p2 = on else p2 = OFF
  ' usw.


goto loop
end




' Auswertung von nichtlinearen Sensorwerten über eine interne bzw. externe Tabelle

#Auswertung_Tab
  looktab Tab_Sensor1, (sensor1/31), sensor1_wert
  looktab Tab_Sensor2, sensor2, sensor2_wert
return

' Bei der Definition von Tabellen muß darauf geachtet werden, daß 
' sie erst nach dem end-Zeichen definiert werden.

'' Definition einer internen Tabelle
'table Tab_Sensor1                   'Diese Tabelle an das Programmende
'  3 10 7 -1234 789                  'kopiert, zwecks Kompatibilitaet
'  -32100 0 53                       'mit 'Lbit' Firmware: das |_ Team
'tabend

'' Definition einer externen Tabelle  'Diese Tabelle an das Programmende
'table Tab_Sensor2 "sensor2.tab"      'kopiert, zwecks Kompatibilitaet
                                      'mit 'Lbit' Firmware: das |_ Team



' Auswertung von linearen Sensorwerten

' Bei linearen Sensorwerten müssen die Werte nicht linearisiert werden
' und können somit sofort ausgewertet werden bzw. mit einer Konstanten
' multipliziert werden.

#Auswertung
  sensor1_wert = sensor1/31
  sensor2_wert = sensor2
return













' --- Definitionen --------------------------------------------------

  define x word
  define i byte

  define tab1_ende 9
  define tab2_ende 19

' --- Programmoperationen -------------------------------------------

'Programmtitel ausgeben
  print "C-Control/BASIC      009.BAS"
  print "============================"
  print

' Ausgabe der ersten Tabelle, i ist die Indexvariable,
' beachten Sie, dass der erste Tabelleneintrag den Index 0 hat

  for i = 0 to tab1_ende
    looktab tab1, i, x
    print "tab1["; i; "]="; x
  next

' Leerzeile
  print

  for i = 0 to tab2_ende
    looktab tab2, i, x
    print "tab2["; i; "]="; x
  next

' Leerzeile
  print

' der END-Befehl ist hier besonders wichtig, da die
' nachfolgenden Tabellendaten sonst vom Mikroprozessor
' wie Befehle abgearbeitet werden, was sicher zu einem
' Systemabsturz fuehrt

end

' Definition einer internen Tabelle

table tab1
  3 10 7 -1234 789
  -32100 0 53 90 -45
tabend

' Definition einer externen Tabelle
table tab2 "009demo.tab"

' Definition einer internen Tabelle
table Tab_Sensor1                   'Diese Tabelle an das Programmende
  3 10 7 -1234 789                  'kopiert, zwecks Kompatibilitaet
  -32100 0 53                       'mit 'Lbit' Firmware: das |_ Team
tabend
' Definition einer externen Tabelle  'Diese Tabelle an das Programmende
table Tab_Sensor2 "sensor2.tab"      'kopiert, zwecks Kompatibilitaet
                                     'mit 'Lbit' Firmware: das |_ Team