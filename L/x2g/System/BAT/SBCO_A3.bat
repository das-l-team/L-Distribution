@echo off

REM ver 0.26
CALL  L:\x2g\3rdparty\CCTrans32\$_L-WORK.DIR\L3_CCTrans32.exe %1 3

START L:\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\L3_putty.exe -load "COM 3" rem -sercfg "9600"
exit