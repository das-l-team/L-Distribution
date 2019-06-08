[
  Vor dem Kompilieren eines Open-Control/BASIC Quelltextes mit der
  L-Distribution bitte dessen Dateinamenserweiterung in '.OCB' umbenennen.
  z.B.: 'MELODIE.BAS' wird zu 'MELODIE.BAS.OCB')

  Zusaetzliche Informationen zum Open-Control/BASIC Kompiler und
  weitere Beispielprogramme koennen unter der Adresse des Open-Control Projekts

     http://om.dharlos.de

  abgerufen werden.

  Informationen zum Echter Open-Control/BASIC-Compiler Version siehe auch:

     L:\x2g\Info.L
]

 "Open-Control/BASIC-Compiler Version 1.12a - 32 Bit - experimentell 1 -"

  Mit L-Distribution 0.29 kommt bereits der neue Open-Control/BASIC Kompiler 1.12a
  und die dort integrierte komfortable 32 Bit Erweiterung als Standardwerkzeug
  zum Einsatz. Auch wenn sich Version 1.12 in der Statuszeile noch als experimentell
  zu erkennen gibt - es scheint es keinerlei Probleme zu geben. Die neue Version erzeugt
  grundsaetzlich zunaechst einmal identischen Bytekode verglichen mit der Vorgaengerversion.
  
  Darueber hinaus kann erstmals in OCBASIC der Datentyp LONG transparent mittels
  Kompilerdirektive 'option 32 Bit' aktiviert werden, sofern die Open-Maxi als
  Zielsystem verwendet wird.
 
  Mit der neuen Version 1.12a laesst sich die 32 Bit Arithmetik jetzt
  ganz besonders komfortabel auf der Open-Maxi programmieren und die Open-Maxi
  verarbeitet jetzt Zahlen von -2147483648 bis +2147483647. Und auch ein
  schnelles 32-Bit-SQR ("Wurzelziehen") ist enthalten.
  
  Bitte beachten: Zuvor muss die 32-Bit-Funktionalität im Hauptprogramm mit der
  Kompilerdirektive  "OPTION 32BIT" aktiviert werden. Ausserdem ist URToken=ON zu setzen.

  Bei Verwendung von "OPTION 32BIT" sind derzeit noch folgende Einschraenkungen
  zu beachten:

  * nur vier Einträge auf dem Rechenstack verfügbar (bei Pointer weniger)
  * belegt rund 1900 Byte Programmspeicher
  * solange aktiv, wird die Befehlsausführung erheblich gebremst
  * Benutzt den Speicher FREERAM1 und FREERAM2
  * einige Funktionen (INPUT, TIMER, usw.) arbeiten nur in 16 Bit
  * Carry wird nicht zurückgeliefert
  * RealPop=ON wird nicht unterstützt

  Weiterfuehrende Informationen zum neuen Open-Control/BASIC Kompiler - und Fragen
  koennen am besten entlang des zugehoerigen Diskussionsfaden im Forum der C-Control Intern
  Website diskutiert werden:

     http://ccintern.dharlos.de/forum/lesen.php?eintrag=16704

  Wie gesagt, diese Entwicklingslinie des Open-Control/BASIC Kompilers ist (Oktober 2018)
  brandneu und es wurde vom Autor noch keine offizielle Versionsgeschichte zu den Neuerungen
  heraus gegeben.

  An deren Stelle sei zunaechst noch die offizielle Versionsgeschichte bis
  zur einschliesslich Version 1.11 (22. April 2017) hier wiedergegeben:

--->%----------------%<---------------------%<------------------->%-----------

Open-Control/BASIC-Compiler v1.11 - 16 Bit & 32 Bit
von Dietmar Harlos ab 20. Juli 2005 bis 22. April 2017


Da das Copyright zu CCBASIC bei Conrad Electronic liegt, habe ich kurzerhand
"Open-Control/BASIC" ins Leben gerufen, um fuer die Open-Micro, Open-Mini,
Open-Midi, Open-Macro und Open-Maxi eine offizielle Programmiersprache zu
haben. Dieser BASIC-Dialekt soll soweit sinnvoll moeglichst 100% kompatibel
zur CCBASIC-Syntax sein, aber trotzdem viele neue Features wie beispielsweise
mehrzeiliges als auch einzeiliges IF, WHILE..WEND, REPEAT..UNTIL, Funktionen
und Subroutinen (Prozeduren) in Standardsyntax bieten. Die neueste Version
unterstuetzt nun auch das Erstellen von Assemblerroutinen. Damit koennen
BASIC- und Assembler-Befehle innerhalb der gleichen Sourcecode-Datei benutzt
werden. Assemblerroutinen sind so deutlich komfortabler zu entwerfen. Unter
anderem kann in Assembler auf alle vom Anwender definierten Variablen und
auf die meisten internen Variablen zugegriffen werden.

