@echo off

L:\X2G\3rdparty\OCBASIC\$_L-WORK.DIR\OCBAS.EXE %1 %5 > L:\x2g\out.txt
L:\x2g\3rdparty\ccupload\cctokdis.exe %4%3.DAT > %4%3.MAP

type L:\x2g\out.txt
pause



exit

