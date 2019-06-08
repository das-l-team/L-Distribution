DeepXS
======
I2C memory device (RAM/EEPROM) support module for the C-Control system.

Copyright (C) 1999, 2000, 2001, 2002 Mark Haemmerling <mail@markh.de>.
Published under the terms of GNU General Public License.
See file COPYING.TXT for details.

Version: 2.0.0
Release date: 2002-07-13

List of distributed files
-------------------------
DXS_200.BAS - Basic module to be inserted into your project
DXS_200.S19 - Precompiled S19 Motorola code used by the Basic module
DXS_200.ASM - ASM sourcecode for recompilation
README.TXT  - This file
COPYING.TXT - A copy of the GNU General Public License

The files are originally distributed as DXS_200.ZIP.

Related Websites
----------------
http://markh.de/deepxs/    - DeepXS Updates Site
http://markh.de/c-control/ - General C-Control Software

What is DeepXS?
---------------
DeepXS is a module for accessing various RAM and EEPROM chips at your I2C bus. DeepXS allows
you to read and write to any supported memory device at any memory location using a simple
SYS command.

Supported devices
-----------------
DeepXS supports all RAM and EEPROM devices that are using the generic 8bit or 16bit memory
addressing. The addressable memory range is full 16bit (64kBytes), no matter if the
device uses paging. DeepXS transparently selects the pages using the most significant
memory address bits. Devices overview for version 2.0.0:

Type   Manufacturer Device     Size      Supported Tested Organization     Device code
------ ------------ ---------- --------- --------- ------ ---------------- ----------------
EEPROM Atmel        AT24C128    16384 x8 yes       no     1d x 256p x  64B 10000000010100xx
EEPROM Atmel        AT24C256    32768 x8 yes       no     1d x 512p x  64B 10000000010100xx
EEPROM Atmel        AT24C512    65536 x8 yes       no     1d x 512p x 128B 10000000010100xx
EEPROM Atmel        AT24C1024  131072 x8 yes       no     1d x 512p x 256B 10000000010100xs
EEPROM Microchip    24C65        8192 x8 yes       yes    1d x   1p x  8kB 1000000001010xxx
EEPROM Microchip    24xx515     65536 x8 yes       yes    2d x   1p x 32kB 1100000001010pxx
EEPROM Philips      PCF8582C-2    256 x8 yes       no     1d x   1p x 256B 0000000001010xxx
EEPROM Philips      PCF8584C-2    512 x8 yes?      no!    2d x   1p x 256B 0100000001010pxx
EEPROM Philips      PCF8588C-2   1024 x8 yes?      no!    4d x   1p x 256B 0100000001010ppx
EEPROM ST           M24128      16384 x8 yes       no     1d x   1p x 16kB 1000000001010000
EEPROM ST           M24128-B    16384 x8 yes       no     1d x   1p x 16kB 1000000001010xxx
EEPROM ST           M24256      32768 x8 yes       no     1d x   1p x 32kB 1000000001010000
EEPROM ST           M24256-B    32768 x8 yes       no     1d x   1p x 32kB 1000000001010xxx
EEPROM ST           M24512      65536 x8 yes       no     1d x   1p x 64kB 1000000001010xxx
------ ------------ ---------- --------- --------- ------ ---------------- ----------------
RAM    Philips      PCF8570       256 x8 yes       no     1d x   1p x 256B 0000000001010xxx
RAM    Philips      PCF8583       256 x8 yes       yes    1d x   1p x 256B 000000000101000x

The organization column:
This column displays how the memory is internally organized. "d" stands for device addresses,
"p" stands for pages (within each device address), and "B" resp. "kB" stand for bytes and
kilobytes.
Device addresses ("d") means that the memory pages are addressed using bits within the
device's I2C address, just like addressing multiple devices, which together offer the same
capacity. DeepXS offers to transparently translate 16bit memory addresses into a memory
address and device address, so that you don't have to care about pages.
Anyway, devices which have more memory than we can address within 16 bits, need to have
different device codes for manually addressing the pages (and therefore transmitting the
page address bit).

The device code column:
This column shows what device codes can be used. An "x" stands for a user selected address
bit, a "p" stands for a page select bit which is transparently set by DeepXS. Bits which
cannot be set by DeepXS (e.g. due to more than 16 bits for addressing the memory location)
are displayed as "s". Those devices must be accessed by manually addressing the specific
memory page, which means that you have to use more than one device code for one and the same
device. Of course you may use one constant and use a logical "OR" function when calling the
system routines.
Important: Bits displayed as "p" _must_ be set to zero in the device code passed to the
system routines. For performance reasons DeepXS does only _set_ bits, it does no resetting. It
therefore assumes that all bits which are supposed to be computed come in as zeros.

