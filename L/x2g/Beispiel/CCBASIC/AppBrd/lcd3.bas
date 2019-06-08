'********************************************************************
'
' C-Control/BASIC       LCD3.BAS
'
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossenem Display
'
' Schwerpunkt:
'
' - Ausgeben der Uhrzeit am Display
'
'********************************************************************

' *** Daten-Definition ***
define value word
define output word

define lcd_buf byte
define lcd_param byte

define lastsec byte

' *** Definition LCD-Ports ***
define lcd_port byteport[2]
define lcd_rs port[14]
define lcd_rw port[13]
define lcd_e port[15]

'*** ASCII-Codes ***
define A_ &H41
define B_ &H42
define C_ &H43
define D_ &H44
define E_ &H45
define F_ &H46
define G_ &H47
define H_ &H48
define I_ &H49
define J_ &H4A
define K_ &H4B
define L_ &H4C
define M_ &H4D
define N_ &H4E
define O_ &H4F
define P_ &H50
define Q_ &H51
define R_ &H52
define S_ &H53
define T_ &H54
define U_ &H55
define V_ &H56
define W_ &H57
define X_ &H58
define Y_ &H59
define Z_ &H5A

define LEERZ &H20
define MINUS &H2D
define NULL &H30
define GLEICH &H3D
define DOPPELPUNKT &H3A

'*** Programmoperationen  ***

  gosub LCD_INIT

#LOOP

  wait second <> lastsec
  lastsec = second
  gosub WRITETIME

goto LOOP

#WRITETIME

 lcd_param = 1 : gosub LCD_GOTOLINE
 lcd_param = NULL + hour / 10 : gosub LCD_WRITECHAR
 lcd_param = NULL + hour mod 10 : gosub LCD_WRITECHAR
 lcd_param = DOPPELPUNKT : gosub LCD_WRITECHAR
 lcd_param = NULL + minute / 10 : gosub LCD_WRITECHAR
 lcd_param = NULL + minute mod 10 : gosub LCD_WRITECHAR
 lcd_param = DOPPELPUNKT : gosub LCD_WRITECHAR
 lcd_param = NULL + second / 10 : gosub LCD_WRITECHAR
 lcd_param = NULL + second mod 10 : gosub LCD_WRITECHAR

return


'*** LCD_Interface ***
'( muss in jedes Programm mit LCD-Ausgabe eingefuegt werden)

#LCD_INIT

' alle ports 0
  lcd_port = OFF

' 8-Bit-Modus aktivieren
  lcd_param=&H38 : gosub LCD_WRITECMD

' mit 8-Bit-Command in 4-Bit-Modus umschalten
  lcd_port=&B00000010
  tog lcd_e
  tog lcd_e

' ab jetzt 4-Bit-Modus
  lcd_param = &H28 : gosub LCD_WRITECMD
  lcd_param = &H0C : gosub LCD_WRITECMD

' Display loeschen
#LCD_CLS
  lcd_param = &H02 : gosub LCD_WRITECMD
  lcd_param = &H01 : gosub LCD_WRITECMD
return

' Zeilenwechsel
#LCD_GOTOLINE
  if lcd_param = 1 then lcd_param = &H80
  if lcd_param = 2 then lcd_param = &HC0
  goto LCD_WRITECMD

' LCD-Kommando
#LCD_WRITECMD
  lcd_buf = OFF
  goto LCD_WRITE

' Zeichenausgabe
#LCD_WRITECHAR
  lcd_buf = &B00100000

' Kommando oder Zeichen an Display senden
#LCD_WRITE
  lcd_port = lcd_buf or (lcd_param shr 4) ' Hi-Nibble
  tog lcd_e
  tog lcd_e
  lcd_port = lcd_buf or (lcd_param and &H0F)  ' Lo-Nibble
  tog lcd_e
  tog lcd_e
return
