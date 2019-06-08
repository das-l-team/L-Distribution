@echo off



echo Auswahl der assoziierten Schnittstelle


type L:\x2g\system\msg\INFO_INVOKING_AS05.txt

copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.BIN  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.HEX  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_AS05.txt %4%3.S19  > NUL:


"L:\x2g\3rdparty\cross_assemblers\franks\as05\as05.exe" %1     -m -l -i -o  > NUL:
"L:\x2g\3rdparty\cross_assemblers\franks\as05\as05.exe" %1 -s2 -m -l -i -o  > NUL:
"L:\x2g\3rdparty\cross_assemblers\franks\as05\as05.exe" %1 -s1 -m -l -i -o  > L:\x2g\out.txt

IF ERRORLEVEL 1 GOTO Err_Msg
type L:\x2g\out.txt
del L:\x2g\out.txt

echo OK
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
echo "%4%3.BIN"
echo "%4%3.HEX"
echo "%4%3.S19"

EXIT

:Err_Msg
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_AS05_CONSOLE.txt
del L:\x2g\out.txt