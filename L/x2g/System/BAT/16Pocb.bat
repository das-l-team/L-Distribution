@echo off



@type L:\x2g\system\msg\INFO_invoking_CCBASPAR_4_MAP.txt
@del "%4%3.MAP" > NUL:
@L:\x2g\3rdparty\ccbaspar\OCBASIC\ccbaspar.exe %1 %5 > L:\x2g\out.txt

rem @copy %3.TMP
@type L:\x2g\out.txt
@del L:\x2g\out.txt
@type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt

echo %4%3.TMP
echo %4%3.MAP
echo %4%3.DAT
echo %1
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L
@type L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt

