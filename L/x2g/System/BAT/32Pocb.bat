@echo off

type L:\X2G\system\msg\INFO_INVOKING_DOSBOX.txt

:Compile
@type L:\X2G\system\msg\INFO_invoking_CCBASPAR_4_MAP.txt
@L:\x2g\3rdparty\dosbox\dosbox.exe   -conf "L:\x2g\3rdparty\DOSBOX\dosbox_L.conf" -c "@cd L:\x2g\3rdparty\ccbaspar\ocbasic" -c "@L:\x2g\SYSTEM\BAT\DB16Pocb.bat %1 %2 %3 %4 %5 > L:\x2g\out.txt"  -c exit
@type L:\x2g\out.txt
@del L:\x2g\out.txt

@type L:\X2G\system\msg\INFO_RESULTS_STORED_IN_FILE.txt

echo %4%3.MAP
echo %4%3.TMP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L

@type L:\X2G\system\msg\INFO_NA_mouse2_err_line.txt
