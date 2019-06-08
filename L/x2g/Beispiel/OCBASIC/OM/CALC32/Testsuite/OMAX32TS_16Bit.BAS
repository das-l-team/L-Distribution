
' --------------------------------------------------------------------------
' Testsuite f¸r Open-Maxi
' von Dietmar Harlos am 24. Mai 2012
' am 24. Juni 2018 rudiment‰r f¸r komfortable 32-Bit-Erweiterung angepaﬂt
' am 30. Juni 2018 den PC-Programmtest nach FreeBASIC portiert
' --------------------------------------------------------------------------

' Erst dieses Programm starten, dann OMAX32TS_16Bit.exe

'  * ein automatischer Test f¸r den Open-Maxi-Interpreter
'  * AD[4] muﬂ auf GND liegen
'  * das Programm testet jede Tokenroutine des Interpreters mittels Zufallszahlen
'  * das I≤C-LCD zeigt wechselnde Zahlenausgaben

INCLUDE "..\omax.def"

' --------------------------------------------------------------------------

DEFINE a WORD
DEFINE al BYTE[1] OF a
DEFINE ah BYTE[2] OF a
DEFINE amsb BIT[16] OF a
DEFINE b WORD
DEFINE bl BYTE[1] OF b
DEFINE bh BYTE[2] OF b
DEFINE c BYTE
DEFINE bitport0 PORT[1]
DEFINE byteport0 BYTEPORT[1] 'PORT A
DEFINE byteport1 BYTEPORT[2] 'PORT B
DEFINE byteport2 BYTEPORT[5] 'PORT E
DEFINE byteport3 BYTEPORT[9] '1. PCF8574
DEFINE wordport0 WORDPORT[1]
DEFINE poti AD[4]
DEFINE daport1 DA[2]
DEFINE led PORT[9]
DEFINE basirq_result WORD

DEFINE fktnr BYTE
DEFINE toknr BYTE

DEFINE bytevar BYTE
DEFINE wordvar WORD

DEFINE ^bp BYTE
DEFINE ^wp WORD

' --------------------------------------------------------------------------

' Alle Tokenbefehle der Open-Maxi
' nach dem omax_os.asm

DEFINE Tok_Nop 0
DEFINE Tok_Push_Off 1
DEFINE Tok_Pause 2
DEFINE Tok_Goto 3
DEFINE Tok_If_Then 4
DEFINE Tok_Gosub 5
DEFINE Tok_Return 6
DEFINE Tok_Return_Interrupt 7
DEFINE Tok_Sys 8
DEFINE Tok_Slowmode 9
DEFINE Tok_Push_Bitport 10
DEFINE Tok_Push_Byteport 11
DEFINE Tok_Push_Wordport 12
DEFINE Tok_Pop_Bitport 13
DEFINE Tok_Pop_Byteport 14
DEFINE Tok_Pop_Wordport 15
DEFINE Tok_Push_Adport 16
DEFINE Tok_Pop_Daport 17 'Neu
DEFINE Tok_Inlasm 18
DEFINE Tok_Push_On 19
DEFINE Tok_Push_Wordvalue 20
DEFINE Tok_Push_Bitvar 21
DEFINE Tok_Push_Bytevar 22
DEFINE Tok_Push_Wordvar 23
DEFINE Tok_Pop_Bitvar 24
DEFINE Tok_Pop_Bytevar 25
DEFINE Tok_Pop_Wordvar 26
DEFINE Tok_Looktab 27
DEFINE Tok_Push_Internalvar 28
DEFINE Tok_Pop_Internalvar 29
DEFINE Tok_Print_Number 30
DEFINE Tok_Print_String 31
DEFINE Tok_Put 32
DEFINE Tok_Rxd 33
DEFINE Tok_Get 34
DEFINE Tok_Input 35
DEFINE Tok_Array_Pointer 36
DEFINE Tok_Cts 37
DEFINE Tok_Printcrlf 38
DEFINE Tok_Push_1 39
DEFINE Tok_Not 40
DEFINE Tok_And 41
DEFINE Tok_Nand 42
DEFINE Tok_Or 43
DEFINE Tok_Nor 44
DEFINE Tok_Xor 45
DEFINE Tok_Shl 46
DEFINE Tok_Shr 47
DEFINE Tok_Randomize 48
DEFINE Tok_Rand 49
DEFINE Tok_Negieren 50
DEFINE Tok_Addition 51
DEFINE Tok_Subtraktion 52
DEFINE Tok_Multiplikation 53
DEFINE Tok_Division 54
DEFINE Tok_Mod 55
DEFINE Tok_Abs 56
DEFINE Tok_Sqr 57
DEFINE Tok_Max 58
DEFINE Tok_Min 59
DEFINE Tok_Groesser 60
DEFINE Tok_Groesser_Gleich 61
DEFINE Tok_Kleiner 62
DEFINE Tok_Kleiner_Gleich 63
DEFINE Tok_Gleich 64
DEFINE Tok_Ungleich 65
DEFINE Tok_Sgn 66
DEFINE Tok_Removetos 67
DEFINE Tok_Add_Bytevar_Stack 68
DEFINE Tok_Add_Wordvar_Stack 69
DEFINE Tok_Filehandling 70
DEFINE Tok_Eof 71
DEFINE Tok_Baud 72
DEFINE Tok_Interrupt 73
DEFINE Tok_For_Next_Cmp_Bytevar 74
DEFINE Tok_For_Next_Cmp_Wordvar 75
DEFINE Tok_For_Next_Add_Bytevar 76
DEFINE Tok_For_Next_Add_Wordvar 77
DEFINE Tok_Dbnz 78
DEFINE Tok_Peek_Poke 79 'Neu
DEFINE Tok_Tog 80
DEFINE Tok_Pulse 81
DEFINE Tok_Deact_Bitport 82
DEFINE Tok_Deact_Byteport 83
DEFINE Tok_Deact_Wordport 84
DEFINE Tok_Push_Bytevalue 85
DEFINE Tok_Push_Bytevar_Bytevalue 86 'wird nicht getestet
DEFINE Tok_Push_Wordvar_Wordvalue 87 'wird nicht getestet
DEFINE Tok_Looktab_Bytetable 88
DEFINE Tok_I2C_Lcd 89 'Neu

' --------------------------------------------------------------------------

INCLUDE "..\omax32.iia"   '32-Bit-Erweiterung einbinden

' --------------------------------------------------------------------------

#main

RunOnErr=ON

if err then
  led=off
  while true
    ?"Error ";err;" at $";
    printhex=ON
    ?erradr
    printhex=OFF
    pause 25
    tog led
  wend
end if

URTok=ON


open# for WRITE           'Initialisierung fÅr File-I/O
print# 45                 '10 Zahlen in Datei schreiben
print# -12345
print# 89
print# 34
print# -789
print# 8
print# 0
print# -1
print# 1
print# 5664
close#

baud R38400
led=off
IrqReq=on

WHILE TRUE
  GET ah
  GET al
  GET bh
  GET bl
  GET toknr

  ?a
  ?b
  ?toknr

  IF toknr=Tok_Nop THEN
    inline 0
    ?-789
  ELSEIF toknr=Tok_Push_Off THEN
    inline 1
    ?pop
  ELSEIF toknr=Tok_Pause THEN
    pause 1
    ?a+2345
  ELSEIF toknr=Tok_Goto THEN
    goto label1
    end
    #label1
    ?-4567
  ELSEIF toknr=Tok_If_Then THEN
    if a<b then ?a else ?b
  ELSEIF toknr=Tok_Gosub THEN
    gosub subroutine1
  ELSEIF toknr=Tok_Return THEN
    gosub subroutine2
  ELSEIF toknr=Tok_Return_Interrupt THEN
    ?basirq_result
  ELSEIF toknr=Tok_Sys THEN
    sys asmsubroutine
    ?a
  ELSEIF toknr=Tok_Slowmode THEN             'nicht getestet
    ?"-"
  ELSEIF toknr=Tok_Push_Bitport THEN
    ?bitport0
  ELSEIF toknr=Tok_Push_Byteport THEN
'    daport1=off
    ?byteport1
  ELSEIF toknr=Tok_Push_Wordport THEN
