@echo off



:Compile
type L:\X2G\system\msg\INFO_INVOKING_DOSBOX.txt

copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\CCBASBIG\*.L L:\x2g  > NUL:

copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %3.MNE  > NUL:

type L:\x2g\SYSTEM\MSG\INFO_invoking_CCBASBIG.txt

L:\x2g\3rdparty\dosbox\dosbox.exe -noconsole -conf "L:\x2g\SYSTEM\BAT\dosbox_L.conf" -c "L:\x2g\SYSTEM\BAT\DBbasBIG.bat %1 %2 %3 %4 %5 %6 > L:\x2g\out1.txt"

rem echo %errorlevel%
rem type L:\x2g\out.txt
type L:\x2g\system\tmp\ccbasbig.out
del  L:\x2g\system\tmp\ccbasbig.out

rem @del L:\x2g\%2
rem @copy L:\x2g\%3.* %4 > NUL:
rem @echo bug_fix > L:\x2g\%3.DAT
rem @del L:\x2g\%3.DAT
rem @del L:\x2g\out.txt

type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
:: echo %4%3.TMP \  Not available
:: echo %4%3.VAR /  Not available
rem v.0.22 echo %4%3.MNE
echo %4%3.DAT
echo %4%3.BAS
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L


type L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt
type L:\x2g\system\msg\HINT_CONSIDER_EXTENDED_COMPILER_F9.txt