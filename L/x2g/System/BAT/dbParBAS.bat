@REM  THIS FILE TO EXECUTE FROM INSIDE DOSBOX EMULATOR
@REM ERRORLEVEL seems not working with either CCBAS.EXE or CCBASPAR.exe


@type L:\x2g\System\MSG\dbPbas.txt
@echo off

REM This script maps the input file's source directory to 'W:' only while in this DOSBox instance
REM Although this seems functional under DOSBox 0.73 - no testing has yet been done under different DOSBox versions

@mount w: %4  > NUL:

@L:\x2g\3rdparty\ccbaspar\ccbaspar.exe w:\%2 > L:\x2g\out.txt
@copy w:\%3.MAP w:\%3.VAR > NUL:
@REM change v.0.21 to v.0.22 L:\x2g\3rdparty\ccupload\cctokdis.exe w:\%3.DAT > w:\%3.MAP



@IF NOT ERRORLEVEL 0 GOTO Err_Msg
@type L:\x2g\out.txt
@REM  echo *** COMMUNITY *** 'ERRORLEVEL' seems not possible with either ccbas.exe or ccbaspar.exe  *** ANY IDEAS? ***
echo.
type "L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo %4%3.TMP
echo %4%3.MAP
echo %4%3.DAT
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
EXIT

:Err_Msg
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_compiler_all_CONSOLE.txt
type "L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt"
type "L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt"

exit