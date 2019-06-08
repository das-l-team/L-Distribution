@echo off
echo [ Starte: ]
echo CCBAS2MC echter C-Control/BASIC Compiler Version x.x *      (* Zur Uebersetzung von BASIC Progammen in nativen Maschinenkode zwecks Geschwindigkeitsteigerung. )
echo Copyright (c) 2000 Dietmar Harlos ADPC
@L:\x2g\3rdparty\ccbas2mc\ccbas2mc.exe %1 > L:\x2g\out.txt
@type L:\x2g\out.txt
@del L:\x2g\out.txt

copy L:\x2g\3rdparty\CCBAS2MC\*.L L:\x2g > NUL:
