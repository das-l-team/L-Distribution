  das |_ Team  pr�sentiert:  |_ Distribution, beta. (Ein Hobbyprojekt)

  Eine Freewaresammlung und Entwicklungsumgebung f�r Mikrokontroller.

  Dies ist Version 0.29. M�glicherweise gibt es schon eine neuere Version.
  Pr�fe es selbst:  http://update.ghn-sensorik.de/L-Team/Distribution_0.29
  

�brigens: Das ben�tigte PASSWORT steht ganz unten in diesem Text!

  HAFTUNGSAUSSCHLUSS
  ==================
  Diese Software-Zusammenstellung wird "so wie sie ist" zum Zwecke der Erkundung
  verf�gbar gemacht. Es handelt sich um eine Betaversion. Das |_ Team kann keine
  Haftung f�r Sch�den �bernehmen die evt. aus der Installation oder Verwendung
  der L-Distribution entstehen k�nnten. Du erkennst diesen Haftungsausschluss
  mit der Installation oder Nutzung der L-Distribution an.
  
  Sofern die nationalen Rechtsbestimmungen keinen vollst�ndigen Haftungsausschluss
  zulassen,  darf die L-Distribution nicht installiert oder verwendet werden.

  Das PASSWORT f�r die Installation erh�lst du per Klick auf den Hyperlink oben, oder
  kannst es unten, am Ende dieses Textes, auch offline lesen.


  Voraussetzungen zur Installation
  ================================
  
   - _Keine_ vorherige Installation des ConTEXT Editors.
   Grund: Die vorherigen Einstellungen werden �berschrieben.

   - Gute Grundkenntnisse in der Bedienung eines Windows-Computers


  Betriebssysteme
  ===============

  - Windows:  95, 98, 2000, XP, Vista, 7, 8, Windows 10

  - ReactOS:   (via) The Virtue-L Computer

               http://visit.ghn-sensorik.de/


  - VirtualBox, QEMU: (via) The Virtue-L Computer
  
               S.a. folgenden Beitrag im Forum der Website 'C-Control Intern':

               http://ccintern.dharlos.de/forum/lesen.php?eintrag=16534


Installationsverzeichnis:
=========================

 - |_ Distribution kann auf beliebiges Laufwerk und beliebiges
   Unterverzeichnis installiert werden. Mit einer Ausnahme:

   Bei schon vorhandenem Laufwerk "L:" muss der Installationspfad
   genau "L:\x2g\" lauten.

 - Das Windows-Benutzerkonto muss im Installationsverzeichnis die
   Dateirechte "Lesen", "Schreiben", "L�schen", "Ausf�hren" zulassen.

 - Das Installationsverzeichnis "x2g" muss nach der Installation �ber den
   Laufwerksbuchstaben "L:\x2g\.." vorhanden sein.                  

      Wenn kein physisches Laufwerk L: existiert wird ein virtuelles Laufwerk
      L: mit dem DOS/Windows Kommando SUBST erzeugt.


      Das Installationsprogramm legt hierzu folgenden Eintrag in der Registry an:

      HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
             MOUNT_L_Distribution_DIR


SUBST kann auch von Hand eingegeben werden: 

  SUBST L: <Installationsverzeichnis> Beispiel: subst L: c:\L

Und so kannst du die Zuweisung mit Substitute wieder aufheben:
  
  SUBST /D L:

Lizenz:
=======

  Diese Freewaresammlung enth�lt von Mitgliedern der Community entwickelte
  Programme und Komponenten, die aus dem Internet auch einzeln  herunter
  geladen werden k�nnnen.
  
  Alle Rechte an den enthaltenen Programmen und Komponenten verbleiben bei
  deren jeweiligen Autoren/innen bzw. Urhebern/Rechteinhabern. Im Ordner
  der jeweiligen Freewarekomponente, unterhalb L:\x2g\3rdparty\ findest
  du weitere Informationen in den Originalarchiven.

  das |_ Team  stellt die eigenen im Verzeichnis  L:\x2g\System\ enthaltenen
  Werke als freie Software unter der Lizenz "GPLv2 or later" zur Vef�gung.

  das |_ Team stellt die eigenen im Verzeichnis  L:\x2g\System\MSG\ enthaltenen
  Werke unter der "Creative Commons by-sa" oder alternativ "CC0" heraus, solange
  es sich dabei nicht um l�ngere Testxausz�ge handelt, die einem 3rd-party Copyright
  unterstehen k�nnten. Bitte dazu die Quellenangaben im jeweilgen Text beachten.


Sicherheitsabfrage/
P A S S W O R T
===============
 Achtung:

 Vorherige Einstellungen der vorhandenen ConTEXT-Installation werden verloren gehen.

 Wenn du das willst, gib bitte im n�chsten Fenster das folgende Passwort ein:

                                        lks300714

(Tasten 'L' 'K' 'S' '3' '0' '0' '7' '1' '4' )







