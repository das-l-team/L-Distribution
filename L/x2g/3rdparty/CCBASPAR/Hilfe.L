[ die |_ Distribution - Anwendungsunterst�tzung ]


  Um einen Open-Control/BASIC Quelltext innerhalb der |_ Distribution
  erfolgreich zu kompilieren, muss dessen Dateierweiterung auf ".OCB"
  ende. Dadurch erst wird der f�r Open-Control/BASIC entwickelte Kompiler
  verwendet. Programme mit der Dateiendung ".BAS" werden innerhalb dieser
  Distribution grunds�tzlich mit dem f�r C-Control/BASIC entwickelten
  Kompiler verarbeitet.

TIPP: Open-Control/BASIC Quelltextdateien vor dem ersten Kompilieren
      umbenennen: 
       
      (Beispiel:) Quelltextdatei "Demo.bas" in "Demo.bas.ocb" umbenennen.


  Zur Komilierung von C-Control/BASIC Quelltexten sind in dieser Distribution
  zwei spezialisierte Kompiler enthalten -

- auf Taste F12:
================

     "CCBASBIG.EXE" von Dietmar Harlos, mit den gleichen Einschr�nkungen
      betreffend IF..THEN..ELSE wie der aus 1998 stammende Original
      CCBASIC-Dialekt, jedoch erweitert m�gl. Programmumfang bis 32000 Bytes.

TIPP: CCBASBIG kann als Referenzkompiler dienen, um die Kompilierbarkeit eines
      Quelltextes mit allen bisher verf�gbaren CCBASIC-IDE's zu gew�hrleisten.
      Hierbei ist darauf zu achten, dass der maximale Programmumfang unter der
      Gr�ssenbeschr�nkung des urspr�nglichen CCBASIC Kompilers liegt: Maximal 8099 Bytes.


1. Die |_ Distribution verwendet als  Referenzkompiler  f�r C-Control/BASIC-
   Quelltexte das Programm CCBASBIG.EXE von Dietmar Harlos. (Taste F12)
   CCBASBIG.EXE erm�glicht eine Programmgr��e von max. 32000 Bytes.
   Das verwendete Zielsystem mu� nat�rlich �ber entsprechende Programm-
   speicherkapazit�t verf�gen.(Die Original C-Control besitzt 8 KiB Speicher.)
   CCBASBIG.EXE hat keine  Variablenliste ".VAR" und Zwischendatei ".TMP"
   Das Originalarchiv befindet sich in "L:\x2g\3rdparty\CCBASPAR\ccbasbig.zip"
   Wenn dein Quelltext auch mit den IDE 1.33 von Conrad Electronic kompatibel bleiben
   soll, verwende diese Toolchain und achte darauf dass dein kompiliertes Programm
   nicht gr�sser als 8099 Bytes wird.
   --------------------------------------------------------------------------


- auf Taste F9:
===============

