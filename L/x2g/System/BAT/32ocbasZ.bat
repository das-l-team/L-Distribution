@echo off
type L:\x2g\system\msg\INFO_invoking_ocb_COMPILER.txt

copy L:\x2g\3rdparty\OCBASIC\INFO.L L:\x2g\ > NUL:
::copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
::copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:

L:\X2G\3rdparty\OCBASIC\OCBAS108_32.EXE %1 %5
rem L:\X2G\3rdparty\OCBASIC\$_L-WORK.DIR\OCBAS.EXE %1 %5


::IF ERRORLEVEL GOTO Err_Msg

type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.DAT
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
exit

:Err_Msg

::type L:\x2g\out.txt
type L:\x2g\SYSTEM\MSG\ERR_ocb_CONSOLE.txt
::del L:\x2g\out.txt

copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.MAP  > NUL:
::copy L:\x2g\SYSTEM\MSG\ERR_bpp.txt %4%3.TMP  > NUL:

