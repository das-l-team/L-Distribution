
'Dies ist ein unfertiges Programmfragment. Kompilierung erzeugt Fehermeldungen

define bp1 byteport[1]
define bp2 byteport[2]
define wp1 wordport[1]

define LCD_PORT wp1

print wordport

define b23 byte[23]
define b24 byte[24]
define s0  byte[21]
define s1  byte[22]
define s4  byte[20]

define SDA      port[9]  'Fuer M 2.x Unit und M 1.x Adapter
define SCL      port[10]


'___[ Sekundaerer I2C-BUS ]___


 '---[ HD44780 / CControl-Interface 1.1 ]--------------------------------
 

#LCD_Init
' alle ports 0:
  lcd_port = OFF
' 8-Bit-Modus aktivieren:
  s0=&b00111000:gosub LCD_WriteCMD
  ' mit 8-Bit-Command in 4-Bit-Modus umschalten:
  lcd_port=&B00000010
  pulse lcd_e
  ' ab jetzt 4-Bit-Modus:
  s0 = &b00101000:gosub LCD_WriteCMD
  s0 = &b00001100:gosub LCD_WriteCMD
  ' Display loeschen:
#LCD_cls
  s0 = &b00000010:gosub LCD_WriteCMD
  s0 = &b00000001:gosub LCD_WriteCMD
  return
' Zeilenwechsel:
#LCD_GotoLine
  if s0 = 1 then s0 = &b10000000 ' &H80
  if s0 = 2 then s0 = &b11000000 ' &HC0
  'goto LCD_WRITECMD

#LCD_WriteCmd
 lcd_rs=OFF
 goto TRANSFER_DATA

#LCD
lcd_rs=ON

#TRANSFER_DATA

 'HiNibble:
   lcd_port = (lcd_port and &b10100000) or (s0 shr 4)
   pulse lcd_e

 'Lo-Nibble:
   lcd_port = (lcd_port and &b10100000) or (s0 and &b00001111)
   pulse lcd_e
   s0=0 'Wichtig, da s0 nach RÅckkehr zu RS_232 erneut ausgewertet wird

RETURN
'---[ ENDE LCD ]------------------------------------------------------------


'---[ I2C ROUTINEN START ]--------------------------------------------------

#I2C_Start
SDA=OFF
SCL=OFF
return

#I2C_Stop
SDA=OFF
SCL=ON
SDA=ON
return



#I2C_Write
for s4=1 to 8
    SDA=OFF
    if (s0 and 128) =128 then SDA=ON
    pulse SCL
    s0=s0 shl 1 '1 Bit nach links schieben
next
pulse SCL
return

#I2C_Read
s0=0
deact SDA
for s4=1 to 8
    s0=s0 shl 1
    SCL=ON
    if SDA then s0=s0+1
    SCL=OFF
next
return

'#I2C_Write '|_
'for s1=128 to 1 step -s1/2
'    if (s1 AND s0)=s1 then SDA=ON else SDA=OFF
'    pulse SCL
'next
'pulse SCL
'return


'#I2C_Read '|_
' s0=0
' DEACT SDA
' for s1=128 to 1 step -s1/2
'     SCL=ON
'     if SDA then s0=s0+s1
'     SCL=OFF
' next
'return


























#Ack
SDA=0
pulse SCL
return

#NoAck
SDA=1
pulse SCL
return
