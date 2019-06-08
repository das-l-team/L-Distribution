
@echo off


copy L:\x2g\system\msg\ERR_CCUPLOAD.txt  L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT > NUL:
copy L:\x2g\system\msg\ERR_CCUPLOAD_BAX.txt  L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX > NUL:

L:\x2g\System\BAT\COPY.INF.bat

type L:\x2g\SYSTEM\MSG\INFO_INVOKING_CCTOKBAS.txt

echo C-Control Decompiler v3.11, registriert auf "12 Jahre C-Control intern" - (c) Dietmar Harlos ADPC 2004/08/20

type L:\x2g\SYSTEM\MSG\INFO_THIS_MAY_TAKE_A_WHILE.txt

L:
 cd L:\x2g\3rdparty\ccupload
 cctokbas.exe "%1" %5
 echo .
type L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX

rem L:\x2g\3rdparty\dosbox\dosbox.exe -conf "L:\x2g\system\bat\dosbox_L.conf" -c "@cd L:\x2g\3rdparty\ccupload\" -c "@L:\x2g\3rdparty\ccupload\ccupload.exe %1" -c "@L:\x2g\3rdparty\cctokbas\cctokbas.exe L:\x2g\3rdparty\ccupload\ccupload.DAT" -c "@echo ON" -c "@echo [ TASTE ]" -c "@pause > NUL:" -c exit

rem L:\x2g\3rdparty\dosbox\dosbox.exe -conf "L:\x2g\SYSTEM\BAT\dosbox_ccupload.conf" -c "@cd L:\x2g\3rdparty\ccupload\" -c "L:\x2g\SYSTEM\BAT\DBccupld.bat %1 %2" -c "EXIT"


type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
type L:\x2g\system\msg\HINT_SAVE_FILES_IF_CHANGED.txt