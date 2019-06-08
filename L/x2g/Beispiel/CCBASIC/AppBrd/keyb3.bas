'********************************************************************
'
' C-Control/BASIC       KEYB3.BAS  '(Geaendert von) das |_ Team: Tabelle in Zeilen 65 bis 69
'                                  'auskommentiert und Tabelle an das Programmende kopiert.
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossener Tastatur
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkt:
'
' - ASCII-Code der gedrueckten Taste
'
'********************************************************************

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


' --- Tastaturabfrageschleife ---

#LOOP

' anhand einer Tabelle werden die vom A/D-Wandler gemessenen
' Spannungswerte einer Taste zugeordnet, dabei wird eine
' Toleranz von +- 3 zugelassen, um Widerstandstoleranzen
' zu kompensieren

  for key_nr = 0 to 11
    looktab keycodes, key_nr, compare
    if abs(keyboard-compare) < 3 then gosub HANDLE_KEY
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


' --- Zuordnung von ASCII-Codes und byteweise Ausgabe ---

#HANDLE_KEY
  looktab asciicodes, key_nr, key_ascii
  put key_ascii
return

table asciicodes
  42 55 52 49
  48 56 53 50
  35 57 54 51
tabend

table keycodes
  0 23 46 68
  90 111 132 152
  173 193 214 235
tabend

