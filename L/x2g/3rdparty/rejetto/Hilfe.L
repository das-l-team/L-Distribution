Please DO NOT delete or move "pss.exe" (25600 Bytes, CRC32: eaa3b9ec) from folder L:\x2g\3rdparty\rejetto\pss\


Starting with version 0.26, |_ Distribution toolchain utilizes pss.exe utilitiy
as alternative to the standard "taskkill.exe" or "tskill.exe" windows utilities.

In case the standard windows utilities cannot be found inside their standard
installation path %windir%\system32\, pss.exe will be called to close the temial emulator
and free the associated COM port prior upload of a new program into the microcontroller.

This serves as a fall-back mechanism and is invoked by the |_ toolchain using the batch
files SBMU_A1.BAT through SBMU_B4.bat. These can be found inside the L:\x2g\System\BAT\
directory. (e.g.: L:\x2g\System\BAT\SBMU_A1.BAT )

"pss.exe" may also be used to terminate unresponsive programs or tasks on the earlier
branches of windows-compatible operating systems, such as 95,98,Me, where Microsofts
taskkill.exe and tskill.exe utilities may not be supported.

For more information on the pss.exe tool, please have a look at the file archive
provided in this directory. Please also consider to have a look at the author's website:

 www.rejetto.com