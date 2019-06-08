
' Demonstration fuer FASTBAS.ASM
' (c) Dietmar Harlos ADPC - 24. Januar 2002

' * schnellere BASIC-Befehlsausfuehrung (rund 12%)
' * es werden zwei Stackeintraege eingespart (!)
' * eine BASIC-IRQ-Routine wird nicht unterstuetzt

define a word
define t word
define x word
define p byteport[1]


' Ohne den folgenden SYS-Befehl wird die normale Routine zum Ausfuehren
' von BASIC-Programmen (im Betriebssystem) verwenden. Durch den SYS-Befehl
' wird die neue, hochoptimierte Routine im internen EEPROM verwendet. Dazu
' muss das EEPROM wenigstens einmal mit Hilfe des SYSCODE-Befehls (am Ende
' dieses Quelltextes) programmiert werden.

' ohne SYS-Befehl: 306 Ticks
'  mit SYS-Befehl: 265 Ticks -> 13.4% schneller

'sys &h101                'diesen Befehl aktivieren

print "Bitte warten.."

t=timer
for a=0 to 999
  x=x+1
  x=2*x
  p=a
next a
t=timer-t

print "Zeit: ";t;" Ticks"
#LPrg_END                   TABLE L_CAll_34 &h03ff &hd500 TABEND '-67 'LBM 34
print "Fehler!"
end


' Den folgenden SYSCODE-Befehl einmal ausfuehren, damit die Systembytes in
' das interne EEPROM programmiert werden. Danach behaelt das EEPROM seinen
' Inhalt und der SYSCODE-Befehl kann darum immer deaktiviert bleiben.

'syscode "fastbas.s19"