Ich habe einige Zeit ins Austesten gesteckt und insbesondere darauf geachtet,
dass der Compiler moeglichst sinnvolle Meldungen ausgibt, falls waehrend der
Kompilierung Fehler auftreten.

Defaultmaessig wird Tokencode erzeugt, der die neuen Befehle der Open-Micro
nutzt und auf diese Weise die Programmgroesse um typisch 20% reduziert und
die Befehlsausfuehrung beschleunigt. Mit Hilfe der Option "CCBAS" ist es
aber moeglich, zu bisherigen C-Control-Versionen kompatiblen Tokencode mit
bis zu 64 KB Groesse zu erzeugen. Der Compiler kann statt CCBAS.EXE in die
DOS-IDE oder in die Windows-Entwicklungsumgebung ConTEXT eingebunden werden.

Der Compiler erzeugt als Ausgabe eine DAT-Datei mit dem Tokencode. Der Code
kann nach der Kompilierung mit einem Downloadtool wie OMDLWIN.EXE, CCDL.EXE
oder OMDL.EXE zur C-Control, bzw. zum OM-Controller gesendet werden.

Die Datei OCBAS.EXE enthaelt die aktuelle Version des Open-Control/BASIC-
Compilers. Ausserdem gibt es aktuelle INCLUDE-Dateien fuer die OM-Controller
und diverse Beispielprogramme, die vor allem die Nutzung des neuen integrier-
ten Assemblers demonstrieren! Und bei den TOOLS gibt es eine ressourcen-
schonende OCBASIC-Version 0.84 ohne Assembler fuer sehr alte Rechner (8086).

Es gibt eine 32-Bit-Version vom Open-Control/BASIC-Compiler namens
OCBAS32.EXE, die statt OCBAS.EXE in die ConTEXT-IDE integriert werden kann.
Diese 32-Bit-Version ist - anders als die 16-Bit-Version OCBAS.EXE - auch
unter Windows Vista und Windows 7 lauffaehig.

Ab Version 1.11 wird bei erfolgreicher Compilierung eine MAP-Datei generiert,
die Informationen ueber die definierten Bezeichner enthaelt. Ausserdem wird die
Anfangsadresse und der Tokencode der verschiedenen Programmzeilen aufgefuehrt.

Dokumentation zum Compiler existiert, abgesehen vom Demo-Sourcecode, in Form
der umfangreichen Bedienungsanleitungen zur Open-Micro, Open-Mini, Open-Midi,
Open-Macro und Open-Maxi. Sie sind auf der offiziellen Site zur OM
(http://om.dharlos.de) erhaeltlich.


Liste der Dateien in diesem Archiv:

OCBAS.EXE .... Der Compiler - kann z.B. in die DOS-IDE eingebunden werden
OCBAS32.EXE .. Der Compiler als 32-Bit-Version fuer Windows Vista und 7
OM ........... Verzeichnis mit Demoprogrammen fuer die Open-Micro/Open-Mini
CC ........... Verzeichnis mit Demoprogrammen fuer die C-Control Version 1.1
TOOLS ........ Verzeichnis mit einigen Hilfsprogrammen, siehe INFO.TXT


Hier die Liste der Bugfixes und Erweiterungen seit OCBASIC 0.81:

Behoben in 0.82:
  - bei ADD und SUB kein Fehler bei Verwendung ungueltiger Variablentypen

Behoben in 0.83:
  - Namen von Tabellen koennen bestehende Labelnamen sein
  - Tabellennamen koennen doppelt vergeben werden
  - bei ungueltigem Vergleichsoperator (">>") kommt interner Fehler
  - vor Remark (') musste ein SPACE stehen
  - ELSEIF und ENDIF fehlen in CCE.TOK fuer DOS-IDE

Erweiterung in 0.84:
  - WHILE TRUE und WHILE ON werden jetzt optimiert (spart 4 Byte)

Erweiterung in 0.90:
  - integrierter 6808-Assembler, der z.Z. nur von der OM unterstuetzt wird

Erweiterung in 0.91:
  - Prozeduren (PROCEDURE) und Funktionen (FUNCTION) hinzugefuegt, damit
    der Anwender dafuer nicht mehr ein Label, POP und REMOVETOS verwenden
    muss. Dadurch ergibt sich ein Komfortgewinn und der Sourcecode ist
    besser lesbar.
  - REMOVETOS wird, wenn Code fuer die C-Control V1.1 erzeugt wird, jetzt
    in ein SYS &h1499 umgesetzt. Dadurch ist mit "OPTION CCBAS" erstellter
    Code, der REMOVETOS enthaelt, nicht auf der OM, der C-Control V2.0x,
    V1.2 und Conrad-Micro lauffaehig. FUNCTION und PROCEDURE enthalten
    versteckte REMOVETOS-Befehle, falls mehr als ein Parameter vom Stack
    geholt wird.

Erweiterung in 0.92:
  - die OM10.INC-INCLUDE-Datei wurde um viele Definitionen erweitert, die
    besonders fuer Nutzer des integrierten 6808-Assemblers sinnvoll sind
  - neue Beispielprogramme erstellt, um die Faehigkeiten des Assemblers
    zu demonstrieren (u.a. CRC32, DTMF-Signalausgabe und Debugging)
  - neuer Befehl INLINE, der wie !DB Daten in den Code einfuegt
  - Subroutinen (PROCEDURE) und Funktionen (FUNCTION) werden durch INLASM-
    Schluesselwort zu Assemblerroutinen. Der Compiler erzeugt automatisch
    einen INLASM- und RETURN-Tokenbefehl und ein INLASM-Label.
  - Bei Subroutinen und Funktionen am Programmbeginn wird automatisch ein
    "GOTO main" davor kodiert. Wenn zusaetzlich INLASM angegeben, wird
    die IAR als IIAR angesehen. Das GOTO ist also einsparbar. Das ist aber
    nicht der Fall bei IIARs in Tabellen oder mit einfachem Label.
  - bei Subroutinen und Funktionen koennen nun auch BIT-Variablen zur
    Parameteruebergabe benutzt werden
  - Labels, Subroutinen und Funktionen mit Assemblercode lassen sich mittels
    SYS aufrufen. Das spart Zeit beim Aufruf gegenueber GOSUB und spart
    einen GOSUB-Stackeintrag.
  - in Assembler koennen nun auch noch nicht definierte Labels bei Befehlen
    mit 16-Bit-Adressierung (u.a. lange Sprungbefehle) verwendet werden
  - Trennzeichen (Komma und Semikolon) bei PRINT sind nicht mehr optional,
    da auch CCBASIC dabei mitunter enorme Schwierigkeiten hat
  - Offset bei Angabe des Indexes bei DEFINE moeglich
  - Offset beim Definieren von Konstanten moeglich (z.B. DEFINE a konst+2)
  - Offset beim Label bei BRA und anderen kurzen Sprungbefehlen moeglich
  - detaillierte Fehlermeldungen, falls ein Bezeichner in Assembler nicht
    verwendbar ist
  - bei vom Compiler als INLASM-Label zu erkennenden Labels (z.Z. nur INLASM-
    PROCEDURE und -FUNCTION) wird wegen der beiden Tokenbefehle INLASM und
    RETURN bei der Verwendung innerhalb des Assemblers und bei SYS auto-
    matisch deren Adresswert um zwei erhoeht
  - interne Variablen der OM koennen innerhalb des Assemblers benutzt werden
  - BIT-, BYTE- und WORD-Variablen koennen in BYTE-, WORD- und LONG-Variablen
    untergebracht werden (z.B. DEFINE a BIT[5] OF b). Das hilft, Variablen-
    ueberschneidungen zu vermeiden.
  - OPTION kann ab jetzt nur noch am Programmbeginn benutzt werden
  - neue Option "OPENMIDI"
  - der INLASM-Befehl wurde wg. Verwechslungsgefahr mit INLASM-Schluessel-
    wort entfernt
  - im Fehlerfall werden aus Sicht des Compilers ueberfluessige Anweisungen
    nun bis Anweisungsende ausgegeben
  - Fehler in der Uebergabeparameterliste bei GOTO und GOSUB wurden nicht
    immer vom Compiler gemeldet (z.B. test (1,2,)
  - Binaerzahlen koennen nun auch mit dem Prefix % statt &b beginnen
  - bei mehr als 20 Fehlermeldungen wird die Kompilierung abgebrochen
  - Kommata sind bei den Assemblerbefehlen CBEQ, DBNZ, BSET, BCLR, BRSET,
    BRCLR und MOV nicht mehr optional
  - Fehler in CBEQ und DBNZ behoben
  - internen Fehler bei Verwendung von BITPORTs und BITs in ASM behoben
  - weitere diverse Verbesserungen, Erweiterungen und Bugfixes

Erweiterung in 1.0:
  - Es wurden wieder einige neue Demoprogramme mit dem Compiler entwickelt.
    Darunter die Erzeugung von Tonsignalen (DTMF) mit Hilfe einer PWM mit
    25 kHz Taktfrequenz bei 7 Bit Werteaufloesung, Tiefpassfilterung eines
    mit rund 4,5 kHz Abtastfrequenz gesampelten Signals und die Verwendung
    einer alternativen Interpreterschleife, die BASIC-Programme rund 10%
    schneller ausfuehren kann.
  - Die Include-Datei OM10.INC wurde in OM.DEF umbenannt. Durch die
    Endung DEF kann der Anwender erkennen, dass in dieser INCLUDE-Datei
    ausschliesslich Definitionen (kein Sourcecode oder Tabellen) stehen.
  - Der Assembler kennt nun folgende neue Alternativsyntax: STC, STI,
    ENABLE, DISABLE, NOTA, NOTX, NOT, XOR, ADDSP, ADDHX und COPY.
  - Bei FOR..NEXT koennen nun auch Pointervariablen als Schleifenvariable
    eingesetzt werden. Pointervariablen besitzen immer BYTE-Format.
  - Das Komma und Semikolon bei PRINT ist wieder optional. Das entspricht
    der Vorgehensweise der meisten BASIC-Dialekte.

Erweiterung in 1.01:
  - Bei "WAIT" kam die falsche Fehlermeldung "fehlender Operator bei PAUSE"

Erweiterung in 1.02:
  - Bei Word-Pointern wurde der User-Ram-Zeiger falsch inkrementiert

Erweiterung in 1.03:
  - Bei z.B. "PUSH" kam die irrefuehrende Fehlermeldung "fehlender Operator"
  - Unterstuetzung der internen Variablen der Open-Midi

Erweiterung in 1.04:
  - Im integrierten Assembler passten die Adressen der internen Wordvariablen
    (FILEPOS, PCADR, IRQADR, ERRADR) bei der Open-Midi nicht.

Erweiterung in 1.05:
  - Eine INCLUDE-Datei wird nun auch im Verzeichnis des Compilers gesucht

Erweiterungen in 1.06:
  - mittels Option "-withfilename" koennen zu ConTEXT kompatible Fehler-
    meldungen erzeugt werden
  - die Kompilierung wird abgebrochen, falls eine INCLUDE-Datei nicht
    geoeffnet werden konnte
  - neue Stringfunktionen ASC, ASCII, CVBYT, CVI und CVWRD
    (Stringkonstanten ohne eine Stringfunktion sollten wegen Verwechslungs-
     gefahr mit Strings nicht mehr verwendet werden!)
  - bei Konstanten wird auch auf der Open-Midi in Faellen, in denen bisher
    ein "PUSH WORDVALUE" verwendet wurde, ein "PUSH BYTEVALUE" generiert
  - rudimentaere Unterstuetzung der Open-Macro
  - neue Konstanten R38400 und R19200 fuer die Open-Macro
  - vorlaeufige Definitionsdatei OMAC0.DEF fuer Open-Macro

Erweiterungen in 1.07:
  - neue Befehle LOOKTABBYTE und LOOKTABWORD fuer die Open-Macro
  - Unterstuetzung der internen Variablen der Open-Macro im 6808-Assembler

Behoben in 1.08:
  - Zwei Zeichen lange Stringkonstanten fuehrten zu Problemen, deshalb werden
    sie nicht mehr unterstuetzt. Es muss jetzt z.B. a=CVI("12") statt a="12"
    verwendet werden.

Erweiterungen in 1.09:
  - Open-Maxi hinzugefuegt
  - PEEK und POKE fuer Open-Maxi hinzugefuegt
  - LCD-Kommandos fuer Open-Maxi hinzugefuegt
  - Assemblerbefehle ASLA, ASLX und ASL hinzugefuegt
  - HCS08-Assemblerbefehl BGND fuer Open-Maxi hinzugefuegt
  - HCS08-EXT-Assembleradressierungart fuer Open-Maxi bei STHX, LDHX und
    CMPHX hinzugefuegt
  - Assemblerzugriff auf Bittypen auf der Open-Macro hinzugefuegt
  - neue Beispielprogramme: MANDEL.BAS und BLUEPETE.BAS
  - Aktualisieren der Includedateien

Behoben in 1.10:
  - In ON..GOTO und ON..GOSUB darf kein Label abgefragt werden, das erst
    hinter dem Befehl definiert wird. Es kommt jetzt die Fehlermeldung
    "Label noch nicht definiert bei ON GOTO/GOSUB".

Erweiterungen in 1.11:
  - es wird eine MAP-Datei mit nuetzlichen Informationen ausgegeben
  - die 32-Bit-Version ist jetzt wieder kompatibel zu Windows 95 und 98


Fehlermeldungen zum Compiler bitte direkt an meine E-Mail-Adresse schicken.

Allgemeine Fragen werden im Forum zur C-Control-1 beantwortet:

http://ccintern.dharlos.de/forum

Viel Spass mit OCBASIC

Dietmar Harlos
dharlos@web.de





 