'********************************************************************
'  TERMINAL.BAS      '(Geaendert von) das |_ Team: Tabelle in Zeilen 36 bis 40
'                    'auskommentiert und Tabelle an das Programmende kopiert.
'  - ein kleines Funknetzwerk mit C-Control/BASIC-Modulen
'  - Beschreibung siehe FUNKNETZ.TXT
'
'  M.Foerster, 04.11.97
'********************************************************************

goto MAIN

'====================================================================
' KEYBOARD
'====================================================================

' keyboard resources
define key_nr byte
define compare byte
define keyboard ad[8]

' keys
define KEY_ASTERIX 0
define KEY_7       1
define KEY_4       2
define KEY_1       3
define KEY_0       4
define KEY_8       5
define KEY_5       6
define KEY_2       7
define KEY_CROSS   8
define KEY_9       9
define KEY_6       10
define KEY_3       11
define NOKEY       255

'table keycodes
'  0 23 46 68
'  90 111 132 152
'  173 193 214 235
'tabend

define KEYCODE_TOLERANCE 3

#GETKEY
  for key_nr = 0 to 11
    looktab keycodes, key_nr, compare
    if abs(keyboard-compare) < KEYCODE_TOLERANCE then return
  next
  key_nr = NOKEY
return

'====================================================================
' LCD
'====================================================================

' *** Daten-Definition ***
define value word
define output word

define lcd_buf byte
define lcd_param byte

define i byte

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
define DOT &H2E

#WRITEVALUE

  output = abs(value)

  ' negatives Vorzeichen oder Leerzeichen
  lcd_param = MINUS
  if value < 0 then gosub LCD_WRITECHAR

  ' Zehntausender-Dezimalstelle oder Leerzeichen (Ausblenden fuehrender Nullen)
  lcd_param = NULL + output/10000
  if abs(value) >= 10000 then gosub LCD_WRITECHAR
  output = output mod 10000

  ' Tausender-Dezimalstelle oder Leerzeichen
  lcd_param = NULL + output/1000
  if abs(value) >= 1000 then gosub LCD_WRITECHAR
  output = output mod 1000

  ' Hunderter-Dezimalstelle oder Leerzeichen
  lcd_param = NULL + output/100
  if abs(value) >= 100 then gosub LCD_WRITECHAR
  output = output mod 100

  ' Zehner-Dezimalstelle oder Leerzeichen
  lcd_param = NULL + output/10
  if abs(value) >= 10 then gosub LCD_WRITECHAR

  ' einer Dezimalstelle oder Leerzeichen
  lcd_param = NULL + output mod 10
  gosub LCD_WRITECHAR
return

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

'====================================================================
' NETWORK
'====================================================================

define tx_enable port[16]

define rxMsgDest byte
define rxMsgSrc  byte
define rxMsgM1   byte
define rxMsgM2   byte
define rxMsgM3   byte
define rxMsgM4   byte
define rxMsgCRC  byte

define txMsgDest byte
define txMsgM1   byte
define txMsgM2   byte
define txMsgM3   byte
define txMsgM4   byte

define crc     byte
define ok      byte

define FALSE 0
define TRUE -1

define TAG &HAA

define SELF 1

#SENDMESSAGE
  tx_enable = ON
  crc = TAG xor txMsgDest xor SELF xor txMsgM1 xor txMsgM2 xor txMsgM3 xor txMsgM4
  put TAG
  put txMsgDest
  put SELF
  put txMsgM1
  put txMsgM2
  put txMsgM3
  put txMsgM4
  put crc
  tx_enable = OFF
  if rxd then get crc ' dummy read
  if rxd then get crc
  if rxd then get crc
  if rxd then get crc
  if rxd then get crc
  if rxd then get crc
  if rxd then get crc
  if rxd then get crc
return

#GETMESSAGE
  ok = FALSE

  if rxd then get crc else return
  if (crc <> TAG) then return
  pause 1

  if rxd then get rxMsgDest else return
  if rxMsgDest <> SELF then return
  crc = crc xor rxMsgDest

  if rxd then get rxMsgSrc else return
  crc = crc xor rxMsgSrc

  if rxd then get rxMsgM1 else return
  crc = crc xor rxMsgM1
  if rxd then get rxMsgM2 else return
  crc = crc xor rxMsgM2
  if rxd then get rxMsgM3 else return
  crc = crc xor rxMsgM3
  if rxd then get rxMsgM4 else return
  crc = crc xor rxMsgM4

  if rxd then get rxMsgCRC else return
  if crc <> rxMsgCRC then return

  ok = TRUE
return

'====================================================================
' MAIN Program
'====================================================================

define MSG_REQUEST 0
define MSG_ANSWER  255

define SENSOR1 AD[1]
define SENSOR2 AD[2]
define SENSOR3 AD[3]

define nexttime word
define fx byte
define FXREPEATTIME 250

#MAIN
  gosub LCD_INIT
  gosub PROMPT
  baud R2400                       'Limit fuer Telemetriesender!

#LOOP
  gosub GETKEY
  if key_nr <> NOKEY then gosub HANDLEKEY

  if timer >= nexttime then gosub DO_FX

  gosub GETMESSAGE
  if ok then gosub HANDLEMESSAGE
goto LOOP

#PROMPT
  gosub LCD_CLS
  lcd_param = S_ : gosub LCD_WRITECHAR
  lcd_param = E_ : gosub LCD_WRITECHAR
  lcd_param = L_ : gosub LCD_WRITECHAR
  lcd_param = E_ : gosub LCD_WRITECHAR
  lcd_param = C_ : gosub LCD_WRITECHAR
  lcd_param = T_ : gosub LCD_WRITECHAR
return

#HANDLEKEY
  randomize timer
  fx = key_nr

#DO_FX
  nexttime = timer + FXREPEATTIME + rand mod 10
  on fx goto FX_ASTERIX, FX_7, FX_4, FX_1, FX_0, FX_8, FX_5, FX_2, FX_CROSS, FX_9, FX_6, FX_3
  goto PROMPT

#FX_ASTERIX
  fx = NOKEY
  goto PROMPT

#FX_0
return

#FX_CROSS
return

#FX_1
  txMsgDest = 1
  txMsgM2 = 1
  goto GETSENSORDATA

#FX_2
  txMsgDest = 1
  txMsgM2 = 2
  goto GETSENSORDATA

#FX_3
  txMsgDest = 1
  txMsgM2 = 3
  goto GETSENSORDATA

#FX_4
  txMsgDest = 2
  txMsgM2 = 1
  goto GETSENSORDATA

#FX_5
  txMsgDest = 2
  txMsgM2 = 2
  goto GETSENSORDATA

#FX_6
  txMsgDest = 2
  txMsgM2 = 3
  goto GETSENSORDATA

#FX_7
  txMsgDest = 3
  txMsgM2 = 1
  goto GETSENSORDATA

#FX_8
  txMsgDest = 3
  txMsgM2 = 2
  goto GETSENSORDATA

#FX_9
  txMsgDest = 3
  txMsgM2 = 3
  goto GETSENSORDATA

#GETSENSORDATA
  if txMsgDest <> SELF then goto SENDREQUEST

  rxMsgSrc = SELF
  rxMsgM2 = txMsgM2
  if rxMsgM2 = 1 then rxMsgM4 = SENSOR1
  if rxMsgM2 = 2 then rxMsgM4 = SENSOR2
  if rxMsgM2 = 3 then rxMsgM4 = SENSOR3
  goto DISPLAYDATA

#SENDREQUEST

  gosub LCD_CLS
  lcd_param = S_ : gosub LCD_WRITECHAR       ' STATION ...
  lcd_param = T_ : gosub LCD_WRITECHAR
  lcd_param = A_ : gosub LCD_WRITECHAR
  lcd_param = T_ : gosub LCD_WRITECHAR
  lcd_param = I_ : gosub LCD_WRITECHAR
  lcd_param = O_ : gosub LCD_WRITECHAR
  lcd_param = N_ : gosub LCD_WRITECHAR
  value = txMsgDest
  gosub WRITEVALUE
  lcd_param = LEERZ : gosub LCD_WRITECHAR
  lcd_param = DOT : gosub LCD_WRITECHAR
  lcd_param = DOT : gosub LCD_WRITECHAR
  lcd_param = DOT : gosub LCD_WRITECHAR

  txMsgM1 = MSG_REQUEST
  txMsgM3 = 0
  txMsgM4 = 0
  goto SENDMESSAGE

#HANDLEMESSAGE
  if rxMsgM1 = MSG_REQUEST then goto SENDANSWER

#DISPLAYDATA
  gosub LCD_CLS

  lcd_param = S_ : gosub LCD_WRITECHAR       ' STATION
  lcd_param = T_ : gosub LCD_WRITECHAR
  lcd_param = A_ : gosub LCD_WRITECHAR
  lcd_param = T_ : gosub LCD_WRITECHAR
  lcd_param = I_ : gosub LCD_WRITECHAR
  lcd_param = O_ : gosub LCD_WRITECHAR
  lcd_param = N_ : gosub LCD_WRITECHAR
  value = rxMsgSrc
  gosub WRITEVALUE

  lcd_param = 2: gosub LCD_GOTOLINE
  lcd_param = A_ : gosub LCD_WRITECHAR       ' SENSOR
  lcd_param = D_ : gosub LCD_WRITECHAR
  value = rxMsgM2
  gosub WRITEVALUE
  lcd_param = GLEICH : gosub LCD_WRITECHAR
  value = rxMsgM4
  gosub WRITEVALUE
return

#SENDANSWER
  txMsgDest = rxMsgSrc
  txMsgM1 = MSG_ANSWER
  txMsgM2 = rxMsgM2
  txMsgM3 = 0
  txMsgM4 = 0
  if rxMsgM2 = 1 then txMsgM4 = SENSOR1
  if rxMsgM2 = 2 then txMsgM4 = SENSOR2
  if rxMsgM2 = 3 then txMsgM4 = SENSOR3
  goto SENDMESSAGE



table keycodes
  0 23 46 68
  90 111 132 152
  173 193 214 235
tabend
