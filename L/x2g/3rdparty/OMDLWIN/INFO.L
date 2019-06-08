[ Der nachfolgende Text wird aus diesem in der |_ Distribution enthaltenen
  Softwarearchiv wiedergegeben:  "L:\x2g\3rdparty\OMDLWIN\omdl15.zip"
]


==========================================================================

OMDLWIN.EXE Version 1.5 fuer Windows 95/98/Me/NT/2000/XP/Vista/7/8/10
Programmuebertragung zur Open-Micro, Open-Mini, Open-Midi, Open-Macro und
                         Open-Maxi

Freeware von Dietmar Harlos ADPC ab 2006/02/17
http://om.dharlos.de

==========================================================================

Mit diesem Uebertragungsprogramm kann eine vom OCBASIC- oder CCBASIC-
Compiler erstellte DAT-Datei ueber die Serielle Schnittstelle zu einem
C-Control-1-kompatiblen Controller wie der Open-Micro, Open-Mini, Open-
Midi, Open-Macro und Open-Maxi sicher uebertragen werden. Durch einen
optionalen Parameter lassen sich die OM-Controller nach der erfolgreichen
Uebertragung ausserdem automatisch starten, wodurch das soeben
uebertragene Programm ausgefuehrt wird.

Das Uebertragungsprogramm OMDLWIN wurde geschrieben, damit es zusammen
mit dem OCBASIC-Compiler in die ConTEXT-Entwicklungsumgebung eingebunden
und auf Tastendruck gestartet werden kann.

Aufruf: OMDLWIN "mein programm.dat" [COM [BAUDRATE|AUTOBAUD]] [AUTOSTART]

Parameter:
  COM ........ Nummer oder Kennung der Seriellen Schnittstelle (z.B. COM1)
  BAUDRATE ... Die zu verwendende Baudrate (z.B. 9600)
  AUTOBAUD ... Die hoechste Baudrate automatisch waehlen (ab Open-Macro)
  AUTOSTART .. Den OM-Controller nach der Uebertragung starten

Die Gaensefuesschen um den Programmnamen koennen weggelassen werden, falls
im Pfad und Namen der DAT-Datei keine Leerzeichen enthalten sind.

Der Parameter AUTOBAUD kann gefahrenlos auch auf Controllern verwendet
werden, die eine Uebertragung mit erhoehter Geschwindigkeit nicht
unterstuetzen.

Als kleine Demonstration koennen die Dateien DEMO1 und DEMO2 gestartet
werden. Sie funktionieren auf der Open-Micro, Open-Mini, Open-Midi und
Open-Macro, aber nicht auf der Open-Maxi. Mit DEMO1 wird "Blue Peter.DAT"
zum OM-Controller geschickt, woraufhin das Lied "Blue Peter" aus einem an
PORT[6] angeschlossenen Piezo-Schallwandler ertoent. Das Programm im
Controller wird unmittelbar nach der Uebertragung automatisch gestartet.
Die zweite Demonstration uebertraegt den Micro-Benchmark, der vom
Entwickler der neuen C-Control herausgegeben wurde. Das Programm wird
allerdings nicht automatisch ausgefuehrt, sondern es sollte nach der
Uebertragung zunaechst ein Terminalprogramm gestartet werden. Innerhalb
des Terminalprogramms fuehrt das Druecken der RETURN-Taste zum Starten
des Programms im Controller, falls sich der Controller noch immer im
Hostmode befindet. Es wird daraufhin die Geschwindigkeit des Controllers
in BASIC-Instruktionen pro Sekunde ausgegeben.

==========================================================================

Uebertragung mit 38400 Baud auf der Open-Macro:
-----------------------------------------------

Standardmaessig benutzt die Open-Macro die Single-Wire-RS232 an PORT[1].
Diese kann nur mit 9600 Baud betrieben werden. Der Controller, auf dem die
Open-Macro basiert, besitzt allerdings auch eine Hardware-RS232 ("ESCI"),
die bis zu 38400 Baud bietet. Um die ESCI im Hostmode zu aktivieren, muss
PORT[1] vom Anwender vor Eintritt in den Hostmode auf LOW (0 Volt, Masse)
gelegt werden. Der Anwender muss also folgendermassen vorgehen:

  - Hostmodeschalter in Stellung "HOST" bringen (PORT[3] auf Masse)
  - Taster an PORT[1] druecken und gedrueckt halten (PORT[1] auf Masse)
  - Controller resetten (bzw. einschalten)
  - Taster an PORT[1] loslassen

