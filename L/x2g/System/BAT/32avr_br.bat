@echo off




type L:\x2g\system\msg\INFO_INVOKING_AVR_BR.txt

copy L:\x2g\SYSTEM\MSG\ERR_AVR_BR.txt %4%3.L    > NUL:


"L:\x2g\3rdparty\AVR-Tools\AVR-Brenner\AVR-Brenner.exe" %1

IF ERRORLEVEL  1 GOTO Err_Msg
type L:\x2g\out.txt
del L:\x2g\out.txt

echo [ OK ]
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo "%4%3.BIN"
echo "%4%3.HEX"
echo "%4%3.S19"
echo "%4%3.LST"
echo "%4%3.TAB"
echo "%1
echo L:\Info.L
echo L:\x2g\Hilfe.L
EXIT

:Err_Msg
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_AVR_BR_CONSOLE.txt
del L:\x2g\out.txt