
@echo off



call L:\x2g\System\BAT\TTY_STOP.bat

copy L:\x2g\system\msg\Hilfe.L         L:\X2G\Hilfe.L > NUL:
copy L:\x2g\system\msg\ERR_CCUPLOAD.txt  L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT > NUL:
copy L:\x2g\system\msg\ERR_CCUPLOAD_BAX.txt  L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX > NUL:
copy L:\x2g\system\msg\ERR_CCUPLOAD_MNE.txt  L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP > NUL:

copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\CCUPLOAD\*.L L:\x2g > NUL:



type L:\x2g\SYSTEM\MSG\INFO_INVOKING_DOSBOX.txt

type L:\x2g\SYSTEM\MSG\INFO_INVOKING_CCUPLOAD.txt

::echo.C-Control Upload Tool v1.0 - (c) Dietmar Harlos ADPC 2003/02/13
::echo.C-Control Decompiler v3.11, registriert auf "12 Jahre C-Control intern" - (c) Dietmar Harlos ADPC 2004/08/20

type L:\x2g\SYSTEM\MSG\INFO_THIS_MAY_TAKE_A_WHILE.txt


L:\x2g\3rdparty\dosbox\dosbox.exe -noconsole -conf "L:\x2g\SYSTEM\BAT\dosbox_L.conf" -c "@cd L:\x2g\3rdparty\ccupload\" -c "@L:\x2g\SYSTEM\BAT\DBccupld.bat %1 %2 %3 %4 1 %6 %7"


@copy L:\x2g\3rdparty\ccupload\CCTOKBAS.BIN L:\x2g\3rdparty\ccupload\CCUPLOAD.BIX > NUL:
@copy L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP L:\x2g\3rdparty\ccupload\CCUPLOAD.MAX > NUL:
@copy L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT L:\x2g\3rdparty\ccupload\CCUPLOAD.DAX > NUL:


type L:\x2g\system\msg\HINT_SAVE_FILES_IF_CHANGED.txt
type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.BAX
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.MAP
echo L:\x2g\3rdparty\ccupload\CCUPLOAD.DAT
@rem echo L:\x2g\3rdparty\ccupload\CCTOKBAS.BIN
@rem echo L:\x2g\3rdparty\ccupload\CCUPLOAD.BIX
@rem echo L:\x2g\3rdparty\ccupload\CCUPLOAD.MAX
@rem echo L:\x2g\3rdparty\ccupload\CCUPLOAD.DAX

echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
