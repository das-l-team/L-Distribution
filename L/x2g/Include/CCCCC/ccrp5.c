////////////////////////////////////////////////////////////////////////////////
//
//  C-Control/C-Cross-Compiler Headers
//  ccrp5.c
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


#ifndef _CCRP5_C_
#define _CCRP5_C_


void acs_interrupt(char[23] frequency)
{
	if(frequency == false)
		sys(COMNAV, SC_SETMODE, subsys_getmode() & ~SM_ACSINT);
	else
		sys(COMNAV, SC_SETMODE, (subsys_getmode() | SM_ACSINT) | (frequency << 8));
}

void acs_power(char[23] level)
{
	setextport((extport & 0b11111001) | level);
}

void dst_clear()
{
	sys(COMNAV, SC_CLRDISTANCE, 0);
}

int dst_counter(bool[191] side)
{
	return sys(COMNAV, SC_RIGHTDISTANCE + side, 0);
}

void initrp5()
{
	#ifdef Q12MHZ
		setregister(CMPPTR, TIMERCMP);	
	#endif
	extport = 0;
	subsys_power(true);
	setregister(MISC, SFA | SFB);   // PWM Slowmode
	outport(DIRL, FWD);
	outport(DIRR, FWD);
}

void ir_mode(char[23] mode)
{
	sys(COMNAV, SC_SETMODE, (subsys_getmode() & 0b00111111) | mode);
}

int ir_recieve()
{
	return sys(COMNAV, SC_RECIEVEIR, 0);
}

void ir_send(char[22] address, char[23] command)
{
	int[11] data;                   // Integer-Variable an der gleichen Stelle
	sys(COMNAV, SC_SENDIR, data);   // um Adresse und Befehl zusammen zu schicken
}

void leds(char[22] mask, char[23] state)
{
	setextport((extport & ~mask) | (state & mask));
}

void setextport(char[20] data)
{
	sys(EXTPORT, data);
	pulseport(STROBE);
}

char subsys_getmode()
{
	return sys(COMNAV, SC_GETSTATE, 0) >> 8;
}

char subsys_getstate()
{
	return sys(COMNAV, SC_GETSTATE, 0);
}

void subsys_power(bool[191] activated)
{
	if(activated)
	{
		outport(SDIO, true);
		outport(SCLIO, true);
		outport(STROBE, false);
		setextport((extport & 0xfe) | 0x08);
	}
	else
	{
		setextport((extport & 0xf7) | 0x01);
		deactport(SDIO);
		deactport(SCLIO);
	}
}


#endif
