////////////////////////////////////////////////////////////////////////////////
//
//  C-Control/C-Cross-Compiler Headers
//  ccrp5.h
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


#ifndef _CCRP5_H_
#define _CCRP5_H_


#ifdef Q12MHZ
//	#include <asm/ccrp5q12.h>
//	#include <sys/ccontrol.h>
#else
//	#include <asm/ccrp5.h>
#endif
#include <sys/68hc05b6.h>


// Porterweiterung
#define SDIO                          0
#define SCLIO                         2
#define STROBE                        3

// COM/NAV-Subsystem
#define SUBSYSDATA                    0
#define SUBSYSCLK                     1

// COM/NAV-Subsystem Kommandos
#define SC_SENDIR                     0
#define SC_RECIEVEIR                  1
#define SC_SETMODE                    2
#define SC_CLRDISTANCE                3
#define SC_GETSTATE                   4
#define SC_DEVADDRESS                 5
#define SC_LEFTDISTANCE               6
#define SC_RIGHTDISTANCE              7
#define SC_PING                       8

// COM/NAV-Subsystem Modis
#define SM_IRPROTOCOL        0b00000001
#define SM_RC5               0b00000000
#define SM_REC80             0b00000001
#define SM_IRINT             0b00000010
#define SM_ACSINT            0b00000100
#define SM_ADDRMODE          0b00010000

// COM/NAV-Subsystem Status
#define SS_ACSL              0b00000001
#define SS_ACSR              0b00000010
#define SS_GOTIR             0b00000100

// Sensoren (AD-Ports)
#define SYSVOLTAGE                    2
#define SYSCURRENT                    0
#define CHARGECURRENT                 1
#define LIGHTL                        6
#define LIGHTR                        5
#define MICROPHONE                    3
#define TOUCH                         4

// Motoren
#define SPEEDL                        0
#define SPEEDR                        1
#define DIRL                          5
#define DIRR                          4
#define FWD                        true
#define REV                       false

// void acs_power(char[23] level)
#define ACSLO                0b00000100
#define ACSHI                0b00000010
#define ACSMAX               0b00000000

// int dst_counter(bool[191] side)
#define RIGHTDST                  false
#define LEFTDST                    true

// void ir_mode(char[23] mode)
#define RC5                        0b00
#define REC80                      0b01
#define IRINT                      0b10

// void leds(char[22] mask, char[23] state)
#define LED1                 0b00010000
#define LED2                 0b00100000
#define LED3                 0b01000000
#define LED4                 0b10000000
#define LEDX                 0b11110000


char[20] extport;                       // Wird von der ausführlichen LED-Ansteuerung benötigt

void acs_interrupt(char[23] frequency);
void acs_power(char[23] level);
void dst_clear();
int dst_counter(bool[191] side);
void initrp5();
void ir_mode(char[23] mode);
int ir_recieve();
void ir_send(char[22] address, char[23] command);
void leds(char[22] mask, char[23] state);
void setextport(char[20] data);         // Argument gleich in den Puffer schreiben
char subsys_getmode();
char subsys_getstate();
void subsys_power(bool[191] activated);


#include <ccrp5.c>


#endif
