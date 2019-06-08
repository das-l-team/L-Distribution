
@echo off

:: Following maps whatever input file's source directory is to 'W:' while in this DOSBox instance
:: Although this seems functional under DOSBox 0.73 - no testing has yet been done under other DOSBox versions

mount w: %4  > NUL:

L:
cd L:\x2g\3rdparty\ccupload\
echo [1/3]
ccupload.exe %5
REM IF ERRORLEVEL  1 GOTO ERR_MSG
echo .
echo [2/3]
cctokdis.exe L:\x2g\3rdparty\ccupload\ccupload.dat > CCUPLOAD.MAP
REM IF ERRORLEVEL  1 GOTO ERR_MSG
echo .
echo [3/3]
cctokbas.exe L:\x2g\3rdparty\ccupload\ccupload.dat %6
REM IF ERRORLEVEL  1 GOTO ERR_MSG
echo .
exit

:ERR_MSG
echo MIST
pause
exit