'********************************************************************
'
' C-Control/BASIC       PLRS_DEMO2.BAS
'
' Programmierbeispiel zum Power Line Remote Switch (PLRS)
'
' Systemvoraussetzungen:
'
' - C-Control System (Station)
' - angeschlossenes Power Line Modem (Modem-Bruecke geschlossen)
' - PLRS (für dieses Beispiel auf Adresse $13)
'   angekoppelter Netzleitungsphase
'
' Schwerpunkte:
' - Schalten von Relais und Beep
' - Abfrage von Tasten und Schaltzustand des Relais
'
'------------ FUNKTION DES PROGRAMMS ------------------------
'  Tastenfunktion:
'    F1 RELAIS ON
'    F2 RELAIS OFF
'    F3 BEEP ON
'    F4 BEEP OFF
'
'  Zustandsanzeige:
'    LED1 RELAY STATUS
'    LED2 PLRS TASTE ON/OFF
'    LED3 PLRS TASTE 1
'    LED4 PLRS TASTE 2
'
'
'
'********************************************************************


network self=101 mailslot=1
'--------------------------------
' Speicher fuer eingehende Mails
'---------------------------------
define mail_command byte  ' erstes der 24 Userspeicherbytes
define mail_sender  byte
define mail_data1   byte
define mail_data2   byte
define mail_data3   byte

'-------------------------------
' Definition der Kommando-IDs
'-------------------------------
define COMMAND_STATUS 7
define COMMAND_SWITCH 8
'-------------------------------
' Definition des Empfängers
'-------------------------------
define RECEIVER &H13

'-----------------------------
' Definition der STATION PORTS
'-----------------------------
'----   RELAYS  -----------
define RELAY1       port[7]
define RELAY2       port[8]
'---- FUNCTION KEYS -------
define FUNCTION1    port[9]
define FUNCTION2    port[10]
define FUNCTION3    port[11]
define FUNCTION4    port[12]
'------- LEDs -------------
define LED1         port[13]
define LED2         port[14]
define LED3         port[15]
define LED4         port[16]



' Modeminitialisierung
if not initmodem then end
' STATION LEDs Initialisierung
LED1=on:LED2=on:LED3=on:LED4=on

'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'IIIIIIIIIII   ABFRAGE SCHLEIFE     IIIIIIIIIIIIIIII
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
#idle
'----- ABFRAGE DER STATION FUNKTIONSTASTEN ---------
if FUNCTION1=off then gosub SWITCH_ON
if FUNCTION2=off then gosub SWITCH_OFF
if FUNCTION3=off then gosub SWITCH_BEEP_ON
if FUNCTION4=off then gosub SWITCH_BEEP_OFF
'----- ABFRAGE DES PLRS-STATUS ---------------------
gosub REQUEST_STATUS
'----- STATUS AUSWERTEN UND MIT LEDs ANZEIGEN -------
if (mail_data3 and &H80)= 0 then LED1=off else LED1=on
if (mail_data3 and &H01)= 0 then LED2=off else LED2=on
if (mail_data3 and &H02)= 0 then LED3=off else LED3=on
if (mail_data3 and &H04)= 0 then LED4=off else LED4=on
goto idle




'--------------------------------------------------------------
'     ÜBERTRAGUNG VON SCHALTKOMMANDOS AN DEN PLRS
'--------------------------------------------------------------
#SWITCH_ON
sendmail COMMAND_SWITCH,RECEIVER,0,128,128
return
#SWITCH_OFF
sendmail COMMAND_SWITCH,RECEIVER,0,128,0
return
#SWITCH_BEEP_ON
sendmail COMMAND_SWITCH,RECEIVER,0,64,64
return
#SWITCH_BEEP_OFF
sendmail COMMAND_SWITCH,RECEIVER,0,64,0
return
'--------------------------------------------------------------
'     ÜBERTRAGUNG EINER STATUSABFRAGE AN DEN PLRS
'--------------------------------------------------------------
' mail_data3 enthält den Zustand von Taster und Relais
' bit 7 = Zustand Relais
' bit 0 = Zustand Taste ON/OFF
' bit 1 = Zustand Taste 1
' bit 2 = Zustand Taste 2
'---------------------------------------------------------------
#REQUEST_STATUS
sendmail COMMAND_STATUS,RECEIVER,0,0,0
pause 3:return



#onmail
return
