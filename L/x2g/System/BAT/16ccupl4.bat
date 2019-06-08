
@echo off

rem update 0.26:

call L:\x2g\System\BAT\TTY_STOP.bat




copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:

copy "L:\x2g\system\msg\ERR_CCUPLOAD.txt"      "L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT" > NUL:
rem copy "L:\x2g\system\msg\ERR_CCUPLOAD.txt"      "L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP" > NUL:
copy "L:\x2g\system\msg\ERR_CCUPLOAD_BAX.txt"  "L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX" > NUL:

type "L:\x2g\SYSTEM\MSG\INFO_INVOKING_CCUPLOAD.txt"

echo C-Control Upload Tool for Win32 v1.0 - (c) Dietmar Harlos ADPC 2004/08/20
echo C-Control Decompiler v3.11, registriert auf "12 Jahre C-Control intern" - (c) Dietmar Harlos ADPC 2004/08/20

type "L:\x2g\SYSTEM\MSG\INFO_THIS_MAY_TAKE_A_WHILE.txt"

@copy L:\x2g\3rdparty\ccupload\*.L L:\x2g > NUL:

@L:
@cd L:\x2g\3rdparty\ccupload\

echo [ 1/3 ]  C-Control Upload Tool for Win32 v1.0 - (c) Dietmar Harlos ADPC 2004/08/20
ccuplwin.exe 4
copy "L:\x2g\system\msg\ERR_CCUPLOAD.txt"      "L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP" > NUL:
rem ::IF ERRORLEVEL  < 2 GOTO ERR_MSG
echo [ 2/3 ]  C-Control/Token-Disassembler V1.0 OM - (c) Dietmar Harlos 5. August 2005
cctokdis.exe L:\x2g\3rdparty\ccupload\ccupload.dat > CCUPLOAD.MAP
echo [ 3/3 ]  C-Control Decompiler v3.11, registriert auf "12 Jahre C-Control intern" - (c) Dietmar Harlos ADPC 2004/08/20
cctokbas.exe L:\x2g\3rdparty\ccupload\ccupload.dat

type "L:\x2g\system\msg\HINT_SAVE_FILES_IF_CHANGED.txt"
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX
rem echo L:\x2g\3rdparty\ccupload\CCTOKBAS.BIN
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L



