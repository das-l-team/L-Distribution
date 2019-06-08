'
'                      Hilfsprogramme zur Inline-Assemblierung
'  lassen sich sicherlich unter Verwendung des OM-Betriebssystems und entsprechender Einsprünge
'                        beträchtlich schrumpfen...
 '-------------------------------------------------------------------------------------------------
 ' Befehle:
 ' FwPutHex und FwPrtHex    'Ausgabe des AkkuWertes als HexZahl - mit und ohne CarriageReturn
 ' FwPutDez und FwPrtDez    'Ausgabe des AkkuWertes als DezimalZahl - mit und ohne CarriageReturn
 ' FwPutBin und FwPrtBin    'Ausgabe des AkkuWertes als BinaerZahl - mit und ohne CarriageReturn
 ' FwPrtPcA                 'Ausgabe des Programmcounters as Hex- und des Akkus als Binär&Dezimalzahl
 ' FwPrtStA                 'Ausgabe der obersten StackWerte (AnzahlÜbergabe mittels Akku)
 ' FwPrtHXC                 'Ausgabe der Register: H, X und CCR
 '---------------------------------------------------------------------------------------------------

'--------------------------------------------------------------------------------------------------
' FwPrtStA: Ausgabe der gestapelten maximal 50 (kann natürlich vergrößert werden) letzten Bytes...
'             Ausgabeanzahl wird im Akku übergeben
'--------------------------------------------------------------------------------------------------
  #FwPrtStA                         ' Stapelanzeige als "$$.$$&Bxxxxxxxx XXX"
   ! PSHA                           ' AusgabeAnzahl sichern
   ! LDX $1,SP                      ' Anzahl in [X] speichern
  ! PULH                            ' Anzahl in [H] speichern
  ! AIS #-50                        ' SP must always point to the next empty stack location
  ! LDA #0                          ' für Zähler-Ausgabe
  #Loop1_FwPrtStA                   '
  ! AIS #+1                         ' Stapel nach unten zählen (AIS #+1=>PUL ohne entfernen)
  ! INCA                            ' A=A+1
   ! PSHA                           ' AusgabeZähler retten
    ! PSHX                          ' X für DBNZX retten
    ! JSR FwPutHex                  ' StackAusgabezähler als HEX-Wert, Top=1
    ! LDA "."
    ! JSR FwPutSci                  ' "."
    ! LDA $37,SP                    '($37=#54) => 50 + 2(für PSH) + 2(für JSR) +1 (für AIS+1)
    ! JSR FwPutHex                  ' StapelWert Anzeigen
    ! JSR FWPutBin                  '
    ! JSR FWPrtDez                  '
   ! PULX
  ! PULA
  ! DBNZX Loop1_FwPrtStA            ' Loop bis X=0
   ! PSHH                           '   Anzahl nach
  ! PulX                            '   [X] schieben
  #Loop2_FwPrtStA                   ' Stapelpointer wieder restaurieren
  ! AIS #-1                         ' Stapel nach oben zählen (AIS #-1=>PSH ohne stapeln)
  ! DBNZX Loop2_FwPrtStA            ' Loop bis X=0
  ! AIS #50                         ' Restore SP
  ! RTS

