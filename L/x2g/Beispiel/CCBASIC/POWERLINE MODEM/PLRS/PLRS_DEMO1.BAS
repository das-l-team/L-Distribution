'********************************************************************
'
' C-Control/BASIC       PLRS_DEMO1.BAS
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
' - Schalten des Relais 
' - Abfrage vom Schaltzustand des Relais
'
'------------ FUNKTION DES PROGRAMMS ------------------------
' Schalten Sie das Relais mit F1/F2 an der Station ein/aus
' Beachten Sie den Zustandswechsel von LED1 an der Station.
' LED1 ändert ihren Zustand natürlich auch,wenn das Relais
' manuell mit Taster1 am PLRS geschaltet wird.
'    
'  Tastenfunktion:
'    F1 RELAIS ON
'    F2 RELAIS OFF
'
'  Zustandsanzeige:
'    LED1 RELAIS STATUS
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
'---- FUNCTION KEYS -------
define FUNCTION1    port[9]
define FUNCTION2    port[10]
'------- LEDs -------------
define LED1         port[13]



' Modeminitialisierung
if not initmodem then end
' STATION LEDs Initialisierung
LED1=on

'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'IIIIIIIIIII   ABFRAGE SCHLEIFE     IIIIIIIIIIIIIIII
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
#idle
'----- ABFRAGE DER STATION FUNKTIONSTASTEN ---------
if FUNCTION1=off then gosub SWITCH_ON
if FUNCTION2=off then gosub SWITCH_OFF
'----- ABFRAGE DES PLRS-STATUS ---------------------
gosub REQUEST_STATUS
'----- STATUS AUSWERTEN UND MIT LEDs ANZEIGEN -------
' mail_data3 enthält den Zustand von Taster und Relais
' bit 7 = Zustand Relais
if (mail_data3 and &H80)= 0 then LED1=off else LED1=on
goto idle




'--------------------------------------------------------------
'     ÜBERTRAGUNG VON SCHALTKOMMANDOS AN DEN PLRS
'--------------------------------------------------------------
#SWITCH_ON  ' Bit 7 markieren (128)  und auf 1 (128)setzen                                                     
sendmail COMMAND_SWITCH,RECEIVER,0,128,128
return
#SWITCH_OFF ' Bit 7 markieren (128)  und auf 0 (0)setzen              
sendmail COMMAND_SWITCH,RECEIVER,0,128,0
return

'--------------------------------------------------------------
'     ÜBERTRAGUNG EINER STATUSABFRAGE AN DEN PLRS
'--------------------------------------------------------------
#REQUEST_STATUS
sendmail COMMAND_STATUS,RECEIVER,0,0,0
pause 3:return



#onmail
return
