'********************************************************************
'
' C-Control/BASIC       Roll2.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Rolladensteuerung
'
' Systemvoraussetzungen:
'
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - zweites Modem als Remote-IO (Modem-Bruecke offen,
'   Adressbruecken auf Adresse 2 gesetzt)
' - angeschlossene DCF77-Antenne
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
define rolldown port[1] at 2
define rollup port[2] at 2

' Die Netzwerkadresse 2 muﬂ an der C-Control Remote-I/O seperat
' eingestellt werden.

' benoetigte Variablen
define hourdown byte
define hourup byte
define minutedown byte
define minuteup byte

' Modeminitialisierung
if not initmodem then end

' Initialisierung der Variablen
hourdown = 21
minutedown = 0
hourup = 6
minuteup = 0

#main
  wait second = 0
  if (hour = hourdown) and (minute = minutedown) then gosub Rollab
  if (hour = hourup) and (minute = minuteup) then gosub Rollauf
goto main

#Rollauf
  gosub LCD_loeschen
  put &H1B      'ESC Funktion
  put &H44      'D
  put 0         '¥Nummer des Festtextes von 0 bis 127
  rolldown = 0
  rollup = 1
return

#Rollab
  gosub LCD_loeschen
  put &H1B      'ESC Funktion
  put &H44      'D
  put 1         '¥Nummer des Festtextes von 0 bis 127
  rollup = 0
  rolldown = 1
return

#LCD_loeschen
  Put &H1B        'ESC Funktion
  Put &H26        '&
  Put &H23        '# (Steuerzeichen des LCD-Controllers)
return

end
