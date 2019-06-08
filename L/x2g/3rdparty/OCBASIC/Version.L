
Willkommen zur |_ Distribution [beta]

Bekannte Probleme:

  Auf manchen Systemen wird das Fenster der ConTEXT-IDE
      nach dem Start unvollständig dargestellt.

         So behebst du das Problem:

      1. Minimiere das ConTEXT Fenster über die Schaltfläche
         in der Windows-Taskleiste, anschliessend

      2. Maximiere danach das ConTEXT Fenster über die Schaltfläche
         in der Windows-Taskleiste

         Das Programmfenster ´des ConTEXT Editors sollte daraufhin
         vollständig dargestellt werdem.

 - Lange_Dateinamen_besonders_wenn_diese_Umlaute_und Leerzeichen enthalten_kÖnnen_-zu-Problemen_fÜhren.

 - Unter Vista, W7, W8, W10 sollte nicht in C:\Programme (bzw. C:\Programme (x86) installiert
   werden. Dies liegt vermutlich an den dort geltenden Einstellungen der Windows Access Control List (ACL).

 - Die L-Distribution-Skripte benötigen vollen Dateizugriff innerhalb des L-Distribution Installationsordners ("\x2g\...")

   Abhilfe: Installationsverzeichnis entsprechend wählen, z.B. "C:\L"
             oder auch z.B. "c:\Mein Verzeichnis\L", oder ein anderes als das Systemlaufwerk, z.B. "D:\"

 - Die Installation sollte mit Admimistratorrechten erfolgen, ansonsten kann es speziell unter Windows 7,8,10
   erforderlich werden im Anschluß 'regedit' von der Kommandozeile zu starten um die Dateien

           "L:\x2g\System\SETUP\DE\x2g_XXX_DE_32.reg"
       und
           "L:\x2g\System\SETUP\DE\L-PuTTY_XXX_de_XP.reg"

            manuell zu importieren.

          ('XXX' steht für die höchste vorhandene Versionsnummer)

  - Es wird ein virtuelles Laufwerk L: benötigt. Dazu bitte in der Kommandozeile Folgendes eintippen:

    Subst L: C:\L


Besonderheiten:

  - Dateinamenserweiterungen sind wie folgt den jeweiligen Werkzeugen zugeordnet:

    .ASM, A05                      --> 6805-kompatibler Assembler

    .BAS, .MAP, .TMP, .BAX         --> C-Control/BASIC

    .BPP, .BLIB                    --> C-Control/BASIC++

    .c5, .h                        --> C-Control/C-Cross-Compiler

    .OCB, .PRO, .DEF, .IAR, .IIA   --> Open-Control/BASIC

    .ocbasr (nativ. Maschinencode) --> Open-Control/BASIC (Für Open-Mico/Mini/Midi)

    .AVR, .HEX                     --> WinAVR toolchain, AVR-Brenner (experimentell)


 Tipp

  Öffne im ConTEXT Editor die beiden 'magischen' Dateien "L:\x2g\Hilfe.L" und "L:\x2g\Info.L" !

  Dort erhälst du, passend zum jeweiligen Arbeitsschritt, Informationen zur verwendeten
  3rd-party Komponente, die z.B. aus den Read-Me Dateien der lokal vorhandenen Originalarchive
  wiedergegeben werden. Unbedingt empfehlenswert, nicht nur für technisch Interessierte.


 Arbeitsverzeichnis:

     die |_ Distribution  kann auf ein beliebiges Laufwerk und dort in ein beliebiges
     Unterverzeichnis installiert werden.

     Einzige Bedingung: Dieses Verzeichnis muss mit dem SUBST Kommando so gemappt werden können,
     dass es als neues virtuelles Laufwerk mit dem Laufwerksbuchstaben "L:" erscheint.

     Das Installationsprogramm versucht dies automatisch indem es in der Windows-Registry unter

     HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run  den Schlüsselwert
     MOUNT_L_Distribution_DIR anlegt. Dies erspart dir die manuelle Eingabe nach jedem
     Windows-Start.

Tipp
     Falls das automtatische SUBST nicht funktioniert (Kein Laufwerk "L:" erscheint im Explorer)
     kann  SUBST L: <Installationspfad> auch manuell in der Kommandozeile eingetippt werden.

     Danach erscheint im Dateisystem-Exploer das neue virtuelle Laufwerk "L:" welches unterhalb
     des Installationspfades z.B. "C:\L" zu finden ist.

     Bei Computern an denen viele Laufwerke oder USB-Speicher angeschlossen sind, kann es sein
     dass Laufwerksbuchstabe "L:" schon anderweitig vergeben ist. In diesem Fall muss dann als
     Installationsverzeichnis "L:\x2g\" genommen werden, damit es funktioniert.  SUBST kann dafür
     entfallen, weil bereits das (physikalische) Laufwerk 'L:' auf dem Computer vorhanden ist.



  - Nur C-Control/BASIC: "Via Mausklick zur Fehlerzeile" haben wir leider noch nicht
    hinbekommen. Abhilfe: Einfach nur noch fehler-freien Quelltext schreiben ;-)
    Natürlich kannst du die in der Fehlermeldung genannte Zeile anhand
    der Zeilennummern links im Editorfenster auch manuell ansteuern.
<--[Hier siehst du so eine Zeilenummer]



Historie:

Version 0.29

- Neu:        Nahtlose Einbindung des neuen Open-Control In-System-Debugger (Taste F12).
              Besonderheit: Die zuletzt für die Programmübertragung gewählte Serielle Schnittstelle
              wird automatisch auch für den In-System-Debugger verwendet. (Die Auswahl erfolgt über
              die Tasten F9, F10, F11, F12, während die Datei L:\x2g\Hilfe.L im Editor geöffnet ist.)
              Es ist dadurch möglich, Programme auf bis zu vier separaten OM-Controllern unabhängig
              voneinander - und quasi gleichzeitig zu debuggen!

- Update:     Programmübertragungstool OMDLWIN (Taste F11) aktuelle Version 1.5 - mit Unterstützung für
              AUTOBAUD auf Open-Maxi. Nach der schnellen Programmübertragung mit 115200 baud wird
              automatisch auf 9600 baud zurück geschaltet, damit die üblichen Terminalprogramme mit meist
              nur 9600 baud zur Ansicht der Programmausaben verwendet werden könn. Auch beim Upload auf die
              Open-Macro wird das Verfahren AUTOBAUD unterstützt, Hierzu muß zuvor auf der Open-Macro die
              serielle Hardwareschnitttelle (ESCI) für den Programmupload aktiviert werden. Auf der Open-Macro
              kann der Programmupload mittels AUTOBAUD mit bis zu 38400 baud erfolgen.
              Weitere Einstellmöglichkeiten existieren, wennn das Zielsystem mit Windows und über einen
              FTDI-basierten USB-nach-Seriell Adapter verbunden ist. Siehe auch im Forum:

                                 http://ccintern.dharlos.de/forum/lesen.php?eintrag=16546
                                 http://ccintern.dharlos.de/forum/lesen.php?eintrag=16715


- Update:     Syntaxhighlighting für OCBASIC aktualisiert. Neue Schlüsselwörtern 'psha', 'pshx', 'pshh',
             'pula', 'pulx','pulh', 'bcc', 'bcs' sind enthalten. Als Vorlage diente 'om_context_sh_v23.zip'
              von der OM-Info Site. Zusätzlich werden 'Lbit' Schlüsselwörter und weitere Variablen farblich
              hervorgehoben. Der 7x12 DOS-Zeichensatz (DOS7X12.FON) aus dem oben genannten Zip-Archiv
              wird nun ebenfalls installiert.

- Behoben: Nach dem Kompilieren bestimmter Quelltexte blieb ein Kommandozeilenfenster geöffnet.
           (Einfache Ursache: In der Datei "L:\x2g\3rdparty\OCBASIC\HTMLINFO.bat" fehlte das 'exit')

- Tipp:      .OCB, und .ocbasr-Quelltexte, welche NICHT den OCBASR-Kompiler verwenden, sollten in der letzten
              Zeile mit dem Zeichen <CR> (Carriage Return) abgeschlossen sein. Sonst erscheint nach jedem
              Kompilerlauf ein Fenster mit Tipps zur Verwendung der OCBASR-Erweiterung.

- Update:     Schnelles Dateien-Vergleichstool hinzugefügt, FCB.exe, Version 0.8.2.0,
              mit freundlicher Genehmigung von Uwe Sieber, http://www.uwe-sieber.de .

              Hierzu neues Unterverzeichnis angelegt: L:\x2g\3rdparty\Uwe_Sieber. FCB.exe verspricht schnellere
              Reaktionszeit und weniger Ressourcenbedarf als das Windows-eigene Tool "FC.exe", welches zudem
              in manchen Windowsversionen (ohne installierten Microsoft Hotfix KB953930) fehlerhaft ist.
              Siehe auch: "http://www.sereby.org/site/xpsp3" -> "Wenn die zwei Dateien, die Sie vergleichen, am 128 Byte
              ein TAB oder ein SPACE haben, funktioniert der Fc.exe-Befehl nicht ordnungsgemäß"

              FCB.exe, wird z.B. innerhalb der L-Distribution für die Auswahl der passenden Toolchain verwendet, um
              zu erkennen ob in einem Open-Control/BASIC Quelltext das neue Schlüsselwort "COMPILE" enthalten ist.
              In diesem Fall erscheint nach erfolgter Kompilierung ein verwendet wirdSchlüsselwort kompiliert wird.




- Lbit Firmware Versionsupdate von v.853 auf v.854 (nicht veröffentlicht) und v.855 - Die aktuelle
              Version v.855 der 'Lbit' Firmware für fünf unterschiedliche Speicherausbauten liegt
              dieser Sammlung bei (für 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB). Quelltext enthalten!


       Tipp:  Der vollständige Quelltext der 'Lbit' Firmware ist im Verzeichnis "L:\x2g\L-TOOLS\Lbit-FW"
              Es handelt sich um einen Quelltext im CCBASIC - Format mit erweiterten Variablenpositionen.

            - Behoben v.855:
              Der Systemaufruf "Sekundenimpuls, 1PPS" funktioniert, ist aber unabhängig von der Echtzeituhr.
              "1PPS" wird vom 20ms Systemtimer abgeleitet. Der 20 ms Systemtimer aber ist direkt von der
              Quarzfrequenz abhängig, (bzw. von dem weniger präzisen Schwinger auf der M-Unit) und 'tickt'
              daher nicht unbedingt auch synchron mit der Sekunde der DCF77 Uhr im C-Control.
              Siehe hierzu auch diese Info im Forum: http://ccintern.dharlos.de/forum/lesen.php?eintrag=12238



           Behoben in v.854:

            - LGet_DA3 liefert den Defaultwert '0' ab v.854 auch über den Stack zurück, damit es
              direkt als Funktionsergebnis genutzt werden kann. (In v.853 wurde der Wert für
              LGet_DA3 nur via b24 zurück geliefert, LGet_DA1 u. LGet_DA2 sind nicht betroffen.)
              Da der C-Control I 1.1 aber nur über 2 DA-Kanäle verfügt, liefert LGet_DA3 immer den
              Defaultwert '0', was beim Lbit System auch als "Diese Funktion ist nicht implementiert"
              interpretiert werden kann.

            - Komforterweiterung ab v.854:
              Kompatibel mit Telnet LINE MODE.
              Im Hostmodus wird nunmehr das ASCII-Zeichen 13 sowie auch das ASCII-Zeichen 10 ignoriert.
              Dadurch kann zur Fernbedienung z.B. Telnet unter Linux verwendet werden, ohne dass dort
              normalerweise erst erforderliche Umschalten des (Linux-)Telnet Clients in den sogenannten
              CHARACTER MODE.

            - Erste rudimentäre Einbindung einer CRON-Funktionalität im Hostmodus: Bei aktiviertem UIP erhält
              dieses einen Sekundenimpuls: "1PPS". Hiermit kann man z.B. ein sekündliches Update der
              UIP-Statuszeile mit den Portzuständen komfortabel realisieren.

            - Eine neue L_Call Funktion: Nr. 56,  "#Lbit_Version" bzw. "#BmVers". Diese dient als Ergänzung
              der vorherigen L_Call Funktion Nr. 2 "#BmVersOK" bzw. "#LbitVersOK".
              Hierzu wurde angepasst die (derzeit noch) für OCBASIC 1.11a notwendige Hilfsdatei:
             "L:\x2g\Include\OCBASIC\L-BMCALL.PRO". Ebenfalls wurden die Dateien "L:\x2g\Include\OCBASIC\L-INIT.PRO",
              und "L:\x2g\Include\OCBASIC\L-EXIT.PRO" auf die neue Funktion umgestellt. Die vorherige L_Call Funktion #2
              bleibt aber bis auf Weiteres fuer alte Programme vorhanden. Die Erweiterung erfolgte, nachdem in Lbit v.853
              eine sporadische Fehlermöglichkeit entdeckt wurde. Siehe hierzu auch den nächsten Absatz.



  Geändert: - Zeile 3188: #NotImplemented PRINT "n/a="; --> "(N/A)"; - ergibt dann (N/A)0 bei der Funktionsausgabe Ausgabe.
  Geändert: - Zeilen 2221 bis 2239 verschoben nach, dadurch

              Beschleunigt: - 'v.853 --> v.854 Aufrufe "Call Slot" etwas beschleunigt.
              (Ein zwischengeschalteter GOTO-Sprung konnte dadurch entfallen)

   Behoben: - Eine sporadische Fehlermöglichkeit, welche auftrat wenn die ersten zwei Einträge aus der ersten
              Umwandlungstabelle im Programm zufällig Bytekombinationen enthalten, die wertemässig aus der
              Gruppe von nicht adressneutralen Token des Bytekodeinterpreters der C-Control I 1.1 übereinstimmen.

   Behoben: - Lbit Funktion Nr. 18 LPrg_Run ('RunSlot'). In v.853 wurde die GOSUB Tabelle nicht gelöscht. Dies
              begrenzte die Rekursionstiefe mit der Funktion gestarteter Programme auf 2 (anstatt 4).
              Ursache: In Zeile 2231 fehlte das 'f_CLEAR_GOSUB=TRUE'.

   Behoben: - Lbit Funktion Nr. 18 LPrg_Run ('RunSlot'). Wird als Slotnummer ein negativer Wert uebergeben, oder
              als Slotnummer die '0'

  Geändert: - Format der Fehlermeldung "?NO RET.ADDR." etwas intuitver gestaltet.

 Historie:  - Die nahezu identische Lbit Funktion Nr.17 war davon nicht betroffen: 'RunSlotKeepRam ' Allerdings
              liegen die flags 'f_CLEAR_GOSUB' und 'f_CLEAR_RAM' im Userbyte 14, so dass diese Funktion
              derzeit eigentlich "RunSlotKeepRAMexcept_b14" heissen muesste.
              Seit der (nicht veröffentlichten) Version v.825 erfolgt bereits der UIP Aufruf mittels PUSH-POP Technologie.
              Vorteil: Alle 24 Userbytes bleiben unbeeinflusst und könnten somit zur Parameterübergabe verwendet
              werden. Bei Slotaufrufen mittels Lbit Funktionen 15,16,17, (und natuerlich 18) werden jedoch einige
              der Variablen veraendert. Daher sollten bei RunSlotKeepRam nur die Userbytes 1 bis einschliesslich 12
              zur Übergabe von Parametern an das zur Laufzeit neu zu startende Userprogramm uebergeben werden.