2. Die |_ Distribution verwendet als  Standard Toolchain  f�r C-Control/BASIC-
   Quelltexte das von Dietmar Harlos entwickelte Programm C-Control/BASIC Parser
   aus dem Archiv  "L:\x2g\3rdparty\CCBASPAR\ccbasparser_v1_1.zip" (Taste F9)
   Diese Toolchain erm�glicht die Verwendung von mehr als 24 Uservariablen und
   mehrzeilige IF..THEN..ELSE Statements. Es wird eine 'Zwischendatei ".TMP"
   erstellt aus der dann das fertige Programm kompiliert wird. Zus�tzlich gibt
   es eine Variablenliste ".VAR" in der die Variablen mit Index verzeichnet
   sind. Die Belegung der Variablenpl�tze kann so leichter erkannt werden,
   zus�tzlich gibt der Parsert eine Warnmeldung aus, wenn im Variablenbereich
   L�cken vorhanden sind die f�r weitere Variablen genutzt werden k�nnen.

   Die maximale Programmgr��e betr�gt kompiliert 8099 Bytes und es besteht
   derzeit eine kleine Inkompatibilit�t des Parsers zu Quelltexten die bestimmte
   Formatierungszeichen (Tabulatoren) enthalten.

   Auch darf hinter einer Deklaration mittels DEFINE kein extra Argument mehr
   folgen wie es z.B. bei den NETWORK-Befehlen notwendig ist. Deshalb k�nnen
   leider nicht alle mit dem Referenzkompiler (F12) verwendbaren Quelltexte
   auch mit der Parser-Kompiler-Kombination kompiliert werden. An einem
   konkreten Beispiel l��t sich dies aufzeigen. Lade dazu den Quellkode

  "L:\x2g\Beispiel\CCBASIC\PARSERTEST\Infrared.bas"

   Die Kompilierung im CCBASIC-Referenzmodus (Taste F12) ist erfolgreich,
   aber bei Druck auf Taste F9 meldet der Parser mehrere Fehler bei DEFINE.

   Dies liegt vermutlich an den Tabulatorzeichen (ASCII-Kode 9) die zwischen
   der jeweiligen Define Direktive und in der Zeile folgenden Konstante
   enthalten sind. Denn, ersetzt man diese Tabulatoren durch Leerzeichen
  (ASCII-Kode 32), erfolgt keine Fehlermeldung des C-Control/BASIC Parsers.

   Nach Ersetzen der Tabulatorzeichen erzeugen beide Kompiler v�llig identischen
   Bytekode. Daher handelt es sich in diesem Fall nicht um die der Parserdokumentation
   beschriebene Funktion zur Umgehung eines Bugs im originalen CCBASIC Kompiler.

Tipp|  Du brauchst aber nicht auf die Tabulatortaste verzichten. Wir haben die
       ConTEXT-IDE so vorkonfiguriert dass Druck auf die Tabulatortaste eine
       entsprechende Anzahl Leerzeichen erzeugt.

   Mit dieser Version des CCBASIC-Parser k�nnen die NETWORK-Befehle nur verwendet
   werden wenn keine DEFINE Anweisung mit mehr als einem Parameter im Quelltext
   enthalten ist: (z.B. 'DEFINE  remoteport1 port[3] at 1')


Tipp|
    | Der Pfad zum ZIP-Archiv mit Marios Projektarchiv zum Infrarotempfang mit
    | C-Control lautet  "L:\x2g\Beispiel\CCBASIC\PARSERTEST\infrared.zip"
    | Zwei weitere Projekte zu Infrarot- Empfang und Aussendung koennen evt.
    | im Downladbereich von   http://ccintern.dharlos.de  geladen werden.
    | (linke Seite, dort unter Hardware und Wetterstation nachgucken)



  ========================================
  Grenzen der enthaltenen CCBASIC Kompiler
  ========================================

   C-Contol/BASIC Programme die, (A) mehr als 24 Variablen nutzen UND, (B) deren Umfang
   nach Kompilierung 8099 Bytes �berschreitet k�nnen mit dieser Ausgabe der Distribution
   aus technischen Gr�nden nicht kompiliert werden.
   Unseres Wissens ist hierzu die Kombination aus Original Conrad Windows-IDE mit dem
   DLL Switcher von IDEL in der Lage. Damit ist allerdings kein mehrzeiliges IF..THEN..ELSE
   Statement m�glich.

   Es sei an dieser Stelle erw�hnt, dass die Syntax der weiter entwickelten Progammiersprachen
   mikrokontrollerBASIC, BASIC++, CCCCC, und OCBASIC ohne die o.g. Einschr�nkungen auskommen
   und zumeist einen h�heren Komfort bieten, z.B. bei der Definition von literalen Konstanten.
   Teilweise erm�glichen diese Weiterentwicklungen objektorientierte Kontrollstrukturen und die
   automatische Verwaltung von lokalen Variablen auf Quelltextebene.

   Im Internet sind noch viele Quelltexte f�r die C-Control I 1.1 zu finden, die ausschliesslich
   im �lteren CCBASIC-Dialekt vorliegen. Aus Gr�nden der Abw�rtskompatibilit�t wird der CCBASIC-
   Dialekt innerhalb dieser Distribution weiterhin vollst�ndig unsterst�tzt.
   

   (Stand: Jan. 2017)


