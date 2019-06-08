@echo off
REM THIS FILE ONLY TO BE installed on old Win95 and Win98 systems

type L:\x2g\system\msg\INFO_invoking_ocb_COMPILER.txt

copy L:\x2g\3rdparty\OCBASIC\*.L L:\x2g > NUL:

copy /b L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt "%4%3.MAP"  > NUL:
REM next line added for 0.29
copy /b L:\x2g\SYSTEM\MSG\ERR_compiler_DAT2TAB.txt "%4%3.TAB"  > NUL:

::copy %1 + L:\x2g\3rdparty\OCBASIC\$_L-WORK.DIR\URAMTAB.txt %4%3.compare
:: above line does not work
:: so using plan b instead

copy %1  %4%3.compare > nul:
type  L:\x2g\3rdparty\OCBASIC\$_L-WORK.DIR\URAMTAB.txt >> %4%3.compare



L:\X2G\3rdparty\OCBASIC\$_L-WORK.DIR\OCBASR32.EXE %1 %5

:: IF ERRORLEVEL GOTO Err_Msg  REM Run of OCBASR v.2.02 always returns ERRORLEVEL '0'.
:: echo %errorlevel%           REM It will however delete output file '%4%3.DAT' if the
                               REM compilation run has failed to complete.
                               REM Hence, indirect determination of compilation status is
                               REM done by checking for existence of '%4%3.DAT' (see next line)
IF EXIST "%4%3.DAT" GOTO success


:Err_Msg
type L:\x2g\SYSTEM\MSG\ERR_ocb_CONSOLE.txt
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


exit

:success

L:\x2g\3rdparty\DAT2TAB\$_L-WORK.DIR\DAT2TAB.exe %4%3.DAT > NUL:
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.MAP
echo %4%3.DAT
echo %4%3.TAB

REM since FCB is not working under Win98 Win95
fc /L /N %4%3.OCBasr %4%3.compare > nul:


IF NOT ERRORLEVEL 1 GOTO skip
echo %4%3.OCBasr
:: start /min L:\x2g\3rdparty\OCBASIC\HTMLINFO.bat removed in 0.29
:skip
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L

REM since FCB not working under Win98 Win95
fc /L /N %4%3.OCBasr %4%3.compare > nul:

IF ERRORLEVEL 1 GOTO skip2

del %4%3.ocbasr
:skip2
del %4%3.compare


exit

