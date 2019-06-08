' ---------------------------------------------------------------------------
' --- Aufruf von Firmwareroutinen auf der Open-Micro/Mini/Midi/Macro/Maxi ---
' --- das SWI wirkt bei Firmwareaufrufen gleichzeitig wie ein RTS -----------
' ---------------------------------------------------------------------------

' Um unabhaengig vom Speicherlayout zu sein, werden Firmwareroutinen ueber
' Funktionsnummern aufgerufen.

PROC FwPush INLASM     ' Byte auf dem Rechenstack speichern
! clrx                 ' Uebergabe vom Byte im Akkumulator (A)
! swi                  ' ab Open-Macro: Byte wird auf Word, dessen
END PROC               '  Highbyte immer Null ist, erweitert

PROC FwPop INLASM      ' Wert vom Rechenstack lesen und entfernen
! ldx #1               ' Rueckgabe vom Byte im Akkumulator (A)
! swi                  ' ab Open-Macro: Rueckgabe eines Words auf OSTEMP:A
END PROC

PROC FwPutSCI INLASM   ' ein Byte ueber die serielle Schnittstelle senden
! ldx #2               ' Uebergabe vom Byte im Akkumulator (A)
! swi                  ' (deaktiviert das Interruptsystem, bei Bedarf also CLI)
END PROC               ' auf Open-Macro: aktive Schnittstelle wird verwendet,
                       '  ausserdem kein CLI notwendig

PROC FwGetSCI INLASM   ' ein Byte ueber die serielle Schnittstelle empfangen
! ldx #3               ' Rueckgabe vom Byte im Akkumulator (A)
! swi                  ' (deaktiviert das Interruptsystem, bei Bedarf also CLI)
END PROC               ' auf Open-Macro: aktive Schnittstelle wird verwendet,
                       '  ausserdem kein CLI notwendig

PROC FwIntrprt INLASM  ' Tokenbefehl (Token in A) ausfuehren; evt. Parameter
! ldx #4               ' holt der Befehl selbststaendig von der PC-Adresse;
! swi                  ' die PCADR kann mit untenstehender IVarAddr-Funktion
END PROC               ' mit anschliessendem LSRX : LSLX ermittelt werden

PROC FwW2Flash INLASM  ' ein Byte ins User-Flash schreiben (OS ist geschuetzt)
! ldx #5               ' Uebergabe vom Highbyte der Adresse im H-Register,
! swi                  ' Uebergabe vom Lowbyte auf dem Hardwarestack, muss aber
END PROC               ' wieder entfernt werden ("PUSHX : BSR W2Flash : POPX")
                       ' Uebergabe vom Byte im Akkumulator (A)
                       ' Rueckgabe vom geschriebenen Byte im Akkumulator,
                       ' oder komplementaeres Byte, wenn ausserhalb User-Flash
                       ' Routine verwendet einen Teil des USER-RAMs
                       ' auf Open-Maxi muss ggf. FCDIV initialisiert werden

PROC FwIVarAddr INLASM ' Adresse einer beliebigen internen Variable ermitteln;
! ldx #6               ' Uebergabe der Variablennummer auf dem Hardwarestack
! swi                  ' (ist anschliessend mit z.B. AIS #1 zu entfernen),
END PROC               ' das H-Register muss geloescht sein
                       ' Rueckgabe im X-Register, Akkumulator und den Flags
                       ' (Z=1: Adresse in X, Bitmaske in A)
                       ' (Z=0: Adresse in X, Variablennummer in A)

PROC FwGetByte INLASM  ' nur Open-Midi, Open-Macro und Open-Maxi:
! ldx #7               ' Das naechste Byte von der Adresse holen, auf die
! swi                  '  PCADR zeigt, und PCADR inkrementieren
END PROC               ' Rueckgabe im X-Register

PROC FwPushW INLASM    ' nur Open-Macro und Open-Maxi:
! ldx #8               ' das Word OSTEMP:A auf dem Rechenstack speichern
! swi
END PROC

PROC FwRxd INLASM      ' nur Open-Macro und Open-Maxi:
! ldx #9               ' feststellen, ob ein Byte von der seriellen Schnitt-
! swi                  '  stelle geholt werden kann (Z=1: Buffer ist leer)
END PROC               ' verwendet wird die aktive Schnittstelle (ESCI/an PTA0)

PROC FwI2Cinit INLASM  ' nur Open-Maxi:
! ldx #10              ' I2C-Bus initialisieren
! swi                  ' (notwendig mindestens bei I2C-EEPROMs)
END PROC               ' Geschwindigkeit bei i2cdelay=20: 100 kHz
                       ' Geschwindigkeit: circa 20E6/(8*i2cdelay+40)

PROC FwI2Cstart INLASM ' nur Open-Maxi:
! ldx #11              ' I2C-Bus-Startbedingung
! swi                  ' Geschwindigkeit bei i2cdelay=20: 100 kHz
END PROC

PROC FwI2Cwrite INLASM ' nur Open-Maxi:
! ldx #12              ' I2C-Bus-Schreibroutine
! swi                  ' Uebergabe: A=Datenbyte
END PROC               ' Geschwindigkeit bei i2cdelay=20: 100 kHz
                       ' Rueckgabe: A=0/$ff für NoAck/Ack

PROC FwI2Cread INLASM  ' nur Open-Maxi:
! ldx #13              ' I2C-Bus-Leseroutine
! swi                  ' Uebergabe: A=0/$ff für NoAck/Ack
END PROC               ' Geschwindigkeit bei i2cdelay=20: 100 kHz
                       ' Rueckgabe: A=Datenbyte

PROC FwI2Cstop INLASM  ' nur Open-Maxi:
! ldx #14              ' I2C-Bus-Deaktivierung
! swi                  ' Geschwindigkeit bei i2cdelay=20: 100 kHz
END PROC

' ---------------------------------------------------------------------------
