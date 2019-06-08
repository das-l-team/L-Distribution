@echo off
type L:\x2g\system\msg\INFO_invoking_ocb_COMPILER.txt

copy L:\x2g\3rdparty\OCBASIC\*.L L:\x2g > NUL:

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt "%4%3.MAP"  > NUL:

L:\X2G\3rdparty\OCBASIC\$_L-WORK.DIR\OCBAS32.EXE %1 %5

:: IF ERRORLEVEL GOTO Err_Msg  REM OCBASIC v.1.11 will always return ERRORLEVEL '0'.
:: echo %errorlevel%           REM It will however delete former output file '%4%3.DAT'
                               REM if compilation of sourcecode failed to complete
                               REM Hence determination of compilation status is
                               REM done by checking for existence of '%4%3.DAT' (see next line)
IF EXIST "%4%3.DAT" GOTO success


:Err_Msg

type L:\x2g\SYSTEM\MSG\ERR_ocb_CONSOLE.txt
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


exit

:success
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


exit

