
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


