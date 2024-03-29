[ Der nachfolgende Text wird aus diesem in der |_ Distribution enthaltenen
  Softwarearchiv wiedergegeben: "L:\x2g\3rdparty\CCTOKBAS\cctokbas_vollversion.zip"

  Nachfolgend die eingeschraenkte Textversion des Manuals. Die HTML-Version dieser
  Datei iat im in lokalen Pfad: L:\x2g\3rdparty\CCUPLOAD\INFO.HTM hinterlegt.
               
  Verwandte Informationen zu diesem Arbeitsschritt sind in  L:\x2g\Hilfe.L
  zu finden. Dazu in der Ausgabekonsole unten auf L:\x2g\Hilfe.L Doppelklicken
]



                                CCTOKBAS 3.1
                        Decompiler f�r C-Control/BASIC
                              und C-Control/PLUS

                               20. August 2004

                            Autor: Dietmar Harlos

Einleitung

Mit dem CCTOKBAS-Decompiler k�nnen tokensierte Programme der C-Control-Mikro-
kontroller in lesbaren BASIC-Quellcode umgewandelt (detokensiert) werden. Auf
diese Weise lassen sich C-Control/BASIC-Programme, deren Quellcode verloren
gegangen ist, wieder in lesbaren BASIC-Code zur�ck�bersetzen. Als besonderen
Bonus lassen sich mit Hilfe des Decompilers sogar C-Control/PLUS-Programme in
C-Control/BASIC-Programme umwandeln. Au�erdem wird eine detaillierte Liste
aller verwendeten Variablen und deren Lage im User-RAM erstellt. Dadurch ist
sofort ersichtlich, ob mehrere Variablen den gleichen Speicherbereich belegen.

Der Decompiler kann DAT-Dateien vom C-Control/BASIC-Compiler f�r DOS oder vom
C-Control/PLUS-Compiler tempor�r angelegte CODE.TXT-Dateien lesen oder eine
direkte Verbindung zur C-Control aufnehmen und das im Speicher der C-Control
stehende Programm �ber die RS232-Schnittstelle einlesen und verarbeiten.
Letzteres sollte sowohl unter reinem DOS, als auch in der DOS-Box und im
MS-DOS-Modus aller Windows-Versionen funktionieren.

Unterst�tzt werden die C-Control-Mikrokontroller der Version 1.1 in allen
Varianten (M-Unit, Main-Unit und Station). Der vom Decompiler erstellte
Quellcode ist zur Version 1.7 des C-Control/BASIC-Compilers kompatibel. Unter
Windows wird die Version 1.33 der C-Control/BASIC-Entwicklungsumgebung
ben�tigt.

Bedienung

Zuerst sollte der Inhalt des ZIP-Archivs, in dem sich der Decompiler
befindet, in ein beliebiges Verzeichnis entpackt werden. Das kann zum
Beispiel mit Winzip geschehen. Um einen Eindruck davon zu vermitteln, wie der
Decompiler zu benutzen ist, liegen dem ZIP-Archiv drei Beispiel-DAT-Dateien
bei. Das erste Beispiel (DEMO1.DAT) liest Daten von einer Chipkarte (daf�r
ist nat�rlich eine entsprechende Kontakteinrichtung erforderlich), das zweite
Beispiel (DEMO2.DAT) gibt �ber die serielle Schnittstelle nach einer
Begr��ung die aktuelle Zeit aus, bis eine Taste im Terminalprogramm gedr�ckt
wird, und das dritte Beispiel (DEMO3.DAT) enth�lt eine gro�e Tabelle und
spielt Musik �ber einen am BEEP-Ausgang der C-Control angeschlossenen
Piezo-Schallwandler.

�bersetzt werden die Demo-Programme folgenderma�en. Unter Windows wird in das
Verzeichnis des Decompilers gewechselt und das beiliegende DEMO.PIF
gestartet. Eventuell wird die Endung "PIF" nicht angezeigt, sondern nur
"DEMO". Nach dem Starten �ffnet sich ein Fenster mit MS-DOS-Logo und einigen
Meldungen des Decompilers. Der Dekompiliervorgang ist bereits abgeschlossen
und im Verzeichnis wurde eine neue Datei namens DEMO1.BAX erstellt. Diese
enth�lt den aus der DEMO1.DAT-Datei erstellten Quellcode und kann nun in der
C-Control/BASIC-Entwicklungsumgebung geladen, untersucht und kompiliert
werden.

