[ Der nachfolgende Text wird aus diesem in der |_ Distribution enthaltenen
  Softwarearchiv wiedergegeben: "L:\x2g\3rdparty\DAT2TAB\DAT2TAB_v102.ZIP"
]


---------------------------------------------------------------------------
DAT2TAB V1.02 - (c) Dietmar Harlos 31. Juli bis 23. August 2016
---------------------------------------------------------------------------

Mit diesem Tool koennen Codebereiche aus DAT-Dateien vom OCBASIC-Compiler in
die CCBASIC-Tabellenform umgewandelt werden. Nuetzlich ist das zum Beispiel,
um diese Codebereiche in CCPLUS-Tabellen einzufuegen. So koennen positions-
unabhaengige INLASM-Routinen fuer die OM auch in CCPLUS verwendet werden.

Vor jeden Code, der in Tabellenform umgewandelt wird, muss der Anwender ein...

INLINE "DAT2TAB Codename START"

...setzen und nach dem Code muss ein...

INLINE "DAT2TAB Codename END"

...stehen. Es wird dann eine Tabelle namens Codename erstellt.

Aufruf: DAT2TAB DATEI.DAT

Die Ausgabe befindet sich in der Datei DAT2TAB.TAB.

Bei ungerader Byteanzahl des Codes fuegt DAT2TAB.EXE ein Fuellbyte in die
Tabelle ein, weil in der Tabelle nur WORDs stehen duerfen. Ausserdem ist
nicht gewaehrleistet, dass die Tabellen hintereinander im Speicher abgelegt
werden. Aus diesen Gruenden ist es nicht erlaubt, von einer Tabelle in eine
andere zu springen.

---------------------------------------------------------------------------

Die Dateien in diesem ZIP-Archiv:

DAT2TAB.EXE ........ Das Tool zum Konvertieren
DEMO.dat ........... Demo-Eingabeprogramm f�r das Tool
DAT2TAB.TAB ........ Demo-Ausgabedatei des Tools

Demo-OCBASIC-Programm f�r das Tool:

DEMO.BAS ........... Demoprogramm f�r 32-Bit-Arithmetik
32BITASM.PRO ....... INCLUDE-Datei f�r 32-Bit-Arithmetik - editiert
OM_FW.PRO .......... INCLUDE-Datei f�r Firmwareroutinen
OMAC.DEF ........... INCLUDE-Datei f�r Definitionen f�r die Open-Macro
OMAX.DEF ........... INCLUDE-Datei f�r Definitionen f�r die Open-Maxi

---------------------------------------------------------------------------

Fehlermeldungen zum Tool bitte direkt an meine E-Mail-Adresse schicken.

Allgemeine Fragen werden im Forum zur C-Control-1 beantwortet:

http://ccintern.dharlos.de/forum

Viel Spa� und Erfolg mit den OM-Mikrocontrollern!

Dietmar Harlos
Dipl.-Ing. f�r Elektrotechnik
dharlos@web.de
