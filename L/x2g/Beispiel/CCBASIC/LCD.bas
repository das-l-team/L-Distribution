
'Dieser Beitrag wurde aus dem Forum der Website http://ccintern.dharlos.de ubernommen.
'Link zum Beitrag im Forum der ccintern: http://ccintern.dharlos.de/forum/lesen.php?eintrag=4151

' LCD-Treiber in CCBASIC mit LOCATE, CLS und Sonderzeichen
' letztes Update 11.01.2005 (fuer NAN-YA 4x20)

' *** BYTE-VARIABLEN FUER LCD-TREIBER ***
define lcd_buf  byte 'Puffer fuer Datentranfer zum Display
define lcd_dat  byte 'zu sendenden Daten-Bytes
                             'lcd_dat auch für LOCATE-Funktion im Format xxy
                             '(10er+100er für spalte und 1er fuer Zeile
                             'beginnend bei 0)

define i        byte  'Laufvariablen, welche nur fuer CG-RAM-Export
define j        byte  'benoetigt werden und anderweitig verwandt werden koennen
 
' *** Port-Variablen LCD-Treiber ***
define lcd_port     byteport[2] 'LCD-Interface-Port - gesamt
define lcd_rs        port[14]    'Befehls-Leitung - fuer Cmd's auf 1
define lcd_e         port[15]    'Execute-Leitung - H-L-Pulse
 
' ***   DISPLAY - POWER_ON_INITIALISIERUNG   ***
lcd_port = &B01000000                  'EXE-Leitung HI setzen
lcd_dat  = &B00110000 : gosub SEND_COM 'FUNC-Set (noch 8-Bit)
lcd_port = &B01000010 : pulse lcd_e    'FUNC-Set: ab jetzt 4-Bit
lcd_dat  = &B00101000 : gosub SEND_COM 'N=1 (2zeilg. Disp.) F=0 (5x7 Font)
lcd_dat  = &B00001100 : gosub SEND_COM 'Disp an, Cursor aus, Blinken aus
lcd_dat  = &B00000110 : gosub SEND_COM 'Adresspointer increm., Kein Shift
'Sonderzeichen in den CG-RAM exportieren
for i = 0 to 56 step 8
   lcd_dat = 64 + i : gosub SEND_COM
   for j = i to i + 7
      looktab CG_CODES,j,lcd_dat
      gosub SEND_CHAR
   next
next
 
gosub CLS

 
'--------- anwenderprogramm (hier: testausgabe-schleife)
lcd_dat = 41 : gosub LOCATE ' spalte 5, zeile 2 des displays setzen
   for i = 14 to 21
      looktab PRINTS,i,lcd_dat
      gosub SEND_CHAR
next i
end
'--------------------------------------------------------

#CLS        ' Einsprung "Display loeschen"
   lcd_dat = 2 : gosub SEND_COM
   lcd_dat = 1 : goto  SEND_COM
#LOCATE     ' Einsprung "Cursor auf Display platzieren"
   looktab DDRAM_ADD,lcd_dat mod 10,lcd_buf
   lcd_dat = lcd_buf + lcd_dat / 10
#SEND_COM   ' Einsprung "Befehl an Display senden"
   lcd_buf = &B01000000
   goto SEND_OUT
#SEND_CHAR  ' Einsprung "Zeichen senden"
   lcd_buf = &B01100000
   #SEND_OUT
   lcd_port = lcd_buf or (lcd_dat shr 4)    ' obere 4 Bits senden
   pulse lcd_e
   lcd_port = lcd_buf or (lcd_dat and &H0F) ' untere 4 Bits senden
   pulse lcd_e
return

' Zeichengenerator-Daten ***
table CG_CODES
      31 17 17 17 17 17 31 00 'Code 00, leerer Rahmen
      31 31 31 31 31 31 31 00 'Code 01, voller Klotz
      10 00 17 17 17 17 14 00 'Code 02, grosses Ue
      00 16 08 04 02 01 00 00 'Code 03, Zeichen \
      00 00 00 00 00 00 00 00 'Code 04, Leerzeichen
      00 00 04 14 04 00 00 00 'Code 05, Zeichen CTRL+G
      04 00 04 08 16 17 14 00 'Code 06, verkehrtes Fragezeichen
      15 16 14 17 14 01 30 00 'Code 07, Paragraph
     '17 14 17 17 31 17 17 00 'Code __, grosses Ae
     '17 14 17 17 17 17 14 00 'Code __, grosses Oe
tabend
' DD-RAM-Adressen (hier fuer 4x20-Zeichen-Display)
table DDRAM_ADD
     0 32 64 128 '128 192 148 212
tabend

' *** Programm-Ausgaben auf Display ***
table PRINTS
      '"Autostartzahl"          14 Bytes  0...13
      065 117 116 111 115 116 097 114 116 122 097 104 108 058
      '"Status: "                 8 Bytes 14...21
      083 116 097 116 117 115 058 032
tabend
 
