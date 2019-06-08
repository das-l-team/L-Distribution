CCBASPAR = (Schritt 1)

  Das Programm  C-Control/BASIC-Parser  von Dietmar Harlos umgeht einen
  Bug im CCBASIC Kompiler der bei bestimmten Befehlskombinationen im
  CCBASIC Quelltext fehlerhaft uebersetzten Bytekode zur Folge hat.
  Eine Liste (.VAR) mit den ersten 24 Positionen der Variablen wird erzeugt.
  Erstmals fuer CCBASIC ist mehr als eine Anweisung hinter THEN moeglich.
  Beispiel: IF true THEN a=1 : b=12 : c=123 : PRINT a,b,c ELSE PRINT "Fehler"
  Auch IF..THEN..ELSE Kombinationen ueber mehrere Zeilen sind durch den
  vorgeschalteten Parserlauf mit CCBASIC jetzt moeglich. Tabulatoren im
  Quelltext muessen allerdings manuell durch Leerzeichen ersetzt werden.

CCBAS = (Schritt 2)

  Der C-Control/BASIC-Kompiler in der erweiterten Version von http://
  ccintern.dharlos.de kompiliert die vom Parser erzeugte Zwischendatei
  ".TMP"  Unter neueren Windows-Versionen muss dazu ein DOS-PC emuliert
  werden (Das "DOSBox"-Fenster), was die Schnelligkeit erheblich bremst
  Bis Windows-XP und mit manchen der Professional, bzw. Ultimate Versionen
  von Vista und 7 kann man weiterhin die Toolchain fuer 16-bit kompatibles
  Windows nutzen.  Das bringt eine deutliche Beschleunigung. Die nahezu
  verzoegerungsfreie Kompilierung der CCBASIC Windows-IDE von Conrad
  erreicht es hier allerdings auch damit nicht. Ein Vorteil ist die
  Verwendbarkeit des Mausrades zum Scrollen im Quelltext, was mit der
  Conrad-IDE nicht, bzw. nur mit Tricks moeglich ist. (s.a.)
  http://ccintern.dharlos.de/forum/lesen.php?eintrag=16149

[ Der nachfolgende Text wird aus einem in die |_ Distribution aufgenommenen
  Programmarchiv wiedergegeben. Der Pfad zum Archiv lautet:

  L:\x2g\3rdparty\CCBASPAR\ccbasparser_v1_1.zip
]



=== C-Control/BASIC-Parser fuer den DOS-C-Control/BASIC-Compiler ===

Version: 1.1
Autor  : Dietmar Harlos (dharlos@web.de)
Datum  : 27.02.2003


=== Programmbeschreibung ===

Der C-Control/BASIC-Parser (CCBASPAR.EXE) erweitert den C-Control/BASIC-
Compiler von Conrad Electronic (CCBAS.EXE) um einige sinnvolle Funktionen.
In BASIC-Programmen koennen mehrzeilige, verschachtelte IF-Abfragen ver-
wendet werden. Ausserdem meldet der Parser in einigen Faellen, in denen
der Compiler ohne Warnung fehlerhaften Code erzeugen wuerde, einen Fehler.
Unter anderem wird ueberprueft, ob alle deklarierten Variablen in das
User-RAM passen und ob ungenutzte Bereichen im Variablenspeicher existieren.
Darueber hinaus werden alle deklarierten Variablen in einer MAP-Datei auf-
gelistet, wodurch Variablenueberschneidungen sofort ersichtlich sind. 


=== Einbindung in die DOS-IDE ===

Der Parser kann problemlos in die C-Control-Entwicklungsumgebung fuer DOS
(CCE.EXE) anstelle des Compilers CCBAS.EXE eingebunden werden. Dazu wird CCE
gestartet und im Menue "Option" der Menuepunkt "Tools" ausgewaehlt. Im
Abschnitt "BASIC-Compiler" muss als Programm "$CCEPATH$\CCBAS.EXE" durch
"$CCEPATH$\CCBASPAR.EXE" ersetzt werden. Anschliessend muss man CCBASPAR.EXE
in das Verzeichnis, in dem CCE.EXE steht, kopieren. Nun wird bei jedem
Compiliervorgang innerhalb der Entwicklungsumgebung zunaechst der Parser
aufgerufen, der automatisch den Original-Compiler CCBAS.EXE startet, sofern
sich die beiden Programme im gleichen Verzeichnis befinden.


