'********************************************************************
'
' C-Control/BASIC       NET6.BAS
'
' Programmierbeispiele zum Power Line Modem / Remote-IO 
'
' Systemvoraussetzungen:
' 
' - C-Control System (Unit oder Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - zweites C-Control System mit Modem an gleicher oder
'   angekoppelter Netzleitungsphase
' - evtl. weitere Netzteilnehmer (Remote-IOs) 
' 
' Schwerpunkte:
'
' - Netzwerkkonfiguration
' - impliziter Empfang von Mail-Kommandos 
' 
' Senden von Mail-Kommandos siehe NET4.BAS
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254,
' Festlegung ab welcher Byteposition eingehende Mail-Kommandos
' gespeichert werden sollen (5 Bytes)
network self=101 mailslot=1

' Netzwerk-IDs der Remote-IOs
define REMIO1 1
define REMIO2 2

' Definition lokaler und entfernter Ports, z.B.:
define localport   byteport[1] at 101
define remoteport1 port[3]   at 1
define remoteport2 port[7]   at 2

' Speicher fuer eingehende Mails
define mail_command byte  ' erstes der 24 Userspeicherbytes
define mail_sender  byte
define mail_data1   byte
define mail_data2   byte
define mail_data3   byte

' Definition der Kommando-IDs aus NET4.BAS
define COMMAND_A 12 
define COMMAND_B 33
define COMMAND_C 57
define COMMAND_D 123

' Speicher zur Uebernahme empfangener Daten
define a1 byte
define a2 byte       
define a3 byte
define a4 byte       
define t1 byte
define t2 byte       
define p  byte

' eine Variable
define x byte


' Modeminitialisierung
if not initmodem then end


' Zugriffe auf Netzwerkports (lokal am eigenen Modem 
' und entfernt):
' VOR JEDEM einzelnen Netzzugriff - lesend oder schreibend - 
' erfolgt bei Angabe eines Mailslots in der 
' NETWORK-Anweisung automatisch ein Aufruf von GETMAIL,
' bei Empfang eines Mail-Kommandos wird NACH dem 
' Netzzugriff, aber ggf. noch innerhalb der aktuellen
' Basic-Anweisung, automatisch per GOSUB zu ONMAIL
' verzweigt 

#loop
  ' ein Zugriff auf einen lokalen Port (am eigenen Modem),
  ' ein Mail-Kommando kann entgegengenommen werden
  localport = ON
  
  ' zwei Netzwerkzugriffe in einer BASIC-Anweisung - 
  ' erst lesend auf remoteport2, dann schreibend auf remoteport1;
  ' ggf. werden in dieser Zeile automatisch zwei Mail-Kommandos 
  ' entgegengenommen
  remoteport1 = remoteport2
  
  pause 25  

goto loop

' Auswertung der Mail-Kommandos wie in NET5.BAS:
  
' onmail muss fuer den Mail-Empfang definiert sein!
#onmail
  if mail_command = COMMAND_A then goto handle_cmd_A
  if mail_command = COMMAND_B then goto handle_cmd_B
  if mail_command = COMMAND_C then goto handle_cmd_C
  if mail_command = COMMAND_D then goto handle_cmd_D
return  

#handle_cmd_A
 a1 = mail_data1
 a2 = mail_data2
 a3 = mail_data3
return

#handle_cmd_B
 a4 = mail_data1
 t1 = mail_data2
 t2 = mail_data3
return

#handle_cmd_C
 p = mail_data1
return

#handle_cmd_D
 ' Kommando D aus NET4.BAS enthaelt keine Daten 
 ' und dient nur zur Anweisung, eine bestimmte Operation
 ' auszufuehren, als Beispiel hier eine Tonausgabe
 beep 100, 10, 0  
return



