////////////////////////////////////////////////////////////////////////////////
//
//  C-Control/C-Cross-Compiler Headers
//  68hc05b6.h
//
//  Copyright (C) 2005, 2006  Oliver Haag
//
//  This file is part of the C-Control/C-Cross-Compiler.
//
//  The C-Control/C-Cross-Compiler is free software// you can redistribute it
//  and/or modify it under the terms of the GNU General Public License as
//  published by the Free Software Foundation// either version 2 of the License,
//  or (at your option) any later version.
//
//  The C-Control/C-Cross-Compiler is distributed in the hope that it will be
//  useful, but WITHOUT ANY WARRANTY// without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
//  Public License or the file COPYING for more details.
//
//  You should have received a copy of the GNU General Public License along with
//  this program// if not, write to the Free Software Foundation, Inc.,
//  51 Franklin St, Fifth Floor, Boston, MA 02110, USA 
//
////////////////////////////////////////////////////////////////////////////////


#ifndef _SYS_68HC05B6_H_
#define _SYS_68HC05B6_H_


// Ports
#define PORTA                      0x00 // Port A data register
#define PORTB                      0x01 // Port B data register
#define PORTC                      0x02 // Port C data register
#define PORTD                      0x03 // Port D input data register
#define DDRA                       0x04 // Port A data direction register
#define DDRB                       0x05 // Port B data direction register
#define DDRC                       0x06 // Port C data direction register

// EEPROM
#define EECR                       0x07 // EEPROM/ECLK control register
#define ECLK                 0b00001000 // External clock output bit
#define E1ERA                0b00000100 // EEPROM erase/programming bit
#define E1LAT                0b00000010 // EEPROM programming latch enable bit
#define E1PGM                0b00000001 // EEPROM charge pump enable/disable

// Analogports
#define ADDATA                     0x08 // A/D data register
#define ADSTAT                     0x09 // A/D status/control register
#define COCO                 0b10000000 // Conversion complete flag
#define ADRC                 0b01000000 // A/D RC oscillator control
#define ADON                 0b00100000 // A/D converter on
#define CH3                  0b00001000 // A/D channel 3
#define CH2                  0b00000100 // A/D channel 2
#define CH1                  0b00000010 // A/D channel 1
#define CH0                  0b00000001 // A/D channel 0

// PWM
#define PLMA                       0x0a // Pulse length modulation A
#define PLMB                       0x0b // Pulse length modulation B
#define MISC                       0x0c // Miscellaneous register
#define POR                  0b10000000 // Power-on reset bit
#define INTP                 0b01000000 // External interrupt senstivity options - Positive edge
#define INTN                 0b00100000 // External interrupt senstivity options - Negative edge
#define INTE                 0b00010000 // External interrupt enable
#define SFA                  0b00001000 // Slow or fast mode selection for PLMA
#define SFB                  0b00000100 // Slow or fast mode selection for PLMB
#define SM                   0b00000010 // Slow mode
#define WDOG                 0b00000001 // Watchdog enable/disable

// SCI
#define BAUD                       0x0d // SCI baud rate register
#define SCP1                 0b10000000 // Serial prescaler select bits
#define SCP0                 0b01000000 // "
#define SCT2                 0b00100000 // SCI rate select bits (transmitter)
#define SCT1                 0b00010000 // "
#define SCT0                 0b00001000 // "
#define SCR2                 0b00000100 // SCI rate select bits (reciever)
#define SCR1                 0b00000010 // "
#define SCR0                 0b00000001 // "
#define SCCR1                      0x0e // SCI control register 1
#define R8                   0b10000000 // Recieve data bit 8
#define T8                   0b01000000 // Transmit data bit 8
#define M                    0b00010000 // Mode (select character format)
#define WAKE                 0b00001000 // Wake-up mode select
#define CPOL                 0b00000100 // Clock polarity
#define CPHA                 0b00000010 // Clock phase
#define LBCL                 0b00000001 // Last bit clock
#define SCCR2                      0x0f // SCI control register 2
#define TIE                  0b10000000 // Transmit interrupt enable
#define TCIE                 0b01000000 // Transmit complete interrupt enable
#define RIE                  0b00100000 // Reciever interrupt enable
#define ILIE                 0b00010000 // Idle line interrupt enable
#define TE                   0b00001000 // Transmitter enable
#define RE                   0b00000100 // Reciever enable
#define RWU                  0b00000010 // Reciever wake-up
#define SBK                  0b00000001 // Send break
#define SCSR                       0x10 // SCI status register
#define TDRE                 0b10000000 // Transmit data register empty flag
#define TC                   0b01000000 // Transmit complete flag
#define RDRF                 0b00100000 // Recieve data register full flag
#define IDLE                 0b00010000 // Idle line detected flag
#define OR                   0b00001000 // Overrun error flag
#define NF                   0b00000100 // Noise error flag
#define FE                   0b00000010 // Framing error flag
#define SCDAT                      0x11 // SCI data register

// Timer
#define TCR                        0x12 // Timer control register
#define ICIE                 0b10000000 // Input captures interrupt enable
#define OCIE                 0b01000000 // Output compares interrupt enable
#define TOIE                 0b00100000 // Timer overflow interrupt enable
#define FOLV2                0b00010000 // Force output compare 2
#define FOLV1                0b00001000 // Force output compare 1
#define OLV2                 0b00000100 // Output level 2
#define IEDG1                0b00000010 // Input edge 1
#define OLV1                 0b00000001 // Output level 1
#define TSR                        0x13 // Timer status register
#define ICF1                 0b10000000 // Input capture flag 1
#define OCF1                 0b01000000 // Output compare flag 1
#define TOF                  0b00100000 // Timer overflow status flag
#define ICF2                 0b00010000 // Input capture flag 2
#define OCF2                 0b00001000 // Output compare flag 2
#define ICR1H                      0x14 // Capture high register 1
#define ICR1L                      0x15 // Capture low register 1
#define OCR1H                      0x16 // Compare high register 1
#define OCR1L                      0x17 // Compare low register 1
#define TCH                        0x18 // Counter high register
#define TCL                        0x19 // Counter low register
#define ATCH                       0x1a // Alternate counter high register
#define ATCL                       0x1b // Alternate counter low register
#define ICR2H                      0x1c // Capture high register 2
#define ICR2L                      0x1d // Capture low register 2
#define OCR2H                      0x1e // Compare high register 2
#define OCR2L                      0x1f // Compare low register 2

// Options register
#define OPTR                     0x0100 // Options register
#define EE1P                 0b00000010 // EEPROM protect bit
#define SEC                  0b00000001 // Security bit


#endif
