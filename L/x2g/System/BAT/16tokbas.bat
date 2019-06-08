
@copy L:\x2g\system\msg\ERR_CCTOKBAS_BAX.txt  %4%3.BAX  > NUL:
@copy L:\x2g\system\msg\ERR_CCTOKBAS_MNE.txt  %4%3.MNE  > NUL:

@REM next 4 lines inserted in 0.26
@copy L:\x2g\system\msg\ERR_DAT2TAB_TAB.txt   %4DAT2TAB.TAB > NUL:
@L:\x2g\3rdparty\DAT2TAB\$_L-WORK.DIR\dat2tab.exe %1
@copy L:\x2g\3rdparty\ccupload\DAT2TAB.TAB   %4DAT2TAB.TAB > NUL:
@del   L:\x2g\3rdparty\ccupload\DAT2TAB.TAB



@type L:\x2g\SYSTEM\MSG\INFO_INVOKING_CCTOKBAS.txt
@echo .
@type L:\x2g\SYSTEM\MSG\INFO_COPYRIGHT_CCTOKBAS.txt

@copy L:\x2g\system\msg\Hilfe.L L:\x2g\Hilfe.L > NUL:  > NUL:
@copy L:\x2g\system\msg\Info.L L:\x2g\Info.L   > NUL:  > NUL:
@copy L:\x2g\3rdparty\CCUPLOAD\*.L L:\x2g > NUL:

@REM @copy %1 "L:\x2g\3rdparty\ccupload"
@attrib  %1 -R -H
@L:
@cd L:\x2g\3rdparty\ccupload


@cctokdis.exe %1 > %4%3.MNE
@cctokbas.exe %1 -debug


@type L:\x2g\system\msg\HINT_SAVE_FILES_IF_CHANGED.txt
@type L:\x2g\system\msg\INFO_RESULTS_STORED_IN_FILE.txt
@echo %4DAT2TAB.TAB
@echo %4%3.BAX
@echo %4%3.MNE
@echo %4%3.DAT
@echo L:\x2g\Info.L
@echo L:\x2g\Hilfe.L
