
' #######################################################################
' ###                                                                 ###
' ### FLOAT05COD (Floating Point routines) von Motorola/Freescale     ###
' ###                                                                 ###
' ### Edited for MOT/BBS' 07-FEB-92 (Ed2)                             ###
' ###                                                                 ###
' ### Konvertiert nach OCBASIC von Dietmar Harlos am 14. Juni 2012    ###
' ### letztes Update (Fehlerkorrektur) am 31. Januar 2013             ###
' ###                                                                 ###
' ### Revision History:                                               ###
' ### Rev 0  - 25-Sep-90 Module Creation Terry Echard                 ###
' ### Rev 1  - 20-Jul-91 rewritten for Bytecraft compiler. [DCHJR]    ###
' ### Rev 2  - 24-Jul-91 added 6805 'C' callable functions. [DCHJR]   ###
' ### Rev 3  - 07-Dec-12 Fehlerkorrektur bei fp_add_ [DH]             ###
' ### Rev 4  - 11-Dec-12 Fehlerkorrektur bei fp_divide [DH]           ###
' ### Rev 5  - 31-Jan-13 rewritten fp_divide 132 Bytes shorter [GeKue]###
' ###                    usr_ram_18 bis 21   not used                 ###
' ### Rev 6  - 08-Feb-13 rewritten fp_multipl 60 Bytes shorter [GeKue]###
' #######################################################################

' #######################################################################
' ### This software is provided as "FREEWARE" in "AS IS" condition.   ###
' #######################################################################

' void fp_multiply(int *mcand, *mplier;);    /* floating point multiply */
' void fp_divide(int *divisor, *divend;);    /* floating point divide */
' void fp_subtract(int *subtor, *subhend;);  /* floating point subtraction */
' void fp_add_(int *augend, *addend;);       /* floating point addition */
' void int_2_fp(registera ptr2int;);         /* 16 bit integer to floating point */
' void fp_2_int(registera ptr2fp;);          /* floating point to 16 bit integer */
' void fp_rmove(unsigned int *from, *to;);   /* FP register block move */
' void load8a(registera ptr2int;);           /* load 32 bit FP accum /w 8 bit # */
' void load16a(registera ptr2int;);          /* load 32 bit FP accum /w 16 bit # */
' void mpy161(registera ptr2int;);           /* multiply 16X16= 32 bit # */

DIM accum3     BYTE ' accumulator high order byte
DIM accum2     BYTE
DIM accum1     BYTE
DIM accum0     BYTE ' accumulator low order byte
DIM ctr        BYTE ' iteration counter
DIM temp1      BYTE ' miscelleneous temps
DIM temp0      BYTE
DIM sign1      BYTE
DIM sign2      BYTE
DIM bit_cnt    BYTE
DIM byte_cnt   BYTE
DIM usr_ram_1  BYTE ' floating point ram scratch pad
DIM usr_ram_2  BYTE ' (kann auch vom Anwender benutzt werden)
DIM usr_ram_3  BYTE
DIM usr_ram_4  BYTE
DIM usr_ram_5  BYTE
DIM usr_ram_6  BYTE
DIM usr_ram_7  BYTE
DIM usr_ram_8  BYTE
DIM usr_ram_9  BYTE
DIM usr_ram_10 BYTE
DIM usr_ram_11 BYTE
DIM usr_ram_12 BYTE
DIM usr_ram_13 BYTE
DIM usr_ram_14 BYTE
DIM usr_ram_15 BYTE
DIM usr_ram_16 BYTE
DIM usr_ram_17 BYTE
'DIM usr_ram_18 BYTE       ' \
'DIM usr_ram_19 BYTE       '  >  neue Divisionsroutine
'DIM usr_ram_20 BYTE       '  >    braucht die nicht
'DIM usr_ram_21 BYTE       ' /

' ############################################################################
' ### LOAD8A, LOAD8 Function.  Load 32 bit FP accum with indirect constant ###
' ###                                                                      ###
' ### Requires the following:                                              ###
' ###   PARM1 -> address of 8 bit constant to be loaded into FP accum.     ###
' ###   REG X -> address of 8 bit constant to be loaded into FP accum.     ###
' ############################################################################

'#load8a:                   ' GeKue ==> auskommentiert, da unnütz
'! tax                      ' xfer 'c' ptr to index register

#load8
! clr accum3
! clr accum2
! clr accum1
! lda ,x
! sta accum0
! rts

' ############################################################################
' ### LOAD16A, LOAD16 Function.  Load 32 bit FP accum /w indirect constant ###
' ###                                                                      ###
' ### Requires the following:                                              ###
' ###   PARM1 -> address of 16 bit constant to be loaded into FP accum.    ###
' ###   REG X -> address of 16 bit constant to be loaded into FP accum.    ###
' ############################################################################

'#load16a:                  ' GeKue ==> auskommentiert, da unnütz
'! tax                      ' xfer 'c' ptr to index register

#load16
! clr accum3
! clr accum2
! lda ,x
! sta accum1
! lda 1,x
! sta accum0
! rts




' #####################################################################
' ### IEEE_2_BIN Function.  Convert IEEE format FP to binary FP.    ###
' #####################################################################

DEFINE fp1_addr usr_ram_1
DEFINE fp2_addr usr_ram_2
DEFINE fp_b2i0  usr_ram_3
DEFINE fp_b2i1  usr_ram_4
DEFINE fp_b2i2  usr_ram_5
DEFINE fp_b2i3  usr_ram_6
DEFINE fp_b2i4  usr_ram_7
DEFINE fp1_i2b0 usr_ram_8
DEFINE fp1_i2b1 usr_ram_9
DEFINE fp1_i2b2 usr_ram_10
DEFINE fp1_i2b3 usr_ram_11
DEFINE fp2_i2b0 usr_ram_12
DEFINE fp2_i2b1 usr_ram_13
DEFINE fp2_i2b2 usr_ram_14
DEFINE fp2_i2b3 usr_ram_15

#ieee_2_bin:
! sta fp1_addr             ' save the addresses of the fp numbers
! stx fp2_addr
! ldx fp1_addr             ' buffer the floating point numbers
! lda ,x
! sta fp1_i2b0
! lda 1,x
! sta fp1_i2b1
! lda 2,x
! sta fp1_i2b2
! lda 3,x
! sta fp1_i2b3

! ldx fp2_addr             ' buffer the floating point numbers
! lda ,x
! sta fp2_i2b0
! lda 1,x
! sta fp2_i2b1
! lda 2,x
! sta fp2_i2b2
! lda 3,x
! sta fp2_i2b3

! lda fp1_i2b0             ' save the sign for fp1
! and #$80
! sta sign1

! lda fp2_i2b0             ' save the sign for fp2
! and #$80
! sta sign2

! lsl fp1_i2b1
! rol fp1_i2b0             ' restore the full exponent
! lsr fp1_i2b1
! bset 7,fp1_i2b1          ' set the implied bit

! lsl fp2_i2b1
! rol fp2_i2b0             ' restore the full exponent
! lsr fp2_i2b1
! bset 7,fp2_i2b1          ' set the implied bit

! clr fp_b2i0              ' clear the resultant buffers  (usr_ram_3 bis 7
! clr fp_b2i1
! clr fp_b2i2
! clr fp_b2i3
! clr fp_b2i4

! rts

' #####################################################################
' ### BIN_2_IEEE Function.  Convert binary FP to IEEE format FP.    ###
' #####################################################################

#bin_2_ieee:
! lsl fp_b2i1              ' remove implied bit
! lsr fp_b2i0
! ror fp_b2i1
! lda fp_b2i0
! ora sign1                ' return the sign
! sta fp_b2i0
! rts

' #####################################################################
' ### FP_MULTIPLY Function. IEEE 32 Bit floating point Multiply.    ###
' ###                                                               ###
' ### Requires the following:                                       ###
' ###                                                               ###
' ###    ptr1 (X) = 8 bit ptr to multiplicand register.             ###
' ###    ptr2 (A) = 8 bit ptr to multiplier register.               ###
' ###                                                               ###
' ###    Will leave IEEE floating point 4 byte register result reg. ###
' #####################################################################

DEFINE fp_expp  usr_ram_3  ' multiply result (product)
DEFINE fp_prod1 usr_ram_4
DEFINE fp_prod2 usr_ram_5
DEFINE fp_prod3 usr_ram_6
DEFINE fp_prod4 usr_ram_7
DEFINE fp1_expm usr_ram_8  ' multiplier
DEFINE fp1_mul1 usr_ram_9
DEFINE fp1_mul2 usr_ram_10
DEFINE fp1_mul3 usr_ram_11
DEFINE fp2_expm usr_ram_12 ' multiplicand
DEFINE fp2_mul1 usr_ram_13
DEFINE fp2_mul2 usr_ram_14
DEFINE fp2_mul3 usr_ram_15

#fp_multiply:
! jsr ieee_2_bin           ' convert from ieee format to binary format
! lda fp1_expm             ' check for multiply by zero
! beq m_by_0
! lda fp2_expm
! bne fp_m0
#m_by_0
! rts

