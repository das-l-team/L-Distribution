'********************************************************************
'
' C-Control/BASIC       NET4.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO
'
' Systemvoraussetzungen:
'
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - zweites C-Control System mit Modem an gleicher oder
'   angekoppelter Netzleitungsphase
'
' Schwerpunkte:
'
' - Netzwerkkonfiguration
' - Versenden von Mail-Kommandos
'
' Empfang von Mail-Kommandos siehe NET5.BAS
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254
network self=100

' Netzwerkadresse eines anderen C-Control-Modem-Systems
define RECEIVER 101

' Definition von Kommando-IDs (Werte beliebig 11...255), z.B.:
define COMMAND_A 12
define COMMAND_B 33
define COMMAND_C 57
define COMMAND_D 123

'Die Kommando-IDs dienen zur einfachern Handhabung von Befehlen
'im Netzwerk bei der Programmierung, da man sich besser eine
'Kommando-ID z.B. "Licht_an" als "12" merken kann.

' Definition einiger interessanter Ports
define a1 ad[1]
define a2 ad[2]
define a3 ad[3]
define a4 ad[4]
define t1 ad[5]       ' Temperatursensoren bei der C-Control Station
define t2 ad[6]
define p byteport[1]  ' Ports P1 bis P2 und Relais bei der Station


' Modeminitialisierung
if not initmodem then end


' Uebertragung lokaler Portinformationen an ein anderes
' C-Control-System per Mail-Kommando

#loop

'Der Befehl SENDMAIL dient zum Übertragen von einem Befehl
'(z.B. COMMAND_A) an eine andere C-Control Station
'(RECEIVER=Netzwerkadresse). Mit diesem Befehl können 
'zusätzlich 3 Datenbytes übertragen werden.

 ' Mail-Kommandos mit max. 3 Datenbytes
  sendmail COMMAND_A, RECEIVER, a1, a2, a3
  sendmail COMMAND_B, RECEIVER, a4, t1, t2

  ' Kommando mit weniger als 3 Datenbytes
  sendmail COMMAND_C, RECEIVER, p

  ' Kommando ohne Datenbytes
  sendmail COMMAND_D, RECEIVER

  pause 50

goto loop

' Hinweis:
' SENDMAIL kann auch mit RETRY spezifiziert werden, z.B.
' retry sendmail COMMAND_D, RECEIVER

