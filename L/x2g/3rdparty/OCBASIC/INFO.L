[
  Der nachfolgende Text ist der HTML-Datei   L:\x2g\3rdparty\OCBASIC\INFO.HTM  entnommen
  und nachtraeglich fuer die Ansicht in einem Texteditor formatiert.

  Fuer bessere Lesbarkeit kann natuerlich die obige HTML-Datei mit einem Browser geoeffnet
  und dargestellt werden.

  Informationen zum C-Control/BASIC Compiler siehe auch:   L:\x2g\Hilfe.L
]




                                       OCBASR32

                              Echter BASIC-Compiler fuer die
                            Open-Micro, Open-Mini und Open-Midi
                                 Autor: Dietmar Harlos
                       
                       Datum: 18. November 2006 bis 22. April 2017

Einleitung:
Die Open-Micro, Open-Mini und Open-Midi fuehren BASIC- und CCPLUS-Programme mit einer recht ansehnlichen
Geschwindigkeit aus. Sie sind trotz des relativ niedrigen Bustaktes von 3.2 MHz rund 16-mal so schnell
wie die Original-C-Control-1. Um BASIC-Programme noch weiter zu beschleunigen, kann man den Compiler
OCBASR einsetzen, mit dem BASIC-Quellcode sehr komfortabel in Maschinensprache, bzw. Assembler, umgewandelt
werden kann. Der Standard-Compiler OCBASIC uebersetzt bekanntlich BASIC-Quellcode in Tokencode, der vom
Interpreter in der OM ausgefuehrt wird. Gegenueber diesem interpretiertem Tokencode wird die vom Compiler
OCBASR erzeugte Maschinensprache natuerlich erheblich schneller ausgefuehrt.

Installation:
Die Installation des neuen Compilers ist denkbar einfach. Man muss einfach das Programm OCBASR32.EXE in
das Verzeichnis kopieren, in dem schon OCBAS32.EXE steht und in ConTEXT bei den Benutzerbefehlen
"OCBAS32.EXE" durch "OCBASR32.EXE" ersetzen. Nun wird bei einer Compilierung der BASIC-Compiler OCBASR
statt OCBASIC gestartet.

Benutzung:
Noch einfacher ist es, BASIC-Quellcode in Assemblercode, bzw. Maschinensprache uebersetzen zu lassen. Der
zu beschleunigende Code muss in einer Funktion oder in einer Subroutine (Prozedur) stehen. Wird hinter
die Startzeile dieser Subroutine oder Funktion das Schluesselwort COMPILE angefuegt, wird der OCBASR-
Compiler aktiv und uebersetzt den in ihr stehenden BASIC-Sourcecode in die Maschinensprache. Dieser
Programmteil wird nun ueblicherweise 3 bis 4 mal schneller ausgefuehrt. Einige BASIC-Befehle sind sogar
10 bis 20 mal schneller. Der Rest des Programms wird interpretiert ausgefuehrt. Siehe folgendes Beispiel. 

  INCLUDE "omid.def" 
DEFINE a,b,c BYTE

unterprogramm 
PRINT funktion(5,8) 
END 

PROCEDURE unterprogramm COMPILE 
  PRINT "Hallo, hier ist ein Unterprogramm in Maschinensprache!" 
  RETURN 
END PROCEDURE 

FUNCTION funktion(a,b) COMPILE 
  FOR c=a TO b 
    PRINT c 
  NEXT c 
  RETURN 123 
END FUNCTION 
 
Bild1: Beispielprogramm. Das Schluesselwort COMPILE bewirkt, dass eine Subroutine oder
       Funktion in Maschinensprache uebersetzt und schneller ausgefuehrt wird.

Bei der Entwicklung des BASIC-Compilers OCBASR stand vor allem die sehr einfache
Benutzung im Vordergrund. Der Anwender braucht nur das Schluesselwort COMPILE an
den Namen eines Unterprogramms anzuhaengen, um sein Programm zu beschleunigen.
Es laesst sich so gut wie jeder BASIC-Befehl in Maschinensprache uebersetzen und er
fuehrt interpretiert wie compiliert, abgesehen von der Geschwindigkeit, zum
gleichen Ergebnis. Siehe dazu auch die beigefuegten Demoprogramme DEMO1.BAS,
DEMO2.BAS und DEMO3.BAS. Die Beispielprogramme fuer die Open-Micro und Open-Mini
befinden sich im Verzeichnis OM. Und die drei Programme fuer Open-Midi in OMID.

Nachteile

Leider hat diese hohe Kompatiblitaet auch ihren Preis: Der compilierte Code nutzt
viele Betriebssystemroutinen, wodurch sich der relativ geringe Geschwindigkeits-
zuwachs von "nur" Faktor 3 bis 4 erklaert. Ausserdem nimmt der compilierte Code
natuerlich erheblich mehr Platz in Anspruch als der interpretierte Tokencode. Aber
da in einem Programm ueblicherweise nurein oder zwei Subroutinen oder Funktionen
beschleunigt werden muessen, ist das genaugenommen kein grosser Nachteil. Ich
konnte beispielsweise durch die Compilierung einer einzigen Subroutine ein ganzes
Programm (den Disassembler DISA6808.BAS) um Faktor 2,5 beschleunigen. Das
Programm belegte dadurch gerade einmal 1,4% mehr Platz im Programmspeicher. Oft
ist ein Faktor 3 mit 20% Grössenzunahme realisierbar, wie beispielweise bei in
BASIC geschriebenen I²C-LCD-Routinen. Ein weiterer Nachteil des neuen Compilers
ist, dass bei Fehlermeldungen, die waehrend der uebersetzung auftreten, die Zeilen-
nummern moeglicherweise nicht passen. Das liegt daran, dass der Compiler OCBASR
vom Standard-Compiler OCBASIC eine temporaere Sourcecode-Datei uebersetzen laesst, in
der die COMPILE-Bereiche ans Ende verschoben wurden. Der Anwender sollte deshalb
sinnvollerweise vor dem Einfuegen der COMPILE-Schluesselwoerter sicherstellen, dass
sein Programm fehlerfrei uebersetzt werden kann. Ausserdem sucht der neue Compiler
derzeit keine COMPILE-Bereiche in INCLUDE-Dateien.

Fragen und Antworten

Es folgen einige Fragen und Antworten, die mir Betatester des Compilers gestellt
haben. Ich erhalte den Fehler "Konstante oder TABEND statt 'URAMBASE' erwartet bei
TABLE". Wenn Du COMPILE verwenden moechtest, ist es erforderlich, die Definitions-
datei fuer die Open-Micro und Open-Mini (OM.DEF), bzw. fuer Open-Midi (OMID.DEF),
mitzuladen. Am Beginn des Programms sollte deshalb immer ein INCLUDE "OM.DEF", bzw.
INCLUDE "OMID.DEF", stehen. Diese Definitionsdatei wird auch von den meisten
anderen Programmen benoetigt.

Was bedeutet der Fehler "Label 'OCBASRxxx' nicht gefunden"?

Vermutlich hast Du versucht, mit einem im COMPILE-Bereich stehenden GOSUB oder
GOTO zu einem Label im Tokencode zu springen. Es ist aber nicht zulaessig, in
einer nach Maschinensprache uebersetzten Subroutine oder Funktion irgendein
Sprungziel aufzurufen, das ausserhalb von COMPILE-Bereichen steht. Und auch umgekehrt
klappt das nur mit Subroutinen und Funktionen. Der Compiler meldet in solchen Faellen
einen Fehler, weil er ein Label nicht finden kann. Das einzige, was man in COMPILE-
Bereichen vom Tokencode aufrufen kann, sind INLASM-Routinen per SYS-Befehl. Wenn man
SYS falsch anwendet, erkennt das OCBASR allerdings nicht.

Hintergrund: Normalerweise wird von der OM Tokencode ausgefuehrt und per Tokenbefehl
muss die OM auf die Ausfuehrung von Maschinensprache "umgeschaltet" werden. Das
bewerkstelligt ein INLASM-Token, das von OCBASIC automatisch an den Beginn einer
INLASM- und COMPILE-Funktion oder -Prozedur gestellt wird. Deshalb ist wildes
Springen zu Labels in Assembler- oder COMPILE-Code nicht zulaessig. Wenn der Compiler
Dein Programm klaglos uebersetzen wuerde, wuerde die OM Tokencode als Maschinencode
oder umgekehrt ausfuehren.

Kannst Du OCBASR nicht einfach in OCBAS implementieren? Dann muesste man nur das
Schluesselwort COMPILE hinzufuegen.

