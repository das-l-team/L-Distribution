',------------------------------------------------------------------------,
'| DeepXS - I2C memory device (RAM/EEPROM) support module for the         |
'|          C-Control/BASIC System                                        |
'| Copyright (C) 1999, 2000, 2001, 2002  Mark Haemmerling <mail@markh.de> |
'|                                                                        |
'| This program is free software; you can redistribute it and/or modify   |
'| it under the terms of the GNU General Public License as published by   |
'| the Free Software Foundation; either version 2 of the License, or      |
'| (at your option) any later version.                                    |
'|                                                                        |
'| This program is distributed in the hope that it will be useful,        |
'| but WITHOUT ANY WARRANTY; without even the implied warranty of         |
'| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          |
'| GNU General Public License for more details.                           |
'|                                                                        |
'| You should have received a copy of the GNU General Public License      |
'| along with this program; if not, write to the Free Software            |
'| Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.              |
'|                                                                        |
''------------------------------------------------------------------------'

' Version: 2.0.0
' Release date: 2002-07-13

' See http://markh.de/deepxs/ for updates.
' Requires DXS_200.S19 and CC-Basic 1.33+.

' Please insert this module at the begin of your source.

DeepXS_EndOfModule ' Jump to the end of this module

' Adjust subroutine addresses if necessary (if there are
' any other ASM routines before DeepXS):
Define DeepXS_W &H0101 'Write routine address
Define DeepXS_R &H010D 'Read routine address

#DeepXS_Val
' Returns content of operand stack (used to get previously read data)
Return

' Some predefined device codes: (feel free to add some or remove unused ones)

' EEPROM devices:
' - Atmel AT24C128 (16k x8) at 10100xx, using 16bit EEPROM addressing:
Define E_AT24C128_0      &B1000000001010000 ' A1..A0: 00 (onboard EEPROM addr.!)
Define E_AT24C128_1      &B1000000001010001 ' A1..A0: 01
Define E_AT24C128_2      &B1000000001010010 ' A1..A0: 10
Define E_AT24C128_3      &B1000000001010011 ' A1..A0: 11

' - Atmel AT24C256 (32k x8) at 10100xx, using 16bit EEPROM addressing:
Define E_AT24C256_0      &B1000000001010000 ' A1..A0: 00 (onboard EEPROM addr.!)
Define E_AT24C256_1      &B1000000001010001 ' A1..A0: 01
Define E_AT24C256_2      &B1000000001010010 ' A1..A0: 10
Define E_AT24C256_3      &B1000000001010011 ' A1..A0: 11

' - Atmel AT24C512 (64k x8) at 10100xx, using 16bit EEPROM addressing:
Define E_AT24C512_0      &B1000000001010000 ' A1..A0: 00 (onboard EEPROM addr.!)
Define E_AT24C512_1      &B1000000001010001 ' A1..A0: 01
Define E_AT24C512_2      &B1000000001010010 ' A1..A0: 10
Define E_AT24C512_3      &B1000000001010011 ' A1..A0: 11

' - Atmel AT24C1024 (128k x8) at 10100xx, using 16bit EEPROM addressing,
'   pages must be selected as different devices (17bit memory addressing):
Define E_AT24C1024_0_P0  &B1000000001010000 ' A1: 0 (onboard EEPROM addr.!)
Define E_AT24C1024_0_P1  &B1000000001010001 ' A1: 0
Define E_AT24C1024_1_P0  &B1000000001010010 ' A1: 1
Define E_AT24C1024_1_P1  &B1000000001010011 ' A1: 1

' - Microchip 24C65 (8k x8) at 1010xxx, using 16bit EEPROM addressing:
Define E_24C65_0         &B1000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define E_24C65_1         &B1000000001010001 ' A2..A0: 001
Define E_24C65_2         &B1000000001010010 ' A2..A0: 010
Define E_24C65_3         &B1000000001010011 ' A2..A0: 011
Define E_24C65_4         &B1000000001010100 ' A2..A0: 100
Define E_24C65_5         &B1000000001010101 ' A2..A0: 101
Define E_24C65_6         &B1000000001010110 ' A2..A0: 110
Define E_24C65_7         &B1000000001010111 ' A2..A0: 111

' - Microchip 24xx515 (64k x8) at 1010xxx, using 16bit EEPROM addressing,
'   including 1bit page selection:
Define E_24xx515_0       &B1100000001010000 ' A1..A0: 00 (onboard EEPROM addr.!)
Define E_24xx515_1       &B1100000001010001 ' A1..A0: 01
Define E_24xx515_2       &B1100000001010010 ' A1..A0: 10
Define E_24xx515_3       &B1100000001010011 ' A1..A0: 11

' - Philips PCF8582C-2 (256 x8) at 1010xxx, using 8bit EEPROM addressing:
Define E_PCF8582C2_0     &B0000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define E_PCF8582C2_1     &B0000000001010001 ' A2..A0: 001
Define E_PCF8582C2_2     &B0000000001010010 ' A2..A0: 010
Define E_PCF8582C2_3     &B0000000001010011 ' A2..A0: 011
Define E_PCF8582C2_4     &B0000000001010100 ' A2..A0: 100
Define E_PCF8582C2_5     &B0000000001010101 ' A2..A0: 101
Define E_PCF8582C2_6     &B0000000001010110 ' A2..A0: 110
Define E_PCF8582C2_7     &B0000000001010111 ' A2..A0: 111

' - Philips PCF8584C-2 (512 x8) at 10100xx, using 8bit EEPROM addressing,
'   plus 1bit page selection:
Define E_PCF8584C2_0     &B0100000001010000 ' A1..A0: 00 (onboard EEPROM addr.!)
Define E_PCF8584C2_1     &B0100000001010001 ' A1..A0: 01
Define E_PCF8584C2_2     &B0100000001010010 ' A1..A0: 10
Define E_PCF8584C2_3     &B0100000001010011 ' A1..A0: 11

' - Philips PCF8588C-2 (1k x8) at 101000x, using 8bit EEPROM addressing,
'   plus 2bit page selection:
Define E_PCF8588C2_0     &B0100000001010000 ' A0: 0 (onboard EEPROM addr.!)
Define E_PCF8588C2_1     &B0100000001010001 ' A0: 1

' - ST M24128(-B) (16k x8) at 1010xxx, using 16bit EEPROM addressing:
'   (for the standard M24128 w/o chip enable lines, use E_M24128)
Define E_M24128          &B1000000001010000 ' (onboard EEPROM addr.!)
Define E_M24128_0        &B1000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define E_M24128_1        &B1000000001010001 ' A2..A0: 001
Define E_M24128_2        &B1000000001010010 ' A2..A0: 010
Define E_M24128_3        &B1000000001010011 ' A2..A0: 011
Define E_M24128_4        &B1000000001010100 ' A2..A0: 100
Define E_M24128_5        &B1000000001010101 ' A2..A0: 101
Define E_M24128_6        &B1000000001010110 ' A2..A0: 110
Define E_M24128_7        &B1000000001010111 ' A2..A0: 111

' - ST M24256(-B) (32k x8) at 1010xxx, using 16bit EEPROM addressing:
'   (for the standard M24256 w/o chip enable lines, use E_M24256)
Define E_M24256          &B1000000001010000 ' (onboard EEPROM addr.!)
Define E_M24256_0        &B1000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define E_M24256_1        &B1000000001010001 ' A2..A0: 001
Define E_M24256_2        &B1000000001010010 ' A2..A0: 010
Define E_M24256_3        &B1000000001010011 ' A2..A0: 011
Define E_M24256_4        &B1000000001010100 ' A2..A0: 100
Define E_M24256_5        &B1000000001010101 ' A2..A0: 101
Define E_M24256_6        &B1000000001010110 ' A2..A0: 110
Define E_M24256_7        &B1000000001010111 ' A2..A0: 111

' - ST M24512 (64k x8) at 1010xxx, using 16bit EEPROM addressing:
Define E_M24512_0        &B1000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define E_M24512_1        &B1000000001010001 ' A2..A0: 001
Define E_M24512_2        &B1000000001010010 ' A2..A0: 010
Define E_M24512_3        &B1000000001010011 ' A2..A0: 011
Define E_M24512_4        &B1000000001010100 ' A2..A0: 100
Define E_M24512_5        &B1000000001010101 ' A2..A0: 101
Define E_M24512_6        &B1000000001010110 ' A2..A0: 110
Define E_M24512_7        &B1000000001010111 ' A2..A0: 111

' RAM devices:
' - Philips PCF8570 (256 x8) at 1010xxx, using 8bit RAM addressing:
Define R_PCF8570_0       &B0000000001010000 ' A2..A0: 000 (onboard EEPROM addr.!)
Define R_PCF8570_1       &B0000000001010001 ' A2..A0: 001
Define R_PCF8570_2       &B0000000001010010 ' A2..A0: 010
Define R_PCF8570_3       &B0000000001010011 ' A2..A0: 011
Define R_PCF8570_4       &B0000000001010100 ' A2..A0: 100
Define R_PCF8570_5       &B0000000001010101 ' A2..A0: 101
Define R_PCF8570_6       &B0000000001010110 ' A2..A0: 110
Define R_PCF8570_7       &B0000000001010111 ' A2..A0: 111

' - Philips PCF8583 (256 x8) at 101000x, using 8bit RAM addressing:
Define R_PCF8583_0       &B0000000001010000 ' A0: 0 (onboard EEPROM addr.!)
Define R_PCF8583_1       &B0000000001010001 ' A0: 1

' Note: Philips EEPROMs still untested. Please mail me if you can test them.

' Device code bitfield explanation:

' Bit(s) Function
' ------ --------
' 15..14 00: use 8bit memory addressing w/o paging
'        01: use 8bit memory addressing w/ paging (copy mem. addr. bits 10..9 to
'            A1..A0), used by Philips EEPROMs
'        10: use 16bit memory addressing w/o paging
'        11: use 16bit memory addressing w/ paging (copy mem. addr. bit 15 to A2),
'            used by Microchip EEPROMs
' 13.. 7 reserved ("don't care" for now)
'  6.. 3 I2C device address group 1 (hardcoded part of device address)
'  2.. 0 I2C device address group 2 (partially or fully selectable by pins A2..A0)

' HINT:
' You should comment out the "SysCode" line once your MC68HC05 is programmed with
' the DeepXS 2.0.0 system code. The internal EEPROM of the controller allows only
' about 10.000 programming cycles. Reprogramming is only needed when the system
' code has changed, i.e., if the .asm source file has been reassembled.
' Leaving the internal controller EEPROM untouched will also save you alot of time!

SysCode "DXS_200.S19"
#DeepXS_EndOfModule

',------------------------------------------------------------------------,
'|   DeepXS - End of module - Place your program below...                 |
''------------------------------------------------------------------------'
