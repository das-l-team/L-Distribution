@echo off
type L:\x2g\system\msg\INFO_INVOKING_CCCCC.txt
echo .
copy L:\x2g\3rdparty\ccccc\*.L L:\x2g > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
rem oben sorry - Konsolenausgabe geht nach null wegen Umlautproblematik und redundanter Dateinamenanzeige
L:\X2G\3rdparty\CCCCC\$_L-WORK.DIR\ccccc.exe %1 -l -i"L:/x2g/Include/CCCCC/" > NUL:

IF ERRORLEVEL 1 GOTO Err_Msg
REM 0 ist ok 1 ist Fehler
type %4%3.LOG
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.LOG
echo %4%3.DAT
echo %4%3.C5
type L:\x2g\System\MSG\INFO_CONSOLE_CCCCC_RUN.txt

REM In ReactOS (tested up until build 67001-rel) THERE IS A BUG PREVENTING THE FOLLOWING
REM 3 LINES TO DISPLAY CORRECTLY. Hence, intended message is displayed from separate .TXT file. Helps with localization also
REM echo L:\x2g\Info.L
REM echo L:\x2g\Hilfe.L
REM echo L:\x2g\3rdparty\CCCCC\COPYING

exit

:Err_Msg
rem echo errorlevel = %errorlevel%
L:\X2G\3rdparty\CCCCC\$_L-WORK.DIR\ccccc.exe  %1 -l -i"L:/x2g/INCLUDE/CCCCC/"
rem oben - sorry nochmal kompilieren um ggfs. doch noch Fehlerzeile in die Ausgabekonsole zu bekommen
type L:\x2g\SYSTEM\MSG\HINT_CCCCC_ERRLINE.txt
echo %4%3.LOG
echo %4%3.C5
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
