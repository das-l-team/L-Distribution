Mit dem �bertragungstool CCtrans32.EXE, von Dierk Schmid CSS MicroSystems GmbH,
Weinsberg, kann der Bytekode von zuvor kompilierten Programmen zur C-control I
�bertragen werden.

CCTrans32.EXE ist urspr�nglicher Bestandteil der integrierten Entwicklungsumgebung
Workbench++. Mit der Workbench++, ebenfalls von CSS Microsystems GmbH, k�nnen
weiterhin BASIC++ Programme und Assembler Programme f�r die C-Control I und
Kompatible entwickelt werden. Die Workbench++ erm�glicht zus�tzlich die Entwicklung
von Assemblerprogrammen f�r die C-Control I 2.0 Mikrokontroller Systeme.

Das �bertragungstool CCTrans32.EXE erzeugt nur geringe CPU Belastung und hat eine
fein aufgel�ste Fortschrittsanzeige.

S19-Dateien (assemblierte Maschinenspracheprogramme) k�nnen auch einzeln zum
Zielsystem �bertragen werden.

Aufgrund der geringen CPU-Belastung ist keine Beeinflussung von zeitkritischen
Programmen (z.B. MIDI-, Video-,oder Audio-Player) durch das �bertragungstool
CCTrans32 zu erwarten.


Syntax:

CCTrans32.exe[Laufwerk:][Pfad][Dateiname][Port][/S19][/CCASM][/Help][/br38400]

[Laufwerk:][Pfad][Dateiname]
      Bezeichnet Laufwerk, Verzeichnis und Datei.
[Port]    --> Gibt den Port an. Entweder numerisch 1-16 oder mit Bezeichner z.B. COM1
[/S19]    --> Es handelt sich um eine Assembler S19-Datei.
[/CCASM]  --> Es handelt sich um eine CCASM Syscode Datei.
[/Help]   --> Diese Hilfe.
[/br38400]--> Baudrate 38400. Kann von 1200 bis 38400 �bergeben werden.
