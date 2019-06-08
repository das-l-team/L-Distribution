'********************************************************************
'
' C-Control/BASIC       LED2.BAS
'
' Systemvoraussetzungen:
'
' - LED-Modul am C-Control Starter Board oder Application Board
'
' Das Beispiel gibt Zahlenwerte auf dem LED-Modul aus
' und zeigt die Anwendung des SYS-Befehls mit Parameteruebergabe
' (neu ab CCBAS.EXE 1.33 und CCBAS32.DLL 1.2)
'********************************************************************

' --- Definitionen --------------------------------------------------

define value word

' *** Ports zur Ansteuerung des LED-Moduls ***

' Starter Board
define led_clk port[10]
define led_en port[11]
define led_data port[14]

' alternativ Application Board
'define led_clk port[14]
'define led_en port[15]
'define led_data port[10]

' Systemadressen
define LEDVAL &H101             ' Ausgabe eines Wertes
define LEDDIGIT &H187           ' Ausgabe eines Zeichens

' Zeichencodes

define LED_SPACE 255


' --- Programmopeartionen -------------------------------------------

' *** Initialisierungen ***

led_clk=0
led_en=0
led_data=0


' *** Ausgabe ***

led_en = ON                     ' schaltet alle Segmente aus

' Ausgabe eines Wertes am Display: der Systemtreiber uebernimmt
' die Aufsplittung in die einzelnen Dezimalstellen, die rechtsbuendige
' Ausgabeformatierung mit fuehrenden Leerzeichen sowie die
' Ausgabe des negativen Dezimalzeichens sowie eines optionalen
' Dezimalpunktes

' Parameter des SYS-Befehls:
' 6:  6-stellige Ausgabe (fuehrende Leerzeichen + '-' + Dezimalstellen)
' 2: die zweite Ziffer von rechts bekommt einen Dezimalpunkt
' -1000: der Ausgabewert

sys LEDVAL -1000, 2, 6

' WICHTIG: die Parameter sollten Konstanten oder Variablen sein und keine
' Berechnungen enthalten!!!

led_en = OFF                     ' schaltet die Segmente ein

pause 200

' Ausgabe von Werten (ohne Dezimalpunkt)
for value = -32000 to 32000 step 100
  pause 50
  led_en = ON
  sys LEDVAL value, 0, 6
  led_en = OFF
next


end

'syscode "ledstbrd.s19"          ' Systemtreiber fuer Starter Board
'syscode "ledapbrd.s19"          ' Systemtreiber fuer Application Board

