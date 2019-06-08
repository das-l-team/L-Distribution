;****************************************************************
;*
;*  LCD driver machine code part
;*  for the Conrad C-Control 1 Application Board
;*
;*  written Jan-2003 by Klaus Dormann - K@2m5.de
;*
;****************************************************************
PortC   equ     2       ;0-3 LCD data lines
                        ;4   LCD R/W 0=write 1=read
                        ;5   LCD RS  0=command 1=data
                        ;6   LCD E +pulse

PC      equ     $66     ;Basic Program Counter (word)
PCsave  equ     $cf     ;if LPS goes wrong
Stack   equ     $92     ;top of stack (byte)

GetBas  equ     $e04    ;get next byte from basic program
GotoPC  equ     $15d2   ;goto PCsave (if LPS Syntax was wrong)

        org     $101

;
; LCmd entry point
; write command to LCD - SYS LCmd command
;
LCmd    lda     Stack     ;load command
        bclr    #5,PortC  ;set command mode
        bra     LCmd2
;
; LPut entry point
; write character to LCD - SYS LPut char
;
LPut    lda     Stack     ;load character
Send    bset    #5,PortC  ;set data mode
LCmd2   tax               ;save character
        lsra              ;high nibble first
        lsra
        lsra
        lsra
        bsr     Send2     ;do the handshake
        txa               ;low nibble
        and     #$f
Send2   brclr   #5,PortC,Send3
        ora     #$20      ;keep data mode
Send3   sta     PortC
        bset    #6,PortC  ;clock select (on leading edge)
        bclr    #6,PortC  ;clock data (on trailing edge)
        rts
;
; LPS entry point
; LCD print string - SYS LPS:PRINT"blabla"
;
LPS     lda     PC        ;may have to backoff
        sta     PCsave
        lda     PC+1
        sta     PCsave+1
        jsr     GetBas    ;skip print string token
        cmp     #31
        beq     LPS2      ;syntax OK!
        jmp     GotoPC    ;Oups! rerun this token
LPS3    bpl     LPS1      ;standard ascii
        ldx     #7        ;use translation
LPS4    cmp     PrtChar-1,x
        beq     LPS5      ;gotit
        decx
        bne     LPS4      ;more
LPS5    lda     LCDChar,x
LPS1    bsr     Send      ;-> LCD
LPS2    jsr     GetBas    ;next char
        bne     LPS3      ;zero-terminated
        rts
;
; LPN entry point
; LCD print numeric - SYS LPN var/10000
;     example displays 10^4 digit on LCD
;     display of least significant digit to LCD
;     implies (stack mod 10) or &h30
;
LPN     ldx     #16       ;prepare for mod 10 (word)
        clra
LPN1    lsl     Stack     ;low word
        rol     Stack-1   ;high word
        rola
        cmp     #10
        blo     LPN2
        sub     #10
LPN2    decx
        bne     LPN1
        ora     #$30      ;or "0"
        bra     Send
;
; Translation-table for country specific special characters
; (German)
;
PrtChar db      'ядƒц÷ь№'
LCDChar db      $eb,$e2,$e1,$e1,$ef,$ef,$f5,$f5
