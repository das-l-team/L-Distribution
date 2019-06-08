@echo off
type L:\X2G\system\msg\INFO_INVOKING_DOSBOX.txt
type L:\x2g\system\msg\INFO_invoking_CCBASPAR.txt


copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.MAP  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.DAT  > NUL:
copy L:\x2g\SYSTEM\MSG\ERR_compiler_all.txt %4%3.TMP  > NUL:



copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:
copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:
copy L:\x2g\3rdparty\CCBASPAR\*.L L:\x2g > NUL:

:: thank you, community on http://superuser.com/questions/790519/running-dosbox-completely-headless
:: and http://www.vogons.org/viewtopic.php?t=22813 for (not knowingly) helped us closing this long
:: time open ticket: No Pop-up Window when executing DOS (command line) applications.
rem set SDL_VIDEODRIVER=dummy

@call L:\x2g\3rdparty\dosbox\dosbox.exe -noconsole -conf "L:\x2g\SYSTEM\BAT\dosbox_L.conf" -c "@L: "-c "@cd L:\x2g\3rdparty\ccbaspar\" -c "@L:\x2g\SYSTEM\BAT\DBParbas.bat %1 %2 %3 %4 %5 %6" -c "exit"


type L:\x2g\out.txt
del L:\x2g\out.txt

type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
echo %4%3.TMP
echo %4%3.VAR
echo %4%3.DAT
echo %4%3.BAS
echo L:\x2g\Info.L
echo L:\x2g\Hilfe.L



type L:\x2g\system\msg\INFO_NA_mouse2_err_line.txt
type L:\x2g\system\msg\HINT_CONSIDER_LEGACY_COMPILER_F12.txt
