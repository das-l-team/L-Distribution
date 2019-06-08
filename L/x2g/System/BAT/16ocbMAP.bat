@echo off



type L:\x2g\system\msg\INFO_invoking_CCTOKDIS_4_MAP.txt

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:


copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:

L:\x2g\System\BAT\COPY.INF.bat

L:\X2G\3rdparty\OCBASPAR\OCBASIC\ccbaspar.exe %1 %5 

L:\X2G\3rdparty\OCBASIC\$_L-WORK.DIR\OCBAS32.EXE %1 %5
L:\x2g\3rdparty\ccupload\cctokdis.exe %4%3.DAT > %4%3.MAP

type L:\x2g\out.txt
del L:\x2g\out.txt
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
type L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt

