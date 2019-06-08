



'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'IIIIIIIIIIIIIII      C-CONTROL  LCD 2x8 BASIC TREIBER     IIIIIIIIIIII
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
' CONRAD ELECRONIC Feb. 00 (DH)
'
'---------------- Kurzbeschreibung -------------------------------------
' Die Demo beinhaltet die Unterprogramme für die wesentlichen Funktionen
' des LCD 2x8.
' - Cursor auf Zeile 1
' - Cursor auf Zeile 2
' - Text anzeigen
' - Text scrollen
' - Display löschen
'----------------------------------------------------------------------------------------------
' CURSOR AUF ZEILE SETZEN
' Dazu wird einfach das Unterprogramm aufgerufen
'
' TEXT SCHREIBEN
' Hierfür wird die Variable lcd_char mit dem entsprechenden Displaycode an das Unterprogramm
' übergeben.
' Den Displaycode für Buchstaben und Sonderzeichen können Sie der Tabelle in der Anleitung
' entnehmen. Er ist der jeweilige ASCII-Code + 128
'
' Die Demo schreibt:       LCD 2x8
'                           DEMO
'
' Nach einer kurzen Pause wird das Display wieder gelöscht.

' DISPLAY SCROLLING
' Da acht Character nicht immer ausreichen einen sinnvollen Text anzuzeigen, kann ein
' längerer Text in das Display geschrieben und als "Laufschrift" sichtbar gemacht werden.
' In diesem Beispiel werden die Buchstaben von A-Z an das Display gesendet und dann
' durch Scrolling nach links der Reihe nach sichtbar gemacht.
'
'----------------------------------------------------------------------------------------------
'----------------------------------------------------------------------------------------------



'--------------------------
'------ I/O PORTS ---------
'--------------------------

'---- MINI LCD 2x8 --------
define sdio port[1]
define sclio port[2]
'--------------------------
'---- SYSTEM MEMORY -------
'--------------------------
'---- MINI LCD 2x8 --------
define lcd_char      byte[1]
define lcd_data      byte[2]
define value         byte[3]



'--------------------------------------------------
' ---------------- INITIALISIERUNG ----------------
'--------------------------------------------------
'
'Einschaltmeldung für das MINI-LCD
gosub lcd2x8_init




'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'IIIIIIIIIIIIIII PROGRAMM START IIIIIIIIIIIIIIIIIIII
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
#continue_pgm

gosub message1
pause 100
gosub clear_display
gosub long_line
pause 100
gosub clear_display

goto continue_pgm


'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'IIIII APPLICATIONBOARD DISPLAY AUSGABEN  IIIIIIIIIIIII
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'+++++++++++++++ EINSCHALTTEXT AUSGEBEN +++++++++++

#message1
gosub clear_display:gosub setline1
lcd_char=&H20:gosub write_character
lcd_char=&HCC:gosub write_character
lcd_char=&HC3:gosub write_character
lcd_char=&HC4:gosub write_character
lcd_char=&HA0:gosub write_character
lcd_char=&HB2:gosub write_character
lcd_char=&HF8:gosub write_character
lcd_char=&HB8:gosub write_character
lcd_char=&HA0:gosub write_character

gosub setline2
lcd_char=&H20:gosub write_character
lcd_char=&H20:gosub write_character
lcd_char=&HC4:gosub write_character
lcd_char=&HC5:gosub write_character
lcd_char=&HCD:gosub write_character
lcd_char=&HCF:gosub write_character
return

'++++++++ LANGE ZEILE SCHREIBEN UND SCROLLEN +++++++
#long_line
'----------- Cursor auf Zeile 1 -----------------
gosub setline1
'------ Buchstaben A-Z zum Display --------------
for value=0 to 24
lcd_char=&H41+value+128:gosub write_character
next:pause 100
'---------- Display scrollen   -------------------
for value = 0 to 24
gosub scroll_display_left
pause 10:next
for value = 0 to 24
gosub scroll_display_right
pause 10:next
return

'--------------------------------------------
'-------- LCD 2x8 BASIC Treiber -------------
'--------------------------------------------
#setline1
lcd_char=&H84:goto mode_control
#setline2
lcd_char=&HC4:goto mode_control
#clear_display
lcd_char=&H01:goto mode_control
#scroll_display_left
lcd_char=&H18:goto mode_control
#scroll_display_right
lcd_char=&H1C:goto mode_control
#write_character
beep 368,1,0
sclio=on:sdio=on:sdio=off:sclio=off
lcd_data=&H74:gosub write_byte
lcd_data=&H40:gosub write_byte
lcd_data=lcd_char:gosub write_byte
sdio=off:sclio=on:sdio=on:return

'-----------------------------------------------
#mode_control
sclio=on:sdio=on:sdio=off:sclio=off
lcd_data=&H74:gosub write_byte
lcd_data=&H00:gosub write_byte
lcd_data=lcd_char:gosub write_byte
sdio=off:sclio=on:sdio=on:return
#write_byte
sdio=(lcd_data and &H80)shr 7:sclio=on:sclio=off
sdio=(lcd_data and &H40)shr 6:sclio=on:sclio=off
sdio=(lcd_data and &H20)shr 5:sclio=on:sclio=off
sdio=(lcd_data and &H10)shr 4:sclio=on:sclio=off

sdio=(lcd_data and &H08)shr 3:sclio=on:sclio=off
sdio=(lcd_data and &H04)shr 2:sclio=on:sclio=off
sdio=(lcd_data and &H02)shr 1:sclio=on:sclio=off
sdio=lcd_data and &H01:sclio=on:sclio=off
deact sdio:sclio=on:sclio=off:sdio=off:return
#lcd2x8_init
sclio=on:sdio=on:sdio=off:sclio=off
lcd_data=&H74:gosub write_byte
lcd_data=&H00:gosub write_byte
lcd_data=&H25:gosub write_byte
lcd_data=&H06:gosub write_byte
lcd_data=&H24:gosub write_byte
lcd_data=&H0F:gosub write_byte
lcd_data=&H84:gosub write_byte
sdio=off:sclio=on:sdio=on:return
