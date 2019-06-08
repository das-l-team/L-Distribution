
' ---------------------------------------------------------------------------
' Demoprogramm fuer den echten Open-Control/BASIC-Compiler OCBASR
' ---------------------------------------------------------------------------

' In einer Tabelle stehende Strings auf der Seriellen Schnittstelle ausgeben.

' Das Suchen des gewuenschten Strings per "Skip Text" wird durch die
' Compilierung um mehr als Faktor 3 beschleunigt.

' --- Definitionen ----------------------------------------------------------

INCLUDE "omid.def"

DEFINE a,b BYTE

' --- Hauptprogramm ---------------------------------------------------------

textausgeben 10              'den 11. Text aus der Tabelle ausgeben

END

' --- Subroutine ------------------------------------------------------------

PROCEDURE textausgeben(a) COMPILE

  b=0                        'Skip Text - um Faktor 3,3 beschleunigt
  WHILE a
    WHILE LOOKTAB(strings,b)
      ADD b,1
    WEND
    ADD b,1
    SUB a,1
  WEND
  
  WHILE LOOKTAB(strings,b)   'Text byte-fuer-byte ausgeben
    PUT LOOKTAB(strings,b)
    ADD b,1
  WEND
  PRINT
  
  RETURN

END PROCEDURE

' --- Tabelle ---------------------------------------------------------------

TABLE strings BYTE

  "Das ist der 1. String",0
  "Das ist der 2. String",0
  "Das ist der 3. String",0
  "Das ist der 4. String",0
  "Das ist der 5. String",0
  "Das ist der 6. String",0
  "Das ist der 7. String",0
  "Das ist der 8. String",0
  "Das ist der 9. String",0
  "Das ist der 10. String",0
  "Das ist der 11. String",0

END TABLE
