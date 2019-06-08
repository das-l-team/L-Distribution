Glückwunsch, die Installation ist fast komplett!

Gleich wird das Fenster der ConTEXT-IDE geöffnet.

ConTEXT dient als Editor und Schaltzentrale für
alle Arbeitsschritte bei der Programmentwicklung
und Übertragung zum jeweiligen Zielsystem, z.B.
in Verbindung mit einem Mikrokontroller-Board.


TIPP: Auf manchen Systemen wird das Fenster der ConTEXT-IDE
      nach dem Start unvollständig dargestellt. 

         So behebst du das Problem:

      1. Minimiere das ConTEXT Fenster über die Schaltfläche
         in der Windows-Taskleiste, anschliessend

      2. Maximiere danach das ConTEXT Fenster über die Schaltfläche
         in der Windows-Taskleiste

         Das Programmfenster des ConTEXT Editors sollte daraufhin
         vollständig dargestellt werdem.


Schnellanleitung:
================
  Mit diesen 4 Tasten bedienst du alle Grundfunktionen:

     _____      _____      _____       _____
    ||F9_||     ||F10||     ||F11||     ||F12||
    ||___||     ||___||     ||___||     ||___||
    |/___\|     |/___\|     |/___\|     |/___\|


  Du kannst auch die Maus verwenden, indem du auf eines
  der 4 kleinen Kopfpiktogramme in der Menüleiste klickst.
  Wenn du den Mauszeiger über eines der Piktogramme bewegst
  erscheint ein Hinweistext zur dort hinterlegten Funktion.


  Hierzu ein Beispiel:

  Angenommen, du möchtest ein Open-Control/BASIC-Programm
  schreiben. Erstelle zuerst eine leere Datei und speichere
  diese ab. Wichtig ist dabei, dass die Dateiendung " .OCB"
  lautet.

  Beispiel für den Dateinamen: Hallo.OCB

  Anhand der Dateiendung bestimmt das System, um welche Art
  von Quelltext es sich handelt und welche der enthaltenen
  Werkzeugprogramme und in welcher Reihenfolge diese automatisch
  aufgerufen werden damit am Ende ein fertiges Anwenderprogramm
  entsteht. Die Aneinanderreihung mehrerer Softwarewerkzeuge
  wird manchmal auch 'Toolchain' genannt. Das ist Englisch und
  steht für eine Kette von Werkzeugen die dann zusammen das
  Endergebnis liefern, also z.B. aus deinem Quelltext mit den
  BASIC-Schlüsselwörtern das fertige Programm 'zaubern'

Tipp: Das Pulldown-Menü in der Mitte der oberen Menüleiste ändert
      zwar die farbliche Darstellung deines Quelltextes (das sogenannte
      Syntax-Highlighting). Die Toolchain, welche verwendet wird, kannst
      du damit aber nicht auswählen.


  Erstelle dein erstes Programm!
  ------------------------------

  'Mein erstes Programm  <- Dies ist eine Zeile mit Kommentar

   WHILE NOT rxd

     PRINT "Das ist einfach!"
     PAUSE 50

   WEND



  Um dein Programm zu kompilieren, drücke anschliessend die Taste

                 _____
                ||F9_||
                ||___||
                |/___\| .

   Kompilieren bedeutet hier, dass der vorliegende Quelltext
   maschinell analysiert und umgewandeltwird. Dazu dient der
   Kompiler. Dieser erzeugt aus dem Quelltext eine zusätzliche
   Datei "*.DAT". Darin ist der ausführbare Bytekode enthalten.


Du musst evt. noch den richtigen COM-port auswählen, an welchem
das Zielsystem angeschlossen ist. Dies funktioniert wie folgt:

Zuerst öffnest du die Datei L:\x2g\Hilfe.L

Anschliessend drückst die eine der Funktionstasten F9, F10, F11, F12,
entsprechend der Nummer des COM-Ports an welchem das Zielsystem
angeschlossen ist. Diesen Vorgang brauchst du nur einmal durchzuführen,
es sein denn das Zielsystem wird an einen anderen COM-Port angeschlossen.

Nun kannst du dein Programm zum Ziellsystem übertragen.

Drücke eine der Tasten...
                 _____              _____
                ||F10||            ||F11||
                ||___||            ||___||
                |/___\|            |/___\|

...um den Bytekode zum Zielsystem zu übertragen.


  Nachdem die Übertragung beendet ist, wird automatisch das
  Terminal-Fenster geöffnet. Darin kannst du Kommandos an das
  Zielsystem absetzen und dessen Antworten beobachten.

  Je nachdem, welches Zielsystem du verwendest kannst du ein
  Programm mit der Taste <EINGABE> oder <LEERZEICHEN> starten.


  Apropos 'zaubern':

 (Den nachfolgenden Text haben wir noch nicht ins Deutsche übersetzt.
  Vielleicht kannst du ihn trotzdem lesen und verstehen.)

  There a 6 programming languages already configured inside this IDE:

Name:                          File type associations:        Platform:
===
Assembly code                             .asm, .a05               6805
BASIC++                                   .bpp, .blib               all
C-Control/BASIC                           .bas                      all
C-Control/C-Cross-Compiler (CCCCC)        .c5                       all
Open-Control/BASIC                .ocbasr .ocb, .pro, .def          all
Open-Control/BASIC (INLINE assembly code) .iar, .iia   6808, Open-Micro
===




   Did you know?


   - We have included 2 'magic' files for you!
     The first one is located here:  L:\x2g\Info.L
     The second one is located here:  L:\x2g\Help.L

   - The 'magic' files provide you with information just as you need it
     without distracting you. This way, your workflow won't be stalled
     by having to spend time searching through 3rd-party resources yourself.


  Try it out: Just observe the magic files updating in the editor automatically
              providing you with topic related information on the tools you use.


     We think of this as a rather efficient way to credit the merit of
     the many contributors who have graciously provided the 3rd-party
     components which this freeware distribution completely relies upon.

     We highly recommend taking a look at the works of the many individual
     contributors in the following directory: L:\x2g\3rdparty\


  Zusammenstellung von

  das |_ Team, im Februar 2018

 
  Note: The 'magic' files are completely local installation files and therefore
        do NOT establish or need any network or internet connection at all.

Links:

 [1] http://ccintern.dharlos.de/forum/lesen.php?eintrag=16212




