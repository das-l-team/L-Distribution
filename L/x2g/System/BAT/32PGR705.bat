@echo off
type L:\X2G\system\msg\INFO_INVOKING_DOSBOX.txt
type L:\x2g\system\msg\INFO_invoking_68HC705B_PGMR.txt 


::copy L:\x2g\SYSTEM\MSG\68HC705B_PRGMR_Info.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt L:\x2g\3rdparty\ToolsMot\68HC705B\Warning.txt > NUL:
copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt L:\x2g\Hilfe.L > NUL:
copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt L:\x2g\Info.L  > NUL:


::copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
::copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:



::copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
::copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:

::copy L:\x2g\3rdparty\CCBASPAR\Hilfe.L L:\x2g\Hilfe.L  > NUL:
::copy L:\x2g\3rdparty\CCBASPAR\Info.L L:\x2g\Info.L    > NUL:

type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
rem echo %4%3.TMP
rem echo %4%3.VAR
rem echo %4%3.MAP
rem echo %4%3.DAT

echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
echo %1


START L:\x2g\3rdparty\dosbox\dosbox.exe -noconsole -conf "L:\x2g\SYSTEM\BAT\dosbox_L.conf" -c "L: " -c @cd L:\x2g\3rdparty\ToolsMot\68HC707B\ -c "L:\x2g\SYSTEM\BAT\dbPGR705.bat %1 %2 %3 %4 %5 %6" c: > "L:\x2g\out.txt" -c "exit"


::type L:\x2g\out.txt
::del L:\x2g\out.txt





