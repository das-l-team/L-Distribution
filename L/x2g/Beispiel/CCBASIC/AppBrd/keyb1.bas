'********************************************************************
'
' C-Control/BASIC       KEYB1.BAS
'
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

define keyboard ad[8]

' --- Tastaturabfrageschleife ---

#LOOP

' es werden die A/D-Werte fuer die gedrueckten Tasten ausgegeben,
' um zu zeigen, wie sich die einzelnen Spannungswerte der Tasten
' voneinander unterscheiden

  print keyboard

'kleine Pause
  pause 20

' Endlosschleife
goto LOOP

