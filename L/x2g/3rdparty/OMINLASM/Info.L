[ Dieses Verzeichnis ist eine Baustelle ]

 Eine Kopie des Originalarchiv zum Kommandozeilentool INLASM.EXE ist im Pfad
 "L:\x2g\3rdparty\IDI08\om_asm.zip"  einsehbar.

  Weitere Hinweise zur Verwendung von INLASM.EXE siehe:

  http;//ccintern.dharlos.de/forum/lesen.php?eintrag=11272

  Zitat:
  "[...] Das Programm war nur als Notlösung für CCBASIC gedacht. Der neue OCBASIC-
  Compiler besitzt einen integrierten 6808-Assembler, mit dem das Erstellen von
  Assemblercode deutlich komfortabler und einfacher geht. [...]"
  
  
  Neu ab |_ Distribution 0.26:

  Mit 'S192TAB.exe' ist ein weiteres Tool zur Umwandlung von .s19-Dateien in die
  Tabellenform enthalten. Das Ausgabeformat unterscheidet sich geringfügig. Siehe
  den nachfolgenden Text.


Die Ausgabe des Tools 'INLASM.exe':

' Die nachfolgende Tabelle wurde aus "FASTBAS.S19" generiert

TABLE fastbas
  &h1206
  &h9ccd &h0e04 &ha154 &h2306 &hcd09 &h17cc &h0969 &h4897
  &hd61d &hf6b7 &hbed6 &h1df7 &hb7bf &hbdbd &h20e3
TABEND


Die Ausgabe des Tools 'S192TAB.exe':

' Der 1. Maschinencodebereich aus "FASTBAS.S19":
' Startadresse: $0101
' Laenge: 30 Byte

TABLE fastbas_1
  &h0101 30
  &h9ccd &h0e04 &ha154 &h2306 &hcd09 &h17cc &h0969 &h4897
  &hd61d &hf6b7 &hbed6 &h1df7 &hb7bf &hbdbd &h20e3
TABEND


Hier ist die verwendete .s19-Datei:

S12101019CCD0E04A1542306CD0917CC09694897D61DF6B7BED61DF7B7BFBDBD20E3FE
S5030001FB
S9030000FC


Und hier der Quelltext aus dem obige s19-Datei erzeugt wurde.


; Hochoptimierte Routine zum Ausfuehren von BASIC-Programmen
; (c) Dietmar Harlos ADPC, 24. Januar 2002

; * schnellere BASIC-Befehlsausfuehrung (rund 12%)
; * es werden zwei Stackeintraege eingespart (!)
; * eine BASIC-IRQ-Routine wird nicht unterstuetzt
; * laesst sich in einem modifizierten Betriebssystem verwenden
; * im BASIC-Programm ist zu Anfang ein "SYS &h101" erforderlich

  org $101
  
  rsp             ; Stackpointer resetten

loop:  
  jsr $0e04       ; Token vom EEPROM holen
  cmp #84         ; ist es groesser als 84? falls ja, dann
  bls noend       ; die BASIC-Befehlsausfuehrung beenden

  jsr $0917       ; EEPROM abmelden, LEDs loeschen,
  jmp $0969       ; auf zur IDLE-Loop

noend:
  lsla            ; BASIC-Token mit zwei multiplizieren,
  tax             ; damit es als Offset in der Sprungtabelle
  lda $1df6,x     ; verwendet werden kann. Dann die Adresse
  sta $be         ; der zum Token gehoerenden BASIC-Routine
  lda $1df7,x     ; aus der Tabelle lesen und per jmp-Befehl
  sta $bf         ; (auf Adresse $bd) aufrufen. Auf diese
  jsr $bd         ; Weise funktioniert auch der SYS-Befehl.

  bra loop
  
  
; Der Grund, warum diese Routine nicht noch schneller ist, liegt
; daran, dass die C-Control den weitaus groessten Teil ihrer Zeit
; damit verbringt, ueber den I2C-Bus aus dem seriellen EEPROM zu
; lesen (siehe "jsr $0e04").
  
; Bei einem OTP waere es denkbar, ein BASIC-Programm (also BASIC-
; Tokens) im EPROM unterzubringen und diese dann mit Hilfe einer
; leicht modifizierten Routine auszufuehren. Das Programm wuerde
; erheblich schneller laufen, ohne dass man es (z.B. mit CCBAS2MC)
; in Maschinencode uebersetzen muesste.


