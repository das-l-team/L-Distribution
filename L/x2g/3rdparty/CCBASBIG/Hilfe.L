[ Die |_ Distribution - Anwendungsunterst�tzung ]


   Wir verwenden das Tool CCBASBIG.EXE als Referenzkompiler, um zu
   untersuchen ob ein CCBASIC-Quelltext voraussichtlich auch mit frueheren
   Versionen der Original-IDE von Conrad-Electronic kompiliert werden kann,
   welche wohl noch immer auf Begleit CD's zur C-Control I im Umlauf sind.

   CCBASBIG.EXE erm�glicht einen Programmumfang von max. 32000 Bytes.
   Das verwendete Zielsystem mu� nat�rlich �ber entsprechende Programm-
   speicherkapazit�t verf�gen. (Die Original C-Control I 1.1 hat 8 KiB
   Speicher und kann bei einem Materialkostenaufwand von ca. f�nf Euro
   mit dem EEPROM (24C1024) auf 128 KiB erweitert werden.)

   Es werden keine  Variablenliste ".VAR" und keine Zwischendatei ".TMP"  erstellt.

   Sofern eine Auflistung der ersten 24 im Programm tats�chlich verwendeten
   Variablen ben�tigt wird, kann der C-Control/BASIC Quelltext via Taste F9
   kompiliert werden. Die Distribution kombiniert dann den C-Control/BASIC
   Parser von Dietmar Harlos mit der ebenfalls unter  http://ccintern.dharlos.de
   bereit gestellten erweiterten Version des C-Control/BASIC Kompilers.

   Vorteile der zweiten M�glichkeit ist die Verwendbarkeit mehrzeiliger
   IF..THEN Afragen in CCBASIC Quelltexten, bis zu 256 Variablen bei define
   (vgl. http://ccintern.dharlos.de/mehrvars.zip), die genannte Variablen-
   liste, und die Umgehung eines Bugs des C-Control/BASIC Kompilers.

   Nachteile sind eine maximale Programmgr��e von nur 8099 Bytes und eine
   kleine Inkompatibilit�t des Parsers zu Quelltexten die bestimmte
   Formatierungszeichen (Tabulatoren, ASCII-Kode: 9 ) enthalten.

   Am Beispiel eines Programms von Mario Fischer,

   "L:\x2g\Beispiel\CCBASIC\PARSERTEST\Infrared.bas"

   l�sst sich diese kleine Inkompatibilitaet des Parsers aufzeigen:
   W�hrend die Kompilierung im CCBASIC-Referenzmodus (Taste F12)
   durchl�uft, meldet der Parser (Taste F9) mehrere Fehler bei DEFINE.

   Dies liegt vermutlich an Tabulatorzeichen mit dem ASCII-Kode '9' zwischen
   der jeweiligen Define Direktive und der in der  Zeile folgenden Konstante.
   Ersetzt man den Tabulator durch Leerzeichen (ASCII-Kode: 32 ), erfolgt keine
   Fehlermeldung des Parsers.

   Der vom jeweiligen Kompiler erzeugte Bytekode ist in beiden F�llen identisch.
   Es wird sich also nicht um die in der Dokumentation beschriebene Funktion
   des Parsers, einen unentdeckten Fehler im CCBASIC Kompiler zu verhindern, handeln.


    | Der Pfad zum ZIP-Archiv mit Marios Projektarchiv zum Infrarotempfang mit
    | C-Control lautet  "L:\x2g\Beispiel\CCBASIC\PARSERTEST\infrared.zip"
    | Zwei weitere Projekte zu Infrarot- Empfang und Aussendung k�nnen evt.
    | im Downladbereich von   http://ccintern.dharlos.de  geladen werden.
    | (linke Seite, dort unter Hardware und Wetterstation nachgucken)

Hinweis

 Technisch bedingt k�nnen C-Contol/BASIC Programme > 8099 Bytes (Bytekodeumfang)
 die mehr als 24 Variablen per 'define' nutzen von dieser Ausgabe der |_ Distribution
 nicht kompiliert werden.


 Alternative M�glichkeiten

  - Kombination der offiziellen Windows-IDE 1.33 von Conrad-Electronic aus 1997
    mit dem Programm DLL-Switcher von Idel. Hiermit kann zus�tzlich die Baudrate
    zum Mikrokontroller ver�ndert werden, was f�r Overclocker hilfreich sein kann.


 - Verwendung der letzten offiziellen Version der Windows-IDE
   "Conrad C-Control/CCBASIC 2.0 IDE"


 Es sei erw�hnt dass die alternativen BASIC-Dialekte und Cross-Kompiler mBASIC, BASIC++,
 C-Control/C-Cross-Compiler, Open-Control/BASIC - auch allesamt maximal gro�e Programme
 bei maximaler Anzahl Variablen per 'define' erm�glichen.


 Durch die fast 1:1 Abbildung der CCBASIC Anweisungen auf den daraus erzeugten Bytekode
 ist der C-Control/BASIC Kompiler sehr gut geeignet tiefer in die Funktionsweise der
 Virtuellen Maschine des C-Control Systems einzutauchen.