#fp_m0
! lda sign1
! eor sign2
! sta sign1                ' set the sign for the result
! lda fp1_expm
! add fp2_expm
! sta fp_expp
! bcs fp_m1
! bmi fp_m2
! lda #$ff                 ' underflow
! sta fp_expp
! rts

#fp_m1
! bpl fp_m2
! lda #$ff                 ' overflow
! sta fp_expp
! sta fp_prod1
! sta fp_prod2
! sta fp_prod3
! rts

#fp_m2
! lda fp_expp
! add #$82                 ' restore biased exponent
! sta fp_expp
'**********Multiplikation kurz & schnell GeKue 2.2013***********************
'  a1a2a3 x b1b2b3 entspricht Summierung der Produkte von
'   a3b3 => 5.-6. Stelle; a3b2 + a2b3 => 5. - 3. Stelle;
'   a1b3 + a2b2+ a3b1 => 4. - 2. Stelle; a1b2 + a2b1 = 3. - 1. Stelle und
'   a1b1 => 2. und 1. Stelle ; 3 Stellen x 3 Stellen =>maximal 6 Stellen
'***************************************************************************
 !  LDA usr_ram_11   ' a3
 !  LDX usr_ram_15   ' b3
 !  MUL              ' 6.Stelle verwerfen, da nicht genutzt
 !  STX accum0       ' 5. Stelle
 !  LDA usr_ram_11   ' a3
 !  LDX usr_ram_14   ' b2
 !  JSR MUL5         ' 5. - 3. Stelle
 !  LDA usr_ram_10   ' a2
 !  LDX usr_ram_15   ' b3
 !  JSR MUL5         ' 5. - 3. Stelle
 !  LDA usr_ram_9    ' a1
 !  LDX usr_ram_15   ' b3
 !  JSR MUL4         ' 4. - 2. Stelle
 !  LDA usr_ram_10   ' a2
 !  LDX usr_ram_14   ' b2
 !  JSR MUL4         ' 4. - 2. Stelle
 !  LDA usr_ram_11   ' a3
 !  LDX usr_ram_13   ' b1
 !  JSR MUL4         ' 4. - 2. Stelle
 !  LDA usr_ram_9    ' a1
 !  LDX usr_ram_14   ' b2
 !  JSR MUL3         ' 3. - 1. Stelle
 !  LDA usr_ram_10   ' a2
 !  LDX usr_ram_13   ' b1
 !  JSR MUL3         ' 3. - 1. Stelle
 !  LDA usr_ram_9    ' a1
 !  LDX usr_ram_13   ' b1
 !  MUL
 !  ADD usr_ram_5    ' 2. Stelle
 !  STA usr_ram_5
 !  TXA
 !  ADC usr_ram_4    ' 1. Stelle
 !  BMI Mul_MSBSet   ' wenn MSB set, then all ok
 !  ROL usr_ram_7    ' Set MSB
 !  ROL usr_ram_6
 !  ROL usr_ram_5
 !  ROLA
 !  DEC usr_ram_3    ' Exponent
   #Mul_MSBSet:      ' alles ok
 !  STA usr_ram_4

 ! jmp finifpd       ' convert back to ieee format


   #MUL5:
  ! MUL
  ! ADD accum0  '        5.Stelle
  ! STA accum0
  ! TXA
  ! ADC usr_ram_7  '     4.Stelle
  ! STA usr_ram_7
  ! LDA usr_ram_6  '     3.Stelle
  ! ADC #0
  ! STA usr_ram_6
  ! RTS

  #MUL4:
  ! MUL
  ! ADD usr_ram_7   '   4. Stelle
  ! STA usr_ram_7
  ! TXA
  ! ADC usr_ram_6   '   3. Stelle
  ! STA usr_ram_6
  ! LDA usr_ram_5   '   2. Stelle
  ! ADC #0
  ! STA usr_ram_5
  ! RTS

  #MUL3:
  ! MUL
  ! ADD usr_ram_6   '   3. Stelle
  ! STA usr_ram_6
  ! TXA
  ! ADC usr_ram_5   '   2. Stelle
  ! STA usr_ram_5
  ! LDA usr_ram_4   '   1. Stelle
  ! ADC #0
  ! STA usr_ram_4
  ! RTS


'***************************************************
'#finifpm
'! jmp bin_2_ieee           ' convert back to ieee format


' #####################################################################
' ### FP_DIVIDE Function. IEEE 32 Bit floating point division oper. ###
' ###                                                               ###
' ### Requires the following:                                       ###
' ###                                                               ###
' ###    ptr1 (X) = 8 bit ptr to divisor register.                  ###
' ###    ptr2 (A) = 8 bit ptr to dividend register.                 ###
' ###                                                               ###
' ###    Will leave IEEE floating point 4 byte register result reg. ###
' #####################################################################

DEFINE fp_expq  usr_ram_3  ' division result (quotient)
DEFINE fp_quot1 usr_ram_4
DEFINE fp_quot2 usr_ram_5
DEFINE fp_quot3 usr_ram_6
DEFINE fp_quot4 usr_ram_7  ' Zwischenspeicher für ExponentÄnderung
DEFINE fp1_expd usr_ram_8  ' dividend
DEFINE fp1_div1 usr_ram_9
DEFINE fp1_div2 usr_ram_10
DEFINE fp1_div3 usr_ram_11
DEFINE fp2_expd usr_ram_12 ' divisor
DEFINE fp2_div1 usr_ram_13
DEFINE fp2_div2 usr_ram_14
DEFINE fp2_div3 usr_ram_15
'DEFINE fpdbuf1  usr_ram_16 ' temporary buffers
'DEFINE fpdbuf2  usr_ram_17
'DEFINE fpdacc1  usr_ram_18 ' temporary accumulators
'DEFINE fpdacc2  usr_ram_19
'DEFINE fpdacc3  usr_ram_20
'DEFINE fpdacc4  usr_ram_21

#fp_divide:
! jsr ieee_2_bin           ' convert from ieee format to binary format
! lda fp1_expd
! bne div_by0              ' check for division of zero
! rts

#div_by0                   '
! lda fp2_expd
! bne fp_d0                ' check for division by zero
'      ! lda #$ff:! sta fp_expq:! sta fp_quot1:! sta fp_quot2:! sta fp_quot3
! LDHX #$FFFF               ' \
! STHX accum3               '  > Spart 2 Bytes
! STHX accum1               ' /
! rts

#fp_d0                    ' Berechnet Vorzeichen der Division
! lda sign1
! eor sign2
! sta sign1                ' set the sign for the result

! lda fp1_expd
! sub fp2_expd
! sta fp_expq
! bcs fp_d1
! bpl fp_d2
! lda #$55                 ' underflow
! sta fp_expq
! rts

#fp_d1
! bmi fp_d2
! lda #$aa                 ' overflow
! sta fp_expq
! rts

#fp_d2
! lda usr_ram_3
! add #$7e                 '; restore biased exponent $7E=&B01111110
! sta usr_ram_3

'**************GeKue**Pruefroutine***
'  ! LDA usr_ram_8:! JSR FWPutHex: ! LDA usr_ram_9:! JSR FWPutHex:! LDA usr_ram_10
'  ! JSR FWPutHex: ! LDA usr_ram_11:! JSR FWPutHex:! LDA #"a":!JSR PutSCI:! LDA #"k":! JSR FwPrtSCI
'  ! LDA usr_ram_12:! JSR FWPutHex: ! LDA usr_ram_13:! JSR FWPutHex:! LDA usr_ram_14
'  ! JSR FWPutHex: ! LDA usr_ram_15:! JSR FWPutHex:! LDA #"b":!JSR PutSCI:! LDA #"k":! JSR FwPrtSCI

