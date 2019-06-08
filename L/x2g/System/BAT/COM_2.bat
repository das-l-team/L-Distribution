@echo OFF
type L:\x2g\System\MSG\INFO_CONSOLE_COMPORT_2_SELECTED.txt

copy L:\x2g\system\bat\SBMU_A2.BAT L:\x2g\system\bat\SBMU_00.BAT > NUL:
copy L:\x2g\system\bat\SBMU_B2.BAT L:\x2g\system\bat\SBMU_01.BAT > NUL:
copy L:\x2g\System\MSG\INFO_COMPORT_2_SELECTED.txt L:\x2g\Hilfe.L > NUL:

copy L:\x2g\System\BAT\DBG_KLL2.bat L:\x2g\System\BAT\DBG_KILL.bat > NUL:
copy L:\x2g\System\BAT\DBG_RUN2.bat L:\x2g\System\BAT\DBG_RUN.bat  > NUL:

copy L:\x2g\System\BAT\TTY_STP2.bat L:\x2g\System\BAT\TTY_STOP.bat > NUL:
CALL L:\x2g\System\BAT\TTY_STOP.bat

copy L:\x2g\System\BAT\16ccupl2.bat L:\x2g\System\BAT\16ccupld.bat > NUL:
copy L:\x2g\System\BAT\32ccupl2.bat L:\x2g\System\BAT\32ccupld.bat > NUL:

copy L:\x2g\System\MSG\INFO_COMPORT_2_SELECTED.txt L:\x2g\Info.L > NUL:

rem @type "L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo .
@echo L:\x2g\Info.L
@echo L:\x2g\Hilfe.L
START L:\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\L2_putty.exe -load "COM 2" rem -sercfg "9600"