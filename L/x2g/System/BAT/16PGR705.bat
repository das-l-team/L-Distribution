@echo off
::type L:\x2g\system\msg\INFO_invoking_68HC705B_PGMR.txt


::copy L:\x2g\SYSTEM\MSG\68HC705B_PRGMR_Info.txt %4%3.MAP  > NUL:

copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt "L:\x2g\3rdparty\ToolsMot\68HC705B\Warning.txt" > NUL:
copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt "L:\x2g\Hilfe.L" > NUL:
copy L:\x2g\SYSTEM\MSG\68HC705B_PGMR_Info.txt "L:\x2g\Info.L"  > NUL:


type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.TMP
echo %4%3.VAR
echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L

L:
cd L:\x2g\3rdparty\ToolsMot\68HC705B\


start L:\x2g\3rdparty\ToolsMot\68HC705B\pgmr5.exe %1 L:\x2g\3rdparty\ToolsMot\68HC705B\Warning.txt

::type L:\x2g\out.txt
::del L:\x2g\out.txt





