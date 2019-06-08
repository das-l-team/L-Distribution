rem
@echo off
type L:\x2g\system\msg\INFO_invoking_FreeBASIC_COMPILER.txt

copy L:\x2g\3rdparty\FreeBASIC\*.L L:\x2g\Info.L
copy L:\x2g\3rdparty\FreeBASIC\*.L L:\x2g\Hilfe.L

rem copy /b L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt "%4%3.MAP"  > NUL:
GOTO success


:Err_Msg
type L:\x2g\SYSTEM\MSG\ERR_invoking_FreeBASIC_COMPILER.txt
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


exit

:success
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.exe
echo %4%3.DAT

copy %1 %4%3.exe

L:\x2g\3rdparty\FreeBASIC\fbc.exe -s console -v -b %4%3.exe

start %4%3.exe

IF NOT ERRORLEVEL 1 GOTO skip


:skip
echo %1.exe
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


exit

