


type L:\X2G\system\msg\INFO_INVOKING_s2bin.txt
pause
L:\x2g\3rdparty\s2bin\$L_WORK.DIR\s2bin.exe %1%4%3%5.s2b
 pause
rem > L:\x2g\out.txt   REM Haeufig s2bin-Fehlermeldung   ^ Above line ignored.  Not a data record.
rem type L:\x2g\out.txt
echo .



pause
type L:\X2G\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
pause

echo %4%3%5.BIN
echo %4%3%5.s2b
echo %4%3%5.DIS
echo %4%3%5.TAB
echo %4%3%5.s19.TAB
echo %4%3%5.LST
echo %4%3%5.S19




rem L:\x2g\3rdparty\Context\CONTEXT.open %4%3%5