Der Controller befindet sich anschliessend im Hostmode mit aktiviertem ESCI.
TXD der ESCI liegt am PORT[14] und RXD am PORT[13]. Auf dem Starterboard
von CCTools oder dem zweiten PE-Board auf der offiziellen OM-Website kann
der Jumper fuer RS232 auf Dual-Wire umgeschaltet und PORT[14] mit PORT[1]
und PORT[13] mit PORT[2] verbunden werden, um die ESCI zu nutzen. Wird
nun "OMDLWIN prog.dat COM1 AUTOBAUD AUTOSTART" aufgerufen, wird OMDLWIN die
Verbindung zur Open-Macro ueber COM1 aufnehmen, den Controller auf 38400
Baud umschalten, das Programm "prog" uebertragen und zum Schluss die
Open-Macro starten.

Mit ESCI und AUTOBAUD werden Programme bis zu zehnmal schneller uebertragen!

==========================================================================

Uebertragung mit 115200 Baud auf der Open-Maxi:
-----------------------------------------------

Die Open-Maxi besitzt eine Hardware-RS232, die in der Lage ist, Programme
mit 115200 Baud zu uebertragen. Dazu muss der Anwender beim Aufruf nur den
Parameter AUTOBAUD statt der Baudrate angeben. Ein maximal grosses Programm
wird dadurch in unter 12 Sekunden uebertragen!

==========================================================================

Versionshistorie:
-----------------

Erweiterungen in 1.1 gegenueber 1.0:
  - Erkennung der verschiedenen OM-Varianten
  - bessere Erkennung von fehlerhaften DAT-Dateien

Erweiterungen in 1.2:
  - schnellere Uebertragung
  - durch Umschalten der RS232 hervorgerufene Stoerungen werden durch
    mehrfaches Leeren des Empfangsbuffers besser ignoriert
  - Erkennung der Open-Macro und experimenteller OM-Varianten

Erweiterungen in 1.3:
  - neuer Parameter "AUTOBAUD", der statt der Baudrate angegeben werden kann,
    und auf der Open-Macro die schnellstmoegliche Baudrate automatisch waehlt

Erweiterungen in 1.4:
  - Unterstuetzung der Open-Maxi
  - deutlich schnellere Uebertragung bei "AUTOBAUD"
  - Timeouts werden jetzt sicherer erkannt

Erweiterungen in 1.5:
  - auf Open-Maxi: bei "AUTOBAUD" wird jetzt nach der Uebertragung auf
    9600 Baud zurückgeschaltet, damit bei nicht vorhandenem "AUTOSTART"
    der Controller im Terminal mit RETURN gestartet werden kann.

==========================================================================

Hilfsprogramme:
---------------

Im Verzeichnis "Hilfsprogramme" stehen zusaetzlich die DOS-Uebertragungs-
programme OMDL.EXE und CCDL.EXE bereit. Das OMDL wurde speziell fuer die
OM-Controller erstellt, kann auch unter Windows 95, 98 und Me eingesetzt
werden. Allerdings arbeitet es nicht unter aktuelleren Windowsversionen.

Ausserdem steht in diesem Verzeichnis das Terminalprogramm TERMINAL.EXE
fuer DOS, mit dem PRINT- und PUT-Ausgaben der OM-Controller vom PC
empfangen und in der Datei TERMINAL.OUT festgehalten werden koennen. Alle
Tastatureingaben werden vom PC zum Controller gesendet und koennen von
der OM mit GET und INPUT empfangen werden.

Seit neuestem gibt es jetzt ein Terminalprogramm fuer 32-Bit. Es kann
unter allen aktuellen Betriebssystemen eingesetzt werden und arbeitet
wie das Terminalprogramm TERMINAL.EXE fuer DOS.

==========================================================================

Fehlermeldungen bitte direkt an meine E-Mail-Adresse schicken.

Allgemeine Fragen werden im Forum zur C-Control-1 beantwortet:

http://ccintern.dharlos.de/forum

Viel Spass und Erfolg mit den OM-Controllern wuenscht

Dietmar Harlos
http://om.dharlos.de

