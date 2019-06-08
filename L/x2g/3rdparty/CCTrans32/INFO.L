Mit dem Übertragungstool CCtrans32.EXE, von Dierk Schmid CSS MicroSystems GmbH,
Weinsberg, kann der Bytekode von zuvor kompilierten Programmen zur C-control I
übertragen werden.

CCTrans32.EXE ist ursprünglicher Bestandteil der integrierten Entwicklungsumgebung
Workbench++. Mit der Workbench++, ebenfalls von CSS Microsystems GmbH, können
weiterhin BASIC++ Programme und Assembler Programme für die C-Control I und
Kompatible entwickelt werden. Die Workbench++ ermöglicht zusätzlich die Entwicklung
von Assemblerprogrammen für die C-Control I 2.0 Mikrokontroller Systeme.

Das Übertragungstool CCTrans32.EXE erzeugt nur geringe CPU Belastung und hat eine
fein aufgelöste Fortschrittsanzeige.

S19-Dateien (assemblierte Maschinenspracheprogramme) können auch einzeln zum
Zielsystem übertragen werden.

Aufgrund der geringen CPU-Belastung ist keine Beeinflussung von zeitkritischen
Programmen (z.B. MIDI-, Video-,oder Audio-Player) durch das Übertragungstool
CCTrans32 zu erwarten.


Syntax:

CCTrans32.exe[Laufwerk:][Pfad][Dateiname][Port][/S19][/CCASM][/Help][/br38400]

[Laufwerk:][Pfad][Dateiname]
      Bezeichnet Laufwerk, Verzeichnis und Datei.
[Port]    --> Gibt den Port an. Entweder numerisch 1-16 oder mit Bezeichner z.B. COM1
[/S19]    --> Es handelt sich um eine Assembler S19-Datei.
[/CCASM]  --> Es handelt sich um eine CCASM Syscode Datei.
[/Help]   --> Diese Hilfe.
[/br38400]--> Baudrate 38400. Kann von 1200 bis 38400 übergeben werden.