Mit diesem Gedanken habe ich natuerlich auch schon gespielt. Aber ganz so einfach ist
das leider nicht. Vor allem musst Du bedenken, dass der durch OCBASR erstellte Maschinen-
code nicht sehr effektiv ist, da keine Optimierungen durchgefuehrt werden. Schon von
daher ist es fraglich, ob man in dieses Compilerkonzept allzuviel Arbeit stecken
sollte. Wie es sehr viel besser gemacht werden kann, zeigt CCBAS2MC. Mit einem Compiler
wie dem CCBAS2MC koennte der Maschinencode so optimiert werden, dass er bis zu 12 bis 24
mal so schnell ausgefuehrt wird und dabei nur wenig groesser oder gar kleiner ist als der
Tokencode. Obwohl CCBAS2MC eins meiner sinnvollsten Programme ist und es sogar zu einer
Erwaehnung in der c't gebracht hat, wurde es nur von wenigen Personen bei mir registriert.
Offenbar hat den meisten Personen die Geschwindigkeit der C-Control-1 Version 1.1
ausgereicht. Deshalb werde ich nicht zuviel Arbeit in den echten Compiler stecken. Aber
mal sehen, wie das Anwenderecho auf OCBASR ausfaellt.

OCBASR macht sich den normalen Compiler OCBASIC zunutze, indem es ihn zweimal aufruft:
Das erste Mal wird der Tokencode erzeugt, beim zweiten Mal wird der erzeugte Assembler-
quelltext uebersetzt. Wenn keine COMPILE-Bereiche gefunden werden, wird OCBASIC nur
einmal aufgerufen. Aus Sicht des Anwenders gibt es durch das Zwischenschalten von OCBASR
also keinen Nachteil. CCBAS2MC war deutlich schwieriger zu bedienen.

Waere es nicht sinnvoller, CCBAS2MC so anzupassen, dass es fuer die OM verwendet werden kann?

Ob es sinnvoller ist, ist die Frage. Aus Sicht des Anwenders gibt es eine ganze Menge
zu beachten. Die Anwendung wird komplizierter und somit auch die Dokumentation. Denn nur
in gewissen Faellen ist CCBAS2MC in der Lage, optimalen Code zu erzeugen. Wenn der Anwender
"ganz normal" programmiert, wird ueblicherweise auch kein besserer Code erzeugt als bei
CCBASR. Je nach Anwenderecho koennte ich aber noch einige kleine Optimierungen in CCBASR
einfuegen. Allerdings haetten diese den Nachteil, dass der Code etwas anders ausgefuehrt wird.
Solange der Anwender nicht "herumhackt" haette das zwar keinen Nachteil, aber man weiss ja
nie. Auf jeden Fall wuerden diese Optimierungen dazu fuehren, dass in der Doku zum Compiler
einige Gebote und Verbote auftauchen wuerden, die den Normalanwender sicher verunsichern.
Ich finde, das ist es nicht wert.

Auf den ersten Blick ist abschreckend, dass fuer COMPILE mehr Speicherplatz benoetigt wird.

Selbst die Open-Micro und Open-Mini bieten gegenueber Conrad-Micro 386 Byte mehr Speicher.
Ausserdem nimmt der Tokencode mit OCBASIC in der Regel 20% weniger Platz in Anspruch. Macht
insgesamt einen Zuwachs von rund 872 Byte, gemessen im Conrad-Micro-Code. Wenn nun etwas
von diesem Speicher fuer die echte Compilierung verwendet wird, bedeutet das fuer die OM
keinerlei Nachteil.

Ich nehme an, dass OCBASR nur fuer die Open-Micro, Open-Mini und Open-Midi, nicht aber fuer
die Nachfolger wie Open-Macro funktioniert.

Das ist derzeit richtig. Zumindest die Einsprungadressen der Betriebssystemroutinen muessten
angepasst werden. Bei Open-Macro und hoehere wird es schwieriger, weil dort auch
16-Bit-Handling zur Verfuegung steht. Aber vielleicht sollte man OCBASR auf 8-Bit-Handling
begrenzen?

Darf man nun noch den Takt auf 8 MHz erhoehen?

Selbstverstaendlich ist das moeglich. Dadurch wird die Geschwindigkeit noch einmal um
Faktor 2,5 erhoeht. Insgesamt waere die OM dadurch an die 150 mal so schnell wie die
Original-C-Control!

Viel Spass beim Beschleunigen von OCBASIC-Programmen!

Dietmar Harlos
dharlos@web.de
http://ccintern.dharlos.de
http://om.dharlos.de

