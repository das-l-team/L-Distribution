
 *** Tipps Auswahl Installationsverzeichnis ***

 ===============================
 ... ODER drücke einfach Weiter.
 ===============================

 Für Fortgeschrittene sind die nachfolgenden Tipps:

 Unter Windows 10:

    Als Installationspfad eher nicht das sogenannte
   'OneDrive'-Verzeichnis verwenden, weil dies
    Funktionseinschränkungen im Editor und
    Hilfesystem zur Folge haben kann.

[Update:] (Windows 10, build 10049) Es scheint,
    als wären die Funktionseinschränkungen des
   'OneDrive'-Verzeichnis im Zuge der Windows-10
    Entwicklung behoben. Falls es dennoch zu Funktions-
    einschränkungen mit dem OneDrive Verzeichnis
    kommt bitte in lokales  Verzeichnis auf diesem
    Computer installieren.
[Update:] (Windows 10, build 10061, build 10166): 
    Das Windows-10 Problem mit verzögerten Timestamp-
    Aktualisierungen ist wohl behoben. (Vielen Dank an
    die kompetenten Ansprechpartner am Microsoft-Stand
    der Cebit Messe in Hannover für die freundliche
    Entgegennahme dieses Bugreports.)

 Unter Vista, W7, W8, W10:
    
    Eher nicht in "C:\Programme" (bzw. C:\Programme (x86)
    installieren weil dort wohl die Windows ACL zu
    Problemen führt.

    Beachte: Für das Installationsverzeichnis muss das
    jeweilige Benutzerkonto folgende Dateirechte haben:

      Lesen, Schreiben, Löschen,Ausführen.


 Auf ein bestehendes Laufwerk "L:":

    Wenn der Laufwerksbuchstabe 'L:' auf diesem Computer
    schon vergeben ist:

    Das Installationsverzeichnis MUSS dann lauten: "L:\x2g"

    (Also NICHT "L:\x2g\L", so wie es das Installationsskript
     noch irrtümlich vorschlägt!!!)