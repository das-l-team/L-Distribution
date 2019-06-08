
' ---------------------------------------------------------------------------
' Demoprogramm fuer den echten Open-Control/BASIC-Compiler OCBASR
' ---------------------------------------------------------------------------

' Einige Geschwindigkeitstests (Benchmarks) fuer den Compiler OCBASR.

' Bestimmte Befehle werden durch die Compilierung auf mehr als Faktor 20
' beschleunigt. Ueblich ist jedoch eine Geschwindigkeitssteigerung auf "nur"
' das 3- bis 4-fache.

' --- Definitionen ----------------------------------------------------------

INCLUDE "omid.def"

DEFINE a,b BYTE
DEFINE bitport PORT[4]

' --- Hauptprogramm ---------------------------------------------------------

PRINT "Benchmark fuer OCBASR:"

PRINT benchmark

END

' --- Subroutinen und Funktionen --------------------------------------------

' Eine Subroutine mit einigen Geschwindigkeitstests (Benchmarks)

FUNCTION benchmark COMPILE
  
  PrintSpc=ON             'Initialisierung  
  bitport=OFF

  SECOND=0                'Sekunde und Timer auf Null setzen

  FOR a=0 TO 255          '256*256=65536 FOR..NEXT-Schleifendurchlaeufe
    FOR b=0 TO 255        'interpretiert: 8.38 Sekunden
    NEXT b                'compiliert: 2.3 Sekunden
  NEXT a                  '-> Faktor 3.64 mal schneller!
  
  PRINT "FOR..NEXT:";
  zeit                    'Subroutine 'zeit' aufrufen
  
  FOR a=0 TO 255
    FOR b=0 TO 255        'interpretiert: 10.48 Sekunden
      TOG bitport         'compiliert: 2.46 Sekunden
    NEXT b       
  NEXT a                  '-> Faktor 4.26 mal schneller!
  
  PRINT "FOR..NEXT plus TOG:";
  zeit

  FOR a=0 TO 255          '256*256=65536 DBNZ-Schleifendurchlaeufe
    DBNZCTR=0             'interpretiert: 1.7 Sekunden
    #loop1                'compiliert: 0.12 Sekunden
    DBNZ loop1
  NEXT a                  '-> Faktor 14.2 mal schneller!

  PRINT "DBNZ:";
  zeit
  
  FOR a=0 TO 255
    DBNZCTR=0             'interpretiert: 3.84 Sekunden
    #loop2                'compiliert: 0.22 Sekunden
      DEACT bitport
    DBNZ loop2
  NEXT a                  '-> Faktor 17.5 mal schneller!

  PRINT "DBNZ plus DEACT:";
  zeit

  End2Host=ON             'nach END in den Hostmodus

  RETURN 123              'Ruecksprung ins Hauptprogramm

END FUNCTION


' Subroutine "zeit" zur Ausgabe der benoetigten Zeitdauer und zum Nullsetzen
' von Sekunde und Timer der internen Uhr. Wenn diese Subroutine von einer
' anderen COMPILE-Subroutine aufgerufen werden soll, muss sie ebenfalls
' compiliert werden. Denn Spruenge aus dem COMPILE-Bereich in Tokencode
' sind nicht erlaubt. INLASM-Routinen sind jedoch mittels SYS aufrufbar.

PROCEDURE zeit COMPILE

  PRINT SECOND;TIMER
  SECOND=0
  RETURN

END PROCEDURE
