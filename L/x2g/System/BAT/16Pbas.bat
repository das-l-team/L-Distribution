@echo off

REM ( ERRORLEVEL seems not working with either CCBAS.EXE or CCBASPAR.exe -->  ANY ideas? )

type "L:\x2g\system\msg\INFO_invoking_CCBASPAR.txt"

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:

copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\CCBASPAR\*.L L:\x2g > NUL:


L:\x2g\3rdparty\ccbaspar\ccbaspar.exe %1 > L:\x2g\out.txt


::IF NOT ERRORLEVEL 0 GOTO Err_Msg
type L:\x2g\out.txt
del L:\x2g\out.txt
copy %4%3.MAP %4%3.VAR > NUL:

type "L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"

echo %4%3.TMP
echo %4%3.VAR
echo %4%3.DAT
echo %4%3.BAS
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
EXIT

:Err_Msg
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_compiler_all_CONSOLE.txt
del L:\x2g\out.txt

type "L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"