'    daport1=off
    ?wordport0
  ELSEIF toknr=Tok_Pop_Bitport THEN
    led=amsb
    push 1
    ?led
  ELSEIF toknr=Tok_Pop_Byteport THEN
    byteport2=al
    push 0
    ?byteport2
    deact byteport2
  ELSEIF toknr=Tok_Pop_Wordport THEN         'nicht getestet
    ?"-"
  ELSEIF toknr=Tok_Push_Adport THEN
    ?poti
  ELSEIF toknr=Tok_Pop_Daport THEN
    daport1=al
    ?al
  ELSEIF toknr=Tok_Inlasm THEN
    gosub asmroutine2
    ?FREERAM5
  ELSEIF toknr=Tok_Push_On THEN
    inline 19
    ?pop
  ELSEIF toknr=Tok_Push_Wordvalue THEN
    ?12345
  ELSEIF toknr=Tok_Push_Bitvar THEN
    ?amsb
  ELSEIF toknr=Tok_Push_Bytevar THEN
    ?al
  ELSEIF toknr=Tok_Push_Wordvar THEN
    ?a
  ELSEIF toknr=Tok_Pop_Bitvar THEN
    amsb=b
    push 1
    ?amsb
  ELSEIF toknr=Tok_Pop_Bytevar THEN
    bl=al
    push 0
    ?bl
  ELSEIF toknr=Tok_Pop_Wordvar THEN
    ?b
  ELSEIF toknr=Tok_Looktab THEN
    ?looktab(tabellew,a)
  ELSEIF toknr=Tok_Push_Internalvar THEN
    dbnzctr=159
    push 0
    ?dbnzctr
  ELSEIF toknr=Tok_Pop_Internalvar THEN
    erradr=777
    push 0
    ?erradr
  ELSEIF toknr=Tok_Print_Number THEN
    ?a+b/7
  ELSEIF toknr=Tok_Print_String THEN
    ?"-32456"
  ELSEIF toknr=Tok_Put THEN
    put "1"
    put "2"
    put "3"
    put 13
    put 10
  ELSEIF toknr=Tok_Rxd THEN
    ?rxd
  ELSEIF toknr=Tok_Get THEN
    get b
    ?b
  ELSEIF toknr=Tok_Input THEN
    input b
    ?b
  ELSEIF toknr=Tok_Array_Pointer THEN
    IF b=0 THEN     ' PUSH BYTEARRAY
      bytevar=a
      bp=^bytevar
      push 0  'als zus,tzliche HÅrde/Sicherheit
      ?@bp
    ELSEIF b=1 THEN ' PUSH WORDARRAY
      wordvar=a
      wp=^wordvar
      push 0
      ?@wp
    ELSEIF b=2 THEN ' POP BYTEARRAY
      bp=^bytevar
      @bp=a
      push 0
      ?bytevar
    ELSEIF b=3 THEN ' POP WORDARRAY
      wp=^wordvar
      @wp=a
      push 0
      ?wordvar
    ELSE
      ?"arrayfktnr unknown"
    ENDIF
  ELSEIF toknr=Tok_Cts THEN
    ?cts
  ELSEIF toknr=Tok_Printcrlf THEN
    ?"678";
    inline 38
  ELSEIF toknr=Tok_Push_1 THEN
    inline 39
    ?pop
  ELSEIF toknr=Tok_Not THEN
    ?not(a)
  ELSEIF toknr=Tok_And THEN
    ?a and b
  ELSEIF toknr=Tok_Nand THEN
    ?a nand b
  ELSEIF toknr=Tok_Or THEN
    ?a or b
  ELSEIF toknr=Tok_Nor THEN
    ?a nor b
  ELSEIF toknr=Tok_Xor THEN
    ?a xor b
  ELSEIF toknr=Tok_Shl THEN
    ?a shl b
  ELSEIF toknr=Tok_Shr THEN
    ?a shr b
  ELSEIF toknr=Tok_Randomize THEN
    randomize b
    ?rand
  ELSEIF toknr=Tok_Rand THEN
    randomize a
    ?rand
  ELSEIF toknr=Tok_Negieren THEN
    ?-a
  ELSEIF toknr=Tok_Addition THEN
    ?a+b
  ELSEIF toknr=Tok_Subtraktion THEN
    ?a-b
  ELSEIF toknr=Tok_Multiplikation THEN
    ?a*b
  ELSEIF toknr=Tok_Division THEN
    ?a/b
  ELSEIF toknr=Tok_Mod THEN
    ?a mod b
  ELSEIF toknr=Tok_Abs THEN
    ?abs(a)
  ELSEIF toknr=Tok_Sqr THEN
    ?sqr(a)
  ELSEIF toknr=Tok_Max THEN
    ?max(a,b)
  ELSEIF toknr=Tok_Min THEN
    ?min(a,b)
  ELSEIF toknr=Tok_Groesser THEN
    ?a>b
  ELSEIF toknr=Tok_Groesser_Gleich THEN
    ?a>=b
  ELSEIF toknr=Tok_Kleiner THEN
    ?a<b
  ELSEIF toknr=Tok_Kleiner_Gleich THEN
    ?a<=b
  ELSEIF toknr=Tok_Gleich THEN
    ?a=b
  ELSEIF toknr=Tok_Ungleich THEN
    ?a<>b
  ELSEIF toknr=Tok_Sgn THEN
    ?sgn(a)
  ELSEIF toknr=Tok_Removetos THEN
    push b
    push a
    removetos
    ?pop
  ELSEIF toknr=Tok_Add_Bytevar_Stack THEN
    add al,bl
    ?al
  ELSEIF toknr=Tok_Add_Wordvar_Stack THEN
    add a,b
    ?a
  ELSEIF toknr=Tok_Filehandling THEN           'nur zum Teil getestet
    open# for read
    while b<>0
      push input#
      sub b,1
    wend
    ?input#
    close#
  ELSEIF toknr=Tok_Eof THEN
    open# for read
    while b<>0
      push input#
      add b,-1
    wend
    ?eof
    close#
  ELSEIF toknr=Tok_Baud THEN                   ' oben getestet
    baud R38400
    ?b
  ELSEIF toknr=Tok_Interrupt THEN
    if b then
      interrupt basirq
    else
      interrupt off
    end if
    ?a
  ELSEIF toknr=Tok_For_Next_Cmp_Bytevar THEN
    for al=al to bl
    next al
    ?al
  ELSEIF toknr=Tok_For_Next_Cmp_Wordvar THEN
    for a=a to b
    next a
    ?a
  ELSEIF toknr=Tok_For_Next_Add_Bytevar THEN
    for al=al to bl step -1
    next al
    ?al
  ELSEIF toknr=Tok_For_Next_Add_Wordvar THEN
    for a=a to b step -1
    next a
    ?a
  ELSEIF toknr=Tok_Dbnz THEN
    dbnzctr=a
    bytevar=dbnzctr
    #dbnzloop
    dbnz dbnzloop
    ?bytevar
  ELSEIF toknr=Tok_Peek_Poke THEN
    ?peek(a)
  ELSEIF toknr=Tok_Tog THEN
    tog led
    push 1
    ?led
  ELSEIF toknr=Tok_Pulse THEN
    pulse led
    push 1
    ?led
  ELSEIF toknr=Tok_Deact_Bitport THEN
    deact led
    push 1
    pause 2
    ?led
    led=0
  ELSEIF toknr=Tok_Deact_Byteport THEN
    deact byteport2
    push 1
    pause 2
    ?byteport2
  ELSEIF toknr=Tok_Deact_Wordport THEN           'bei Restart getestet
    ?"-"
  ELSEIF toknr=Tok_Push_Bytevalue THEN
    ?123
  ELSEIF toknr=Tok_Push_Bytevar_Bytevalue THEN
    inline 86,1,123
    ?pop+pop
  ELSEIF toknr=Tok_Push_Wordvar_Wordvalue THEN
    inline 87,0,255,255
    ?pop+pop
  ELSEIF toknr=Tok_Looktab_Bytetable THEN
    ?looktabbyte(tabelleb,a)
  ELSEIF toknr=Tok_I2C_Lcd THEN
    LCDINIT
    LCDCLS
    LCDLOCATE 0,0
    LCDPRINT a
    ?b
  ELSEIF toknr=255 THEN 'Restart
    a=-1
    b=-1
    c=255
    deact wordport0
    deact byteport2
    byteport3=255
    interrupt off
    basirq_result=0
    IrqReq=on
    pause 2 'erforderlich wg. vorher led=off & verm. wg. Piezotˆner
    ?wordport0
    led=off
  ELSE
    ?"toknr unknown"
  END IF
WEND



#subroutine1
  ?a+4567
return

#subroutine2
  ?b+7890
return

PROC asmsubroutine INLASM
! lda a+1
! add #255
! sta a+1
! lda a
! adc #0
! sta a
! rts
END PROC

#asmroutine2
inline &h12,6
! mov al,FREERAM5
'! mov al,x+
! rts


PROC basirq
  basirq_result=-23456
RETURN INTERRUPT





table tabellew word
  38 456 90 78 -186 32767 -32768 68 9 1
end table
inline 255,255

table tabelleb byte
  26 96 124 251 1 77 34 7 85 23
end table
inline 255




