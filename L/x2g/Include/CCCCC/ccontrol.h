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


#ifndef _SYS_CCONTROL_H_
#define _SYS_CCONTROL_H_


// Interrupt-Pointer
#define IRQPTR                     0x50 // Userpointer für IRQ-Interrupt
#define CAPPTR                     0x51 // Userpointer für TIMERCAP-Interrupt
#define CMPPTR                     0x52 // Userpointer für TIMERCMP-Interrupt
#define OFLPTR                     0x53 // Userpointer für TIMEROFL-Interrupt

// C-Control Statusregister
#define CCSTAT                     0x7b // Allgemeines C-Control Statusregister
#define DCF77OK              0b00000001
#define TIMESET              0b00010000
#define SLOWMODE             0b00100000
#define TOKENIRQ             0b01000000
#define HANDSHAKE            0b10000000


#endif
