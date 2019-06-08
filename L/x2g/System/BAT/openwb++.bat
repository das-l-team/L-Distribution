@echo OFF

@START C:\Programme\WorkBench++\Workbench.EXE %1


IF errorlevel 1 GOTO ERR

echo %1


type L:\x2g\System\MSG\INFO_INVOKING_WBPP_OK.txt

REM added in 0.27
CALL L:\x2g\System\BAT\TTY_STOP.bat



exit

:ERR


type L:\x2g\System\MSG\INFO_INVOKING_WBPP_FAIL.txt

rem TODO: Meldungstexte in L:\x2g\System\MSG Verzeichnis auslagern und
rem evt. per Skript das aktuelle Verzeichnis der Workbench++ sucher.
rem ( z.B. "C:\Program Files\..." falls  Windows in einer anderen Sprachversion
rem vorliegt...)