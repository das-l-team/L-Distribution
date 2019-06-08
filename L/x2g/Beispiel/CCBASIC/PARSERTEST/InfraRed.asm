; _asm_FileVersion: $0010

PortA		.equ $00		; Ports und Directions
PortB		.equ $01
PortC		.equ $02
PAdir		.equ $04
PBdir		.equ $05
PCdir		.equ $06

VAR01		.equ $A1 		; Anfang der 24 Userbytes im RAM
VAR02		.equ $A2
VAR03		.equ $A3
VAR04		.equ $A4
VAR05		.equ $A5
VAR06		.equ $A6
VAR07		.equ $A7
VAR08		.equ $A8
VAR09		.equ $A9
VAR10		.equ $AA
VAR11		.equ $AB
VAR12		.equ $AC
VAR13		.equ $AD
VAR14		.equ $AE
VAR15		.equ $AF
VAR16		.equ $B0
VAR17		.equ $B1
VAR18		.equ $B2
VAR19		.equ $B3
VAR20		.equ $B4
VAR21		.equ $B5
VAR22		.equ $B6
VAR23		.equ $B7
VAR24		.equ $B8

SysFlgs		.equ $7B		; Betriebssystem-FlagRegister
SYNC		.equ 0			; BitIndex des  -Flags
ACTIVE		.equ 1			; BitIndex des  -Flags
RUN		.equ 2			; BitIndex des  -Flags
DEBUG		.equ 3			; BitIndex des  -Flags
DCFVALID	.equ 4			; BitIndex des  -Flags
SLOWMODE	.equ 5			; BitIndex des  -Flags
UINT		.equ 6			; BitIndex des  -Flags
RTSCTS		.equ 7			; BitIndex des  -Flags

_A		.equ $91 		; StackTop
_A_lo		.equ $92
_B		.equ $93
_B_lo		.equ $94
_C		.equ $95
_C_lo		.equ $96
_D		.equ $97
_D_lo		.equ $98
_E		.equ $99
_E_lo		.equ $9A
_F		.equ $9B
_F_lo		.equ $9C
_G		.equ $9D
_G_lo		.equ $9E

brate		.equ $0D		; RS232 SCR-Baudrate
sccr1		.equ $0E		; RS232 Controlregister 1
sccr2		.equ $0F		; RS232 Controlregister 2
scsr		.equ $10		; RS232 Status-Register
scdat		.equ $11		; RS232 Datenregister

TCR		.equ $12		; Timer Registers ...
TSR		.equ $13
CAP1LO		.equ $15
CAP2LO		.equ $1D
CMP1HI		.equ $16
CMP1LO		.equ $17
CMP2HI		.equ $1E
CMP2LO		.equ $1F
CNTLO		.equ $19

Misc		.equ $0C
INTE		.equ 4			; BitIndex des InterruptEnable-Flags

_IRQPTR 	.equ $50		; User-Interrupt-Routinen-Pointer
_CAPPTR		.equ $51
_CMPPTR 	.equ $52
_OFLPTR 	.equ $53

FrameLo		.equ VAR01
FrameHi		.equ VAR02
DrvFlgs		.equ VAR03
BitsCnt		.equ VAR04

F_LEN		.equ 13			; FrameLength
F_OFFSET	.equ 0			; = 8 * UserVarNr(FrameLo) - 8

WDOG_EN		.equ 7			; BitIndex des WatchDog-Enable Flags
F_VALID		.equ 6			; Bitindex des Frame_Valid Flags

WDOG_TO		.equ 7			; Timerticks, bis WatchDog Frame löscht
DELAY_CNT	.equ $80		; Delays, untill RefTime

RS232_WriteByte	.equ $0C77		; SubR. Senden des xRegs
Store_Bit	.equ $1273		; SubR. Bit nr xReg of UserBytes := _A

	.org $101

; ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
Inizialize:
	lda #IRQ - $100			; load Offset of IRQ to Akku
	sta _IRQPTR			; store Akku to _IRQPTR
	lda #CMP_Common - $100		; load Offset of TCMP_Common to Akku
	sta _CMPPTR			; store Akku to _CMPPTR
	bclr 0,PBdir			; PortB.Bit0 is InPort
	rts
; ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


; ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
Drv_On:
	bset INTE,Misc
	rts
; ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


; ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
Drv_Off:
	bclr INTE,Misc
	rts
; ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


; ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
IRQ:
	lda BitsCnt			; load BitsCnt to Akku
	inca				; inc BitsCnt
	sta BitsCnt			; store Akku to BitsCnt
	bset WDOG_EN,DrvFlgs		; set WatchDog enabled
	lda CMP1HI
	add #WDOG_TO			; set next WatchDog
	sta CMP1HI
	lda CMP1LO
	sta CMP1LO
; Begin of Delayer ***
	lda #DELAY_CNT
DELAY1:
	deca
	bne DELAY1
	lda #DELAY_CNT
DELAY2:
	deca
	bne DELAY2
; End of Delayer ***
TTL_Test:
	lda PortB			; load PortB to Akku
	coma				; invert Akku
	and #$01			; Leave only Bit 0
	sta _A				; store Akku to _A
	clra				; clear Akku
	sta _A_lo			; store Akku to _A_lo
	;ldx _A				; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
	;ldx BitsCnt			; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
	ldx BitsCnt			; load BitsCnt to Index
	jsr Store_Bit			; call SubRoutine
	lda BitsCnt			; load BitsCnt to Akku
	cmp #F_LEN			; compare Akku, F_LEN
	beq FrameReady			; if Akku = FLen goto FrameReady
InFrame:
	;bclr F_VALID,DrvFlgs		; mark frame as not ready
	bra IRQ_Exit0
FrameReady:
	bclr WDOG_EN,DrvFlgs		; set WatchDog disabled
	clra				; clear Akku
	sta BitsCnt			; BitsCnt := 0
	bset UINT,SysFlgs		; raise ccBasic-Interrupt
	;ldx FrameHi			; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
	;ldx FrameLo			; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
	;ldx #$AA			; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
IRQ_Exit0:
	clra				; Akku := 0: std.handler inactive
	rts
; ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


; ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
CMP_Common:
	brclr 6,TSR,CMP_SysTimer	; if SysTimer then Exit_1
	brclr WDOG_EN,DrvFlgs,CMP_Exit0 ; if WatchDog off then Exit_0
CMP_UserTimer:
	bclr WDOG_EN,DrvFlgs		; set WatchDog disabled
	clra				; clear Akku
	sta BitsCnt			; BitsCnt := 0
	;sta FrameHi			; FrameHi := 0
	;sta FrameLo			; FrameLo := 0
	;ldx #$FF			; DEBUG  ONLY !!! ***
	;jsr RS232_WriteByte		; DEBUG  ONLY !!! ***
CMP_Exit0:
	;clra				; Akku := 0: std.handler inactive
	rts
CMP_SysTimer:
CMP_Exit1:
	lda #$01			; Aku := 1: std.handler active
	rts
; ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


	.end
