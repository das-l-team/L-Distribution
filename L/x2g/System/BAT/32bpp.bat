@echo off
::del %4%3.DAT

copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.DAT > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.MAP > NUL:
copy L:\x2g\3rdparty\BASICpp\*.L L:\x2g > NUL:




type L:\x2g\SYSTEM\MSG\INFO_INVOKING_BPP.txt > NUL:

 L:\x2g\3rdparty\BASICpP\$_L-WORK.DIR\bpp.exe %1

REM echo %errorlevel% errlevel  bpp.exe  schreibt wohl trotzdem die (vorherige?) *.DAT/*.MAP-Datei wenn
REM bei Kompilierung Fehler auftauchen. (Wer hat Lösungsvorschläge?)

type %3.LOG
echo OK
type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt"
rem echo %3.LOG
echo "%3.DAT"
echo "%3.MAP"
echo "%3.bpp"
echo "L:\x2g\Info.L"
echo "L:\x2g\Hilfe.L"
EXIT

:ERR
copy %4%3.LOG L:\x2g\out.txt > NUL:
type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_bpp_CONSOLE.txt
del L:\x2g\out.txt

copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.MAP  > NUL:
::copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.TMP  > NUL: