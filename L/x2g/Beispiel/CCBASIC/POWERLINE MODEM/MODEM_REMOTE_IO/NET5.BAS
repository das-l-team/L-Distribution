'********************************************************************
'
' C-Control/BASIC       NET5.BAS
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
' - expliziter Empfang von Mail-Kommandos
'
' Senden von Mail-Kommandos siehe NET4.BAS
'
'********************************************************************

' Festlegung der eigenen Netzwerkadresse, self 32...254,
' Festlegung ab welcher Byteposition eingehende Mail-Kommandos
' gespeichert werden sollen (5 Bytes)
network self=101 mailslot=1

' Speicher fuer eingehende Mails (Variablen)
define mail_command byte ' erstes der 24 Userspeicherbytes 
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


' Modeminitialisierung
if not initmodem then end


' Empfang von Portinformationen eines anderen
' C-Control-Systems per Mail-Kommando

#loop

  ' explizite Statusanfrage an das Modem;
  ' wurde vom Modem zuvor ein Mail-Kommando empfangen,
  ' uebertraegt getmail das Kommando, den Absender und
  ' die Datenbytes in den Mailslot-Speicherbereich und
  ' verzweigt automatisch per GOSUB zum Label onmail
  getmail

goto loop

' onmail muss fuer den Mail-Empfang definiert sein!
#onmail
  if mail_command = COMMAND_A then goto handle_cmd_A
  if mail_command = COMMAND_B then goto handle_cmd_B
  if mail_command = COMMAND_C then goto handle_cmd_C
  if mail_command = COMMAND_D then goto handle_cmd_D
return

#handle_cmd_A
 a1 = mail_data1     '1. Datenbyte
 a2 = mail_data2     '2. Datenbyte
 a3 = mail_data3     '3. Datenbyte
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



