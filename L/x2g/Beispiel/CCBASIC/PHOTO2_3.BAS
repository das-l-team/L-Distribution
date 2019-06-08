'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'!-----------------------------------------------------------------------------------!
'!---------------------------VON  HELMUT  GERKEN-------------------------------------!
'!-----------------------------------------------------------------------------------!
'!------------------------------VERSION  2.3-----------------------------------------!
'!-----------------------------VOM  16.08.2003---------------------------------------!
'!-----------------------------------------------------------------------------------!
'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'
' Beschreibung  des Programmes:
' Mit diesem Programm laesst sich der Solarertrag einer Photovoltaik - Anlage genau 
' ermitteln und darstellen. Dabei ist die schwankende Stromleistung der Kollekktoren
' beruecksichtigt, denn mit der  Stromzaehlschaltung wird der tats„chliche Strom
' ermittelt. In der C-Control wird dann nur noch zusammmengezaehlt und angezeigt.
' Wie man im Programm sehen kann wird die Leistung der Solarzellen in Ampere -
' Stunden, in Watt, in Kilowattstunden und in Euro angezeigt. Desweiteren werden die
' verschiedenen Zustaende dargestellt, Normalbetrieb, Batterie laden, Batterie voll,
' und Aus, keine Sonne.

'***************************************************************************************
' Systemvoraussetzungen:
'
' C - Control/Basic M-Unit
' C - Control/Basic M-Adapter (zur Programmierung)
' LC - Display mit 4 x 16 Zeichen
' 2 Taster zum L”schen der Zaehler oder zum Abbbrechen des L”schens
' 2 Spannungsteiler Eingang 0 - 20 V - Ausgang 0-5 V
' 1 Stromzaehlschaltung im Eigenbau
'
'***************************************************************************************
'
' FUNKTIONEN:
' PORTS:
' PORT 1 = Eingang von der Zaehlschaltung (Zaehlimpulse)
' PORT 2 = Taster nicht l”schen (Esc)
' PORT 3 = Taster Zaehler loeschen
' PORT 4 = Status Wechselrichter ( 1 bedeutet Wechselrichter ist eingeschaltet)
'
' PORT 9-15 ->LCD
'
' PORT AD1 = Spannung von den Solarzellen
' PORT AD2 = Batteriespannung
'
' PORT FREQ2 = Strom von den Solarzellen (von der Stromzaehlschaltung)

'***************************************************************************************

'--------------------------------------------------------------------------------
'-------------------------ZUWEISUNG DER EIN- UND AUSGAENGE ----------------------
'--------------------------------------------------------------------------------

define stromzaehler port[1]
define abbrechen    port[2]
define loeschen     port[3]
define status       port[4]

'-------------------------------------------------------------------------------
'---------------------------PORTS 9 - 15 FUER LC DISPLAY------------------------
'-------------------------------------------------------------------------------

define lcd_port     byteport[2]
define lcd_rw       port[13]
define lcd_rs       port[14]
define lcd_e        port[15]

'-------------------------------------------------------------------------------
'------------------------- ZUWEISUNG DER SPANNUNGSSENSOREN----------------------
'-------------------------------------------------------------------------------

define solarsensor             ad[1]
define batteriesensor          ad[2]
define solarspannung           byte
define batteriespannung        byte

'--------------------------------------------------------------------------------
'-------------------------ZAHLEN KONVERTIERUNG FUER ANZEIGE ---------------------
'--------------------------------------------------------------------------------

define value                   word
define hilfsvalue              word

'--------------------------------------------------------------------------------
'-----------------------------------LCD TREIBER ---------------------------------
'--------------------------------------------------------------------------------

define lcd_buf                 byte
define lcd_param               byte

'--------------------------------------------------------------------------------
'--------------------------------DIVERSE VARIABLEN-------------------------------
'--------------------------------------------------------------------------------

define zaehlermah              word
define zaehlerah               word
define wattstd                 word
define kilowattstd             word
define preis                   word
define zwischenzaehler         byte
define stromstaerke            byte

define a                       byte         'Merker
define b                       byte         'Merker fuer gespeichert
define betriebsart             byte         'Merker fuer Betriebsart
define speicher_betriebsart    byte         'Merker wenn Betriebsart geaendert
'--------------------------------------------------------------------------------
'--------------------------------KONSTANTEN ZUWEISEN-----------------------------
'--------------------------------------------------------------------------------
define strompreis     14                    'Preis fuer eine kWh = 0,14 Euro

'--------------------------------------------------------------------------------
'-------------------------------- INITIALISIEREN --------------------------------
'--------------------------------------------------------------------------------


