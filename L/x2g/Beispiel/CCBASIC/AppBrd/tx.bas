'********************************************************************
'
' C-Control/BASIC       TX.BAS   '(Geaendert von) das |_ Team: Tabelle in Zeilen 76 bis 80
'                                'auskommentiert und Tabelle an das Programmende kopiert.
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossenem Telemetrie-Sender
'   und Tastatur
'
' Schwerpunkt:
'
' - Funkuebertragung von Daten (siehe auch RX.BAS)
' 
'********************************************************************

define value word
define neg byte

define key_nr byte
define compare byte
define key_ascii byte

define keyboard ad[8]


' die Reihenfolge der Tasten auf dem Keyboard
define KEY_ASTERIX 0
define KEY_7       1
define KEY_4       2
define KEY_1       3
define KEY_0       4
define KEY_8       5
define KEY_5       6
define KEY_2       7
define KEY_CROSS   8
define KEY_9       9
define KEY_6       10
define KEY_3       11

' Sender-Enable -Signal liegt an Port 16
define digi byteport[2]
define enable port [16]

' --- Initialisierung ---

  value = 0
  neg = 0
  baud R2400

' --- Tastaturabfrageschleife ---

#LOOP

' anhand einer Tabelle werden die vom A/D-Wandler gemessenen
' Spannungswerte einer Taste zugeordnet, dabei wird eine
' Toleranz von +- 3 zugelassen, um Widerstandstoleranzen
' zu kompensieren

  for key_nr = 0 to 11
    looktab keycodes, key_nr, compare
    if abs(keyboard-compare) < 3 then gosub SEND_KEY
  next

'kleine Pause
  pause 10

' Endlosschleife
goto LOOP

' --- Vergleichstabelle mit Werten, die mit keyb1.bas ermittelt wurden ---

' sollten die von Ihnen festgestellten Tasten-A/D-Werte von dieser Tabelle
' etwas abweichen, so ist das normal und durch die Widerstandstoleranzen
' begruendet

'table keycodes
'  0 23 46 68
'  90 111 132 152
'  173 193 214 235
'tabend


' --- Zuordnung von ASCII-Codes fuer die Tasten aus einer Tabelle und Ausgabe ---

' Achten Sie auf die hier implementierten Sonderfunktionen
' der Tasten # und * sowie auf das Setzten des negativen
' Vorzeichens durch Druecken der 0 vor der eigentlichen Eingabe

#SEND_KEY
  looktab asciicodes, key_nr, key_ascii
  enable = ON        ' Sender einschalten               
  pause 5            ' Stabilisierungszeit fuer den Sender
  put key_ascii      ' Byte uebertragen
  enable = OFF       ' Sender ausschalten

return

' negatives Vorzeichen
#NEGATIVE
  neg = not neg
  print "-";
return

' Loeschen des zuletzt eingegebenen Zeichens
#BACKSPACE
  if value = 0 then neg = not neg
  value = value / 10
  put 8
  put 32
  put 8
return

' Eingabe abschliessen
#NEWLINE
  print
  if neg then value = -value
  print "Sie haben "; value; " eingegeben"
  value = 0
  neg = 0
return

#ERRORBEEP
  beep 100,10,0
return

table asciicodes
  8 55 52 49
  48 56 53 50
  10 57 54 51
tabend

table keycodes
  0 23 46 68
  90 111 132 152
  173 193 214 235
tabend