=== Die Fehlermeldungen und Warnungen des Parsers ===

"Ich kann die Datei "..." nicht finden."
  Der Parser kann die Eingabedatei mit dem BASIC-Sourcecode nicht finden.
  Es sollte der beim Aufruf des Parsers uebergebene Dateiname ueberprueft
  werden.

"Ich kann den C-Control/BASIC-Compiler CCBAS.EXE nicht finden."
  Das Programm CCBAS.EXE steht nicht im gleichen Verzeichnis wie der Parser.

"Hinter FOR darf keine Anweisung folgen"
  Der Compiler erzeugt ein fehlerhaftes Programm, wenn hinter einer FOR-
  Anweisung eine weitere Anweisung folgt.
  
"Hinter NEXT darf keine Anweisung folgen"
  Der Compiler erzeugt ein fehlerhaftes Programm, wenn hinter einer NEXT-
  Anweisung eine weitere Anweisung folgt.
  
"IF ohne ENDIF"
  Zu einer IF-Anweisung wurde keine zugehoerige ENDIF- (oder END IF-)
  Anweisung gefunden. Ein ENDIF muss immer als einzelner Befehl in einer
  Zeile stehen und hinter ihm darf nur ein Kommentar folgen, keine zu-
  saetzliche Anweisung.

"ELSE ohne IF"
  Zu einer ELSE-Anweisung wurde keine zugehoerige IF-Anweisung gefunden.
  Ein ELSE muss immer als einzelner Befehl in einer Zeile stehen und
  hinter ihm darf nur ein Kommentar folgen, keine zusaetzliche Anweisung.

"ENDIF ohne IF"
  Zu einer ENDIF-Anweisung wurde keine zugehoerige IF-Anweisung gefunden.
  Ein ENDIF (oder END IF) muss immer als einzelner Befehl in einer Zeile
  stehen und hinter ihm darf nur ein Kommentar folgen, keine zusaetzliche
  Anweisung.

"Das BYTE [...] (Adresse $...) des Variablenspeichers ist unbelegt"
  Ab Version 1.1 meldet der Parser, ob beim Deklarieren von Variablen
  mit Hilfe eines DEFINE-Befehls ohne Index eine Luecke im User-RAM
  entstanden ist. Eine Luecke entsteht, weil Wordvariablen immer nur an
  geraden Adressen abgelegt werden koennen. Sinnvollerweise sollten deshalb
  in einem Programm zunaechst alle Wordvariablen und erst danach die Byte-
  variablen deklariert werden.

"Index bei DEFINE ausserhalb des erlaubten Bereichs"
  Bei einer DEFINE-Anweisung wurde ein Index benutzt, der eine Variable
  ausserhalb des User-RAMs positioniert. Das kann erwuenscht sein, in
  diesem Fall ist diese Warnung zu ignorieren. Variablen, die ausserhalb
  des User-RAMs liegen, erscheinen nicht in der MAP-Datei.
  
"Variable passt nicht mehr ins User-RAM"
  Es wurden zu viele Variablen definiert. Aus diesem Grund sollte ueberprueft
  werden, ob einige Variablen eingespart werden koennen. Dieser Fehler kann
  nur bei einer DEFINE-Anweisung ohne Index auftreten.

"DEFINE ohne Index bei Bitvariable"
  Bei der Deklaration von Bitvariablen muss zwingend ein Index angegeben
  werden.

"Fehler beim Index von DEFINE"
  Der Index einer DEFINE-Anweisung ist keine Zahl oder weist einen anderen
  syntaktischen Fehler auf.

"Fehler bei DEFINE"
  Eine DEFINE-Anweisung weist einen syntaktischen Fehler auf.


=== Inhalt des ZIP-Archivs ===

Im ZIP-Archiv ist ebenfalls der C-Control/BASIC-Compiler CCBAS.EXE enthalten.
Es handelt sich um die Originalversion von Conrad Electronic mit erweitertem
Variablenspeicher. Informationen hierzu stehen auf der C-Control-intern-Site.
Bei Bedarf kann der Compiler CCBAS.EXE im CCE-Verzeichnis durch den Compiler
im Archiv ersetzt werden.


Viel Spass beim C-Controllern!

Dietmar Harlos
http://ccintern.dharlos.de

