@echo off




type L:\x2g\system\msg\INFO_INVOKING_ALFREDS_05.txt

copy L:\x2g\SYSTEM\MSG\ERR_ASAA_BIN.txt %4%3.BIN  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.HEX  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.LST  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.S19  > NUL:
copy L:\x2g\3rdparty\CROSS_ASSEMBLERS\ALFREDS\*.L L:\x2g > NUL:


"L:\x2g\3rdparty\cross_assemblers\ALFREDS\$_L-WORK.DIR\bin\asw.exe" %1 -x -h -n -L -cpu 68HC05

IF ERRORLEVEL 1 GOTO Err_Msg

"L:\x2g\3rdparty\cross_assemblers\ALFREDS\$_L-WORK.DIR\bin\p2hex.exe" %4%3 %4%3.HEX -F Intel > NUL:
"L:\x2g\3rdparty\cross_assemblers\ALFREDS\$_L-WORK.DIR\bin\p2hex.exe" %4%3 %4%3.S19 -F Moto > NUL:
rem copy %4%3.HEX %4%3.s19 > NUL:



rem [0.26] call "L:\x2g\3rdparty\$_CUSTOMIZED\OM-BETATEST\S192TAB.BAT" %4%3.S19 > NUL:
type L:\x2g\system\msg\INFO_INVOKING_S192TAB.txt
"L:\x2g\3rdparty\S192TAB\s192tab.exe" %4%3.s19 > %4%3.s19.TAB


type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo "%4%3.BIN"
echo "%4%3.HEX"
echo "%4%3.LST"
echo "%4%3.S19"
echo "%4%3.s19.TAB"
echo "%1"
echo "L:\x2g\Info.L"
echo "L:\x2g\Hilfe.L"


exit

:Err_Msg
type L:\x2g\SYSTEM\MSG\ERR_AS05_CONSOLE.txt
