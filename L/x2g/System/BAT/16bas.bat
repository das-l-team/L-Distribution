:: *** COMMUNITY *** 'ERRORLEVEL' seems not possible with either ccbas.exe or ccbaspar.exe  *** ANY ideas? ***


@echo off
type L:\x2g\system\msg\INFO_invoking_CCBAS24+.txt

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:


::copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
::copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:

L:\x2g\System\BAT\COPY.INF.bat

copy L:\x2g\3rdparty\


L:\x2g\3rdparty\ccbas24+\ccbas.exe %1 > L:\x2g\out.txt"

IF ERRORLEVEL -1 GOTO Err_Msg
type L:\x2g\out.txt
del L:\x2g\out.txt

echo OK
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo %4%3.TMP
echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L

EXIT

:Err_Msg
type L:\x2g\out.txt

type L:\x2g\SYSTEM\MSG\ERR_compiler_all_CONSOLE.txt
del L:\x2g\out.txt

type "L:\x2g\system\msg\HINT_CONSIDER_EXTENDED_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"

