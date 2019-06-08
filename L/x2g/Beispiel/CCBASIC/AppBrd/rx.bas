'********************************************************************
'
' C-Control/BASIC       RX.BAS
'
' Systemvoraussetzungen:
'
' - Application Board mit angeschlossenem Telemetrieempfaenger
'   und Display
'
' Schwerpunkt:
'
' - Empfangen von Funkdaten, (Empfang der Daten von tx.bas)
'
'********************************************************************


' *** Daten-Definition ***
define lcd_buf byte
define lcd_param byte

define charcount byte

define recbyte byte

' *** Definition LCD-Ports ***
define lcd_port byteport[2]
define lcd_rs port[14]
define lcd_rw port[13]
define lcd_e port[15]

'*** Programmoperationen  ***

#START

  charcount = 0
  gosub LCD_INIT
  pause 10
  baud R2400

#DOWAIT

' auf Byteempfang warten
  wait rxd

' Byte lesen
  get recbyte

  charcount = charcount + 1
  if charcount = 17 then gosub LINEFEED
  if charcount = 33 then goto START

  ' Byte auf Display schreiben
  lcd_param = recbyte : gosub LCD_WRITECHAR

goto DOWAIT

#LINEFEED
  lcd_param = 2 : gosub LCD_GOTOLINE        ' Wechsel in die zweite Zeile
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