Um weitere C-Control-Programme zu �bersetzen kann die DEMO.PIF-Datei editiert
werden. Fortgeschrittene Anwender werden den Decompiler sicher lieber am
sogenannten DOS-Prompt bedienen wollen. Um die PIF-Datei zu editieren, wird
die rechte Maustaste gedr�ckt, w�hrend die Datei markiert ist. Im nun
erscheinenden Kontextmen� w�hlt man 'Eigenschaften' und es sollte sich ein
neues Fenster mit den Reitern 'Allgemein', 'Programm', 'Schriftart', usw.
�ffnen. Je nach Windows-Version sieht dieses Fenster etwas anders aus. Auf
dem Reiter 'Programm' befindet sich die entscheidende 'Befehlszeile'. Hier
ist der DOS-Befehl eingetragen, der beim Starten der PIF-Datei ausgef�hrt
wird. Er kann beispielsweise in "CCTOKBAS.EXE demo2.dat" ge�ndert und das
Fenster mit 'Ok' geschlossen werden. Beim n�chsten Starten der PIF-Datei wird
nun das zweite Beispiel �bersetzt.

Die vom Decompiler erstellte Ausgabedatei hat die Endung "BAX", um
Verwechslungen mit einer eventuell vorhandenen BASIC-Datei aus dem Wege zu
gehen. Im Bedarfsfall kann der Anwender diese Endung sp�ter in "BAS"
umbenennen. Zus�tzlich legt der Decompiler eine Datei namens CCTOKBAS.BIN an.
Diese enth�lt das zu �bersetzende Programm im Bin�rcode, also aufgebaut aus
den verschiedenen C-Control-Tokenbefehlen wie sie der Decompiler als Eingabe
erh�lt, und kann vom fortgeschrittenen Anwender mit einem Hexeditor
untersucht werden.

Wenn man eine vom C-Control/BASIC-Compiler erstellte DAT-Datei �bersetzen
m�chte, mu� als Befehlszeile "CCTOKBAS.EXE datei.dat" �bergeben werden. Wenn
man dagegen das Programm, das sich augenblicklich im Speicher der C-Control
befindet, �bersetzen m�chte, gibt man "CCTOKBAS.EXE 2" ein, wenn die
C-Control �ber die serielle Schnittstelle COM2 mit dem PC verbunden ist.
Falls es sich bei dem Programm in der C-Control um ein CCPLUS-Programm
handelt, mu� unbedingt der Parameter "-autoccplus" angeh�ngt werden. In
diesem Fall also "CCTOKBAS.EXE 2 -autoccplus".

Wird der Decompiler unter neueren Windows-Versionen (XP, 2000) eingesetzt,
k�nnen auf einigen Computern Probleme bei der �bertragung �ber die serielle
Schnittstelle auftreten. Um auch in diesen F�llen eine Daten�bertragung zu
erm�glichen, habe ich dem ZIP-Archiv ein Programm namens CCUPLWIN beigelegt.
Es wird mittels "CCUPLWIN.EXE 2" aufgerufen, falls die C-Control �ber COM2
verbunden ist, und legt die empfangenen Daten in der Datei CCUPLOAD.DAT ab.
Diese DAT-Datei kann anschlie�end, wie oben gezeigt, als Eingabe f�r den
Decompiler dienen. Falls es sich bei dem Programm in der C-Control um ein
CCPLUS-Programm handelt, darf das "-autoccplus" beim Aufruf des Decompilers
nicht vergessen werden.

Eine vom C-Control/PLUS-Compiler tempor�r abgelegte CODE.TXT-Datei wird
�bersetzt, indem zun�chst die CODE.TXT-Datei in das Verzeichnis des
Decompilers kopiert und anschlie�end "CCTOKBAS.EXE code.txt -autoccplus"
gestartet wird. Die CODE.TXT-Datei befindet sich im gleichen Verzeichnis wie
die CPF-Datei des Programms, das zur Zeit in der PLUS-Entwicklungsumgebung
bearbeitet wird. Jeder Kompiliervorgang aktualisiert die CODE.TXT-Datei.