'; Zähler-StartWerte
 ! CLR usr_ram_7                     '; summiert Exponenten-Änderung
 ! MOV #24,ctr                       '; 24 Bits müssen errechnet werden
 ! LDHX usr_ram_9                    '; StartWerte nach Accum0
 ! STHX accum2                       '  bis Accum3
 ! LDA usr_ram_11
 ! STA accum0
 ! CLR accum3

 #DivRoutin                          '; Nutzt 4Bytes (accum3-accum0) als Zähler
 ! LDHX usr_ram_12                   '; Divisor hat nur drei Bytes
 ! CLRH                              '; deshalb H definieren
 ! CPHX accum3                       '; Vergleich Zähler mit Divisor
 ! BLO Div_Subtrahier                '; Zähler> also subtrahiere Zähler minus Divisor
 ! BEQ Proof_Bytes01                 '; erste 2Bytes Zähler=Divisor, also schau nächste Bytes an
 ! BRA DivisorZuGross                '; Divisor zu groß, Zähler eine Stelle nach links,

  #Proof_Bytes01
 ! LDHX usr_ram_14
 ! CPHX accum1                       '; Vergleich Byte3 Zähler - Divisor
 ! BLO Div_Subtrahier                '; Zähler> also Subtrahiere Zähler minus Divisor
 ! SEC                               '; Setze Carry für Divisor_equ_Numerator
 ! BEQ Divisor_equ_Numerator         '; Divisor=Zähler->Division kann beendet werden

  #DivisorZuGross                    '; Divisor zu groß, Zähler eine Stelle nach links
 ! LDA ctr                           '; Zahl der berechneten Stellen nach A
 ! CBEQA #24,MindereExponent         '; Noch keine Stelle berechnet, dann mindere Exponent
 ! CLC                               '; ja, lösche Carry und
 ! BRA SaveDivResult                 '; sichere Ergebnis (=0, da kein DivisionsStep)
  '   ;Subtraktionsroutine
 #Div_Subtrahier                     '; Zähler> also Subtrahiere Zähler minus Divisor
 ! LDA accum0                        '; Byte0 des Numerators
 ! SUB usr_ram_15                    '; Byte0 Numerator - Byte0 Divisor
 ! STA accum0                        '; Ergebnis sichern
 ! LDA accum1                        '; Byte1 des Numerators
 ! SBC usr_ram_14                    '; Byte1 Numerator - Byte1 Divisor (&Carry)
 ! STA accum1                        '; Ergebnis sichern
 ! LDA accum2                        '; Byte2 des Numerators
 ! SBC usr_ram_13                    '; Byte2 Numerator - Byte2 Divisor (&Carry)
 ! STA accum2                        '; Ergebnis sichern
 ! LDA accum3                        '; größere Genauigkeit vorhalten
 ! SBC #0                            '; Carry übertragen
 ! STA accum3                        '; Ergebnis sichern

 ! SEC                               '; Setze Carry, da DivisionStepOk
  #SaveDivResult                     '; Ergebnis muß gesichert werden
 ! ROL usr_ram_6                     '; Schieb das Ergebnis von unten nach oben, mit Carry
 ! ROL usr_ram_5
 ! ROL usr_ram_4
 #NeuerNmerator                      '; Zwischen-Ergebnis mit 2 multiplizieren
 ! LSL accum0                        '; von rechts 0 rein
 ! ROL accum1                        '; carry weiter schieben
 ! ROL accum2                        '; carry weiter schieben
 ! ROL accum3                        '; carry weiter schieben
 ! DBNZ ctr,DivRoutin                '; Zähler -> es müssen 24 Bits werden

 '*******Runden -> wenn jetzt Zähler>Divisor, wird gerundet
 !  LDHX usr_ram_12
 !  CLRH                             '; da H nicht definiert (Einsparung, if Usr_ram anders definiert !!!)
 !  CPHX accum3
 !  BLO RoundUp
 !  BHI Division_fertsch
 !  LDHX usr_ram_14
 !  CPHX accum1
 !  BHI Division_fertsch

  #RoundUp                           '; Aufrunden, wenn Numerator>=Divisor
 !  INC usr_ram_6
 !  BNE RoundReady                   '; Z=1, Result>0
 !  INC usr_ram_5
 !  BNE RoundReady                   '; Z=1, Result>0
 !  INC usr_ram_4
 #RoundReady
 !  BRA Division_fertsch

  #MindereExponent                   ' ; wenn StartDivision 0 ergibt => ExponentÄnderung mximal -1
 ! DEC usr_ram_7                     ' ; Exponent=Exponent-1  ==> noch Sicherung einbauen
 ! INC ctr                           ' Kompensation für nächstes DBNZ ctr
 ! BRA NeuerNmerator

   #Divisor_equ_Numerator             '; Divisor=Zähler->Division kann beendet werden, aber zuerst eine 1 reinschieben
 ! ROL usr_ram_6                     '; \
 ! ROL usr_ram_5                     ';  > mit Nullen von rechts auffüllen
 ! ROL usr_ram_4                     '; /
 ! DBNZ ctr,Divisor_equ_Numerator
  #Division_fertsch                  ' zum prüfen  (braucht AsmHlf1.Pro)
  ! INC usr_ram_7                    '
  ' kleinster Exponent => -126, größter 127; Bias=127 ==> kleinster: 1, größter: 254, Mitte:127-128
 ' 0 und 255 als Null,Unendlich,NaN
 ! LDA usr_ram_7
 ! ADD usr_ram_3                     ' Exponent
'! CBEQA #$FF,Ueberlauf              ' ===> wenn Exponent $FF sollte nachfolgendes Programm dies erkennen ????
 ! BCC NoUeberlauf                   ' Wenn kein Überlauf wird Carry nicht gesetzt
 ! MOV #$FF,usr_ram_3                ' ===> wenn Exponent $FF sollte nachfolgendes Programm dies erkennen ????
 #NoUeberlauf
 ! STA usr_ram_3
'**************GeKue**Pruefroutine***
'    ! LDA usr_ram_3:! JSR FWPutHex: ! LDA usr_ram_4:! JSR FWPutHex:! LDA usr_ram_5
'    ! JSR FWPutHex: ! LDA usr_ram_6:! JSR FWPutHex:! LDA #"j":!JSR PutSCI:! LDA #"k":! JSR FwPrtSCI


'********************ENDE GeKue***************************************************************

#finifpd:
! CLR usr_ram_7
! jmp bin_2_ieee           '; convert back to ieee format


' #####################################################################
' ### FP_SUBTRACT Function. IEEE 32 Bit floating point subtraction. ###
' ###                                                               ###
' ### Requires the following:                                       ###
' ###                                                               ###
' ###    ptr1 (X) = 8 bit ptr to subtractor register.               ###
' ###    ptr2 (A) = 8 bit ptr to subtracthend (source) register.    ###
' ###                                                               ###
' ###    Will leave IEEE floating point 4 byte register result reg. ###
' #####################################################################

#fp_subtract:
! jsr ieee_2_bin
! lda sign2
! eor #$80                 ' complement the sign of the augend
! sta sign2
! bra fp_add0              ' let fp_add_ finish the subtraction

' #####################################################################
' ### FP_ADD_ Function. IEEE 32 Bit floating point addition.        ###
' ###                                                               ###
' ### Requires the following:                                       ###
' ###                                                               ###
' ###    ptr1 (X) = 8 bit ptr to augend register.                   ###
' ###    ptr2 (A) = 8 bit ptr to addend register.                   ###
' ###                                                               ###
' ###    Will leave IEEE floating point 4 byte register result reg. ###
' #####################################################################

DEFINE fp_exps  usr_ram_3  ' addition result (sum)
DEFINE fp_sum1  usr_ram_4
DEFINE fp_sum2  usr_ram_5
DEFINE fp_sum3  usr_ram_6
DEFINE fp_sum4  usr_ram_7
DEFINE fp1_expa usr_ram_8  ' addend
DEFINE fp1_add1 usr_ram_9
DEFINE fp1_add2 usr_ram_10
DEFINE fp1_add3 usr_ram_11
DEFINE fp2_expa usr_ram_12 ' augend
DEFINE fp2_add1 usr_ram_13
DEFINE fp2_add2 usr_ram_14
DEFINE fp2_add3 usr_ram_15
DEFINE fp1_buf  usr_ram_16 ' temporary buffers
DEFINE fp2_buf  usr_ram_17

#fp_add_:
! jsr ieee_2_bin

#fp_add0:
! lda fp1_expa             ' check for add/sub of 0
! bne fp_add1
! lda fp2_expa
! sta fp_exps
! lda fp2_add1
! sta fp_sum1
! lda fp2_add2             ' hier waren Fehler, die bereits im Original-
! sta fp_sum2              '  quellcode FLOAT05COD vorhanden waren [DH]
! lda fp2_add3
! sta fp_sum3
! lda sign2
! sta sign1
! jmp finiadd

#fp_add1
! lda fp2_expa             ' check for add/sub of 0
! bne fp_add2
! lda fp1_expa
! sta fp_exps
! lda fp1_add1
! sta fp_sum1
! lda fp1_add2             ' hier waren Fehler, die bereits im Original-
! sta fp_sum2              '  quellcode FLOAT05COD vorhanden waren [DH]
! lda fp1_add3
! sta fp_sum3
! jmp finiadd

#fp_add2
! clr fp1_buf
! clr fp2_buf
! lda fp1_expa
! cmp fp2_expa
! bhi fp_add3
! blo fp_add4
! bra fp_add5

#fp_add3
! lsr fp2_add1             ' normalize the augend
! ror fp2_add2
! ror fp2_add3
! ror fp2_buf
! inc fp2_expa
! lda fp2_expa
! cmp fp1_expa
! beq fp_add5
! bra fp_add3

#fp_add4
! lsr fp1_add1             ' normalize the addend
! ror fp1_add2
! ror fp1_add3
! ror fp1_buf
! inc fp1_expa
! lda fp1_expa
! cmp fp2_expa
! beq fp_add5
! bra fp_add4

#fp_add5
! lda fp1_expa
! sta fp_exps              ' save the resultant exponent
! lda sign1
! cmp sign2
! bne fp_add6

! lda fp1_buf              ' if signs are same, then add
! add fp2_buf
! sta fp_sum4
! lda fp1_add3
! adc fp2_add3
! sta fp_sum3
! lda fp1_add2
! adc fp2_add2
! sta fp_sum2
! lda fp1_add1
! adc fp2_add1
! sta fp_sum1
! bcc fp_add8              ' no carry, then done.

! lsr fp_sum1              ' if carry out, then increment the exponent
! ror fp_sum2
! ror fp_sum3
! ror fp_sum4
! inc fp_exps
! lda fp_sum1
! ora #$80
! sta fp_sum1
! bra fp_add8

#fp_add6
! lda fp1_buf              ' else signs are not same, then sub.
! sub fp2_buf
! sta fp_sum4
! lda fp1_add3
! sbc fp2_add3
! sta fp_sum3
! lda fp1_add2
! sbc fp2_add2
! sta fp_sum2
! lda fp1_add1
! sbc fp2_add1
! sta fp_sum1
! bcc fp_add7              ' no carry, then check for ms bit set.

! com fp_sum1              ' if carry out, then 2's complement
! com fp_sum2
! com fp_sum3
! com fp_sum4
! lda fp_sum4
! add #1
! sta fp_sum4
! lda fp_sum3
! adc #0
! sta fp_sum3
! lda fp_sum2
! adc #0
! sta fp_sum2
! lda fp_sum1
! adc #0
! sta fp_sum1
! lda sign2                ' result sign is sign2 (augend)
! sta sign1
#fp_add7
! brset 7,fp_sum1,fp_add8  ' check for ms bit = 1

! lsl fp_sum4
! rol fp_sum3
! rol fp_sum2
! rol fp_sum1
! dec fp_exps
! bne fp_add7              ' exponent went to zero [DCHJR]
                           ' (mit BRA ist Endlosschleife möglich)
#fp_add8
! lda #$80
! add fp_sum4
! sta fp_sum4
! lda fp_sum3
! adc #0
! sta fp_sum3
! lda fp_sum2
! adc #0
! sta fp_sum2
! lda fp_sum1
! adc #0
! sta fp_sum1

#finiadd
! jmp bin_2_ieee           ' back to IEEE format

' ############################################################################
' ### INT_2_FP Function. 16 bit integer to IEEE Floating Point conversion. ###
' ###                                                                      ###
' ### Requires the following:                                              ###
' ###                                                                      ###
' ###    ptr1 (A) = 8 bit ptr to 16 bit integer.                           ###
' ###                                                                      ###
' ### Returns the following:                                               ###
' ###                                                                      ###
' ###    Result (usr_ram_3 - usr_ram_6) = floating point number.           ###
' ############################################################################

DEFINE i2f_msk  usr_ram_1
DEFINE int_addr usr_ram_2
DEFINE fp_i2f0  usr_ram_3
DEFINE fp_i2f1  usr_ram_4
DEFINE fp_i2f2  usr_ram_5
DEFINE fp_i2f3  usr_ram_6
DEFINE byte_hi  usr_ram_7
DEFINE byte_lo  usr_ram_8

#int_2_fp
! clr fp_i2f0             ' usr_ram_3
! clr fp_i2f1
! clr fp_i2f2
! clr fp_i2f3             ' usr_ram_6
! tax                     ' DCHJR - bytecraft problem
! stx int_addr
! lda 1,x
! sta byte_lo
! lda ,x
! sta byte_hi
! and #$7f                 ' mask off the sign bit
! ora byte_lo
! bne not_0
! rts

#not_0
! lda byte_hi
! and #$80
! sta sign1                ' save the sign bit
! lda byte_hi
! and #$7f                 ' mask off the sign bit
! sta byte_hi
! clr bit_cnt
! lda #$02
! sta i2f_msk

#i2f_1
! inc bit_cnt              ' determine the exponent
! lda bit_cnt
! cmp #15
! beq d_mant
! lda byte_lo              ' get low byte of integer
! cmp i2f_msk
! bhs incexp
! lda byte_hi
! bne incexp
#i2f_2
! lsl i2f_msk
! beq hibyt1
! bra i2f_1

#incexp
! inc fp_i2f0
! bra i2f_2

#hibyt1
! lda byte_hi
! sta byte_lo
! clr byte_hi              ' don't cause branch for > 0
! lda #$01
! sta i2f_msk
! bra i2f_1

#d_mant
! lda #$01                 ' determine the mantissa
! sta i2f_msk
! clr bit_cnt
! ldx int_addr             ' return the address of the integer low byte
! lda 1,x
! sta byte_lo              ' restore low byte
! lda ,x
! sta byte_hi              ' restore high byte
! bra i2f_4

#i2f_3
! lsl i2f_msk
! beq hibyt2
#i2f_4
! lda bit_cnt
! cmp fp_i2f0
! bhi fini_i2f
! inc bit_cnt
! clc                      ' clear the carry flag
! ror fp_i2f1
! ror fp_i2f2
! ror fp_i2f3
! lda byte_lo
! and i2f_msk
! beq i2f_3
! lda #$80
! ora fp_i2f1
! sta fp_i2f1
! bra i2f_3