Note:
Using the Philips PCF8583 with A0 soldered to GND will cause an address conflict with the
onboard EEPROM. Due to this, you have to set A0 high, which unfortunately limits the number of
PCF8583's on the bus to a single one.

Please report test results, no matter if successful or not. Please tell me the device you
tested, if it works (please test the full memory range) and which version of DeepXS you used.
Thanks for your help!

Requirements
------------
- C-Control Unit Version 1.1 (Basic/Plus Unit, M-Unit)
- C-Control/BASIC IDE Version 1.33+
- 5 Basic code bytes
- 103 System code bytes
- no free RAM required

Installation
------------
At first, insert the distributed BAS file at the begin of your project, just before any other
command.
If your project already uses some system code, merge the distributed DXS_200.ASM file with your
project's .ASM file and reassemble. You should know how it works if you already use assembler
code. Don't forget to change the pointer constants in the Basic file. If you don't use assembler
already, then you don't have to care. Just use the pre-assembled, included .S19 file.

Before compiling your project, make sure that the assembled .S19 file resides in the same
directory as your project .BAS file.

How to use DeepXS
-----------------
To read a byte from a memory device, simply call:

  SYS DeepXS_R [I2C_DEVICECODE], [MEMORY_LOCATION]
  [VARIABLE] = DeepXS_Val

To write a byte to a memory device, call:

  SYS DeepXS_W [BYTE_DATA], [I2C_DEVICECODE], [MEMORY_LOCATION]

The placeholders are as follows:
[BYTE_DATA]       - 8bit of data to store into RAM or EEPROM of the memory device
[I2C_DEVICECODE]  - 16bit DeepXS device code (see note below and table for a list of supported
                    devices and their address and the note below)
[MEMORY_LOCATION] - 8bit or 16bit address of memory location to read from or to write to
[VARIABLE]        - a variable name (8bit) where to store the read data byte

The 16bit device code contains the memory addressing type, the I2C device address and some
reserved bits for future implementations (maybe 10bit device addressing). An explanation of
the DeepXS device code's bitfield can be found in DXS_200.BAS.

It's highly recommended to use constants to store the device codes. See the basic module for
some examples.

Examples
--------
For these examples, we assume that following constants are defined:

  Define External_RAM   &B0000000001010001 ' I2C: 1010001, 8bit mem. addressing
  Define Onboard_EEPROM &B1000000001010000 ' I2C: 1010000, 16bit mem. addressing

To write the value &HCD into memory location &H02F8 of the onboard EEPROM, call:

  SYS DeepXS_W &HCD, Onboard_EEPROM, &H02F8

To read the byte at memory location &H010C of the onboard EEPROM and store it in the variable
'Result', call:

  SYS DeepXS_R Onboard_EEPROM, &H010C
  Result = DeepXS_Val

The information what kind of addressing the device needs is stored within the 16bit device code.

To write the value &HB1 into memory location &H10 of the external RAM, call:

  SYS DeepXS_W &HB1, External_RAM, &H10

To read the byte at memory location &H2F of the external RAM and store it in the variable
'Result', call:

  SYS DeepXS_R External_RAM, &H2F
  Result = DeepXS_Val

Important note:
Read operations ("SYS DeepXS_R") should always immediately be followed by fetching the data byte
from the operand stack (e.g. done by the Basic routine "DeepXS_Val") before it's getting
overwritten! You cannot include the result of "DeepXS_Val" into any arithmetic or logical
operation, because this would overwrite the operand stack. So please do always use the plain
form, e.g. one of:

  [Variable] = DeepXS_Val
  Print DeepXS_Val
  Put DeepXS_Val

If you still have questions, don't hesitate to contact me at <mail@markh.de>.

Thanks
------
Many thanks go to:

Bernhard Riedl <berni@ifen.bauv.unibw-muenchen.de>...
  ...for telling me that something was wrong with 1.0.0. In fact, this release had really
  stupid bugs. It was just not well tested. I fixed it immediately and released 1.1.0.

Philips Munich and Philips Hamburg...
  ...for providing me a free sample of the PCF8583 and making support for RAM devices possible.

Microchip Technology GmbH Munich, esp. Klaus Koschinsky <Klaus.Koschinsky@microchip.com>...
  ...for providing me two free samples of the 24LC515 serial EEPROM and making support for
  16bit paging possible.

Your opinion
------------
If you have questions, ideas, comments or bug reports, or if you want to contribute, please
contact me at <mail@markh.de>. Thanks.

Mark Haemmerling
