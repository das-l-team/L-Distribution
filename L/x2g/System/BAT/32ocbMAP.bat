@echo off
type L:\X2G\system\msg\INFO_INVOKING_DOSBOX.txt
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:

copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\ccbaspar\OCBASIC\*.L L:\x2g   > NUL:



L:\x2g\3rdparty\dosbox\dosbox.exe -conf "L:\x2g\SYSTEM\BAT\dosbox_L.conf" -c "L:  -c "L:\x2g\SYSTEM\BAT\DBocbMAP.bat %1 %2 %3 %4 %5 %6" -c "type L:\x2g\out.txt" -c "exit"

type L:\x2g\out.txt
del L:\x2g\out.txt

type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt

echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L



type L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt
type L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt
