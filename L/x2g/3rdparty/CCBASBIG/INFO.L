[ Der nachfolgende Text wird aus diesem in der |_ Distribution enthaltenen
  Softwarearchiv wiedergegeben: "L:\x2g\3rdparty\CCBASBIG\ccbasbig.zip" ]


CCBASBIG.EXE beta - Version 0.2000.0525.0714 - freeware
Autor: Dietmar Harlos (dharlos@web.de)

Mit diesem MS-DOS-Programm ist es m�glich, BASIC-Programme
f�r den C-Control-Mikrokontroller bis zu einer Gr��e von maximal
32000 Byte zu kompilieren. (Der Original-Kompiler von Conrad-
Electronic unterst�tzt nur Programme bis zu einer Gr��e von
maximal 8100 Byte.)

Sinn macht das f�r all' die Leute, die das Standard-24C65-EEPROM
durch ein gr��eres ersetzt haben und nun an der Gr��enbeschr�nkung
des BASIC-Kompilers scheitern.

Das Programm kann statt des Originalkompilers CCBAS.EXE auch
innerhalb der DOS-IDE (CCE.EXE) benutzt werden.

Ich �bernehme keinerlei Garantie, da� das Programm CCBASBIG.EXE
wirklich fehlerfrei funktioniert. Da ich nur ein normales EEPROM
auf meiner C-Control-Unit habe, konnte ich das Programm bisher
kaum testen.

Au�erdem ist zu beachten, da� das Programm in relativ kurzer
Zeit (also "Quick'N'Dirty") entstanden ist. Wer auf detaillierte
Fehlermeldungen wie "Diskette voll", "Pfad existiert nicht" und
dergleichen Wert legt sollte das Programm besser nicht benutzen!

Es sollte beachtet werden, da� die TEMP-Environment-Variable den
Namen eines existierenden Verzeichnis enth�lt. Au�erdem enth�lt
das Programm einen Overlay - dieser darf nicht entfernt werden.


Etwas �ber die technischen Hintergr�nde:
========================================

Wie bereits erw�hnt, unterst�tzt der Original-Kompiler nur die
Kompilierung von BASIC-Programmen bis zu einer maximalen Gr��e
von 8100 Byte. 

W�hrend des Kompilierens speichert der Kompiler die erzeugten
BASIC-Token in einem internen Buffer. Wenn dieser Buffer voll
ist, d.h. das kompilierte BASIC-Programm gr��er als 8100 Byte
ist, wird die Kompilierung mit der Fehlermeldung "Programm zu lang"
abgebrochen.

Man k�nnte nun hingehen und einfach die Gr��enabfrage wegpatchen,
doch dadurch w�rde jedes BASIC-Programm, das gr��er als der Buffer
ist, die hinter dem Buffer stehenden Datenstrukturen �berschreiben.
Aus diesem Grund ist diese einfache L�sung leider nicht zu gebrauchen.

Ich bin beim vorliegenden Programm einen anderen Weg gegangen.

Ich habe jede Stelle, an der der Kompiler auf seinen Buffer zu-
greift so ver�ndert, da� nun nicht mehr auf den internen Buffer,
sondern auf einen anderen, gr��eren, der au�erhalb des eigentlichen
Kompilers liegt, zugegriffen wird. Insgesamt mu�ten sechs
Modifikationen (Patches) durchgef�hrt werden. Da der f�r die
Ver�nderungen zur Verf�gung stehende Platz leider sehr begrenzt
war, mu�ten zus�tzliche Subroutinen - au�erhalb des Kompilers - die
Aufgabe �bernehmen, in den Buffer zu schreiben und aus diesem
zu lesen. Da sich die Lage der Subroutinen und des Buffers bei
jedem Programmstart �ndert, m�ssen auch die Modifikationen
bei jedem Programmstart neu durchgef�hrt werden.

CCBASBIG.EXE speichert zun�chst eine Original-CCBAS.EXE-Kopie
im Verzeichnis, da� durch die TEMP-Environment-Variable (in der
AUTOEXEC.BAT) festgelegt wurde. Falls keine TEMP-Variable existiert
wird in das Root-Verzeichnis des Laufwerkes C: gespeichert.
Anschliessend wird diese Kopie so modifiziert, da� der gr��ere
Buffer beim Kompilieren benutzt wird. Dannach wird die gepatchte
CCBAS.EXE-Kopie gestartet und das gew�nschte BASIC-Programm
kompiliert. Nach getaner Arbeit wird die gepatchte CCBAS.EXE-Kopie
sofort gel�scht (ein Aufruf dieser Kopie w�rde vermutlich den
Rechner abst�rzen lassen, da Subroutinen aufgerufen werden, die
nicht mehr im Speicher existieren).

�brigens ist es nicht erforderlich, da� dieses Programm im
gleichen Verzeichnis wie CCBAS.EXE steht. CCBASBIG.EXE enth�lt
diese Programmdatei bereits in einem Overlay.


Viel Spa� beim C-Controllern!

Dietmar Harlos.









