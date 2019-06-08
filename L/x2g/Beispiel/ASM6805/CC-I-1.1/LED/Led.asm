*********************************************
* Systemtreiber fuer des LED-Modul
* 
*  Adressen fuer C-Control/BASIC SYS-Befehl:
*
*  define LEDVAL   &H101
*  define LEDDIGIT &H187
*********************************************

USRDATA	equ $A1 ; Anfang der 24 Userbytes im RAM
VSTACK	equ $91 ; Anfang der 7 Words des Rechen-Stacks

_A	equ $91 ; zuletzt auf den Rechen-Stack gebrachter Wert, Rechenergebnis
_A_lo   equ $92 
_B	equ $93 
_B_lo   equ $94
_C	equ $95
_C_lo   equ $96 
_D	equ $97
_D_lo   equ $98 
_E	equ $99
_E_lo   equ $9A 
_F	equ $9B
_F_lo   equ $9C 
_G	equ $9D
_G_lo   equ $9E

* Steuerports des LED-Displays am Application Board
leddat equ 1
ledclk equ 5
leden  equ 6

* Steuerports des LED-Displays am Starter Board
;leddat equ 5
;ledclk equ 1
;leden  equ 2

pcdat  equ $02
pcdir  equ $06

NumPush    equ $1187
Abs        equ $13BA
Div        equ $137E
_Mul       equ $1360
_Sub       equ $1351

*** LED interface ***
	
	org $101

LEDVAL:
        lda _C
	sta _D
        lda _C_lo
	sta _D_lo

        lda _A
	sta _C
        lda _A_lo
	sta _C_lo

        lda _D
	sta _A
        lda _D_lo
	sta _A_lo

        brclr 7, _A, nextdigit
        bset 0, _B
	jsr Abs

nextdigit:
	jsr NumPush
	jsr NumPush

	lda _C
	sta _A
	sta _B
	lda _C_lo
	lda _A_lo
	lda _B_lo

	jsr NumPush
	jsr load10
	jsr Div
	jsr NumPush
	jsr load10
	jsr _Mul
	jsr _Sub
	
	ldx _A_lo
	lda ledcodes,x

        ldx _C_lo
        beq nopoint
	dec _C_lo
	bne nopoint
        
	and #$7F

nopoint:
	jsr digit
	
	jsr load10
	jsr Div

	lda _B_lo
	bne no0check

	lda _A
	ora _A_lo
	beq sign

no0check:
	dec _C_lo
	bne nextdigit

	rts

sign:   dec _C_lo
	beq exit
        brclr 0, _B, space
        lda #$FD
        jsr digit
	
nextspace: 
	dec _C_lo
	beq exit
space:	lda #255
	jsr digit
	bra nextspace

	
exit:   rts

LEDDIGIT:
        lda _A_lo

digit:  jsr shift
	jsr shift
	jsr shift
	jsr shift
	jsr shift
	jsr shift
	jsr shift
	jsr shift
	rts

shift:  bclr leddat,pcdat ;set serial data
	lsra              ;shift
	bcc shftex
	bset leddat,pcdat

shftex: bset ledclk,pcdat ;clock out
	bclr ledclk,pcdat
	rts

load10: clr _A
	lda #10
	sta _A_lo
	rts

ledcodes:	
	fcb $82, $CF, $91, $85, $CC
	fcb $A4, $A0, $8F, $80, $84
