'********************************************************************
'
' C-Control/BASIC       LCD1.BAS
'
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossenem Display
'
' Schwerpunkt:
'
' - Ausgeben von Text am Display
'
'********************************************************************


' *** Daten-Definition ***
define lcd_buf byte
define lcd_param byte

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

'*** Programmoperationen  ***

  gosub LCD_INIT
  pause 10

' Ausgabe von Application Board  am Display
  lcd_param = A_ : gosub LCD_WRITECHAR       ' APPLICATION
  lcd_param = P_ : gosub LCD_WRITECHAR
  lcd_param = P_ : gosub LCD_WRITECHAR
  lcd_param = L_ : gosub LCD_WRITECHAR
  lcd_param = I_ : gosub LCD_WRITECHAR
  lcd_param = C_ : gosub LCD_WRITECHAR
  lcd_param = A_ : gosub LCD_WRITECHAR
  lcd_param = T_ : gosub LCD_WRITECHAR
  lcd_param = I_ : gosub LCD_WRITECHAR
  lcd_param = O_ : gosub LCD_WRITECHAR
  lcd_param = N_ : gosub LCD_WRITECHAR

  lcd_param = 2 : gosub LCD_GOTOLINE        ' Wechsel in die zweite Zeile

  lcd_param = B_ : gosub LCD_WRITECHAR      ' BOARD
  lcd_param = O_ : gosub LCD_WRITECHAR
  lcd_param = A_ : gosub LCD_WRITECHAR
  lcd_param = R_ : gosub LCD_WRITECHAR
  lcd_param = D_ : gosub LCD_WRITECHAR

  end


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
