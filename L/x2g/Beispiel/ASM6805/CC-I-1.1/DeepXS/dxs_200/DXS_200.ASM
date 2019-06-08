; DeepXS - I2C memory device (RAM/EEPROM) support module for the
;          C-Control/BASIC System
; Copyright (C) 1999, 2000, 2001, 2002  Mark Haemmerling <mail@markh.de>

; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

; -----------------------------------------------------------------------------------

; Version: 2.0.0
; Release date: 2002-07-13

; You have to include the DXS_200.BAS file into your project's Basic file in order to
; make DeepXS 2.0.0 work.
; Required Basic version: C-Control/BASIC V1.33 (or higher).

; Recommeded assembler: AS05 or CASM.

; -----------------------------------------------------------------------------------

; SYS arguments are stored at last 2 or 3 entries of the operand stack
Offset_H        equ $91 ; target address, hi-byte
Offset_L        equ $92 ; dito,           lo-byte
I2CDev_H	equ $93 ; I2C device address, hi-byte
I2CDev_L	equ $94 ; dito,               lo-byte
Data		equ $96 ; data byte to write
Store_H		equ $91 ; will be cleared
Store_L		equ $92 ; target for read data byte

; Internal OS routines for I2C access
I2C_Start       equ $083C
I2C_Write       equ $0846
I2C_Read        equ $086F
I2C_ReadLast    equ $08BB
I2C_Stop        equ $08E5

		org $0101

; --- Write a byte to RAM/EEPROM
DeepXS_W        bsr Send_Addr
                ldx Data      ; load data byte into X
                jsr I2C_Write ; send byte
                jsr I2C_Stop  ; set stop condition on bus
                bra Finish

; --- Read a byte from RAM/EEPROM
DeepXS_R        bsr Send_Addr
		lda I2CDev_L     ; load l-shifted device address into A...
                ora #$01         ; ...and set the LSB to 1 (I2C read operation)
                tax              ; transfer A to X
                jsr I2C_Start    ; set start condition on bus and send device address
                jsr I2C_Read     ; receive byte and store it into A
                sta Store_L      ; store A in lo-byte of result word
		clr Store_H      ; clear hi-byte of result word
		jsr I2C_ReadLast ; end read sequence

; --- Restore I2C bus state for reading the next basic token
Finish          ldx #$A0      ; re-address the onboard EEPROM
		jsr I2C_Start ; set start condition on bus and send EEPROM address
                ldx $66       ; load current basic token program counter hi-byte into X...
                jsr I2C_Write ; ...and send it to the EEPROM device
                ldx $67       ; dito, lo-byte
                jsr I2C_Write
                ldx #$A1      ; return to read mode from onboard EEPROM
		jsr I2C_Start
                rts           ; return to Basic

; --- Compute and send the target byte address
Send_Addr       jsr   I2C_ReadLast          ; end op. system's token read sequence
		brclr 6,I2CDev_H,Paging_Off ; dev. code bit 14 clear: no paging required
Paging		brclr 7,I2CDev_H,Paging_8   ; dev. code bit 15 clear: use 8bit mem. addressing
Paging_16	brclr 7,Offset_H,Paging_Off ; if mem. addr. hi-byte msb is clear, skip
	 	lda   I2CDev_L              ; load dev. code lo-byte (mainly 7bit I2C address) into A
		ora   #$04                  ; ...else set bit 2 of A
		bra   Paging_Finish
Paging_Off	ldx   I2CDev_L              ; load dev. code lo-byte into X and continue below
		bra   Paging_Done
Paging_8	lda   Offset_H              ; load hi-byte of mem. addr. into A: ddddddxx (d=don't care)
; The following line is optional, but strongly recommended. You may comment it out.
		and   #$03                  ; overflow protection:      crop to: 000000xx
		lsla                        ; shift left:                        00000xx0
		ora   I2CDev_L              ; merge w/ dev. code lo-byte
Paging_Finish	tax                         ; transfer A to X...
Paging_Done	lslx                        ; ...and shift left (dev. code's msb only in carry now)
		stx   I2CDev_L              ; overwrite dev. code lo-byte w/ target I2C address
                jsr   I2C_Start             ; set start condition on bus and send dev. addr.
		brclr 7,I2CDev_H,Address_8  ; dev. code bit 15 clear: skip hi-byte of mem. addr.
Address_16	ldx   Offset_H              ; load memory location hi-byte into X...
                jsr   I2C_Write             ; ...and send it to device (16bit mode only)
Address_8	ldx   Offset_L              ; load memory location lo-byte into X...
                jsr   I2C_Write             ; ...and send it to device (both modes)
                rts

; --- End of DeepXS assembler listing
