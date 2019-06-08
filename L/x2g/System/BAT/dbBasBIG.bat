

@echo off
 type L:\x2g\System\MSG\dbBasBIG.txt
:: This maps input file's source directory to 'W:' while in this DOSBox instance
:: Although this seems functional under DOSBox 0.73 - no testing has yet been done using other DOSBox versions

mount w: %4 > NUL:
rem > NUL:


copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %3.DAT  > NUL:



cd L:\x2g\3rdparty\ccbasbig
set temp=L:\x2g\system\TMP
L:\x2g\3rdparty\ccbasbig\ccbasbig.exe w:\%2 > L:\x2g\system\tmp\ccbasbig.out


REM IF ERRORLEVEL 0 GOTO Err_Msg


rem echo OK
rem EXIT

:Err_Msg
return L:\x2g\out.txt

EXIT