Kontrolle

Ziel des Dekompilierungsvorganges ist es, einen CCBASIC-Quellcode zu
erzeugen, mit dem ein Programm kompiliert werden kann, das sich exakt so
verh�lt wie das Ursprungskompilat. Um das zu �berpr�fen, mu� der neuerstellte
Quellcode zun�chst mit dem CCBASIC-Kompiler von Conrad Electronic kompiliert
und in die C-Control �bertragen werden. Treten dabei keine Fehler auf, mu�
die vom Decompiler erstellte Datei CCTOKBAS.BIN in ORIGINAL.BIN umbenannt
werden und danach das soeben in die C-Control �bertragene Programm, wie oben
beschrieben, �ber die serielle Schnittstelle ausgelesen und abermals
dekompiliert werden. Die dadurch neuentstandene BIN-Datei wird mit der alten
mittels folgendem Befehl verglichen: "FC.EXE /b CCTOKBAS.BIN ORIGINAL.BIN".
Hierbei darf nur die Meldung "CCTOKBAS.BIN ist l�nger als ORIGINAL.BIN"
auftreten.

Auf diese Weise wurden das Ursprungskompilat, das durch einen verloren
gegangenen Quellcode oder durch ein CCPLUS-Programm erzeugt wurde, mit dem
aus dem neuerstellten Quellcode generierten Kompilat verglichen. Wenn beide
gleich sind, ist der Quellcode fehlerfrei. Diese einfache Kontrollm�glichkeit
ist bei mittels Autoccplus-Funktion (siehe n�chstes Kapitel) dekompilierten
Programmen leider nicht mehr m�glich.

�bersetzung von CCPLUS nach CCBASIC

Der Informationsaustausch mit verschiedenen C-Control-Anwender hat gezeigt,
da� diese den Decompiler in erster Linie einsetzen, um Programme, die in
C-Control/PLUS erstellt wurden, in C-Control/BASIC-Quellcode zu �bersetzen.
Der Decompiler leistet bei dieser Konvertierungsarbeit wertvolle Hilfe,
jedoch waren bis zur Version 2.02 des Decompilers oft umfangreiche manuelle
Korrekturen am erstellten Quellcode notwendig. Das lag daran, da� CCPLUS
einige Befehlskonstrukte verwendet, die in CCBASIC nicht existieren. Der
Decompiler hat daher in solchen F�llen auch keinen sinnvollen CCBASIC-Code
erstellen k�nnen. Beispielsweise existiert in BASIC kein echtes mehrzeiliges
IF und in PLUS wird oft das spezielle Stackhandling der C-Control ausgenutzt,
um Programme zu optimieren. In der neuen Version 3.0 des Decompilers bin ich
der Bitte verschiedener Anwender nachgekommen und habe die automatische
�bersetzung von CCPLUS nach CCBASIC weiter vereinfacht. Neu hinzugekommen ist
die sogenannte Autoccplus-Funktion, die beim �bersetzen eines
CCPLUS-Programms grunds�tzlich aktiviert werden sollte. Dies geschieht, indem
beim Starten des Decompilers am DOS-Prompt der Parameter "-autoccplus" mit
�bergeben wird.

Die Autoccplus-Funktion sorgt daf�r, da� zu BASIC inkompatible
IF..THEN-Kombinationen automatisch kompatibel gemacht werden. Au�erdem wird
das Stackproblem durch einen effizienten Workaround behoben. Leider werden
die ver�nderten IFs etwas langsamer ausgef�hrt und, was schwerer wiegt, es
werden andere Tokenbefehle benutzt. Das hei�t, die Programme unterscheiden
sich nun in ihrer tokensierten Form und es kann nicht mehr durch einen
einfachen Bin�rvergleich kontrolliert werden, ob die Dekompilierung
fehlerfrei durchgef�hrt wurde. Aus diesem Grund sollte der neuerstellte
BASIC-Quellcode kompiliert, in die C-Control �bertragen und besonders
gr�ndlich ausgetestet werden.

Leider ist auch die Autoccplus-Funktion kein Garant daf�r, da� sinnvoller,
kompilierbarer CCBASIC-Code erstellt wird. Es k�nnen beispielsweise Zeilen
entstehen, die zu lang f�r den BASIC-Compiler sind. Diese m�ssen manuell
aufgeteilt werden. Befehle wie "PRINT INPUT#" werden von CCPLUS (und von
verschiedenen CCBASIC-Erweiterungen) verwendet und k�nnen daher auch in der
�bersetzung auftauchen. Hier ist eine Zerlegung in "INPUT# var : PRINT var"
erforderlich. Im Einzelfall ist ein erfahrener Anwender erforderlich, der die
notwendigen Anpassungen vornimmt. Deshalb gebe ich an dieser Stelle keine
umfangreichen Konvertierungstips, sondern m�chte alle registrierten Anwender
des Decompilers bitten, mich per E-mail anzuschreiben, falls der erstellte
Quellcode nicht kompiliert werden kann. Wie unten angegeben ist diese Hilfe
bei geringem Aufwand kostenlos.

Mit dem Decompiler kann man dem CCPLUS-Kompiler �brigens sehr gut "in die
Karten schauen". Das ist mitunter �u�erst n�tzlich, denn �ber Fehler in
diesem Compiler ist bisher kaum etwas bekannt. Ein mit dem Decompiler
aufgedeckter Fehler in der Dokumentation ist, da� CCPLUS bei Verwendung des
LCDs nicht nur die letzten 2, sondern die letzten 4 Byte des
Variablenspeichers belegt.

Den Quellcode verstehen

Nachdem ein kompilierbarer BASIC-Quellcode vorliegt, sind noch nicht alle
Probleme gel�st, sondern die eigentliche Arbeit beginnt erst. Da die
Originalnamen aller Variablen, Ports und Label verlorengegangen sind, bedarf
es einiger Stunden Arbeit, die verschiedenen Segmente des Programms zu
erkennen und zu verstehen. Der Decompiler benennt die Variablen nach ihrer
Lage im User-RAM und die Label nach ihrer Lage im Programm. Leider ist das
nicht anders m�glich, denn bei dem Vorgang, den Conrad Electronic als
"Kompilieren" bezeichnet, also dem �bersetzen eines Quellcodes oder eines
CCPLUS-Programms in C-Control-Tokencode, gehen alle Namen verloren. In dem
tokensierten Programmcode, den die C-Control ausf�hrt, sind sie also nicht
mehr vorhanden.

Da in der Regel bekannt ist, an welche Sensoren und Aktoren die C-Control
elektrisch angeschlossen ist, sollten zun�chst die verschiedenen Ports
sinnvoll benannt werden. Dann wird die Funktion der Subroutinen erkundet und
deren Label sinnvoll umbenannt. Zum Schlu� folgen die Variablen. Zum
Umbenennen ist �brigens die "Alles ersetzen"-Funktion in der
C-Control/BASIC-Entwicklungsumgebung �u�erst n�tzlich. CCPLUS verwenden f�r
das LCD, die Tastatur, die Datenaufzeichnung, etc. immer die gleichen
Programm-Module, die allerdings bei jedem Programm an anderer Stelle stehen
k�nnen. Erst nach dieser Flei�arbeit sollten die gew�nschten Ver�nderungen
und Erweiterungen am Programm in Angriff genommen werden.

Zu beachten

Damit der Decompiler Tabellen erkennen kann, mu� f�r jede Tabelle wenigstens
ein LOOKTAB-Befehl im zu �bersetzenden Programm vorhanden sein und vor der
Tabelle stehen. Tabellen haben dar�berhinaus eine h�here Priorit�t als Code.
Das hei�t, wenn sich Code und Tabelle �berschneiden, wird nur die Tabelle
ausgegeben.

Der Decompiler f�gt automatisch an jedes kompilierte Programm ein END-Token
(255) an. Bei Tabellen, die ganz am Ende des Programms stehen, f�hrt das
h�ufig dazu, da� ein Eintrag zuviel in der Tabelle steht.

Bei fehlerhaftem Code

