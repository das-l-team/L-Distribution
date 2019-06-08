@echo off




type L:\x2g\system\msg\INFO_INVOKING_AS05.txt

copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.BIN  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.16.txt %4%3.HEX  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.16.txt %4%3.S19  > NUL:
copy L:\x2g\3rdparty\CROSS_ASSEMBLERS\FRANKS\AS05\*.L L:\x2g\ > NUL:

"L:\x2g\3rdparty\cross_assemblers\franks\as05\$_L-WORK.DIR\as05.exe" %1       > NUL:
"L:\x2g\3rdparty\cross_assemblers\franks\as05\$_L-WORK.DIR\as05.exe" %1 -s2   > NUL:
"L:\x2g\3rdparty\cross_assemblers\franks\as05\$_L-WORK.DIR\as05.exe" %1 -z -s1 -m -l -i -w -u -o -h32767  > L:\x2g\out.txt


rem [0.26] call "L:\x2g\3rdparty\$_CUSTOMIZED\OM-BETATEST\S192TAB.BAT" %4%3.S19
type L:\x2g\system\msg\INFO_INVOKING_S192TAB.txt
"L:\x2g\3rdparty\S192TAB\s192tab.exe" %4%3.s19 > %4%3.s19.TAB

rem >%4%3.TAB

rem IF ERRORLEVEL 1 GOTO Err_Msg
rem type L:\x2g\out.txt
rem del L:\x2g\out.txt

echo [.]
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo "%4%3.BIN"
echo "%4%3.HEX"
echo "%4%3.LST"
echo "%4%3.S19"
echo "%4%3.s19.TAB"
echo "%1"
type L:\x2g\out.txt
del L:\x2g\out.txt
echo "L:\x2g\Info.L"
echo "L:\x2g\Hilfe.L"

EXIT

:Err_Msg
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_AS05_CONSOLE.txt
del L:\x2g\out.txt