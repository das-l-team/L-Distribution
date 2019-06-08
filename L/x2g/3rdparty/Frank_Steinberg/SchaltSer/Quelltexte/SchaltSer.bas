'-- SchaltSer.bas ----------------------------------------------- >>fst'08<< -
' - Schaltet DTR, RTS, TxD der seriellen Schnittstelle
'   nach Angaben aus einer Parameterdatei
' - Verwendet das WinAPI zum Steuern der Schnittstelle
' - Quelltext für FreeBasic (Win32), getestet mit Version 0.18.2
' - kompilieren als Windows GUI
'-- V 20080226 -------------------------------- http://www.FrankSteinberg.de -

#include once "windows.bi"
#include once "file.bi"

Declare Sub ComOeffnen()
Declare Sub DateiLesen()
Declare Sub Ende()
Declare Sub Pruefen()
Declare Sub Schalten()
Declare Sub StartFehlerHinweise()

Dim Shared CHandle As Handle,_
           Antwort As Integer,_
           PortNr As String,_
           PortNrOffen As String,_
           Parameter As String,_
           ParameterDatei As String,_
           Titel As String,_
           RTS As Byte, DTR As Byte, TxD As Byte

Titel = "SchaltSer   V20080226   >>fst'08<<"
ParameterDatei = Command$(1)
If ParameterDatei = "" Then ParameterDatei = ExePath + "\SchaltSer.ini"

'*** Parameter aus Datei lesen:
DateiLesen()

'*** Auf fehlende Parameterdatei und Ende-Anweisung in Parameterdatei prüfen:
StartFehlerHinweise()

'*** Bei Programmstart einen Infoton ausgeben:
Beep : Sleep 10 

'*** Hauptschleife
DO 
 DateiLesen()	'Parameterdatei lesen und auswerten
 Pruefen()	  	'Parameter auswerten
 Schalten()	 	'Aushänge der Schnittstelle schalten
 SLEEP 500		  'Pause zur Senkung der Prozessorlast
LOOP


Sub ComOeffnen
	 
 '*** COM-Port öffnen:
 CHandle = CreateFile("\\.\"+PortNr, GENERIC_READ or GENERIC_WRITE, 0, 0, OPEN_EXISTING, 0, 0)

 '*** Programmabbruch und Hinweis, wenn Öffnen fehlschlägt:
 If CHandle = INVALID_HANDLE_VALUE Then
   MessageBox(null,_
              "Fehler beim Öffnen der seriellen Schnittstelle:  " + PortNr + Chr$(10) + Chr$(10) + _
              "ParameterDatei:" + Chr$(9) + ParameterDatei + Chr$(10) + _
              "Inhalt: "+ Chr$(9)+ Chr$(9) + Parameter ,_
               Titel, MB_ICONERROR)
   End
  ELSE
   'MessageBox(null, PortNr + " geöffnet!", "SerSchalt", MB_ICONINFORMATION)
   'Beep                   'Infoton 
   PortNrOffen = PortNr   'aktuell geöffneten Port speichern
 End If
	
End Sub

Sub DateiLesen
	
 '*** Parameterdatei lesen und Angabe zum COM-Port extrahieren:
 Dim Position As Integer
 Parameter = ""
 'PortNr = ""
 Open ParameterDatei For Input As #1
 Line Input #1, Parameter                'nur erste Zeile lesen
 Parameter = UCase$(Parameter)           'Leerzeichen links entfernen
 Parameter = LTrim$(Parameter)           'Leerzeichen rechts entfernen
 Position = InStr(Parameter, "COM")      'Position von Zeichenkette 'COM' suchen 
 If Position Then                        'Wenn Angaben zum COM-Port gefunden ...
  PortNr = Mid$(Parameter, Position, 5)  '5 Zeichen speichern 'COM' plus max. zwei Ziffern
  PortNr = RTrim$(PortNr)                'Leerzeichen bei einstelliger PortNr entfernen
 End If 
 CLOSE #1                                'Datei schließen, damit nach Öffnung Dateizeiger wieder am Beginn
		
End Sub

Sub Schalten

 '*** Nur schalten, wenn Schnittstelle geöffnet:
 If PortNr = "" Then Exit Sub

 '*** RTS, DTR und TxD setzen (+12V)
 IF InStr(Parameter, "RTS+") THEN EscapeCommFunction(CHandle, 3)  'RTS
 IF InStr(Parameter, "DTR+") THEN EscapeCommFunction(CHandle, 5)  'DTR
 IF InStr(Parameter, "TXD+") THEN EscapeCommFunction(CHandle, 8)  'TxD auf BREAK

'*** RTS, DTR und TxD löschen (-12V)
 IF InStr(Parameter, "RTS-") THEN EscapeCommFunction(CHandle, 4)  'RTS low
 IF InStr(Parameter, "DTR-") THEN EscapeCommFunction(CHandle, 6)  'DTR low
 IF InStr(Parameter, "TXD-") Then EscapeCommFunction(CHandle, 9)  'TxD low (Break-Zustand löschen)
	
End Sub

Sub Pruefen
	
 '*** Beenden, wenn END in Parameterdatei:
 IF InStr(Parameter, "END") Then Ende()
 '*** Beenden, Parameterdatei fehlt oder 0-Byte:
 IF Parameter = "" Then Ende()
 
 '*** Schnittstelle schließen und neue öffnen, 
 '    wenn in Parameterdatei gewechselt:
 If (PortNr <> PortNrOffen) Then 
  CloseHandle(CHandle)
  ComOeffnen()
 EndIf
 	
End Sub

Sub Ende

 '*** Schnittstelle schließen:
 CloseHandle(CHandle)
 '*** 3 Infotöne bei Programmende:
 Beep : Sleep 33 : Beep ': Sleep 33 : Beep 
 End 
	
End Sub

Sub StartFehlerHinweise
	
 '*** Wenn Parameterdatei fehlt oder Null-Byte:
 If Parameter = "" Then
  Antwort = MessageBox(null, "Parameterdatei fehlt oder ist leer:   " +ParameterDatei+Chr$(10)+Chr$(10)+_
                       "Weitere Infos anzeigen?" ,_
                       Titel, MB_ICONWARNING Or MB_YESNO)
  '*** Wenn JA-Button gedrückt:
  If Antwort = IDYES Then
   	Shell "START SchaltSer.txt"   'Infotext anzeigen
  EndIf
  End
 EndIf

 '*** Wenn bei Programmstart 'END' in Parameterdatei:
 If InStr(Parameter, "END") Then
  MessageBox(null,_
            "Programmstart abgebrochen; 'END' in Parameterdatei gefunden" + Chr$(10) + Chr$(10) + _
            "ParameterDatei:" + Chr$(9) + ParameterDatei + Chr$(10) + _
            "Inhalt: "+ Chr$(9)+ Chr$(9) + Parameter ,_
             Titel, MB_ICONWARNING)
  End   'Programm beenden
 EndIf
	
End Sub