Update des Zip-Archiv: "L:\x2g\3rdparty\OCBASIC\ocbasr32_v202.zip" ersetzt durch "ocbasr32_v202b.zip"
             (Hat keine funktionalen Auswirkungen, lediglich 2 Kommentarzeilen in Quelltexten wurden korrigiert.)


Version 0.28 - 25. April 2017:

    - (Taste: F9)  Update der OCBASIC-Version auf OCBASR 1.11a mit nützlichen Neuerungen:

       1te Neuerung: Es wird jetzt zusätzlich eine MAP-Datei mit Informationen zur internen
           Programmstruktur, inklusive Adressen auch von Forwardlabel erzeugt und kann sehr
           sehr bequem mit einem Doppelklick auf die Statuszeile geöffnet werden.

       2te Neuerung: Das BASIC-Schlüsselwort COMPILE ist hinzugekommen. Mit diesem Schlüsselwort
           lassen sich auf einfachste Weise (und auch noch nachträglich) Quelltextabschnitte, die
           innerhalb von Prozeduren oder Funktionen stehen, per automatischer Umwandlung in halb-
           nativen Maschinenkode deutlich beschleunigen. Dazu muß lediglich das Schlüsselwort COMPILE
           an die Zeile(n) mit den zu beschleunigenden Prozedur/-bzw. Funktionsnamen angehängt, und
           der Quelltext durch Druck auf die Taste F9 einmal neu kompiliert werden.
           Das Schlüsselwort COMPILE wird derzeit von Open-Micro, Open-Mini, sowie Open-Midi,
           unterstützt.
           
           
        - u.a. wurden folgende Dateien in dieser Version neu angelegt oder angepasst:

        L:\x2g\System\BAT\32ocbasR.bat
        L:\x2g\3rdparty\ConTEXT\Highlighters\OCBASIC.CHL (Syntaxhighligting für .ocbasr)
        L:\x2g\System\SETUP\DE\x2g_110_DE_16.reg, L:\x2g\System\SETUP\DE\x2g_110_DE_32.reg
        L:\x2g\System\SETUP\EN\x2g_110_DE_16.reg, L:\x2g\System\SETUP\DE\x2g_110_EN_32.reg
        L:\x2g\System\SETUP\NL\x2g_110_DE_16.reg, L:\x2g\System\SETUP\DE\x2g_110_NL_32.reg
        L:\x2g\System\SETUP\L_Installer_Package.iss L:\x2g\System\SETUP\Test-EXT\TEST.ocbasr

    - (Taste: F12) Update der OCBASIC-Version auf 1.11a - ohne das neue COMPILE Schlüsselwort,
       ansonsten identisch zum Kompiler auf Taste F9 (Für Vergleichszwecke).

    -  Die Version Open-Control/BASIC 1.11a kann (auch) wieder mit den früheren Versionen
       Winsdows 95 & Windows 98 eingesetzt werden.

    -  sonstige kleinere Änderungen


Version 0.27 - 14. April 2017

   - (Taste: F9) Update der OCBASIC-Version auf 1.10a. Das Update informiert den Anwender mit der neuen Fehlermeldung
     "Label noch nicht definiert bei ON GOTO/GOSUB", falls in ON..GOTO und ON..GOSUB Kombinationen ein Label abgefragt
     werden soll, welches erst hinter dem Befehl im Quelltext definiert wird.


   - Behoben: In Version 0.26 musste einmalig nach jeder Neuwahl des Comports das dadurch automatisiert
     geöffnete Terminalfenster von Hand geschlossen werden, sofern als neuer Comport COM2:, COM3:,
     oder COM4: gesetzt wurde (COM1: war nicht betroffen). Simple Ursache: Nach Copy-and-Paste vergessen,
     in den Dateien "L:\x2g\System\BAT\COM_"2","3","4"_.bat"  den Namen der neu zu öffnenden PuTTY-Instanz
     entsprechend anzupassen. Jetzt korrigiert und lautet L2_PuTTY, L3_PuTTY,und L4_PuTTY, entsprechend
     den COM-Ports COM2, COM3, COM4. (Vorher alle:0 "L1_PuTTY")

   - Den BASIC++ Quelltext zur weiteren Bearbeitung an die Workbench++ IDE senden (Taste F12):
     (die Workbench++ von Dierk Schmid, CSSlabs, muss im Standardverzeichnis installiert sein)
     - das evt. noch geöffnetes PuTTYtel Terminal an der aktiven Schnittstelle wird geschlossen.
       

  
   - Platzoptimierung folgender OCBASIC-Includedateien. Dadurch verringert sich nach
     Neukompilierung etwas der Platzbedarf von 'Lbit'-Programmen:

     - "L:\x2g\Include\OCBASIC\L-INIT.pro"
     - "L:\x2g\Include\OCBASIC\L-EXIT.pro"
     - "L:\x2g\Include\OCBASIC\L-BMCALL.pro"

   - Neues Unterverzeichnis für Beispielprogramme zur 'Lbit'-Firmware angelegt:

     - "L:\x2g\Beispiel\OCBASIC\Lbit\"

   - Neues Unterverzeichnis für 'Lbit'-basierte Tools angelegt:

     - "L:\x2g\L-TOOLS\"

   - Zwei Beispielprogramme aus Posting  http://ccintern.dharlos.de/forum/lesen.php?eintrag=16489  hinzugefügt:

     1.) "L:\x2g\Beispiel\OCBASIC\Lbit\LGet_DA.ocb"  2.) "L:\x2g\L-TOOLS\MEMVIEW\LMEMVIEW4f.ocb"

   - Toolchain Assembler, Taste F9:
   
    -'S192Tab': Versionsupdate auf die 32-Bit Version. Die vorherige 16-Bit Version hatte unter den aktuellen
      Windowsversionen eine Fehlermeldung zur Folge und das hilfsweise Einrichten einer DOSBOX-Instanz hätte die
      Assembler-Toolchain spürbar verlangsamt.


   - Toolchain Assembler, Taste F12:

     - Alfred Arnolds Makroassembler (aswcurr.zip) Versionsupdate von 1.42 Beta,[build 114] auf 1.42 Beta,[build 115]
      - Wieder kann das redundante Archiv "aswcurr.zip" zu Vergleichszwecken nachträglich herunter geladen werden.
        Für Details siehe "L:\x2g\3rdparty\CROSS_ASSEMBLERS\ALFREDS\Version.L" bzw. (nach dem Aufruf des Assemblers)
        in den beiden Hilfedateien L:\x2g\Hilfe.L  und  L:\x2g\Info.L

   - S192Tab': Versionsupdate auf die 32-Bit Version.

   - SumatraPDF-settings.txt: Voreinstellung zur automatischen Suche nach Programmupdates von 'true' auf 'false' gesetzt.

   - Verzeichnisse L:\x2g\3rdparty\$_CUSTOMIZED und dessen Unterverzeichnisse entfernt
   
   - Aus Platzgründen die PDF-Dateien im Verzeichnis L:\x2g\Doc\ und den Sumatra PDF-Reader entfernt. Ebenso das
     '7-Zip'-Installationsprogramm aus 0.26. Das L-Distribution Installationsprogramm ist nun gut 10 MiB kleiner.

   - Sonstige kleinere Änderungen




