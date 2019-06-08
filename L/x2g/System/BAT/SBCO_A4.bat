@echo off

REM ver 0.26
CALL  L:\x2g\3rdparty\CCTrans32\$_L-WORK.DIR\L4_CCTrans32.exe %1 4

START L:\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\L4_putty.exe -load "COM 4" rem -sercfg "9600"
exit