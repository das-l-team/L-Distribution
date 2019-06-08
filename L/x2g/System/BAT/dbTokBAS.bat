


@REM @copy %1 "L:\x2g\3rdparty\ccupload" > NUL:
@attrib  %1 -R -H
@L:
@cd L:\x2g\3rdparty\ccupload



@cctokdis.exe %1 > %4%3.MAP
@cctokbas.exe %1 -debug

exit

