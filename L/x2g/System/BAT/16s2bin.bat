@echo off


rem "L:\x2g\3rdparty\$_CUSTOMIZED\OM-BETATEST\S192TAB.EXE" %4%3.s19 >%4%3%5.TAB

REM Currently, the 3rd-party program named S192TAB.EXE is available for limited use only.
REM Therefore the directory "$$$_NOT_TO_BE_DISTRIBUTED"  (and any of its subdirectories) need to be
REM excluded from any publicly available release of this distribution. Please have this checked before
REM forwarding any copies of this distribution.

REM You can substitute S192TAB.EXE with INLASM.EXE which is 3rd-party SW available but seems
REM to be re-distributable. There are minor differences in the output format of the 2 programs though.
REM

REM v 0.26 S192TAB is now included courtesy Dietmar Harlos website ccintern.dharlos.de
type L:\X2G\system\msg\INFO_INVOKING_S192TAB.txt
L:\x2g\3rdparty\S192TAB\S192TAB.exe %1 > %4%3%5.s19.TAB

type L:\X2G\system\msg\INFO_INVOKING_inlasm_exe.txt
echo.
L:\x2g\3rdparty\ominlasm\inlasm.exe %1 > %4%3%5.TAB


echo.
type L:\X2G\system\msg\INFO_INVOKING_s2bin.txt
L:\x2g\3rdparty\s2bin\$L_WORK.DIR\s2bin.exe %1 %4%3%5.s2b

rem > L:\x2g\out.txt   REM Haeufig s2bin-Fehlermeldung   ^ Above line ignored.  Not a data record.
rem type L:\x2g\out.txt
echo .


L:\x2g\3rdparty\DASMx\dasmx130\DASMx.exe -c6803 -w %4%3%5.BIN

copy L:\x2g\3rdparty\DASMx\dasmx130\*.L L:\x2g > NUL:
type L:\X2G\system\msg\INFO_RESULTS_STORED_IN_FILE.txt

echo %4%3%5.BIN
echo %4%3%5.s2b
echo %4%3%5.DIS
echo %4%3%5.TAB
echo %4%3%5.s19.TAB
echo %4%3%5.LST
echo %4%3%5.S19




rem L:\x2g\3rdparty\Context\CONTEXT.open %4%3%5