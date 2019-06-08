:: THIS FILE TO BE EXECUTED INSIDE DOSBox EMULATOR


REM ( ERRORLEVEL seems not working with either CCBAS.EXE or CCBASPAR.exe -->  ANY ideas? )



@echo off

:: Following maps whatever input file's source directory is to 'W:' while in this DOSBox instance
:: Although this works fine under DOSBox 0.73 - no testing has been done so far under other DOSBox versions

mount W: %4  > NUL:

::L:

cd L:\x2g\3rdparty\ToolsMot\68HC705B\

L:\x2g\3rdparty\ToolsMot\68HC705B\pgmr5.exe %1 warning.txt