Version 0.26 - 05.01.2017 (on file server from 02.01.2017)

   - Neu: Nach Auswahl der Seriellen Schnittstelle wird das Terminalfenster geöffnet um die neuen
     Einstellungen sogleich testen zu können. Zur Auswahl öffnet man im ConTEXT Editor die
     Datei "L:\x2g\Info.L" und drückt dann eine der Funktionstasten F9, F10, F11, oder F12.

   - Konfigurationsdateien: "x2g_107_DE_16.reg", x2g_107_EN_16.reg, x2g_107_DE_16.reg, "x2g_107_DE_32.reg",
     x2g_107_EN_32.reg, x2g_107_DE_32.reg aktualisiert: Parser Rule für Dateityp: '.L' = "%n" und Tooltipps
     aktualisiert.

   - Diese Datei (vorheriger Name "L:\x2g\Konzepstudie Hinweise.L") umbenannt in "L:\x2g\Version.L"

   - Verzeichnis "L:\x2g\3rdparty\BASICpp\L-WORK.DIR\" umbenannt in "L:\x2g\3rdparty\BASICpp\$_L-WORK.DIR\"
     sowie Datei "L:\x2g\SYSTEM\BAT\32bpp.bat" entsprechend angepasst.
       
   - Verzeichnis  "L:\x2g\3rdparty\Terminal\Windows\termite\L-WORK.DIR"
     umbenannt in "L:\x2g\3rdparty\Terminal\Windows\termite\$_L-WORK.DIR"

   - WIN PIC Programmer als Setup-Datei. (Nicht in IDE eingebunden) von Wolfgang Buescher, DL4YH,
     hinzugefügt (968 KB) in Verzeichnispfad: L:\x2g\3rdparty\DL4YH\WINPIC\

   - Name geändert: Link zum Start der Context IDE (vormals START, jetzt START-L)
                    Bezeichnung |_ Distribution, das |_ Team (auch fuer EN,NL Installationen)

   - Installationsprogramm für das 3rdparty-Tool '7-Zip', Version 16.04 hinzugefügt.
    (Im Verzeichnis L:\x2g\3rdparty\7-Zip\)

   - Neues Werkzeugprogramm 'DAT2TAB' (Version 1.02) von Dietmar Harlos hinzugefügt (Taste F12)
     Es kann DAT-Dateien, welche mit dem OCBASIC Kompiler erzeugt wurden in die CCBASIC-Tabellenform
     konvertieren. Dabei werden im OCBASIC Quelltext vorhandene INLINE Anweisungen vorausgesetzt.
     Ein Anwendungsfall ist z.B. die Portierung bestehender OCBASIC Abschnitte auf CCPLUS, siehe auch
     im Forum http://ccintern.dharlos.de/forum/lesen.php?eintrag=16431
    (Ebenfalls neu in Ausgabe 0.26 ist 'S192TAB'. Damit lassen sich auf entsprechende Weise Assembler-
     programme in die CCBASIC-Tabellenform konvertieren. Mehr dazu weiter unten im Text.)

   - Neue Dateizuordnung ".TAB" und Icon für ".TAB" Dateien für 'DAT2TAB' und 'S192TAB' Werkzeuge hinzu
     gefügt. (Dateien "L:\x2g\SYSTEM\Setup\Ltab_Icon.ico" und "L:\x2g\SYSTEM\Setup\L_Installer_Package.iss"
     Zeilen 504,559)

   - Arbeitsverzeichnisse für F9 bis F12 bei .OCB, .DAT - wie folgt geändert:
     .DAT - Datei F12: (16) vorher L:\x2g\3rdparty\ccupload\ - jetzt (default)
     .DAT - Datei F12: (32) vorher (default) - jetzt (default)

     Änderungen werden bei Installation mittels Dateien: "x2g_106_xx_16.reg"
     übernommen. (xx=Länderkürzel).

   - Programmupload mittels Tasten F10,F11:
     3rd-party Tool "PSS" hinzugefügt. Ermöglicht das seit Version 0.25 schon mögliche automatische Schließen des
     PuTTYtel-Terminalfensters auch mit Windows-Versionen 95,98,2000, sowie auf Windowsinstallationen bei denen die
     Systemkomponenten "taskkill.exe/tskill.exe" nicht installiert sind. Unter Windows Me und bei bestimmten (Mehrkern)
     Computern kommt es bei Verwendung von OMDLWIN 1.4 als Uploadprogramm (Taste F11) dennoch zu der Fehlermeldung: Die
     serielle Schnittstelle läßt sicht nicht öffnen. Das scheint ein Timingproblem zu sein. Vermutlich unternimmt OMDLWIN
     1.4 keinen Neuversuch bei der Arbitrierung der Serielllen Schnitstelle. Daher bitte das Terminalfenster wie früher
     von Hand schliessen, oder das Übertragungsprogrmm CCTrans32 (Taste F10) verwenden. Das neue Skript in den
     Dateien L:\x2g\System\BAT\SBMU_01,_02,_03,_04.bat verwendet folgende Reihenfolge: %windir%\system32\tskill.exe,
     %windir%\system32\taskkill.exe, L:\x2g\3rdparty\rejetto\pss\pss.exe.

   - 3rd-party Terminalprogramm PuTTYtel: Versionsupdate von 0.63 auf 0.67 (nur PuTTYtel, ohne SSH-Modul)
     - Neue Einstellungen seit Version 0.25:
       - Return Key=Control-M, Backspace=Control-H,
       - PuTTYtel-Terminalfenster nicht mehr dauerhaft im Vordergrund halten.

   - 3rd-party Tool Sumatra PDF: Versionsupdate von 3.0 auf 3.1.2 - Diese Version unterstützt auch (wieder) ältere PC,
     mit Prozessoren ohne die SSE2 Befehlserweiterung. Zusätzlich werden neuere Versionen der unrar.dll unterstützt,
     sowie auch Windows Server 2003.

      - Seit Version 3.1.1 werden vom aktuellen SumatraPDF Reader alle Windows Versionen ab Windows XP bis einschließlich
        Windows 10 unterstützt. Dies schliesst jetzt auch Windows Server 2003 ein. Dadurch kann  das bis einschließlich
        L-Distribution 0.25 für Windows Server 2003 Systeme mitgeführte Installationsprogramm der Sumatra-Version 2.5
        beginnend mit Ausgabe 0.26 der L-Distribution nun entfallen .

      (Installiert wird folgende Sumatra PDF Version:    (Auf folgendem Betriebssystem:)

              (Keine verfügbar für Win95)               Win95         (BelowVersion: 4.10,4.10;)
               Version_0.7                              Win98-NT      (MinVersion: 4.10,4.10;)
               Version_0.9.1                            Windows2K     (MinVersion: 5.0,5.0;)
               Version_3.1.2               WinXP, Server 2003, 10     (MinVersion: 5.1,5.1;)

     Siehe auch: www.sumatrapdfreader.org/news.html
   
   - Neues UnterverzeichnisTool L:\x2g\3rdparty\ReactOS\Tools\ angelegt und das Kommandozeilentool 'uptime.exe'
     aus dem 'ReactOS' Projekt (http://reactos.org) dort abgelegt. 
     
   - Toolchain Assembler, Taste F9:

     - Werkzeugprogramm 'S192TAB' von Dietmar Harlos eingebunden. 'S192TAB' generiert aus der .S19 Datei eine
       Datentabelle, welche das Assemblerprogramm enthält. 'S192TAB' ähnelt dem Werkzeug 'DAT2TAB' (s.o.),
       nur mit dem Unterschied, dass hier als Eingabedatei ein Assemblerprogramm dient.

     - Kommandozeilenoption '-c' aktiviert. Dadurch wird in der Listingdatei '.LST' die Anzahl der jeweils
       benötigten Prozessorzyklen neben den Mnemonics der Assemblerbefehle in eckigen Klammern dargestellt.

     - Kommandozeilenoption '-z' aktiviert in 'L:\x2g\System\BAT\16as05.bat' und 'L:\x2g\System\BAT\32as05.bat'
       Dies ermöglicht die Verwendung von ALIGN in Assembler Quelltexten für den C-Control I 1.1 Mikrokontroller.
       Einen Beispielquelltext "START.ASM", der ALIGN nutzt, findet man im Kapitel 13 der Fachbuchusgabe
       'C-Control Hardware-Erweiterungen' von Burkhard Kainka.

Tipp: Seit Mitte Mai 2016 stellt Burkhard Kainka sein Fachbuch 'C-Control Hardware-Erweiterungen' im PDF-Format
      auf seiner Website www.b-kainka.de kostenlos zum Download bereit. Siehe auch http://www.b-kainka.de/cc3.htm#dl



     - Toolchain Assembler, Taste F12:

     - Alfred Arnolds Makroassembler (aswcurr.zip) Versionsupdate von 1.42 Beta,[build 98] auf 1.42 Beta,[build 114]
     - Doppelte Kopien der HTML-Anleitung im Verzeichnis L:\x2g\3rdparty\CROSS_ASSEMBLERS\ALFREDS\ durch Verknüpfungen
       zum unterliegenden Verzeichnis $L-WORK.DIR\bin\.. ersetzt. Um Speicherplatz zu sparen ist bereits seit Ld-0.25 das
       redundante Archiv "aswcurr.zip" nicht mehr enthalten. Das Archiv kann zu Vergleichszwecken nachträglich herunter geladen
       werden. Für Details siehe "L:\x2g\3rdparty\CROSS_ASSEMBLERS\ALFREDS\Version.L" bzw. (nach dem Aufruf des Assemblers)
       in den beiden Hilfedateien L:\x2g\Hilfe.L  und  L:\x2g\Info.L



 - Neue Includedatei "L:\x2g\Include\OCBASIC\32BITASM.PRO" für 32-Bit-Arithmetik aus dem Open-Micro Projekt übernommen.

 - Neues Unterverzeichnis angelegt: L:\x2g\Include\TABLES\

 - Neues Unterverzeichnis mit Programmen zum Applicationsboard 1.1 angelegt: L:\x2g\Beispiel\CCBASIC\Appbrd

   - Beispielprogramme in Verzeichnis L:\x2g\Beispiel\CCBASIC\POWERLINE MODEM\:
     Versionsupdate der Dateien NET1.BAS von 08.09.1998, 15:31 auf -> 26.11.1999, 22:09
                                NET2.BAS von 08.09.1998, 15:44 auf -> 26.11.1999, 21:57
                                NET3.BAS von 09.09.1998, 08:56 auf -> 26.11.1999, 22:02
                                NET4.BAS von 15.09.1998, 17:56 auf -> 26.11.1999, 22:06
                                NET5.BAS von 09.09.1998, 10:24 auf -> 06.04.2016, 21:16 (Stand: 19.12.1999, 01:54)

     Anmerkung: Die angezeigten Timestamps können, je nach verwendetem Computersystem, um plus/minus 1 Stunde variieren,
                das liegt wohl an den jeweils verwendeten Betriebssystemeinstellungen, und kein 'richtiger' Fehler.

  Die Versionsupdates betreffen hier lediglich die hinzugefügten Kommentarzeilen. Am eigentlichen Quelltext der Programme
  wurde nichts verändert. Da der Kompiler keine Kommentarzeilen in die aus dem Quelltext erzeugten .DAT Dateien übernimmt,
  bleiben die kompilierten Programme natürlich ebenfalls unverändert.  Beachte: Im Quelltext "NET5.BAS" wurde der in neuerer
  Version vom 19.12.1999, 01:54 fehlende Kommentartext "erstes der 24 Userspeicherbytes" (in Zeile 29) aus didaktischen
  Gründen wieder hinzugefügt. Die Datei hat deswegen den Timestamp 06.04.2016 21:16 befindet sich aber auf dem Stand vom
  19.12.1999, 01:54 Uhr.

   - (Noch:) Quelltexte der Beispielprogramme - sofern dort Datentabellen inmitten von Programmanweisungen standen, wurden diese
             auskommentiert (um Abstand der Zeilennummern zu bewahren) und jeweils eine 1:1 Kopie an das Programmende verschoben.
             Dies folgt der ursprünglichen Empfehlung, in CCBASIC-Programmen Datentabellen stets am Ende eines Programms, hinter
             allen anderen Programmanweisungen zu abzulegen. Dies ist auch Voraussetzung zur Nutzung der 'Lbit' Firmware unter
             C-Control I 1.1. Die Möglichkeit, mittels "Tabellentrick" eigene Tokenbefehle zu definieren bleibt natürlich erhalten.



 - Toolchain Taste F9, F12 für *.bas, "Quelltext kompilieren ...":


   - Taste F9 (mit C-Control/BASIC Parser): Wie schon in der Original IDE von Conrad, lassen sich externe Tabellendateien
     unter CCBASIC nur verwenden wenn diese im selben Verzeichnis stehen wie der BASIC Quelltext. Man kann leider keine
     Pfadangabe schreiben (TABLE Meine_Tabelle "L:\x2g\..."). Siehe auch diesen  Thread im Forum der C-Control Intern
     Website: http://ccintern.dharlos.de/forum/lesen.php?eintrag=16418

     In diesem Zusammenhang:

     - Taste F12 (CCBASIBIG) In Zeile 17 der Steuerdatei "L:\x2g\System\BAT\32basbig.bat" Ausgabe der
                             Statusmeldungen von vormals "L:\x2g\OUT1.txt" nach >NUL: geändert.



   - Toolchain Taste F9  für *.dat, "Bytekode aus Zielsystem im C-Control/BASIC Format darstellen":
     - Das PuTTYtel Terminalfenster wird auch hier automatisch geschlossen (Freigabe der Seriellen Schnittstelle)
     - Das zu lesende Zielsysstem kann jetzt über COM:1, COM:2, COM:3 oder COM:4 ausgelesen werden.
     - Die aktive Schnittstelle entspricht jeweils derjenigen die auch zur Programmierung ausgewählt ist.

    !!  (erledigt??


   - Kleinere Anpassungen, Berichtigung von Druckfehlern:
     - L:\x2g\System\MSG\DE\dbBasBIG.txt
     - L:\x2g\System\MSG\DE\INFO_COPYRIGHT_CCTOKBAS.txt




Version 0.25 - Wednesday, October 21, 2015 - 4:29 pm

   - Toolchain Assembler, Taste F12:
     - Alfred Arnolds Makroassembler (aswcurr.zip) Versionsupdate von 1.42 Beta,[build 98] auf 1.42 Beta,[build 104]

   - Dateityp ".s19", Taste F12:
     Den richtigen Hinweistext im externen Programmer-Fenster (re)aktiviert.

   - Programmupload mittels Tasten F10,F11:
     Um die Serielle Schnittstelle freizugeben braucht das evt. noch vorherigen Upload geöffnete Terminalfenster
     nicht mehr manuell geschlossen werden*. Dies geschieht nunmehr automatisch, sofern das
     verwendete Benutzerkonto das Beenden des Terminalprogramms (mittels taskkill, bzw. tskill unter XP)
     zulaesst.

     Es wird nur das "eigene" beim vorhergehenden Programmupload automatisch geöffnete Terninalfenster
    (Fenstertitel z.B. "|_ 1 Verbindung zum Zielsystem - via PuTTY - die |_ Distribution") automatisch
     geschlossen, und keine anderen Programme, die evt. nachträglich vom Anwender gestartet wurden und
     ggfs. die für den Upload benötigte Serielle Schnittstelle belegen.

     Auf Systemen mit mehreren Seriellen Schnittstellen wird nur jenes Terminalfenster geschlossen welches mit
     der derzeit für den Programmupload ausgewählten Seriellen Schnittstelle verbunden ist. Die anderen bleiben
     unbeeinflusst.

   * Erfolgreich getestet mit Windows XP, Windows7-64bit, Windows 10.
     Unter Windows 95,98,Me kann es weiterhin erforderlich sein das Terminalfenster manuell zu schliessen.

   - Korrektur in Datei L:\x2g\System\BAT\SBCO_B4.bat -> Baudrate von 10416 baud auf 9600 gesetzt (War übrig
     geblieben aus einem Versuch zum beschleunigten Programmupload nur auf COM4: mit OMDLWIN)

Tipp: Mit den Funktionstasten F9, F10, F11, bzw. F12 kann die zu verwendende Serielle Schnittstelle (COM1: bis
      Com4:) ausgewählt werden indem eine dieser Tasten gedrückt wird während die Datei L:\x2g\Info.L, oder eine
      beliebige Datei mit Dateinamenserweiterung ".L" im Editorfenster angeklickt ist.


   - Terminalprogramme:
     Terminal32.exe von Dietmar Harlos in Verzeichnis L:\x2g\3rdparty\Terminal\Windows aufgenommen.

   - Registrierung der Dateitypen:
     Hinweistexte für die Windows Dateitypzuordnung überarbeitet.

   - Dateigrösse der Installationsdatei verkleinert gegenüber Vorversion.


Version 0.24 - 31. Juli 2015



   - PuTTY-Antwort auf ASCII-5 ("Answerback to ^E") in den PuTTY-Terminaleinstellungen
     deaktiviert. Hintergrund: In der Default-Einstellung antwortet das Terminalprogramm PuTTY
     selbsttätig beim Eingang des Zeichens (ASCII Wert 5) mit dem String   PuTTY  . Diese 5
     Buchstaben werden also ohne Zutun an das Zielsystem gesendet werden, was in bestimmten
     Anwendungen unerwünscht sein könnte. Deshalb jetzt deaktiviert.

   - PuTTY-Titelleiste in der Spracheinstellung deutsch geändert zu:
     "|_1 Verbindung zum Zielsystem - via PuTTY Terminal - die |_ Distribution"

     (Version 0.23 war: "|_1 Comport -(PuTTY Terminal) - die |_ Distribution")

   - PuTTY-Einstellungen: Fullscreen on Alt-Enter = True
      Damit kann das PuTTY-Fenster auf Bildschirmgrösse gebracht werden.

   - Der Font DejaVu LGC Sans Mono, 12-point - wird für die Darstellung im PuTTY-Terminal
     verwendet und mit installiert, falls dieser noch nicht im System enthalten ist.
     Evt. scheitert aber die Installation des Fonts wenn das Installationsprogramm ohne
     ausreichende Zugriffsrechte auf das (Windows-Font-Verzeichnis) gestartet wurde.

   - Nach Installation: Manuelles Eintippen der "Parser-Output-Rule" bei Dateityp .AS05
     und .BPP ist nicht mehr nötig. Tipp: Beim Exportieren via ConTEXT-IDE entstehen
     verschachtelte Anführungszeichen im Quelltext der exportierten Registrierungsdatei,
     die jedoch nicht automatisch maskiert werden... (Wir haben dazu die entsprechnde
     .REG-Datei nach dem Export im Editor geöffnet und die doppelten Anführungszeichen
     jeweils mit \ manuell maskiert ("ParserRule"="\"%n\",%l"). Wichtig ist dieses Wissen
     für User die vorhaben die betreffende Registry-Einstellung zu einem späteren Zeitpunkt
     mit der eingebauten Funktion des ConTEXT-Editors selbst zu exportieren.

   - Toolchain Assembler, Taste F9:
       Änderungen in Datei "L:\x2g\SYSTEM\BAT\32as05.bat"
     - Zeige auch Anzahl der Prozessorzyklen in der List-Datei (Schalter -c).

     - Ausgabebreite Listdatei (Schalter -w), auf 138 gesetzt, z.B. gut passend zu einem ab 1400
       Bildpunkte breiten Ausgabebildschirm. (Vor dieser Änderung in Version 0.24 war -w ohne
       Parameter und so daher wurde die Defaultbreite von 131 Spalten verwendet)

   - Toolchain Assembler, Taste F12:
    - Alfred Arnolds Makroassembler (aswcurr.zip), Versionsupdate von 1.42,[build 97] auf 1.42[build 98]

   - Toolchain BASIC++, Taste F9:
       Anwendbarkeit auf Dateien mit der Endung .blib vervollständigt

   - Neue Registrierungsdatei exportiert: hierzu neue

   - Verzeichnis L:\x2g\3rdparty\RADIO_RESSOURCES hinzugefügt.


Version 0.23 - Mai 2015

 - Toolchain Assembler, Taste F12:
   Ausgabe im Intel HEX Format hinzugefügt (Schalter -s2). Hinweistext auf Workaround zur
   Erzeugung einer raw-Datei (*.BIN)

 - CCBASIC 32kB:
   Toolchain für Windows Vista, 7, 8, 10 , und ReactOS: Kompilermeldungen in Ausgabekonsole
   funktionieren. Allerdings wird das ASCII-Logo von CCBASBIG im verwendeten Zeichensatz nicht
   richtig dargestellt.

 - Installerskript:

   - Ikongrafiken für verschiedene Quelltexte hinzugefügt / überarbeitet
   - Dateitypzuordnungen für unterstützte Quellformate
   - PDF-Dateien werden mit dem Sumatra PDF Reader geöffnet

 - Alternative Betriebssyteme, Virtualisierung:

   - erweiterter Funktionstest unter ReactOS
   - Anpassung der Toolchain für ReactOS
   - Eine vorinstallierte Virtuelle Maschine mit ReactOS und  die |_ Distribution können
     unter http://visit.ghn-sensorik.de/L-Team/Distribution/beta/ herunter geladen werden.

 - sonstige kleinere Anpassungen



Version 0.22 - 31. März 2015

 - CCBASIC-Toolchain:
   Nach Rückmeldung aus Betatest  "Kompilerung mit DOSBox zu langsam unter
   virtualisiertem Windows XP." "Detaillierte Statusmeldungen der Toolchain
   im DOSBox Fenster nicht erforderlich - lenken eher ab." die Toolchain für
   CCBASIC überarbeitet:

   - DOSBox, cycles von 'auto' auf 'max' gesetzt.
   - Mappen vorhandener PC Laufwerke in die DOSBox etwas überarbeitet.
   - keine Map-Datei aus dem kompilierten Bytekode erzeugen, dadurch etwas schneller.
     (Wer 'program'.MAP Datei braucht, kann 'program'.DAT öffnen und dann F12 drücken)
   - Informativen Text im DOSBox Fenster hinzugefügt, (L:\x2g\System\MSG\dbPbas.txt)
   - Informativen Text im DOSBox Fenster hinzugefügt, (L:\x2g\System\MSG\dbBasBig.txt)
     Ausgabe übermässiger Statusmeldungen unterdrückt (Know How: @ nicht vor den
     Pfad der DOSBox Konfigurationsdatei stellen, wird sonst nicht geparst)
     Erkenntnis: Den grössten Zeitbedarf verursacht der DOS Kompiler in der DOSBox
     Umgebung. Geschwindigkeit ist wohl nicht weiter zu optimieren.

 - Installerskript:
   - Installation der 32 Bit Toolchain erst ab Winversion 5.2 (war 5.1 in v.0.21)

 - Programmbeispiele: Verzeichnis "BASIC++" umbenannt in "BASICpp", weil derzeit die
   Dekompilierung von .DAT Dateien mit der Toolchain für 32/64 Bit Windows (Taste F12)
   nicht funktioniert wenn Zeichenkette '++' im Dateipfad enthalten ist.

 - Auslesen des Zielsystems (Taste F9 auf beliebge .DAT Datei):
   - Bildschirmmeldungen für 16 Bit und 32 Bit Toolchain überarbeitet.
   - DOSBox cycles von 'auto' auf 'max'

 - PuTTY Einstellungen
   Gleicher Font für Schnittstellen 1 bis 6
   Artikel 'the' anstatt 'die' für Fenstertitel der englischen und niederländischen
   Version



Version 0.21 - März 2015

 - Einstellungen zur Steuerung des Zielsystems via CCTrans32, OMDLWIN, PuTTY:
     Die ohnehin leeren Konsolenfenster der Steuerskripte werden jetzt minimiert
     gestartet um einen optisch flüssigeren Ablauf zu erhalten. Bereits umgesetzt
     für Tasten F10 und F11 für Projektdateien .BAS, .BAX, .BPP, .C5, .DAT, .OCB

 - Anpassungen des Installationsskriptes um die |_ Hilfedateien in der
   jeweils gewählten Landessprache lesen zu können. (DE=100%, EN ca. 80%, NL = 0 %)

 - Hinweisfenster zur Auswahl des Installationsverzeichnis hinzugefügt.
   (Dateien L:\x2g\System\SETUP\DE\ChooseDir.L, L:\x2g\System\SETUP\EN\ChooseDir.L)

 - 4 aktualisierte IDE-Einstellungen zum Import in Windows-Registry.
    Es können somit 32 und 64-bit Windows und die Tool-Tips in Deutsch und Englisch
    verwendet werden. (Für Niederländisch wird vorerst die EN Version automtaisch installiert)
    Die neuen Einstellungen zum (ggf. manuell durchzuführenden) Import in die
    Windows Registry sind unter den folgenden Dateinamen zu finden:

     Deutsch, bis WinXP->  L:\x2g\System\SETUP\DE\x2g_102_DE_16.reg
     Deutsch, ab Vista ->  L:\x2g\System\SETUP\DE\x2g_102_DE_32.reg
     Englisch, bis WinXP-> L:\x2g\System\SETUP\EN\x2g_102_EN_16.reg
     Englisch, ab Vista -> L:\x2g\System\SETUP\EN\x2g_102_EN_32.reg


  - sonstige kleinere Anpassungen


Version 0.20 - Februar 2015

 -  Windows 10 Kompatibilität:

    Als Installationspfad sollte nicht das sogenannte 'OneDrive'-Verzeichnis verwendet werden,
    weil dort die automatische Erkennung von Dateiänderungen mittels Timestamp-Vergleich
    beeinträchtigt ist. Dies hat Einschränkungen bei der Benutzung des Editors zur Folge.

    Abhilfe: Den vom Installations-Programm vorgeschlagenen lokalen Installationspfad übernehmen.

       - oder, falls eine Mehrbenutzerumgebung im Netzwerk benötigt ist, auf ein mittels
         UNC-Pfaden bereitgestelltes  Netzwerklaufwerk, ein NAS, oder einen herkömmlichen
         Windows-Freigabe Ordner ausweichen.

    Ob dies ein Bug der von uns zum Test verwendeten Windows 10 Vorabversion (Build 9926)
    ist, oder ob evt. das 'Cloud'-basierte 'OneDrive' selbst diese Einschränkung erzeugt
    wissen wir nicht.


Version 0.20_RC3 - Januar 2015

 -  Frank A. Kingswood's Makroassembler AS05 (Taste F9): Update von Version
    1.42 auf Version 1.44 übernommen (Datei: 14.Jan.2015, 19:55 Uhr) Durch
    das Update kann AS05 wieder unter neueren Windowsversionen verwendet werden
    auch wenn ein Quelltext Programmanweisungen (Mnemonics) mit Grossbuchstaben
    enthält. Dies wurde von der vorherigen Version 1.42/win32 nicht (mehr) unterstützt.

 -  Alfred Arnold's Macroassembler AS (Taste F12): Update von 1.42 Beta, build 88
    auf 1.42 Beta, build 97 übernommen. (Datei: 20.Dez.2014, 17:49 Uhr)

 - Setup-Script: Der E-Mail-Adresse zum Betatest Passwort fehlte ein Buchstabe.
   Dies wurde sichtbar beim vollständigen Lesen der Installationsvereinbarung
   nach Starten des Installationsvorgangs. (Die E-Mail Adresse auf der Downloadseite
   selbst war und ist vollständig.)

 - Sprachversion Englisch:       INFO_COMPORT_SELECTED[..] angepasst.

 - Sprachversion Niederländisch: hilfsweise englischsprachige Dateiversionen
   1:1 übernommen.

 - sonstige kleinere Anpassungen


Version 0.19 - August 2014

 - Erweiterung des Installationsskriptes für 64-Bit Windows Systeme.
   Noch ungelöst: Keine automatsiche Übernahme der Ikongrafiken und
   Dateitypzuordnungen unter Vista, W7, W8...

 - DOSBOX: Auf einigen Computern Fehlermeldung "Im Laufwerk ... befindet
           sich kein Datenträger. (Nach Wegklicken der Meldung funktioniert
           der Kompilerlauf.

 - sonstige kleinere Anpassungen


Version 0.18 - August 2014

 - Installationsskript: Registry-Einstellungen automatisch für ...
    ... ConTEXT Editor, aktuelle Einstellungen:
        x2g_099_de_XP.reg (für Windows XP)
        x2g_099_de_W7.reg (ab Windows Vista, getestet unter Windows 7)

    ... PuTTY   (getestet mit Windows XP, aktuell: L-PuTTY_003_de_XP.reg

  - sonstige kleinere Anpassungen



Version 0.17 - August 2014

  - Problem mit Timestamp aus Installation behoben. Das Hilfesystem
    uber die Dateien L:\x2g\Hilfe.L und L:\x2g\Info.L funktioniert.

  - Weitere Info.L Dateien editiert

  - Dateien aus den enthaltenen Kopien der Originalarchive zwecks Rueckgewinnung des
    originalen  Timestamps erneut entpackt. Wo es sinnvoll erschien den Finalisierungszeitpunkt
    der ersten Betaversion 0.16 (30.07.2014, 17:30) beibehalten. Dies betrifft die Timestamps
    der (bis auf den Timestamp) identischen Kopien aus den jeweiligen Originalquellen. Angezeigte
    Checksummen der beinhalteten Dateien sind erwartungsgemäss ebenfalls identisch.

  - Weitere Quellenangaben und bisher noch fehlende Kopien weiterer Originalarchive hinzugefuegt.

  - neue PuTTY Einstellungen (aktuell:  L-PuTTY_003_de_XP.reg)

  - neue ConTEXT Einstellungen (aktuell: x2g_097_de_XP.reg)

  - Installationsskript: VerAppName etc. verkuerzt zwecks vollständiger Darstellung in Windows
    Kontextmenue.

  - sonstige kleinere Anpassungen


Version 0.16 - 30. Jul 2014 (Erste veröffentlichte Version für den externen Betatest)

  - Ungelöstes Problem mit auf Zeitpunkt der Installation gesetzten Timestamps der .L Dateien,
    zumindest auf FAT- Dateisystem. Dadurch funktioniert derzeit leider die automatische
    Aktualisierung der Dateien L:\x2g\Hilfe.L und L:\x2g\Info.L nicht. WORKAROUND für den
    Betatest: Mit Windows Suchfunktion alle *.L Dateien von Laufwerk L: aulisten lassen,
    dann ALLE markieren und mit rechter Maustaste öffnen. In jede der geöffneten Dateien
    jeweils ein beliebiges Zeichen einfügen und wieder entfernen. Die so bearbeiteten
    Dateien EINZELN im Abstand von mindestens zwei Sekunden abspeichern. Dadurch erhalten
    alle *.L Dateien im Virtuellen Laufwerk L: wieder unterschiedliche Timestamps, was
    für die Erkennung unterschiedlicher Dateiinhalte durch die ConTEXT-IDE notwendig ist.


Versionen 0.12 bis 0.15 - Juli 2014

  - Eigenes 16x16 Icon mit dem Iconeditor 'IcoFX' von Attila Kovrig entworfen
    Das Icon greift die "Start" und "Stop" Tasten der C-Control I 1.1 auf. Der grüne
    Hintergrund und das stiliserte |_ Team "|_" Symbol sind eine Remineszenz an die
    Main-Unit Platine der C-control I 1.1 mit dem RS232-IC und Anschlussfeld.
    Das D-förmige Element daneben gleicht dem 9-poligen Stecker über welchen die
    C-Control mit dem PC kommuniziert, kann aber auch als "D"istribution gelesen
    werden.

  - Alle '.L' Dateien manuell mit unterschiedlichen Timestamps versehen, damit das
    automatische Nachladen der vom System aktualisierten Dateien "L:\x2g\Hilfe.L"
    und L:\x2g\Info.L" innerhalb der ConTEXT-IDE auch wirklich funktioniert.
   (ConTEXT pollt nur den Timestamp, nicht aber den Inhalt der Dateien.)

  - Alle Sprachdateien im Verzeichnis L:\x2g\System\MSG\ manuell mit unterschiedlichen
    Timestamps versehenm, s.o.

  - Link zur vorlaeufigen Projektseite innerhalb der .ISS Setup Datei eingefuegt.



Version 0.11 - Juni 2014

  - Neuer Test fuer errorlevel:
    - BASIC++ (v.0.331, ist anscheinend immer '0')
      L:\x2g\System\BAT\32bpp.bat erweitert. ConTEXT Parser Rule optimiert: "%n"%l:

  - CCCCC liefert '0' und '1'. ConTEXT Parser Rule: %n(%l:%c)
    errorlevel-abhaengige Konsolenmeldung hinzugefuegt

  - OCBASIC (v.1.09a, ist anscheinend immer '0')

  Neue Registryeinstellugen exportiert:  L:\x2g\Setup\x2g_093_de_XP.reg
                                und      L:\x2g\Setup\L-PuTTY_001_de_XP.reg

  - PuTTY Registry Datei fuer COM1: bis COM6: hinzugefuegt
    Registry Dateien in L:\x2g\Setup\(DE.EN.NL) verschoben, s.o.

  - Anpassungen nach Testlauf auf Win95 und Win98 (keine VMs)


Version 0.10 - Juni 2014

  - Probleme mit v.4 Registry Format auf Windows 7. Nach revert auf regshot #84 und
    Neubearbeitung der Mouse Over Tooltips wieder funktional. Die 'Parser Output Rule'
    fuer asm.a05 wird weiterhin nicht uebernommen, siehe "Bekannte Probleme"

  - Alfred Arnolds AS05 Alternative, "macro assembler" in der Win32 Version verarbeitet
    auch Quelltexte in Grossschreibung. Der Assembler ist zudem unter der GPL lizensiert.
    Eine Alternative zu Frank A. Kingswoods AS05 Assembler. Beide Assembler sind enthalten.




Version 0.09 - 29. Mai 2014

  - Usability Änderungen und Vorbereitung zum externen Betatest
  - Hint-Texte der IDE fuer Mouse Over Tooltip überarbeitet
  - Legacy Tool 'PRGMR' wieder eingebunden. Serieller Port kann innerhalb des Tools geändert werden.
  - GPL basierte AS05 Alternative von Alfred Arnold testweise eingebunden, ca. 50% vollstaendig
  - Disassembler DASMx tesweise eingebunden, ca. 50% vollstaendig
  ! erstmals Probleme mit Import des REGEDIT4 Formats in Windows 7 (mit regshot: X2G_85)


Version 0.08 - Mai 2014

  - Auswahl der Seriellen Schnittstelle über Tasten F9 bis F12, entspr. COM1 bis 4
   (noch nicht implementiert fuer CCUPLOAD)

Version 0.07

  - Installationsskript berücksichtigt Windows-Version nicht. z.B. DOS-kompatible
    Programme werden immer via DOSBox ausgeführt. Dies kann manuell geändert werden,
    z.B. für CCBASIC:  Einstellungen --> Umgebungseinstellungen --> Benutzerbefehle
    Dateityp ".BAS" --> Taste F9 --> Ausführen von "L:\x2g\SYSTEM\BAT\32Pbas.bat"
    auf "L:\x2g\SYSTEM\BAT\16Pbas.bat" geändert wird. ( Evt. noch nicht für alle
    Tools möglich, z.B. CCUPLOAD.EXE )



 Konzeptstudie 0.06



 Konzeptstudie 0.05

 +: Mit Konzeptstudie Version 0.05 stehen alle Inhalte der |_ Distribution auch in Form eines einzelnen
    ZIP-Archivs zur Verfuegung. Dadurch koennen die enthaltenen Dateien auch ohne  vorherige
    Ausführung des automatischen Installationsprogramms auf einem Computer betrachtet werden.

    Im Gegensatz zum automatischen Installationsprogramm erzeugt die Verwendung des ZIP-Archivs allein
    nicht unbedingt eine funktionsbereite |_ Entwicklungsumgebung. (selbst dann nicht, wenn das komplette
    Archiv mit der Option "Verzeichnisstruktur beibehalten" entpackt wurde.) Der Grund ist, dass für eine
    betriebsbereite Installation abhängig von der vorgefundenen Windows und Sprachversion des Computers
    unterschiedliche Dateien in verschiedene Ordner kopiert werden muessen. Natürlich kann das auch später
    noch manuell geschehen. Entsprechendes Detailwissen, welche Dateien wann wohin müssen, vorausgesetzt.

    Natürlich kann hierzu auch das ebenfalls im ZIP-Archiv enthaltene Original Installationsskript der
    |_ Distribution mit dem als Freeware erhältlichen INNO setup-Kompiler analysiert und verändert, oder
    unverändert, kompiliert und ausgeführt werden, um so eine lauffähige Installation der |_ Distribution
    auf dem Computer zu erhalten.


 -: Ab Version 0.05 wurde das bis einschliesslich Version 0.04 noch enthaltene Unterverzeichnis "L:\x2g\3rdparty\TESTPOOL\"
    in ein separates Archiv ausgegliedert. Es ist nicht mehr Bestandteil des automatischen Installationsprogramms, sondern
    steht (auf Anfrage) als eigenstädiges ZIP-Archiv zur Verfügung.

 -: Einige der in Vorversionen für Testzwecke in mehreren Programmversionen beigefügten SW-Tools auf die jeweils
    aktuelle Version begrenzt.


 -: Einige der 3rd-party Zusatzinhalte (überwiegend Beispielprogramme) in den beigelegten Original-Archiven belassen.



 Konzeptstudie 0.04

 +: Link zum Assembler Listfile in Ausgabekonsole hinzugefügt




  Konzeptstudie 0.03    - Hauptsächlich Experimentierstadium, nicht veröffentlicht.

  Konzeptstudie 0.02    - Hauptsächlich Experimentierstadium, nicht veröffentlicht.
 
  Konzeptstudie 0.01    - Hauptsächlich Experimentierstadium, nicht veröffentlicht.