'--------------------------------------------------------------------------------------------------
' FwPrtHXC: Ausgabe des Inhalts des H Registers (Hex,Binaer,Dezimal)
'           Ausgabe des Inhalts des X Registers (Hex,Binaer,Dezimal)
'           Ausgabe des Inhalts des CCR Registers (Binaer)
'--------------------------------------------------------------------------------------------------
  #FwPrtHXC
   ! PSHA                          ' rette Akku
    ! PSHX
     ! PSHH
     ! TPA                         ' transfer CCR to A
      ! PSHA                       ' rette CCR bevor es geändert wird
      ! LDA #"H"
      ! JSR FwPutSci
      ! LDA #":"
      ! JSR FwPutSci
      ! LDA $2,SP
      ! JSR FwPutHex                  ' H ausgeben
      ! JSR FwPutBin                  ' H ausgeben
      ! JSR FwPrtDez                  ' H ausgeben
      ! LDA #"X"
      ! JSR FwPutSci
      ! LDA #":"
      ! JSR FwPutSci
      ! LDA $3,SP
      ! JSR FwPutHex                  ' X ausgeben
      ! JSR FwPutBin                  ' X ausgeben
      ! JSR FwPrtDez                  ' X ausgeben
      ! LDA #"C"
      ! JSR FwPutSci
      ! LDA #":"
      ! JSR FwPutSci
     ! PULA                          ' hole gepushtes CCR nach A
     ! JSR FwPrtBin                  ' CCR ausgeben
    ! PULH
   ! PULX
  ! PULA
  ! RTS


'--------------------------------------------------------------------------------------------------
' FwPrtAdA: Ausgabe des ProgrammCounters as Hex- und des Akkus als Binär&Dezimalzahl
'--------------------------------------------------------------------------------------------------
  #FwPrtPcA
   ! PSHH
   ! PSHX
   ! PSHA                 ' rette Akku
   ! LDA $4,SP            ' gehe zum richtigen SP
   ! JSR FwPutHex         ' und gib aus als HEX-Zahl
   ! LDA $5,SP            ' gehe zum richtigen SP
   ! JSR FwPutHex
   ! LDA #":"
   ! JSR FWPutSCI        ' und gib aus als HEX-Zahl
  ! PULA
   ! PSHA
   ! JSR FWPutBin        ' gib aus als Binärzahl
  ! PULA
  ! JSR FWPrtDez         ' gib aus als Dezimalzahl
  ! PULX
  ! PULH
  ! RTS

'----------------------------------------------------------------------------------------------------
' FwPrtHex/FwPutHex:            HexAusgabe eines Akku-Wertes
'----------------------------------------------------------------------------------------------------
 #FwPrtHex         'Wert im Akku als Hexadezmalzahl im Terminalprogramm ausgeben mit LF&CR
 ! PSHA            ' A retten
 ! JSR FwPutHex    ' Hexzahl ausgeben
 ! JSR LF_CR       ' LF & CR
 ! PULA            ' A retten
 ! RTS
#FwPutHex          'auszugebende Hex-Zahl in A
! PSHA                 ' Rette A
 ! PSHH               ' Rette H
  ! PSHX               ' Rette X
   ! LDX #16
   ! CLRH              ' Lösche H, da nur das byte in A
   ! DIV                ' dividiert werden soll mit dem Divisor in X
    ! PSHH              ' H-Ergebnis retten
    ! JSR HEX_Ausgab
   ! PULA               ' Bringe H in den Akku
   ! JSR HEX_Ausgab
  ! PULX               ' Bringe H:X wieder
 ! PULH               ' in alten Zustand
! PULA
! RTS

   #HEX_Ausgab           ' Wert in Akku, gibt entsprechende HEX-Zahl aus
    ! ADD #48            ' Akku + "0" => ASCII "0-9"
    ! CMP #57             ' wenn <= 9   dann Set Carry and Z
    ! BLS  AusgabHex     ' if (Accumulator) <= (Memory), then branch
    ! ADD #7             ' 48+7=55=> 10+55 = ASCII-A
    #AusgabHex
     ! PSHX               ' Rette X
     ! JSR FWPutSCI       ' gibt "A.. -  .. F" aus
    ! PULX                ' Restauriere X
     #RTS_HEX_Ausgab
    ! RTS

' ----------------------------------------------------------------------------------------------------
'  FwPrtDez/FwPutDez:    Dezimalausgabe des Akkus  als Print und Put-Wert
'-----------------------------------------------------------------------------------------------------
 #FwPrtDez          ' mit Line Feed & Carriage Return
  ! PSHA            ' A retten
  ! JSR FwPutDez    ' Dezimalzahl ausgeben
  ! JSR LF_CR       ' LF & CR
 ! PULA             ' A retten
 ! RTS
 #FwPutDez          'Wert im Akku als Dezimalzahl im Terminalprogramm ausgeben
  ! PSHH                 ' Rette H
   ! PSHX                ' Rette X
    ! PSHA               ' Rette Akku
    ! CMP #100           ' Set C if M > than the unsigned value of the accu; cleared otherwise
    ! BCC  A100_255      ' if (Accumulator) > 99 GOTO
    ! CMP #10
    ! BCC  A10_99        ' if (Accumulator) > 9 GOTO
    ! BRA A0_9
    #A100_255
    ! LDX #100
    ! JSR Dez_CLRH_DIV_PUT
    #A10_99
    ! LDX #10
    ! JSR Dez_CLRH_DIV_PUT
    #A0_9
    ! JSR Ziff_Ausgab
   ! PULA
  ! PULX
 !  PULH
 ! RTS               ' Rette Akku

 #Dez_CLRH_DIV_PUT  ' DIV: Divides a 16-bit dividend (H:A) by an 8-bit divisor contained in X
    ! CLRH          ' Clean the conconated H
    ! DIV           ' The quotient is placed in A, and the remainder is placed in H. The divisor
  #Ziff_Ausgab
    ! ADD #48       ' The quotient,  reamainder and divisor are placed in A, H and X.
     ! PSHH             'rette Rest
     ! JSR FWPUTSCI     ' Gib Akku aus
    ! PULA              ' übergib Rest in den Akku
    ! RTS
'-----------------------------------------------------------------------------------------------------
' FwPutBin/FwPrtBin - Binaerausgabe eines Akku-Wertes
'-----------------------------------------------------------------------------------------------------
  #FwPrtBin          ' Wert im Akku als Binaerzahl im Terminalprogramm ausgeben mit LF&CR
   ! PSHA            ' A retten
   ! JSR FwPutBin    ' Binärzahl ausgeben
   ! JSR LF_CR       ' LF & CR
  ! PULA             ' A retten
  ! RTS
  #FwPutBin          'Wert im Akku als Binaerzahl im Terminalprogramm ausgeben ohne LF&CR
   ! PSHX                      ' X retten
    ! PSHA                     ' Akku retten, für terminale Restauration
     ! PSHA                    ' Akku retten
     ! LDA #"&"
     ! JSR FwPutSci            ' OMAC-Def-Datei
     ! LDA #"B"                ' "&B" ausgeben
     ! JSR FwPutSci            '
    ! PULA                     ' Akku restaurieren
    ! LDX #8                   ' Zähler
   #FwPUTBin_Loop
     ! PSHX                    ' Rette X vor FwPutSci
     ! ROLA                    ' links Shift, setzt Cary, restauriert A
      ! PSHA                   ' Rette Akku
      ! LDA #0                 ' Setze Akku auf 0 ohne Carry-Änderung
      ! ADC #48                ' Addiere Carry dazu
      ! JSR FwPutSci           ' gibt Ziffer 0 o. 1 aus
     ! PULA                    ' restauriere Akku
    ! PULX                     ' restauriere X
    ! DBNZX FwPUTBin_Loop
    ! LDA #32
    ! JSR FWPutSCI             ' Leerzeichenausgabe
   ! PULA
  ! PULX                       'Bringe X wieder in alten Zustand
  ! RTS
'---------------------------------------------------------------------
'     Zeilenvorschub & Wagenrücklauf (Line Feed & Carriage Return)
'----------------------------------------------------------------------
    #LF_CR
    ! PSHA
    ! LDA #10                  ' Line Feed
    ! JSR FwPutSci             '
    ! LDA #13                  ' Cariage Return
    ! JSR FwPutSci             '
   ! PULA
   ! RTS
