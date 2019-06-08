'********************************************************************
'
' C-Control/BASIC       KEYB1.BAS   '(Geaendert von) das |_ Team: Tabelle in Zeilen 57 bis 63
'                                   'auskommentiert und Tabelle an das Programmende kopiert.
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossener Tastatur
' - serielle Verbindung zum PC
' - Terminalprogramm
'
' Schwerpunkt:
'
' - Ermitteln der gedrueckten Taste
'
'********************************************************************

define key_nr byte
define compare byte

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
' Toleranz von +- 3 zugelassen

  for key_nr = 0 to 11
    looktab keycodes, key_nr, compare
    if abs(keyboard-compare) < 3 then gosub HANDLE_KEY
  next

'kleine Pause
  pause 20

' Endlosschleife
goto LOOP

' --- Vergleichstabelle

'table keycodes
'  0 23 46 68
'  90 111 132 152
'  173 193 214 235
'tabend


' --- Verarbeitung des Tastaturereignisses anhand der Tastennummer ---

#HANDLE_KEY

  if key_nr = KEY_ASTERIX then print "Taste *"
  if key_nr = KEY_7 then print "Taste 7"
  if key_nr = KEY_4 then print "Taste 4"
  if key_nr = KEY_1 then print "Taste 1"
  if key_nr = KEY_0 then print "Taste 0"
  if key_nr = KEY_8 then print "Taste 8"
  if key_nr = KEY_5 then print "Taste 5"
  if key_nr = KEY_2 then print "Taste 2"
  if key_nr = KEY_CROSS then print "Taste #"
  if key_nr = KEY_9 then print "Taste 9"
  if key_nr = KEY_6 then print "Taste 6"
  if key_nr = KEY_3 then print "Taste 3"

return

' --- Vergleichstabelle

table keycodes
  0 23 46 68
  90 111 132 152
  173 193 214 235
tabend