Es kann sein, da� das zu �bersetzende Programm Fehler aufweist. Da der
CCBASIC-Compiler von Conrad Electronic beim Kompilieren nur eine begrenzte
Anzahl von Sicherheitsabfragen durchf�hrt, k�nnen damit problemlos Programme
erstellt werden, die sich nicht vollst�ndig dekompilieren lassen. Auch ist es
denkbar, da� das zu dekompilierende Programm eine Tabelle enth�lt, zu der
kein LOOKTAB existiert. In diesem Fall wird der Tabelleninhalt als BASIC-Code
interpretiert, was nat�rlich zu Problemen f�hrt. Der Decompiler gibt in
solchen F�llen eine Warnung aus, die im erzeugten Quellcode gefunden werden
kann, indem nach "***" gesucht wird.

Manche CCBASIC-Befehle bestehen aus mehreren Tokenbefehlen. Es handelt sich
im wesentlichen um die Befehlskombinationen IF..THEN, IF..THEN..ELSE, BEEP,
WAIT, FOR..NEXT und ON..GOTO/GOSUB. Der Decompiler versucht solche
Befehlskombinationen zu erkennen und durch die entsprechenden BASIC-Befehle
zu ersetzen. In fehlerhaften Programmen ist das nicht immer m�glich, so da�
eventuell von Hand nachgebessert werden mu�.

Warn- und Fehlermeldungen

Der Decompiler markiert alle Stellen, an denen Fehler auftreten oder an denen
eine Warnung sinnvoll erscheint durch ein "***" und einen Kommentartext. In
bestimmten F�llen k�nnen diese Meldungen ignoriert werden. Meist weisen sie
aber auf Fehler im zu dekompilierenden Programm hin. In der folgenden Tabelle
versuche ich zu erkl�ren, wie diese Hinweise zu deuten sind.

+------------------------------------+---------------------------------------+
|      Warn- oder Fehlermeldung      |               Erkl�rung               |
+------------------------------------+---------------------------------------+
| Unbekannte IF..THEN-Kombination    | Diese Fehlermeldung tritt in          |
|                                    | Programmen, die in CCPLUS erstellt    |
|                                    | wurden, h�ufig auf und ist durch      |
|                                    | Aktivieren der Autoccplus-Funktion    |
|                                    | zu beheben. Die Autoccplus-Funktion   |
|                                    | sollte nur in Programmen die in       |
|                                    | CCPLUS erstellt wurden aktiviert      |
|                                    | werden.                               |
+------------------------------------+---------------------------------------+
| In dieser Zeile tritt ein Stack    | Diese Fehlermeldung tritt in          |
| Underflow (STACKUVL) auf           | Programmen, die in CCPLUS erstellt    |
|                                    | wurden, h�ufig auf und ist durch      |
|                                    | Aktivieren der Autoccplus-Funktion    |
|                                    | zu beheben. Bei aktiver               |
|                                    | Autoccplus-Funktion kann diese        |
|                                    | Meldung ignoriert werden.             |
+------------------------------------+---------------------------------------+
| Durch Autoccplus kompatibel        | Die Autoccplus-Funktion hat eine      |
| gemachte IF..THEN-Kombination      | "unbekannte IF..THEN-Kombination"     |
|                                    | automatisch zu CCBASIC kompatibel     |
|                                    | gemacht.                              |
+------------------------------------+---------------------------------------+
| Durch Autoccplus eingefuegt        | Kennzeichnet den von der              |
|                                    | Autoccplus-Funktion verwendeten       |
|                                    | Workaround zur Behebung des           |
|                                    | Stack-Underflow-Problems in           |
|                                    | CCPLUS-Programmen.                    |
+------------------------------------+---------------------------------------+
| PUSH: Der Ausdruck oder Wert ...   | Diese Warnung kann auf einen Fehler   |
| verursacht einen Stack Overflow,   | im urspr�nglichen Programm            |
| ... geht verloren.                 | hinweisen. Die Ressourcen der         |
|                                    | C-Control, die f�r Berechnungen       |
|                                    | verwendet werden, sind ersch�pft und  |
|                                    | ein Wert oder Ausdruck geht           |
|                                    | verloren. Es sollte kontrolliert      |
|                                    | werden, ob die Berechnung in der      |
|                                    | folgenden Quellcodezeile von der      |
|                                    | C-Control fehlerfrei ausgef�hrt wird. |
+------------------------------------+---------------------------------------+
|                                    | Diese Fehlermeldungen sollten         |
| Unbekannte FOR..NEXT-Kombination   | niemals auftreten. Vermutlich ist     |
+------------------------------------+ das zu dekompilierende Programm       |
|                                    | fehlerhaft oder es wurde eine         |
| STACKRESET: ... wurde auf den      | Tabelle als Code ausgewertet, da das  |
| Stack geschoben, aber nicht        | zugeh�rige LOOKTAB nicht gefunden     |
| entfernt                           | werden konnte. Es ist auch denkbar,   |
|                                    | da� das zugrundeliegende Programm     |
+------------------------------------+ unter Verwendung von                  |
| Unbekannte Befehlskombination      | Programmiertricks erstellt wurde,     |
+------------------------------------+ die kein �quivalent in der            |
| Ungueltige Tokenkombination        | Standard-CCBASIC-Syntax besitzen.     |
+------------------------------------+ Wer bei der Behebung dieser Fehler    |
| Ungueltiges Token                  | Unterst�tzung ben�tigt, kann mich     |
|                                    | per E-mail anschreiben.               |
+------------------------------------+---------------------------------------+

Verbesserungen bis Version 2.02

Der Decompiler wurde gegen�ber der Vorg�ngerversion stark erweitert. So wurde
zum Beispiel das Stackhandling komplett �berarbeitet. Stack Underflow und
Stack Overflow werden detektiert. Der Decompiler erkennt dadurch fehlerhafte
Befehlskombinationen wesentlich besser und gibt entsprechende Warnungen im
erzeugten Quellcode aus. Auch zusammengesetzte Befehle werden dadurch
sicherer erkannt.

Zus�tzlich gibt es nun eine Debug-Option, mit der der Decompiler veranla�t
werden kann, die �bersetzten Token als Kommentar mit in die Ausgabedatei zu
�bernehmen. Wenn diese Option aktiv ist, werden dar�berhinaus keine
Tokenbefehle zusammengezogen. Unter Zuhilfenahme des Bin�rdumps der Token
(CCTOKBAS.BIN) k�nnen fehlerhafte Tokenkombinationen so leicht untersucht
werden, da zu jedem Tokenbefehl die Adresse (bzw. der Offset im Bin�rdump)
erscheint.

Vom C-Control/PLUS-Compiler erstellte tempor�re CODE.TXT-Dateien und Token im
eigenen Bin�rformat (CCTOKBAS.BIN) k�nnen nun direkt eingelesen werden.

Verbesserungen bis Version 3.1

Es wurden wieder deutliche Ver�nderungen vorgenommen. Die deutlichste
Verbesserung ist die neue Autoccplus-Funktion. Damit lassen sich nun die
meisten CCPLUS-Programme ohne manuelle Nachbearbeitung nach CCBASIC
�bersetzen. Allerdings sollte die Autoccplus-Funktion nur bei
CCPLUS-Programmen aktiviert werden. Bei CCBASIC-Programmen k�nnte das
verwendete Verfahren dazu f�hren, da� Fehler im urspr�nglichen Programm
�bersehen werden. Trotzdem tendiert der Decompiler wie seine
Vorg�ngerversionen dazu, seinen eingebauten Automatismus nur in wirklich
sicheren F�llen anzuwenden und im Zweifel besser eine Warnung zu viel als zu
wenig auszugeben.

Bis zur Version 2.02 traten einige Bugs auf, die nun behoben sind:
PRINT-mit-String-Anweisungen, die von CCTOKBAS verwendete Schl�sselw�rter im
String enthalten, konnten zu Fehlinterpretationen f�hren. PRINT mit Parameter
und Semikolon gefolgt von PRINT ohne Parameter wurde immer zusammengezogen.
Das f�hrte zum Verschwinden von Labels, die zwischen diesen beiden Befehlen
standen. Die Extension der Namen von BIN-Dateien wurde casesensitiv
ausgewertet. RETURN mit Parameter wird jetzt erkannt und entsprechend
ausgegeben.

Bis Version 3.0 gab es Probleme mit IF-Abfragen, die aus mehreren
Tokenbefehlen bestehende CCBASIC-Befehle im Anweisungsteil enthielten.
Beispiele hierf�r sind unter anderem "IF ... THEN WAIT ..." oder "IF ... THEN
FOR ... TO ...". Solche Konstrukte erzeugten nicht kompilierbaren
Zwischencode. In der Version 3.1 sind diese Fehler beseitigt, so da� ab jetzt
jede g�ltige Standard-CCBASIC-Syntax anstandslos �bersetzt werden sollte.

Mehr �bersichtlichkeit im DOS-Fenster wurde dadurch erreicht, da� Pfadnamen
nun, falls m�glich, unterdr�ckt werden. Auch entspricht die Numerierung in
den Variablen- und Portnamen jetzt der Define-mit-Index-Konvention. Es k�nnen
jetzt praktisch beliebig lange Programme verarbeitet werden. In Warn- und
Fehlermeldungen werden, soweit m�glich, immer die zugeh�rigen Adressen
angegeben. Dar�ber hinaus wurde diese Dokumentation erheblich erweitert und
verbessert.

Da einige Anwender mit neueren Windows-Versionen Schwierigkeiten bei der
Kommunikation mit der C-Control �ber die serielle Schnittstelle hatten, habe
ich ein Extra-Programm f�r die Daten�bertragung unter Windows beigelegt. Es
handelt sich um ein Console-Programm f�r Win32. Ich bin gespannt, ob damit
weniger Probleme auftreten, als mit dem eingebauten Terminalmodul des
Decompilers. Au�erdem habe ich die Abfrage des Versionstrings der C-Control
mit Hinblick auf die neue C-Control-Generation modifiziert.

In der Demoversion werden nun 150 statt 100 Zeilen ausgegeben.

Einschr�nkungen

Die BASIC-Befehlskombinationen ON..GOTO/GOSUB werden als einzelne IF-Abfragen
erkannt. Das stellt allerdings kein Problem dar, da der Quellcode beim
Kompilieren trotz dieser Einschr�nkung exakt die gleichen Tokenbefehle
erzeugt. Die diversen Erweiterungen der CCBASIC-Syntax (u.a. NETWORK-Befehle)
lassen sich allerdings immer noch nicht in ihre urspr�ngliche Form
zur�ckkompilieren.

Der Decompiler unterst�tzt keine langen Dateinamen (LFN), sondern wie der
Compiler von Conrad Electronic nur 8.3-Dateinamen (SFN).

Weitgehend ungetestet ist der Decompiler bisher im Zusammenspiel mit der
neuen C-Control-1-Generation (Version 1.2, 2.0 und Micro). Die neuen Features
der Controller werden �ber eine Umleitung der seriellen Schnittstelle
angesprochen, weshalb der Decompiler diese als normale PRINT-, GET- und
PUT-Befehle erkennt und, soweit ich feststellen konnte, sinnvollen Quellcode
erzeugt.

Es gibt eine Voll- und eine Freeware-Version des Decompilers. Die
Freeware-Version ist gegen�ber der Vollversion eingeschr�nkt, da sie nur die
ersten 150 Zeilen des erzeugten Quelltextes ausgibt.

Kontakt

F�r weitergehende Fragen bin ich jederzeit unter der E-mail-Adresse
dharlos@web.de erreichbar. Falls der Decompiler ein Programm aus irgendeinem
Grund nicht dekompilieren kann, stehe ich gerne hilfreich zur Verf�gung.
Dieser Service ist bei geringem Aufwand kostenlos. Bitte bei jeder Anfrage
den Bin�rdump (CCTOKBAS.BIN) und die eventuell vorhandenen DAT- und
BAX-Dateien mit einem Programm wie WinZIP packen und der E-mail als
Attachment hinzuf�gen. Bitte die Dateien niemals einzeln, sondern immer als
Archiv verschicken, da viele E-mail-Programme diese Daten sonst zerst�ren!
Die aktuellste Freewareversion des Decompilers und eine Menge weiterer Tools
f�r die C-Control kann auf meiner Internet-Site http://ccintern.dharlos.de
heruntergeladen werden.


Viel Spa� beim C-Controllern!

Dietmar Harlos.

