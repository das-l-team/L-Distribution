'********************************************************************
'
' C-Control/BASIC       LED4.BAS
'
' Systemvoraussetzungen:
'
' - LED-Modul am C-Control Starter Board oder Application Board
' - Conrad Electronic KTY-Sensor (oder 10k-Poti zum Test) an AD1 
'
' Schwerpunkte:
'
' - gemischte Ausgabe von Zahlen und Zeichen
' - neue Features des BASIC-Compilers bei GOSUB und GOTO
'
' dieses Beispiel realisiert ein einfaches Digitalthermometer
'********************************************************************

' --- Definitionen --------------------------------------------------

define temp word
define tempold word
define sensor ad[1]

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
define LED_C1 178
define LED_GRAD 156


' --- Programmopeartionen -------------------------------------------

' *** Initialisierungen ***

led_clk=0
led_en=0
led_data=0

gosub output                          

' *** Hauptschleife ***

#loop

  looktab kty, sensor, temp 
  if changed then gosub output  ' neu!!! Abfrage eines Rueckgabewertes
  tempold = temp
  pause 10

loop                            ' neu!!! goto kann entfallen


#changed                        
return  temp <> tempold         ' neu!!! Rueckgabewerte von Unterfunktionen


' *** Ausgabe ***

#output
  led_en = ON                     
  sys LEDDIGIT LED_C1
  sys LEDDIGIT LED_GRAD
  sys LEDVAL temp, 2, 4         ' Temperaturausgabe, -27.5°C bis 100.0°C
  led_en = OFF
return 

end

table kty "kty10.tab"

'syscode "ledstbrd.s19"          ' Systemtreiber fuer Starter Board
'syscode "ledapbrd.s19"          ' Systemtreiber fuer Application Board

