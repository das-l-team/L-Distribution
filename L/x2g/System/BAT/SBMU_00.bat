@echo OFF
call L:\x2g\System\BAT\TTY_STOP.bat

type "L:\x2g\System\MSG\INFO_INVOKING_CCT32.txt

@type "L:\x2g\system\msg\HINT_OMDLWIN_F11.txt"
rem @type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
@echo L:\x2g\Info.L
@echo L:\x2g\Hilfe.L

copy  L:\x2g\3rdparty\CCTrans32\*.L L:\x2g\ > NUL:

@echo off
@start /min L:\x2g\System\BAT\SBCO_A2.bat %1 > NUL:
exit