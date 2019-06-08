
' ---------------------------------------------------------------------------
' LCD ueber I2C-Bus mittels Portexpander PCF8574 ansteuern
' In OCBASIC fuer Open-Micro, -Mini, -Midi und -Macro von Dietmar Harlos.
' ---------------------------------------------------------------------------

' Das LCD ist mit dem PCF auf die gleiche Weise verbunden wie auf dem
' I2C-LCD von Conrad Electronic (Bestellnr. 198330). Eine kleine Platine
' mit 16-pol. Wannenstecker fuer das LCD, Sockel fuer den PCF und Ver-
' bindung an PTA4 (PORT[5], SCL) und PTA5 (PORT[6], SDA) der Open-Micro
' ist schnell auf einem Stueck Lochrasterplatine aufgebaut.

' ACHTUNG! DAS I2C-LCD VON CCTOOLS BENUTZT EINE UNUEBLICHE BELEGUNG
' UND DARF NUR MIT DEN SOFTWAREMODULEN VON CCTOOLS VERWENDET WERDEN!

' PCF8574 | LCD
' ----------------------------------------------------------------------
' P0  4   | DB4 11 \
' P1  5   | DB5 12  \ die oberen 4 Bits
' P2  6   | DB6 13  / vom 8-Bit-Datenbus
' P3  7   | DB7 14 /
' P4  9   | R/W  5 -- Lesen (1) oder Schreiben (0)
' P5 10   | RS   4 -- Daten (1) oder Instruktion (0) uebermitteln
' P6 11   | EN   6 -- Daten bei fallender Flanke (1 nach 0) uebernehmen
' P7 12   | EN2    -- reserviert fuer 2. Enable-Leitung einiger LCDs

' ---------------------------------------------------------------------------

PROCEDURE lcd_init
  'Vorgeschriebene Verzoegerung fuer das LCD
  PAUSE 2

  'I2C-Bus initialisieren
  i2c_init

  'PCF ueber I2C-Bus aktivieren
  i2c_start
  IF i2c_write(&h40)=0 THEN              'I2C-Adresse vom PCF8574
    PRINT "NACK" : END
  END IF

  '8-Bit-Modus aktivieren
  lcd_putcmd &h38

  'mit 8-Bit-Command in 4-Bit-Modus umschalten
  i2c_write &b01000010                   'EN auf high
  i2c_write &b00000010                   'EN auf low

  'ab jetzt 4-Bit-Modus
  lcd_putcmd &h28
  lcd_putcmd &h0c

  'LCD loeschen
  lcd_cls

  RETURN
END PROCEDURE

' Im folgenden wird die Assemblerroutine lcd_putcmd per SYS- statt mit dem
' GOSUB-Befehl aufgerufen. Das spart einen Stackeintrag auf dem Aufruf-,
' bzw. GOSUB-Stack und ist etwas schneller.

PROCEDURE lcd_cls
  SYS lcd_putcmd &h02                    'RETURN HOME
  PAUSE 2                                ' (mind. 1.64 ms lt. Datenblatt)
  SYS lcd_putcmd &h01                    'DISPLAY CLEAR
  PAUSE 2                                ' (mind. 1.64 ms lt. Datenblatt)
  RETURN                                 ' (mind. 20 ms lt. Internet !)
END PROCEDURE

PROCEDURE lcd_putcmd(data) INLASM
! jsr FwPop
! pusha
! nsa
! bsr lcd_putcmd_up
! popa
#lcd_putcmd_up
! and #&h0f
! pusha
! ora #&b01000000
! jsr FwPush
! jsr i2c_write
! popa
! jsr FwPush
! jmp i2c_write
END PROCEDURE

PROCEDURE lcd_put(data) INLASM
! jsr FwPop
! pusha
! nsa
! bsr lcd_put_up
! popa
#lcd_put_up
! and #&h0f
! pusha
! ora #&b01100000
! jsr FwPush
! jsr i2c_write
! popa
! ora #&b00100000
! jsr FwPush
! jmp i2c_write
END PROCEDURE

' Die folgende Routine muss folgendermassen aufgerufen werden:
'  SYS lcd_string : INLINE "Text auf dem LCD",0

PROCEDURE lcd_string INLASM
#lcd_string_loop
! ldhx PCADR
! lda ,x
! aix #1
! sthx PCADR
! tsta
! beq lcd_string_exitloop
! jsr FwPush
! ldx #128                               'Ohne diese Verzoegerung wird das
#lcd_string_vrz                          ' LCD offenbar zu schnell beschrieben
! dbnzx lcd_string_vrz                   ' (laut Datenblatt 46 µs benoetigt)
! jsr lcd_put
! bra lcd_string_loop
#lcd_string_exitloop
! rts
END PROCEDURE

