@echo off

echo SchaltSer  Ablaufsteuerung
echo.

echo  1) Steuerdatei "Beispiel2.ini" erzeugen.
echo COM1 DTR- RTS- TXD- >Beispiel2.ini

echo  2) Steuerprogramm starten.
START SchaltSer.exe "Beispiel2.ini"

echo     1,5 Sekunden warten.
sleepms 1500

echo  3) Neue Steuerdatei erzeugen (DTR high).
echo DTR+ >Beispiel2.ini

echo     1,5 Sekunden warten:
sleepms 1500

echo  4) Neue Steuerdatei erzeugen (RTS high).
echo RTS+ >Beispiel2.ini

echo     1,5 Sekunden warten.
sleepms 1500

echo  5) Neue Steuerdatei erzeugen (TxD high).
echo TXD+ >Beispiel2.ini

echo     1,5 Sekunden warten:
sleepms 1500

echo  6) Steuerdatei loeschen (beendet Steuerprogramm):
del "Beispiel2.ini"

echo.
pause