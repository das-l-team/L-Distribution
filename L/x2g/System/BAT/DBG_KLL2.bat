@echo OFF

type "L:\x2g\System\MSG\INFO_OMDEBUG_KILL.txt"

if not exist %windir%\system32\tskill.exe goto skip
echo  ...via tskill.exe ]
start /wait /min %windir%\system32\tskill.exe L2_DEBUG.exe
rem > NUL:
goto skip3

:skip
if not exist %windir%\system32\taskkill.exe goto skip2
echo   ...via taskkill.exe ]
start /wait /min %windir%\system32\taskkill.exe /IM L2_DEBUG.exe
rem > NUL:
goto skip3

:skip2
echo   ...via pss.exe ]
start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L2_DEBUG.exe

:skip3




