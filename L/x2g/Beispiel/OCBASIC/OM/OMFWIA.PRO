' ---------------------------------------------------------------------------
' --- Aufruf von Firmwareroutinen auf der Open-Micro/Mini -------------------
' --- das SWI wirkt bei Firmwareaufrufen gleichzeitig wie ein RTS -----------
' ---------------------------------------------------------------------------

' Um unabhaengig vom Speicherlayout zu sein, werden Firmwareroutinen ueber
' Funktionsnummern aufgerufen.

PROC FwPush INLASM     ' Wert auf dem Rechenstack speichern
! clrx                 ' Uebergabe vom Byte im Akkumulator (A)
! swi
END PROC

PROC FwPop INLASM      ' Wert vom Rechenstack lesen und entfernen
! ldx #1               ' Rueckgabe vom Byte im Akkumulator (A)
! swi
END PROC

PROC FwPutSCI INLASM   ' ein Byte ueber die serielle Schnittstelle senden
! ldx #2               ' Uebergabe vom Byte im Akkumulator (A)
! swi                  ' (deaktiviert das Interruptsystem, bei Bedarf also CLI)
END PROC

PROC FwGetSCI INLASM   ' ein Byte ueber die serielle Schnittstelle empfangen
! ldx #3               ' Rueckgabe vom Byte im Akkumulator (A)
! swi                  ' (deaktiviert das Interruptsystem, bei Bedarf also CLI)
END PROC

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

PROC FwIVarAddr INLASM ' Adresse einer beliebigen internen Variable ermitteln;
! ldx #6               ' Uebergabe der Variablennummer auf dem Hardwarestack
! swi                  ' (ist anschliessend mit z.B. AIS #1 zu entfernen),
END PROC               ' das H-Register muss geloescht sein
                       ' Rueckgabe im X-Register, Akkumulator und den Flags
                       ' (Z=1: Adresse in X, Bitmaske in A)
                       ' (Z=0: Adresse in X, Variablennummer in A)

' ---------------------------------------------------------------------------
