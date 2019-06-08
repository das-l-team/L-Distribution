@echo OFF

start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L1_DEBUG.exe rem doppelt

type "L:\x2g\System\MSG\INFO_FREEING_TTY.txt"
echo COM1 ]
if not exist %windir%\system32\tskill.exe goto skip
echo  (...via tskill.exe)

start /wait /min %windir%\system32\tskill.exe L1_CCTrans32
start /wait /min %windir%\system32\tskill.exe L1_OMDL
start /wait /min %windir%\system32\tskill.exe L1_debug
start /wait /min %windir%\system32\tskill.exe L1_putty
rem > NUL:
goto skip3

:skip
if not exist %windir%\system32\taskkill.exe goto skip2
echo  (...via taskkill.exe)

start /wait /min %windir%\system32\taskkill.exe /IM L1_CCTrans32.exe
start /wait /min %windir%\system32\taskkill.exe /IM L1_OMDL.exe
start /wait /min %windir%\system32\taskkill.exe /IM L1_DEBUG.exe
start /wait /min %windir%\system32\taskkill.exe /IM L1_putty.exe
rem > NUL:
goto skip3

:skip2
echo  (...via pss.exe)

start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L1_CCTrans32.exe
start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L1_OMDL.exe
start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L1_DEBUG.exe
start /wait /min L:\x2g\3rdparty\rejetto\pss\pss.exe -killname:L1_putty.exe
:skip3

call L:\x2g\3rdparty\Uwe_Sieber\sleep\$_L-WORK.DIR\sleep 500
