////////////////////////////////////////////////////////////////////////////////
//
//  C-Control/C-Cross-Compiler Headers
//  asm/p5driv.h
//
//  Copyright (C) 2005, 2006  Oliver Haag
//
//  This file is part of the C-Control/C-Cross-Compiler.
//
//  The C-Control/C-Cross-Compiler is free software; you can redistribute it
//  and/or modify it under the terms of the GNU General Public License as
//  published by the Free Software Foundation; either version 2 of the License,
//  or (at your option) any later version.
//
//  The C-Control/C-Cross-Compiler is distributed in the hope that it will be
//  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
//  Public License or the file COPYING for more details.
//
//  You should have received a copy of the GNU General Public License along with
//  this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin St, Fifth Floor, Boston, MA 02110, USA 
//
////////////////////////////////////////////////////////////////////////////////


#ifndef _ASM_P5DRIV_H_
#define _ASM_P5DRIV_H_


// Systemroutinen
#define PLM_SLOW                 0x01c4 // PLM auf langsam stellen
#define SYSTEM                   0x01c9 // Extport ausgeben
#define COMNAV                   0x0154 // COM/NAV-Subsystem Anfrage schicken
// Erweiterte Systemroutinen
#define REVR                     0x0101 // Antrieb Rechts rückwärts
#define REVL                     0x0106 // Antrieb Links rückwärts
#define FWDR                     0x010b // Antrieb Rechts vorwärts
#define FWDL                     0x0110 // Antrieb Links vorwärts
#define ROTR                     0x0115 // Rechts drehen
#define ROTL                     0x0119 // Links drehen
#define REV                      0x011d // Rückwärts
#define FWD                      0x0121 // Vorwärts
#define COMNAV_STATUS            0x0125 // Aktualisiert alle Flags im Status-Register
#define ACS_LO                   0x01e1 // ACS Power niedrig
#define ACS_HI                   0x01e9 // ACS Power hoch
#define ACS_MAX                  0x01f1 // ACS Power maximal
#define SEND_TLM                 0x014a // Sendet Telemetrie (Channel=hByte,Daten=lByte)
#define SEND_SPEEDR              0x0134 // Sendet Tlm Kanal 8, PWM Rechts
#define SEND_SPEEDL              0x013a // Sendet Tlm Kanal 7, PWM Links
#define SEND_SYSSTAT             0x0144 // Sendet Tlm Kanal 0, Systemstatus (Flags für ACS, Fwd/Rev, ACS LO/HI/MAX)


#endif
