@echo off

REM   Steuerdatei erzeugen; COM1 �ffnen (DTR und RTS auf +), sonst nix:
echo COM1>Beispiel1.ini

REM   Steuerprogramm starten:
start schaltser Beispiel1.ini

REM   3 Sekunden warten:
sleepms 3000

REM   Steuerdatei l�schen beendet SchaltSer:
del Beispiel1.ini
