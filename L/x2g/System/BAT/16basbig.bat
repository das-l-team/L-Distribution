

@echo off
type L:\x2g\SYSTEM\MSG\INFO_invoking_CCBASBIG.txt

rem type "L:\x2g\system\msg\dpBasBIG.txt"

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MNE  /y > NUL:

copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\CCBASBIG\*.L L:\x2g  > NUL:

@cd L:\x2g\3rdparty\ccbasbig > NUL:
@L:\x2g\3rdparty\ccbasbig\ccbasbig.exe %1 
rem v0.22 > L:\x2g\out.txt
rem @cd L:\x2g\ > NUL:

::IF ERRORLEVEL 0 GOTO Err_Msg
rem type L:\x2g\out.txt
rem del L:\x2g\out.txt
:: err_msg workaround
rem v.022 L:\x2g\3rdparty\ccupload\cctokdis.exe L:\x2g\SYSTEM\MSG\ERR_COMPILER_ALL.DAT > %4%3.MNE
rem v.22 L:\x2g\3rdparty\ccupload\cctokdis.exe %4%3.DAT > %4%3.MNE

::echo OK

type "L:\x2g\system\msg\HINT_CONSIDER_EXTENDED_COMPILER_F9.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"

type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"

echo %4%3.DAT
echo %4%3.BAS
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L

EXIT

:Err_Msg
type L:\x2g\out.txt
echo .
echo *** COMMUNITY *** 'ERRORLEVEL' seems not working with either ccbas.exe or ccbaspar.exe  *** any hints on solution? ***

type L:\x2g\SYSTEM\MSG\ERR_compiler_all_CONSOLE.txt
type "L:\x2g\system\msg\HINT_CONSIDER_EXTENDED_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"