#hibyt2
! lda byte_hi
! sta byte_lo
! lda #$01
! sta i2f_msk
! bra i2f_4

#fini_i2f
! lda #$7f
! add fp_i2f0
! sta fp_i2f0
! lsl fp_i2f1              ' remove implied bit
! clc                      ' clear the carry flag
! ror fp_i2f0              ' ieee format
! ror fp_i2f1
! lda sign1                ' restore the sign
! ora fp_i2f0
! sta fp_i2f0
! rts

' #######################################################################
' ### FP_2_INT Function. IEEE 32 Bit FP to 16 bit integer conversion. ###
' ###                                                                 ###
' ### Requires the following:                                         ###
' ###                                                                 ###
' ###    ptr1 (A) = 8 bit ptr to 4 byte floating point register.      ###
' ###                                                                 ###
' ### Returns the following:                                          ###
' ###                                                                 ###
' ###    int_hbyt (usr_ram_1) = High byte of converted signed integer.###
' ###    int_lbyt (usr_ram_2) = Low byte of converted signed integer. ###
' #######################################################################

DEFINE int_hbyt usr_ram_1
DEFINE int_lbyt usr_ram_2
DEFINE expon1   usr_ram_3
DEFINE fp_man1  usr_ram_4
DEFINE fp_man2  usr_ram_5
DEFINE fp_man3  usr_ram_6
DEFINE f2i_mskh usr_ram_7
DEFINE f2i_mskl usr_ram_8

#fp_2_int:
! tax                      ' DCHJR - bytecraft problem
! lda ,x
! sta expon1
! lda 1,x
! sta fp_man1
! lda 2,x
! sta fp_man2
! lda 3,x
! sta fp_man3
! lda expon1
! and #$80
! sta sign1                ' save the sign
! clc                      ' clear the carry flag
! rol fp_man1              ' restore full byte exponent
! rol expon1
! lsr fp_man1
! bset 7,fp_man1           ' set the implied bit

! clr int_hbyt
! clr int_lbyt
! lda expon1
! sub #$7f
! bpl gthan_0

! rts                      ' fp number is fractional, return

#gthan_0
! bne gthan_1
! lda #01
! sta int_lbyt
! lda sign1
! sta int_hbyt
! rts

#gthan_1
! sta expon1               ' save the denormalized exponent
! lda #$01
! sta f2i_mskl
! clr f2i_mskh
! ldx expon1

#f2i_1
! lsl f2i_mskl
! rol f2i_mskh
! bcs f2i_rts              ' check for over flow
! decx
! bne f2i_1

#f2i_2
! lda expon1
! bmi f2i_rts
! dec expon1
! lsl fp_man3
! rol fp_man2
! rol fp_man1
! bcc f2i_3

! lda int_hbyt
! ora f2i_mskh
! sta int_hbyt
! lda int_lbyt
! ora f2i_mskl
! sta int_lbyt

#f2i_3
! lsr f2i_mskh
! ror f2i_mskl
! bra f2i_2

#f2i_rts
! lda sign1
! ora int_hbyt             ' merge in proper sign
! sta int_hbyt
! rts

' #####################################################################
' ### FP_RMOVE Function.  IEEE format Floating Point register move. ###
' ###                                                               ###
' ### Requires the following:                                       ###
' ###                                                               ###
' ###    X = 8 bit ptr to source packed IEEE format register.       ###
' ###    A = 8 bit ptr to dest packed IEEE format register.         ###
' ###                                                               ###
' ###    Will move IEEE floating point 4 byte register in page zero.###
' #####################################################################

#fp_rmove:
! CLRH                     ' GeKue notwendig, da Divisionsroutine H ändert
! stx fp1_addr             ' source from fp1_addr    [temp ptr storage]  usr_ram_1
! sta fp2_addr             ' destination to fp2_addr  usr_ram_2
! lda #4
! sta byte_cnt             ' Zahl der Bytes sichern

#s_fp
! ldx fp1_addr             ' usr_ram_1
! lda ,x                   ' Inhalt (HX) nach a sichern
! ldx fp2_addr             ' X=usr_ram_2
! sta ,x
! inc fp1_addr
! inc fp2_addr
! dec byte_cnt
! bne s_fp
'**************GeKue**Pruefroutine***
'    ! LDA usr_ram_3:! JSR FWPutHex: ! LDA usr_ram_4:! JSR FWPutHex:! LDA usr_ram_5
'    ! JSR FWPutHex: ! LDA usr_ram_6:! JSR FWPutHex:! LDA #"s":!JSR PutSCI:! LDA #"k":! JSR FwPrtSCI
'*****************************************
! rts

