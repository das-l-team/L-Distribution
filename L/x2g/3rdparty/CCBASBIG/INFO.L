[ Der nachfolgende Text wird aus diesem in der |_ Distribution enthaltenen
  Softwarearchiv wiedergegeben: "L:\x2g\3rdparty\CCBASBIG\ccbasbig.zip" ]


CCBASBIG.EXE beta - Version 0.2000.0525.0714 - freeware
Autor: Dietmar Harlos (dharlos@web.de)

Mit diesem MS-DOS-Programm ist es möglich, BASIC-Programme
für den C-Control-Mikrokontroller bis zu einer Größe von maximal
32000 Byte zu kompilieren. (Der Original-Kompiler von Conrad-
Electronic unterstützt nur Programme bis zu einer Größe von
maximal 8100 Byte.)

Sinn macht das für all' die Leute, die das Standard-24C65-EEPROM
durch ein größeres ersetzt haben und nun an der Größenbeschränkung
des BASIC-Kompilers scheitern.

Das Programm kann statt des Originalkompilers CCBAS.EXE auch
innerhalb der DOS-IDE (CCE.EXE) benutzt werden.

Ich übernehme keinerlei Garantie, daß das Programm CCBASBIG.EXE
wirklich fehlerfrei funktioniert. Da ich nur ein normales EEPROM
auf meiner C-Control-Unit habe, konnte ich das Programm bisher
kaum testen.

Außerdem ist zu beachten, daß das Programm in relativ kurzer
Zeit (also "Quick'N'Dirty") entstanden ist. Wer auf detaillierte
Fehlermeldungen wie "Diskette voll", "Pfad existiert nicht" und
dergleichen Wert legt sollte das Programm besser nicht benutzen!

Es sollte beachtet werden, daß die TEMP-Environment-Variable den
Namen eines existierenden Verzeichnis enthält. Außerdem enthält
das Programm einen Overlay - dieser darf nicht entfernt werden.


Etwas über die technischen Hintergründe:
========================================

Wie bereits erwähnt, unterstützt der Original-Kompiler nur die
Kompilierung von BASIC-Programmen bis zu einer maximalen Größe
von 8100 Byte. 

Während des Kompilierens speichert der Kompiler die erzeugten
BASIC-Token in einem internen Buffer. Wenn dieser Buffer voll
ist, d.h. das kompilierte BASIC-Programm größer als 8100 Byte
ist, wird die Kompilierung mit der Fehlermeldung "Programm zu lang"
abgebrochen.

Man könnte nun hingehen und einfach die Größenabfrage wegpatchen,
doch dadurch würde jedes BASIC-Programm, das größer als der Buffer
ist, die hinter dem Buffer stehenden Datenstrukturen überschreiben.
Aus diesem Grund ist diese einfache Lösung leider nicht zu gebrauchen.

Ich bin beim vorliegenden Programm einen anderen Weg gegangen.

Ich habe jede Stelle, an der der Kompiler auf seinen Buffer zu-
greift so verändert, daß nun nicht mehr auf den internen Buffer,
sondern auf einen anderen, größeren, der außerhalb des eigentlichen
Kompilers liegt, zugegriffen wird. Insgesamt mußten sechs
Modifikationen (Patches) durchgeführt werden. Da der für die
Veränderungen zur Verfügung stehende Platz leider sehr begrenzt
war, mußten zusätzliche Subroutinen - außerhalb des Kompilers - die
Aufgabe übernehmen, in den Buffer zu schreiben und aus diesem
zu lesen. Da sich die Lage der Subroutinen und des Buffers bei
jedem Programmstart ändert, müssen auch die Modifikationen
bei jedem Programmstart neu durchgeführt werden.

CCBASBIG.EXE speichert zunächst eine Original-CCBAS.EXE-Kopie
im Verzeichnis, daß durch die TEMP-Environment-Variable (in der
AUTOEXEC.BAT) festgelegt wurde. Falls keine TEMP-Variable existiert
wird in das Root-Verzeichnis des Laufwerkes C: gespeichert.
Anschliessend wird diese Kopie so modifiziert, daß der größere
Buffer beim Kompilieren benutzt wird. Dannach wird die gepatchte
CCBAS.EXE-Kopie gestartet und das gewünschte BASIC-Programm
kompiliert. Nach getaner Arbeit wird die gepatchte CCBAS.EXE-Kopie
sofort gelöscht (ein Aufruf dieser Kopie würde vermutlich den
Rechner abstürzen lassen, da Subroutinen aufgerufen werden, die
nicht mehr im Speicher existieren).

Übrigens ist es nicht erforderlich, daß dieses Programm im
gleichen Verzeichnis wie CCBAS.EXE steht. CCBASBIG.EXE enthält
diese Programmdatei bereits in einem Overlay.


Viel Spaß beim C-Controllern!

Dietmar Harlos.