Pause 2                                'Wartezeit fuer Displayhochlauf
gosub lcd_init                         'LCD Initianlisieren
gosub version                          'Versionsnummer anzeigen
gosub read_data                        'Nach einem Reset Daten aus dem EPROM lesen

a = 0                                  'Merker auf 0 setzen
b = 1                                  'Merker gespeichert setzen
    
'---------------------------------------------------------------------------------
'------------------------ANZEIGE 1. ZEILE BETRIEBSZUSTAND ------------------------
'---------------------------------------------------------------------------------
#status
 gosub lcd_cls
 speicher_betriebsart = betriebsart
 
#unterroutine
 gosub stromzaehlen
 solarspannung = ((solarsensor * 100)/127)
 batteriespannung = ((batteriesensor * 100)/127)
 stromstaerke = freq2 / 140
 if status = on then gosub normal
 if status = off and freq2 > 0 then gosub laden
 if status = off and freq2 = 0 then gosub aus
 if status = off and solarspannung <= batteriespannung then gosub batterie_voll
 if betriebsart <> speicher_betriebsart then goto status
 if loeschen = on then gosub zaehler_loeschen
 goto leistung_aktuell

#normal
 lcd_param = 1 : gosub lcd_gotoline
 gosub leerzeichen
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = &H4F : gosub lcd_writechar    'O
 lcd_param = &H52 : gosub lcd_writechar    'R
 lcd_param = &H4D : gosub lcd_writechar    'M
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H42 : gosub lcd_writechar    'B
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H54 : gosub lcd_writechar    'T
 lcd_param = &H52 : gosub lcd_writechar    'R
 lcd_param = &H49 : gosub lcd_writechar    'I
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H42 : gosub lcd_writechar    'B
 gosub anzeige_ausrufezeichen
 betriebsart = 1
 return

#laden
 lcd_param = 1 : gosub lcd_gotoline
 gosub leerzeichen
 gosub anzeige_batterie
 gosub leerzeichen
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H44 : gosub lcd_writechar    'D
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H4E : gosub lcd_writechar    'N
 betriebsart = 2
 return

#aus
 lcd_param = 1 : gosub lcd_gotoline
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H55 : gosub lcd_writechar    'U
 lcd_param = &H53 : gosub lcd_writechar    'S
 gosub anzeige_ausrufezeichen
 gosub leerzeichen
 lcd_param = &H4B : gosub lcd_writechar    'K
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H49 : gosub lcd_writechar    'I
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = &H45 : gosub lcd_writechar    'E
 gosub leerzeichen
 lcd_param = &H53 : gosub lcd_writechar    'S
 lcd_param = &H4F : gosub lcd_writechar    'O
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = &H45 : gosub lcd_writechar    'E
 betriebsart = 3
 return

#batterie_voll
 if stromstaerke = 0 then return
 lcd_param = 1 : gosub lcd_gotoline
 gosub leerzeichen
 gosub anzeige_batterie
 gosub leerzeichen
 lcd_param = &H56 : gosub lcd_writechar    'V
 lcd_param = &H4F : gosub lcd_writechar    'O
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H4C : gosub lcd_writechar    'L
 betriebsart = 4
 return

'---------------------------------------------------------------------------------
'------ANZEIGE 2. ZEILE LEISTUNG AKTUELL SPANNUNG UND STROM ODER WATT ------------
'---------------------------------------------------------------------------------

#leistung_aktuell
 gosub stromzaehlen 
 if second > 30 then goto leistung_watt
 lcd_param = 2 : gosub lcd_gotoline
 gosub leerzeichen 
 solarspannung = ((solarsensor * 100)/127)
 value = solarspannung / 10
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub anzeige_komma
 hilfsvalue =(solarspannung - ((solarspannung / 10) * 10))
 gosub convert_zahlen_einer
 gosub leerzeichen
 gosub anzeige_volt
 gosub leerzeichen
 gosub leerzeichen
 stromstaerke = freq2 / 14
 value = stromstaerke / 10
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub anzeige_komma
 hilfsvalue =(stromstaerke - ((stromstaerke / 10) * 10))
 gosub convert_zahlen_einer
 gosub leerzeichen
 lcd_param = &H41 : gosub lcd_writechar    '  A
 goto batteriespannung

'-------------------------------------------------------------------------------- 

#leistung_watt
 lcd_param = 2 : gosub lcd_gotoline
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 solarspannung = ((solarsensor * 10)/127)
 stromstaerke = freq2 / 14
 value = (solarspannung * stromstaerke) / 10
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub leerzeichen
 gosub leerzeichen
 lcd_param = &H57 : gosub lcd_writechar    'W
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H54 : gosub lcd_writechar    'T
 lcd_param = &H54 : gosub lcd_writechar    'T
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen

'---------------------------------------------------------------------------------
'------------------3. ZEILE ANZEIGE BATTERIESPANNUNG------------------------------
'---------------------------------------------------------------------------------

#batteriespannung
 gosub stromzaehlen
 lcd_param = 3 : gosub lcd_gotoline
 gosub anzeige_batterie
 gosub anzeige_doppelpunkt
 gosub leerzeichen
 batteriespannung = ((batteriesensor * 100)/127)
 value = batteriespannung / 10
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub anzeige_komma
 hilfsvalue =(batteriespannung - ((batteriespannung / 10) * 10))
 gosub convert_zahlen_einer
 gosub leerzeichen
 lcd_param = &H56 : gosub lcd_writechar    'V

'---------------------------------------------------------------------------------
'------------4. ZEILE ANZEIGE ERTRAG GESAMT IN AH, KWH ODER EURO------------------
'---------------------------------------------------------------------------------

 lcd_param = 4 : gosub lcd_gotoline
 gosub anzeige_summe
 if second <= 20 then goto amperestunden
 if second > 20 and second <= 40 then goto kilowattstunden
 if second > 40 and second <= 60 then goto euro

#amperestunden
 value = zaehlerah
 if zaehlerah > 999 then gosub leerzeichen
 gosub convert_zahlen_tausend
 gosub anzeige_komma
 if zaehlerah < 999 then value = zaehlermah / 10 else value = zaehlermah / 100
 hilfsvalue = abs(value)
 if zaehlerah < 999 then gosub convert_zahlen_zehner else gosub convert_zahlen_einer
 gosub leerzeichen
 lcd_param = &H41 : gosub lcd_writechar                          'A
 lcd_param = &H68 : gosub lcd_writechar                          'h
 goto unterroutine

'------------------------------------------------------------------------------
'----------------------------ANZEIGE ERTRAG IN KWH ----------------------------
'------------------------------------------------------------------------------

#kilowattstunden
 value = kilowattstd
 hilfsvalue = abs(value)
 gosub convert_zahlen_hundert
 gosub anzeige_komma
 value = wattstd / 10
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub leerzeichen 
 lcd_param = &H6B : gosub lcd_writechar                          'k
 lcd_param = &H57 : gosub lcd_writechar                          'W
 lcd_param = &H68 : gosub lcd_writechar                          'h
 goto unterroutine

'------------------------------------------------------------------------------
'-----------------------------ANZEIGE ERTRAG IN EURO-----------------------------
'------------------------------------------------------------------------------
#euro
 preis = (kilowattstd * strompreis) 
 value = preis / 100
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub anzeige_komma
 if preis < 100 then value = preis  
 if preis > 100 then value = preis mod 100
 hilfsvalue = abs(value)
 gosub convert_zahlen_zehner
 gosub leerzeichen
 lcd_param = &H45 : gosub lcd_writechar                          'E
 lcd_param = &H55 : gosub lcd_writechar                          'U
 lcd_param = &H52 : gosub lcd_writechar                          'R
 lcd_param = &H4F : gosub lcd_writechar                          'O
 goto unterroutine

 
'------------------------------------------------------------------------------
'-------------------------------- STROMZAEHLEN --------------------------------
'------------------------------------------------------------------------------

#stromzaehlen
 if a = 0 then gosub zaehlen
 if a = 1 then gosub nicht_zaehlen
 if zaehlermah = 1000 then gosub uebertrag
 wattstd = (zwischenzaehler * 128) / 10
 if wattstd > 1000 then gosub ueberlauf
 if b = 0 then gosub speichern   
 if minute = 1 or minute = 31 then b = 0
 return

#speichern
 if minute = 0 or minute = 30 then gosub write_data
 return
 
#zaehlen
 if stromzaehler = on then zaehlermah = zaehlermah + 1
 a = 1
 return

#nicht_zaehlen
 if stromzaehler = off then a = 0
 return

#ueberlauf
 kilowattstd = kilowattstd + 1
 zwischenzaehler = 0
 return

#uebertrag
 zaehlerah = zaehlerah + 1
 zwischenzaehler = zwischenzaehler + 1
 zaehlermah = 0
return


'-------------------------------------------------------------------------------
'-----------------------------ZAEHLER LOESCHEN----------------------------------
'-------------------------------------------------------------------------------

#zaehler_loeschen
 gosub lcd_cls

#loeschroutine
 lcd_param = 2 : gosub lcd_gotoline
 gosub anzeige_zaehler
 gosub leerzeichen
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H4F : gosub lcd_writechar    'O
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H53 : gosub lcd_writechar    'S
 lcd_param = &H43 : gosub lcd_writechar    'C
 lcd_param = &H48 : gosub lcd_writechar    'H
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = 3 : gosub lcd_gotoline
 lcd_param = &H4E : gosub lcd_writechar    'N
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H49 : gosub lcd_writechar    'I
 lcd_param = &H4E : gosub lcd_writechar    'N
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 gosub leerzeichen
 lcd_param = &H4A : gosub lcd_writechar    'J
 lcd_param = &H41 : gosub lcd_writechar    'A
 if abbrechen = on then goto nicht_loeschen
 if loeschen = on then goto loeschen_variabeln
 goto loeschroutine

#nicht_loeschen
 gosub lcd_cls
 return
 
#loeschen_variabeln
 zaehlermah = 0
 zaehlerah = 0
 wattstd = 0
 kilowattstd = 0
 zwischenzaehler = 0
 gosub write_data
 b = 0
 gosub lcd_cls
 lcd_param = 2 : gosub lcd_gotoline
 gosub anzeige_zaehler
 lcd_param = 3    : gosub lcd_gotoline
 lcd_param = &H47 : gosub lcd_writechar    'G
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H4F : gosub lcd_writechar    'O
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H53 : gosub lcd_writechar    'S
 lcd_param = &H43 : gosub lcd_writechar    'C
 lcd_param = &H48 : gosub lcd_writechar    'H
 lcd_param = &H54 : gosub lcd_writechar    'T
 gosub leerzeichen
 gosub anzeige_ausrufezeichen
 pause 200
 return


'------------------------------------------------------------------------------
'- KONVERTIERUNG DER TAUSENDER, HUNDERTER, ZEHNER UND EINER FUER DIE ANZEIGE --
'------------------------------------------------------------------------------

#convert_zahlen_tausend
 'Tausender-Dezimalstelle oder Leerzeichen
 hilfsvalue = abs(value)
 if abs(value) >= 1000 then lcd_param = &H30 + hilfsvalue/1000 else lcd_param = &H20
 gosub LCD_WRITECHAR
 hilfsvalue = hilfsvalue mod 1000

#convert_zahlen_hundert
 'Hunderter-Dezimalstelle oder Leerzeichen
 if abs(value) >= 100 then lcd_param = &H30 + hilfsvalue/100 else lcd_param = &H20
 gosub LCD_WRITECHAR
 hilfsvalue = hilfsvalue mod 100

#convert_zahlen_zehner
   'Zehner-Dezimalstelle oder Leerzeichen
 if abs(value) >= 10 then lcd_param = &H30 + hilfsvalue/10 else lcd_param = &H20
 gosub LCD_WRITECHAR

  'einer Dezimalstelle
#convert_zahlen_einer
 lcd_param = &H30 + hilfsvalue mod 10
 gosub LCD_WRITECHAR
return



'----------------------------------------------------------------------------
'------------------ VERSIONSNUMMER ANZEIGEN BEI HOCHLAUF---------------------
'----------------------------------------------------------------------------

 #version
 gosub lcd_cls
 lcd_param = 2 : gosub lcd_gotoline
   for a = 0 to 13
    looktab version_zeile_1, a, lcd_param
    gosub lcd_writechar
   next a
 lcd_param = 3 : gosub lcd_gotoline
   for a = 0 to 12
    looktab version_zeile_2, a, lcd_param
    gosub lcd_writechar
   next a
 pause 150
 gosub lcd_cls
 return


'-------------------------------------------------------------------------
'------------------------------ LCD ROUTINEN -----------------------------
'-------------------------------------------------------------------------

#LCD_INIT
' alle ports 0
  lcd_port = OFF

' 8-Bit-Modus aktivieren
  lcd_param=&H38 : gosub LCD_WRITECMD

' mit 8-Bit-Command in 4-Bit-Modus umschalten
  lcd_port=&B00000010
  tog lcd_e
  tog lcd_e

' ab jetzt 4-Bit-Modus
  lcd_param = &H28 : gosub LCD_WRITECMD
  lcd_param = &H0C : gosub LCD_WRITECMD

' Display loeschen
#LCD_CLS
  lcd_param = &H02 : gosub LCD_WRITECMD
  lcd_param = &H01 : gosub LCD_WRITECMD
return

' Zeilenwechsel
#LCD_GOTOLINE
  if lcd_param = 1 then lcd_param = &H80
  if lcd_param = 2 then lcd_param = &HC0
  if lcd_param = 3 then lcd_param = &H90
  if lcd_param = 4 then lcd_param = &HD0
  goto LCD_WRITECMD

' LCD-Kommando
#LCD_WRITECMD
  lcd_buf = OFF
  goto LCD_WRITE

' Zeichenausgabe
#LCD_WRITECHAR
  lcd_buf = &B00100000

' Kommando oder Zeichen an Display senden
#LCD_WRITE
  lcd_port = lcd_buf or (lcd_param shr 4) ' Hi-Nibble
  tog lcd_e
  tog lcd_e
  lcd_port = lcd_buf or (lcd_param and &H0F)  ' Lo-Nibble
  tog lcd_e
  tog lcd_e
return 

'-------------------------------------------------------------------------------------------
'------------------------------TEXTE FUER ANZEIGE--------------------------------------------
'-------------------------------------------------------------------------------------------

#leerzeichen
 lcd_param = &H20 : gosub lcd_writechar    '
 return

#anzeige_komma
 lcd_param = &H2C : gosub lcd_writechar    ',
 return

#anzeige_doppelpunkt
 lcd_param = &H3A : gosub lcd_writechar    ':
 return

#anzeige_ausrufezeichen
 lcd_param = &H21 : gosub lcd_writechar    '!
 return

#anzeige_volt
 lcd_param = &H56 : gosub lcd_writechar    'V
 return


#anzeige_batterie
 lcd_param = &H42 : gosub lcd_writechar    'B
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H54 : gosub lcd_writechar    'T
 lcd_param = &H54 : gosub lcd_writechar    'T
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H52 : gosub lcd_writechar    'R
 lcd_param = &H49 : gosub lcd_writechar    'I
 lcd_param = &H45 : gosub lcd_writechar    'E
 return

#anzeige_summe
 lcd_param = &H53 : gosub lcd_writechar    'S
 lcd_param = &H55 : gosub lcd_writechar    'U
 lcd_param = &H4D : gosub lcd_writechar    'M
 lcd_param = &H4D : gosub lcd_writechar    'M
 lcd_param = &H45 : gosub lcd_writechar    'E
 gosub anzeige_doppelpunkt
 return
 
#anzeige_zaehler
 lcd_param = &H5A : gosub lcd_writechar    'Z
 lcd_param = &H41 : gosub lcd_writechar    'A
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H48 : gosub lcd_writechar    'H
 lcd_param = &H4C : gosub lcd_writechar    'L
 lcd_param = &H45 : gosub lcd_writechar    'E
 lcd_param = &H52 : gosub lcd_writechar    'R
 return

'--------------------------------------------------------------------------------------------
'--------------------------DATEN IM EPROM LESEN UND SCHREIBEN--------------------------------
'--------------------------------------------------------------------------------------------

#read_data
  open# for read
  if eof then return
  input# zaehlermah         'Zaehler fuer Milliamperestunden
  input# zaehlerah          'Zaehler fuer Amperestaunden
  input# wattstd            'Zaehler fuer Wattstunden
  input# kilowattstd        'Zaehler fuer Kilowattstunden
  input# zwischenzaehler    'Zaehler fuer Wattstundenberechnung
  close#
return

#write_data
  b = 1
  open# for write
  print# zaehlermah         'Zaehler fuer Milliamperstunden
  print# zaehlerah          'Zaehler fuer Amperestunden
  print# wattstd            'Zaehler fuer Wattstunden
  print# kilowattstd        'Zaehler fuer Kilowattstunden
  print# zwischenzaehler    'Zaehler fuer Wattstundenberechnung
  close#
 return

'-------------------------------------------------------------------------------------------
'------------------------------TEXTE FUER HOCHLAUF DES SYSTEMS-------------------------------
'-------------------------------------------------------------------------------------------

'-------------ANZEIGE DER VERSIONSNUMMER--------------

table version_zeile_1
&H20 &H20 &H56 &H45 &H52 &H53 &H49 &H4F &H4E &H20       'Version 2.3
&H20 &H32 &H2E &H33
tabend

'------------ANZEIGE DES PROGRAMMIERDATUMS------------

table version_zeile_2
&H20 &H20 &H20 &H31 &H36 &H2E &H30 &H38 &H2E &H32       '16.08.2003
&H30 &H30 &H33
tabend

