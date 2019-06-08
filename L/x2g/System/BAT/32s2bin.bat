@echo off




@type L:\X2G\System\MSG\INFO_INVOKING_s2bin.txt

echo .

echo %1 %4%3%5


@L:\x2g\3rdparty\dosbox\dosbox.exe -conf "L:\x2g\3rdparty\DOSBOX\dosbox_L.conf" -c "L:\x2g\SYSTEM\BAT\DBs2bin.bat %1 %2 %3 %4 %5 %6 > L:\x2g\out1.txt"  -c "exit"

@type L:\x2g\out.txt


@type L:\X2G\3rdparty\DOSBOX\INFO_RESULTS_STORED_IN_FILE.txt

@echo "%4%3%5"

L:\x2g\3rdparty\Context\CONTEXT.exe %4%3%5