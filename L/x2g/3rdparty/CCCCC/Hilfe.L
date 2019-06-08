[ Die nachfolgende lokale Datei,

  L:\x2g\3rdparty\CCCCC\handbook-german.pdf

  enthaelt das ausfuehrliche Handbuch zum C-Control/C-Cross-Compiler
  von Oliver Haag.


  Evt. koennen online weitere Informationen zum Compiler erhalten werden.
  Die offizelle Projektseite ist unter

  http://sourceforge.net/project/showfiles.php?group_id=165854)

  Bei Fragen zum Kompiler 'CCCCC' sollte auch das oben genannte Handbuch als PDF gelesen werden.

  (Nachfolgend ein sehr kleiner Auszug aus dem oben genannten PDF-Handbuch, gewandelt ins Textformat) ]

1.1 Compiler
 Der Compiler wird über die Kommandozeile mit Hilfe von Kommandozeilenparametern gesteuert. Die
 Syntax schaut folgendermaßen aus:
 bin/ccccc [Optionen] Datei
 Optionen:
 -a Datei Assemblerdatei einbinden (Nicht zusammen mit -h und -s verwendbar)
 -i Pfad Pfad zu den Include-Dateien
 -l Logbuchdatei erstellen
 -o Datei Name der Ausgabedatei
 -c Programm und Assemblerprogramm im C-Control dat-Format
 -h Ausgabe im Intel Hex-Format
 -s Ausgabe im Motorola S-Records Format
 Datei: Name der Quelltextdatei


2.1.1 #define
 Definiert Konstanten grundsätzlich wie in ISO-C. Der Text vom Ende des Definitionsnames bis zum Zeilenende
 wird beim compilieren an alles Stellen im Quelltext eingefügt wo der Defnitionsname vorkommt.
 Falls ein Kommentar folgt wird nur der Text bis zum Anfang den Kommentars eingefügt.
 Es sind bereits folgende Konstanten standardmäßig definiert:
 false 0
 true -1
 CCCCC [Version] Version: Compilerversion, Hexadezimal (z.B. 1.0.13.2 = 0x10d2)
 C CONTROL [Version] Version: C-Control-Betriebsystemversion (z.B. 1.1 = 0x1100)
 2.1.2 #error
 Gibt eine Fehlermeldung zurüuck wenn die Zeile erreicht wird.
 2.1.3 #ifdef
 Übersetzt die folgenden Zeilen bis zu #endif oder #else (bzw. #elif usw.) nur wenn die folgende Definition
 definiert wurde.
 2.1.4 #ifndef
 Übersetzt die folgenden Zeilen bis zu #endif oder #else (bzw. #elif usw.) nur wenn die folgende Definition
 nicht definiert ist.
 2.1.5 #else
 Übersetzt die folgenden Zeilen bis zu #endif nur wenn die vorige Bedingung nicht zutraf.
 2.1.6 #elifdef
 Übersetzt die folgenden Zeilen bis zu #endif oder #else (bzw. #elif usw.) nur wenn die vorige Bedingung
 nicht zutraf und die folgende Definition definiert wurde.
 2.1.7 #elifndef
 Übersetzt die folgenden Zeilen bis zu #endif oder #else (bzw. #elif usw.) nur wenn die vorige Bedingung
 nicht zutraf und die folgende Definition nicht definiert ist.
 2.1.8 #include
 Bindet Header-Dateien ein wie in ISO-C.
 2.1.9 #undef
 Macht die Definition der folgenden Definition rückgängig.

