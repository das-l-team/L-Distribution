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


#ifndef _SYS_BAUD_H_
#define _SYS_BAUD_H_


#ifdef Q12MHZ
	#define B7200        0b11010010
	#define B14400       0b11001001
	#define B28800       0b11000000
#else
	#define B75          0b11111111
	#define B150         0b11110110
	#define B300         0b11101101
	#define B600         0b11100100
	#define B1200        0b11011011
	#define B2400        0b11010010
	#define B4800        0b11001001
	#define B9600        0b11000000
#endif


#endif
