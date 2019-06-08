@echo OFF
call L:\x2g\System\BAT\TTY_STOP.bat

type "L:\x2g\System\MSG\INFO_INVOKING_OMDLWIN.txt"

@type "L:\x2g\system\msg\HINT_CCTRANS32_F10.txt"
rem @type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
@echo L:\x2g\Info.L
@echo L:\x2g\Hilfe.L

copy  L:\x2g\3rdparty\OMDLWIN\*.L L:\x2g\ > NUL:

@echo off
@start /min L:\x2g\System\BAT\SBCO_B3.bat %1 > NUL:
exit