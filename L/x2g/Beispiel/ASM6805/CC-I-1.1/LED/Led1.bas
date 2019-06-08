'********************************************************************
'
' C-Control/BASIC       LED1.BAS
'
' Systemvoraussetzungen:
'
' - LED-Modul am C-Control Starter Board oder Application Board
' 
' Das Beispiel gibt Zeichen auf dem LED-Modul aus
' und zeigt die Anwendung des SYS-Befehls mit Parameteruebergabe
' (neu ab CCBAS.EXE 1.33 und CCBAS32.DLL 1.2)
'********************************************************************

' --- Definitionen --------------------------------------------------

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
define LED_A 136
define LED_B 224
define LED_C1 178
define LED_C2 241
define LED_D 193
define LED_E 176
define LED_F 184
define LED_G 162
define LED_H1 200
define LED_H2 232
define LED_I 250
define LED_J 195
define LED_L 242
define LED_N1 138
define LED_N2 233
define LED_O 225
define LED_OE 161
define LED_P 152
define LED_Q 140
define LED_R 249
define LED_S 164
define LED_T 240
define LED_U1 194
define LED_U2 227
define LED_UE 163
define LED_Y 196
define LED_0 130
define LED_1 207
define LED_2 145
define LED_3 133
define LED_4 204
define LED_5 164
define LED_6 160
define LED_7 143
define LED_8 128
define LED_9 132

define LED__ 247
define LED_MINUS 253
define LED_GRAD 156
define LED_OMEGA 148
define LED_MY 216


' --- Programmopeartionen -------------------------------------------

' *** Initialisierungen ***

led_clk=0
led_en=0
led_data=0


' *** Ausgabe ***

led_en = ON                     ' schaltet alle Segmente aus

' die 7-Segment-Zeichencodes werden als Parameter
' dem SYS-Befehl uebergeben 

sys leddigit LED_SPACE          ' die Zeichen werden in 
sys leddigit LED_S              ' umgekehrter Reihenfolge
sys leddigit LED_A              ' an das Modul gesendet
sys leddigit LED_B              ' <LEERZ> S A b C C  ->  CCbAS
sys leddigit LED_C1
sys leddigit LED_C1

led_en = OFF                    ' schaltet die Segmente ein


pause 200

led_en = ON                     ' schaltet alle Segmente aus

' durch ausschalten des hoechsten Bits in den 7-Segment-Zeichencodes
' werden die Dezimalpunkte aktiviert

sys leddigit LED_SPACE AND &H7F
sys leddigit LED_S AND &H7F
sys leddigit LED_A AND &H7F
sys leddigit LED_B AND &H7F
sys leddigit LED_C1 AND &H7F
sys leddigit LED_C1 AND &H7F

led_en = OFF                    ' schaltet die Segmente ein


end

'syscode "ledstbrd.s19"          ' Systemtreiber fuer Starter Board
syscode "ledapbrd.s19"          ' Systemtreiber fuer Application Board

