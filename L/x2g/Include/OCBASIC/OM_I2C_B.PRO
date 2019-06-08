
' ---------------------------------------------------------------------------
' --- Routinen fuer I2C-Bus auf der Open-Micro/Mini/Midi/Macro @ 3.2 MHz ----
' --- fuer einen Master und beliebige 100-kHz-Slaves - V2.0b ----------------
' --- von Dietmar Harlos am 20. Oktober 2006 --------------------------------
' --- am 22. Juli 2010: fuer BYTEPORT[2] ------------------------------------
' ---------------------------------------------------------------------------

' --- Nutzung der Routinen --------------------------------------------------

' i2c_init              'I2C-Bus initialisieren
' i2c_start             'Start-Signal ueber den I2C-Bus senden
' ack=i2c_write(data)   'das Byte "data" ueber den Bus senden und
'                       'Acknowledge vom Slave zurueckliefern
' data=i2c_read(ack)    'ein Byte vom Slave holen und Acknowledge senden
' i2c_stop              'Stop-Signal ueber den I2C-Bus senden

' --- Portdefinitionen ------------------------------------------------------

DEFINE SCL bPTB4        'PTB4  = PORT[13]
DEFINE SDA bPTB5        'PTB5  = PORT[14]
DEFINE I2CPORT PTB      'PORTB = BYTEPORT[2]
DEFINE I2CDDR DDRB      'DDRB  = BYTEPORT[2]

' --- I2C-Bus-Initialisierung -----------------------------------------------

' After an interruption in protocol, power loss or system reset, any
' 2-wire part can be reset by following these steps:
' (a) Clock up to 9 cycles
' (b) look for SDA high in each cycle while SCL is high and then
' (c) create a start condition as SDA is high.

' SDA wird vom Pull-Up-Widerstand auf high (5 Volt) gezogen, sobald es
' deaktiviert wird. Falls SDA nach Deaktivierung aber immer noch low ist,
' dann wird es vom Slave auf Masse gezogen. Deshalb weitertakten, bis der
' Slave mit seiner Uebertragung fertig ist oder ein Highbit auf der SDA-
' Leitung uebertraegt. Denn nur wenn SDA high, also deaktiviert ist, laesst
' sich ein Start-Signal ueber den I2C-Bus uebertragen.

PROCEDURE i2c_init INLASM

! bclr SDA,I2CDDR               'DEACT SDA
! ldx #9
#i2c_init_1
! bsr i2c_delay
! bset SCL,I2CPORT              'SCL=on
! bset SCL,I2CDDR
! bsr i2c_delay
! brset SDA,I2CPORT,i2c_delay   'if SDA then ...
! bclr SCL,I2CPORT              'SCL=off
! bset SCL,I2CDDR
! dbnzx i2c_init_1

#i2c_delay                      'Verzoegerung fuer 4,7 Mikrosekunden
! nsa
! nsa
! nsa
! nsa
! rts

END PROCEDURE

' --- I2C-Bus-Startbedingung ------------------------------------------------

PROCEDURE i2c_start INLASM

! bset SCL,I2CPORT              'SCL=on
! bset SCL,I2CDDR
! bsr i2c_delay
! bclr SDA,I2CPORT              'SDA=off
! bset SDA,I2CDDR
! bsr i2c_delay
! bclr SCL,I2CPORT              'SCL=off
! bra i2c_delay

END PROCEDURE

' --- 100 kHz I2C-Bus-Schreibroutine ----------------------------------------

FUNCTION i2c_write(data) INLASM

! jsr FwPop          'Eintrag vom Rechenstack in den Akkumulator holen
                     'das Pop ist noetig, damit Stack aufgeraeumt bleibt
! ldx #8
#i2c_write_1
! lsla               '1 ein Bit in das Carryflag schieben
! bcc i2c_write_2    '3
! bclr SDA,I2CDDR    '4 SDA auf Eingang & high
! bra i2c_write_3    '3
#i2c_write_2
! bclr SDA,I2CPORT   '4
! bset SDA,I2CDDR    '4 SDA auf Ausgang & low
#i2c_write_3
! bset SCL,I2CPORT   '4
! nsa                '3 \
! nsa                '3  \
! nsa                '3   >Thigh = 16 TZ = 5 Mikrosekunden
! nsa                '3  /
! bclr SCL,I2CPORT   '4 /
! dbnzx i2c_write_1  '3 Tlow = 18, 19 oder 15 TZ

! bclr SDA,I2CDDR    '4 SDA auf Eingang & high
! clra               '1
! nsa                '3
! bset SCL,I2CPORT   '4
! nsa                '3
! brset SDA,I2CPORT,i2c_write_4 '5 ACK lesen
! deca               '1
#i2c_write_4
! bclr SCL,I2CPORT   '4

! jmp FwPush         'ACK auf Stack

END FUNCTION

' --- 100 kHz I2C-Bus-Leseroutine -------------------------------------------

FUNCTION i2c_read(acknowledge) INLASM

! jsr FwPop          'ACK vom Rechenstack in den Akkumulator holen
                     'das Pop ist noetig, damit Stack aufgeraeumt bleibt
! ldx #1
#i2c_read_1
! nsa                          '3
! bset SCL,I2CPORT             '4
! nsa                          '3 \
! brclr SDA,I2CPORT,i2c_read_2 '5  \ 
#i2c_read_2                    '    > Thigh = 13 TZ 
! rolx                         '1  /  (gleich 4 Mikrosekunden)
! bclr SCL,I2CPORT             '4 /
! nsa                          '3
! nsa                          '3
! bcc i2c_read_1               '3 -- Tlow ist 16 TZ (5 Mikrosek.)

! tsta               'ACK
! beq i2c_read_noack
! bclr SDA,I2CPORT   'SDA=low
! bset SDA,I2CDDR
#i2c_read_noack
! bset SCL,I2CPORT   '4
! nsa                '3 \
! nsa                '3  \ 
! nsa                '3   > Thigh = 16 TZ
! nsa                '3  /
! bclr SCL,I2CPORT   '4 /
! bclr SDA,I2CDDR    'SDA=Eingang 'Thd;dat = 3 TZ = 1 Mikrosekunde

! txa
! jmp FwPush

END FUNCTION

' --- I2C-Bus-Deaktivierung -------------------------------------------------

PROCEDURE i2c_stop INLASM

! bclr SDA,I2CPORT              'SDA=off
! bset SDA,I2CDDR
! bsr i2c_delay
! bclr SCL,I2CDDR               'DEACT SCL
! bsr i2c_delay
! bclr SDA,I2CDDR               'DEACT SDA
! bra i2c_delay

END PROCEDURE

' ---------------------------------------------------------------------------
