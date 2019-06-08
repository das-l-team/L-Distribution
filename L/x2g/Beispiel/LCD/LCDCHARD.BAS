'****************************************************************************
'
' C-Control/BASIC   LCDCHARD.BAS
'
' Eigene Zeichen definieren fÅr das LCD Display
'   Das LCD Display, das von der Firma Conrad mit dem Application Board
'   ausgeliefert wird, enthÑlt als Controller einen HD 44780. Der Controller
'   kann unterschiedliche LCD Displays ansteuern. Einzeilige, zweizeilige,
'   vierzeilige, solche mit 16 Zeichen und mit 20 Zeichen. Andere mîgen
'   auch gehen. Solltest Du also ein anderes als das von Conrad verkaufte
'   LCD-Modul haben, so kann es durchaus sein, da· dieses Programm
'   funktioniert. Hauptsache, es steckt ein HD 44780 drin.
'
'   Der Controller kann Displays mit 5 x 8 und 5 x 10 Punktmatrix an-
'   steuern. Die Beispiele hier beziehen sich auf die 5 x 8 Punktmatrix.
'   FÅr eine 5 x 10 Matrix sind die Beispiele entsprechend abzuwandeln.
'
'   Der Controller enthÑlt einen festen Zeichensatz im ROM. Es kînnen 
'   jedoch 8 Zeichen durch das Anwendungsprogramm definiert werden. Dazu
'   enthÑlt der Controller einen 64 Bytes gro·en RAM, wo die Zeichen ab-
'   gelegt werden. Der Speicher nennt sich CGRAM (Character Generator RAM).
'   Die definierten Zeichen kînnen dann als &H00 bis &H07 benutzt werden
'   (ASCII). Der Speicher ist leider flÅchtig. Das hei·t, da· der Inhalt
'   verlorengeht, wenn die Stromzufuhr unterbrochen wird. Eigene Zeichen
'   mÅssen also vom Programm immer Åbertragen werden. Am besten, am
'   Programmanfang.
'
'   Die Zeichen liegen an bestimmten Adressen im Speicher des Controllers:
'      1. Zeichen: &B000000
'      2. Zeichen: &B001000
'      3. Zeichen: &B010000
'      4. Zeichen: &B011000
'      5. Zeichen: &B100000
'      6. Zeichen: &B101000
'      7. Zeichen: &B110000
'      8. Zeichen: &B111000
'   Richtig! Die Adressen sind 6 Bit breit! Die Adresse wird auf den
'   Datenbus gelegt (D0 bis D7). Die beiden Bits davor MöSSEN &B01 sein,
'   um dem Controller anzuzeigen, da· jetzt eine Adresse aus dem CGRAM
'   folgt, in die geschrieben werden kann. Die Routine LCD_WRITECMD er-
'   ledigt zufÑllig genau das Passende, so da· mit
'      lcd_param = &B01000000 : gosub LCD_WRITECMD
'   der Adre·zeiger auf das erste Zeichen positioniert wird.
'   Danach werden die Definitionen fÅr das Zeichen einfach in den Speicher
'   geschrieben. LCD_WRITECHAR pa·t an dieser Stelle zufÑllig auch genau.
'
'   Die Definition ist relativ simpel: Ein Zeichen besteht aus 5 mal 8
'   Punkten. Jede Zeile stellt ein Byte dar, wobei die letzten 5 Bit die
'   Punkte der Zeile sind. Das erste Byte ist die oberste Zeile. Das zweite
'   Byte die zweite Zeile und so weiter. Bis zur 8. Zeile.
'   Jedes gesetzte Bit stellt einen schwarzen Punkt auf dem Display dar.
'
'                CGRAM-Adresse   Definitionsbyte   Beschreibung
'   -----------+---------------+-----------------+-------------------
'   1. Zeichen   0 0 0  0 0 0    * * * 0 0 0 0 0   1.Zeichen 1. Zeile
'                0 0 0  0 0 1    * * * 0 0 0 0 0   1.Zeichen 2. Zeile
'                0 0 0  0 1 0    * * * 0 0 0 0 0   1.Zeichen 3. Zeile
'                0 0 0  0 1 1    * * * 0 0 0 0 0   1.Zeichen 4. Zeile
'                0 0 0  1 0 0    * * * 0 0 0 0 0   1.Zeichen 5. Zeile
'                0 0 0  1 0 1    * * * 0 0 0 0 0   1.Zeichen 6. Zeile
'                0 0 0  1 1 0    * * * 0 0 0 0 0   1.Zeichen 7. Zeile
'                0 0 0  1 1 1    * * * 0 0 0 0 0   1.Zeichen 8. Zeile
'
'   2. Zeichen   0 0 1  0 0 0    * * * 0 0 0 0 0   2.Zeichen 1. Zeile
'                0 0 1  0 0 1    * * * 0 0 0 0 0   2.Zeichen 2. Zeile
'                0 0 1  0 1 0    * * * 0 0 0 0 0   2.Zeichen 3. Zeile
'                0 0 1  0 1 1    * * * 0 0 0 0 0   2.Zeichen 4. Zeile
'                0 0 1  1 0 0    * * * 0 0 0 0 0   2.Zeichen 5. Zeile
'                0 0 1  1 0 1    * * * 0 0 0 0 0   2.Zeichen 6. Zeile
'                0 0 1  1 1 0    * * * 0 0 0 0 0   2.Zeichen 7. Zeile
'                0 0 1  1 1 1    * * * 0 0 0 0 0   2.Zeichen 8. Zeile
'  
'   3. Zeichen   0 1 0  0 0 0    * * * 0 0 0 0 0   3.Zeichen 1. Zeile
'                0 1 0  0 0 1    * * * 0 0 0 0 0   3.Zeichen 2. Zeile
'                0 1 0  0 1 0    * * * 0 0 0 0 0   3.Zeichen 3. Zeile
'                0 1 0  0 1 1    * * * 0 0 0 0 0   3.Zeichen 4. Zeile
'                0 1 0  1 0 0    * * * 0 0 0 0 0   3.Zeichen 5. Zeile
'                0 1 0  1 0 1    * * * 0 0 0 0 0   3.Zeichen 6. Zeile
'                0 1 0  1 1 0    * * * 0 0 0 0 0   3.Zeichen 7. Zeile
'                0 1 0  1 1 1    * * * 0 0 0 0 0   3.Zeichen 8. Zeile
'                .
'                .
'                .
'  
'   8. Zeichen   1 1 1  0 0 0    * * * 0 0 0 0 0   8.Zeichen 1. Zeile
'                1 1 1  0 0 1    * * * 0 0 0 0 0   8.Zeichen 2. Zeile
'                1 1 1  0 1 0    * * * 0 0 0 0 0   8.Zeichen 3. Zeile
'                1 1 1  0 1 1    * * * 0 0 0 0 0   8.Zeichen 4. Zeile
'                1 1 1  1 0 0    * * * 0 0 0 0 0   8.Zeichen 5. Zeile
'                1 1 1  1 0 1    * * * 0 0 0 0 0   8.Zeichen 6. Zeile
'                1 1 1  1 1 0    * * * 0 0 0 0 0   8.Zeichen 7. Zeile
'                1 1 1  1 1 1    * * * 0 0 0 0 0   8.Zeichen 8. Zeile
'
'   Beispiel: wir wollen uns das Zeichen &H06 definieren. Es soll wie
'             folgt aussehen:
'                X . . . X
'                X . . . X
'                X X X X X
'                X . . . X
'                X . . . X
'                . X . X .
'                . . X . .
'                . . . . .
'             Jedes 'X' steht fÅr einen gesetzten Punkt.
'             Daraus ergibt sich der folgende Sourcecode:
'
'             'Wir definieren das Zeichen &H06 im CGRAM des LCD Controllers.
'             'Die Adresse ist &B110000 bis &B110111.
'
'             '1. Wir teilen dem Controller mit, da· wir ab jetzt in den
'             '   CGRAM ab Adresse &B110000 ff. schreiben wollen:
'             lcd_param = &B01110000 : gosub LCD_WRITECMD
'
'             '2. Wir teilen dem Controller mit, da· der Adre·zÑhler nach
'             '   jedem Schreibvorgang um Eins ERHôHT werden soll:
'             lcd_param = &B00000110 : gosub LCD_WRITECMD
'
'             '3. Wir schreiben locker nacheinander weg die Definitionen der
'             '   8 Zeilen. Es zÑhlen nur die rechten 5 Bit. Jedes gesetzte
'             '   Bit steht fÅr einen dunklen Punkt. Genauso, wie wir die
'             '   Zeile hinterher zu sehen kriegen.
'             lcd_param = &B00010001 : gosub LCD_WRITECHAR '1. Zeile
'             lcd_param = &B00010001 : gosub LCD_WRITECHAR '2. Zeile
'             lcd_param = &B00011111 : gosub LCD_WRITECHAR '3. Zeile
'             lcd_param = &B00010001 : gosub LCD_WRITECHAR '4. Zeile
'             lcd_param = &B00010001 : gosub LCD_WRITECHAR '5. Zeile
'             lcd_param = &B00001010 : gosub LCD_WRITECHAR '6. Zeile
'             lcd_param = &B00000100 : gosub LCD_WRITECHAR '7. Zeile
'             lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
'
'             'Wir wiederholen die Schritte 1 und 3 fÅr jedes weitere
'             'Zeichen, das wir definieren wollen.
'
'             '4. Wir teilen dem Controller mit, da· ab jetzt wieder in
'             '   den normalen DDRAM (Display Data RAM) geschrieben werden
'             '   soll. Damit wird der Cursor auf das erste Zeichen in der
'             '   ersten Zeile gesetzt.
'             lcd_param = &B10000000 : gosub LCD_WRITECMD
'
'
'
' Systemvoraussetzungen:
' - Application Board mit angeschlossenem Display
'
' Andreas Richau, Email: ARichau@provinzial-online.de
'
' Dieser Sourcecode darf frei in eigenen Programmen verwendet werden.
'
'****************************************************************************

'****************************************************************************
'*   Variablen (Daten). Max. 24 Byte!                                       *
'****************************************************************************
define i        byte      'Schleifenvariable

'--- LCD Display ------------------------------------------------------------
define lcd_buf   byte
define lcd_param byte

'****************************************************************************
'*   Tastatur-Port                                                          *
'****************************************************************************
define keyboard  ad[8]

'****************************************************************************
'*   LCD Display Ports                                                      *
'****************************************************************************
define lcd_port  byteport[2]   '8 Bit Port 2 (9-16)
define lcd_rw    port[13]
define lcd_rs    port[14]
define lcd_e     port[15]

'****************************************************************************
'*   Andreas' Magic LCD Display Constants                       Ver. 1.00   *
'*   ------------------------------------                       20.09.1999  *
'*   Aufruf: lcd_param = <konstante> : gosub LCD_WRITECMD                   *
'*   Copyright (c) 1999 Andreas Richau. All rights reserved.                *
'*                                      Alle Rechte vorbehalten.            *
'*   Email: ARichau@provinzial-online.de                                    *
'****************************************************************************
define LCD_CursorOff    &B00001100   'kein Cursor sichtbar
define LCD_CursorOn     &B00001110   'Unterstrich (nicht blinkend)
define LCD_CursorBlock  &B00001101   'gro·er Block, blinkend
define LCD_CursorLine   &B00001110   'Unterstrich (nicht blinkend)
define LCD_CursorBlink  &B00001111   'Unterstrich/Block, abwechselnd blinkend
define LCD_DisplayOff   &H08         'Display ausschalten
define LCD_DisplayOn    &H0C         'Display einschalten
define LCD_CursorLeft   &H10         'Cursor ein Zeichen nach links
define LCD_CursorRight  &H14         'Cursor ein Zeichen nach rechts
define LCD_DisplayLeft  &H18         'ges. Display ein Zeichen nach links
define LCD_DisplayRight &H1C         'ges. Display ein Zeichen nach rechts

define LCD_GotoLine1    &H80         'Cursor in Zeile 1
define LCD_GotoLine2    &HC0         'Cursor in Zeile 2

define LCD_GotoLine1c1  &H80         'Cursor in Zeile 1, Spalte 1
define LCD_GotoLine1c2  &H81         'Cursor in Zeile 1, Spalte 2
define LCD_GotoLine1c3  &H82         'Cursor in Zeile 1, Spalte 3
define LCD_GotoLine1c4  &H83         'Cursor in Zeile 1, Spalte 4
define LCD_GotoLine1c5  &H84         'Cursor in Zeile 1, Spalte 5
define LCD_GotoLine1c6  &H85         'Cursor in Zeile 1, Spalte 6
define LCD_GotoLine1c7  &H86         'Cursor in Zeile 1, Spalte 7
define LCD_GotoLine1c8  &H87         'Cursor in Zeile 1, Spalte 8
define LCD_GotoLine1c9  &H88         'Cursor in Zeile 1, Spalte 9
define LCD_GotoLine1c10 &H89         'Cursor in Zeile 1, Spalte 10
define LCD_GotoLine1c11 &H8A         'Cursor in Zeile 1, Spalte 11
define LCD_GotoLine1c12 &H8B         'Cursor in Zeile 1, Spalte 12
define LCD_GotoLine1c13 &H8C         'Cursor in Zeile 1, Spalte 13
define LCD_GotoLine1c14 &H8D         'Cursor in Zeile 1, Spalte 14
define LCD_GotoLine1c15 &H8E         'Cursor in Zeile 1, Spalte 15
define LCD_GotoLine1c16 &H8F         'Cursor in Zeile 1, Spalte 16
define LCD_GotoLine1c17 &H90         'Cursor in Zeile 1, Spalte 17
define LCD_GotoLine1c18 &H91         'Cursor in Zeile 1, Spalte 18
define LCD_GotoLine1c19 &H92         'Cursor in Zeile 1, Spalte 19
define LCD_GotoLine1c20 &H93         'Cursor in Zeile 1, Spalte 20
define LCD_GotoLine1c21 &H94         'Cursor in Zeile 1, Spalte 21
define LCD_GotoLine1c22 &H95         'Cursor in Zeile 1, Spalte 22
define LCD_GotoLine1c23 &H96         'Cursor in Zeile 1, Spalte 23
define LCD_GotoLine1c24 &H97         'Cursor in Zeile 1, Spalte 24
define LCD_GotoLine1c25 &H98         'Cursor in Zeile 1, Spalte 25
define LCD_GotoLine1c26 &H99         'Cursor in Zeile 1, Spalte 26
define LCD_GotoLine1c27 &H9A         'Cursor in Zeile 1, Spalte 27
define LCD_GotoLine1c28 &H9B         'Cursor in Zeile 1, Spalte 28
define LCD_GotoLine1c29 &H9C         'Cursor in Zeile 1, Spalte 29
define LCD_GotoLine1c30 &H9D         'Cursor in Zeile 1, Spalte 30
define LCD_GotoLine1c31 &H9E         'Cursor in Zeile 1, Spalte 31
define LCD_GotoLine1c32 &H9F         'Cursor in Zeile 1, Spalte 32
define LCD_GotoLine1c33 &HA0         'Cursor in Zeile 1, Spalte 33
define LCD_GotoLine1c34 &HA1         'Cursor in Zeile 1, Spalte 34
define LCD_GotoLine1c35 &HA2         'Cursor in Zeile 1, Spalte 35
define LCD_GotoLine1c36 &HA3         'Cursor in Zeile 1, Spalte 36
define LCD_GotoLine1c37 &HA4         'Cursor in Zeile 1, Spalte 37
define LCD_GotoLine1c38 &HA5         'Cursor in Zeile 1, Spalte 38
define LCD_GotoLine1c39 &HA6         'Cursor in Zeile 1, Spalte 39
define LCD_GotoLine1c40 &HA7         'Cursor in Zeile 1, Spalte 40

define LCD_GotoLine2c1  &HC0         'Cursor in Zeile 2, Spalte 1
define LCD_GotoLine2c2  &HC1         'Cursor in Zeile 2, Spalte 2
define LCD_GotoLine2c3  &HC2         'Cursor in Zeile 2, Spalte 3
define LCD_GotoLine2c4  &HC3         'Cursor in Zeile 2, Spalte 4
define LCD_GotoLine2c5  &HC4         'Cursor in Zeile 2, Spalte 5
define LCD_GotoLine2c6  &HC5         'Cursor in Zeile 2, Spalte 6
define LCD_GotoLine2c7  &HC6         'Cursor in Zeile 2, Spalte 7
define LCD_GotoLine2c8  &HC7         'Cursor in Zeile 2, Spalte 8
define LCD_GotoLine2c9  &HC8         'Cursor in Zeile 2, Spalte 9
define LCD_GotoLine2c10 &HC9         'Cursor in Zeile 2, Spalte 10
define LCD_GotoLine2c11 &HCA         'Cursor in Zeile 2, Spalte 11
define LCD_GotoLine2c12 &HCB         'Cursor in Zeile 2, Spalte 12
define LCD_GotoLine2c13 &HCC         'Cursor in Zeile 2, Spalte 13
define LCD_GotoLine2c14 &HCD         'Cursor in Zeile 2, Spalte 14
define LCD_GotoLine2c15 &HCE         'Cursor in Zeile 2, Spalte 15
define LCD_GotoLine2c16 &HCF         'Cursor in Zeile 2, Spalte 16
define LCD_GotoLine2c17 &HD0         'Cursor in Zeile 2, Spalte 17
define LCD_GotoLine2c18 &HD1         'Cursor in Zeile 2, Spalte 18
define LCD_GotoLine2c19 &HD2         'Cursor in Zeile 2, Spalte 19
define LCD_GotoLine2c20 &HD3         'Cursor in Zeile 2, Spalte 20
define LCD_GotoLine2c21 &HD4         'Cursor in Zeile 2, Spalte 21
define LCD_GotoLine2c22 &HD5         'Cursor in Zeile 2, Spalte 22
define LCD_GotoLine2c23 &HD6         'Cursor in Zeile 2, Spalte 23
define LCD_GotoLine2c24 &HD7         'Cursor in Zeile 2, Spalte 24
define LCD_GotoLine2c25 &HD8         'Cursor in Zeile 2, Spalte 25
define LCD_GotoLine2c26 &HD9         'Cursor in Zeile 2, Spalte 26
define LCD_GotoLine2c27 &HDA         'Cursor in Zeile 2, Spalte 27
define LCD_GotoLine2c28 &HDB         'Cursor in Zeile 2, Spalte 28
define LCD_GotoLine2c29 &HDC         'Cursor in Zeile 2, Spalte 29
define LCD_GotoLine2c30 &HDD         'Cursor in Zeile 2, Spalte 30
define LCD_GotoLine2c31 &HDE         'Cursor in Zeile 2, Spalte 31
define LCD_GotoLine2c32 &HDF         'Cursor in Zeile 2, Spalte 32
define LCD_GotoLine2c33 &HE0         'Cursor in Zeile 2, Spalte 33
define LCD_GotoLine2c34 &HE1         'Cursor in Zeile 2, Spalte 34
define LCD_GotoLine2c35 &HE2         'Cursor in Zeile 2, Spalte 35
define LCD_GotoLine2c36 &HE3         'Cursor in Zeile 2, Spalte 36
define LCD_GotoLine2c37 &HE4         'Cursor in Zeile 2, Spalte 37
define LCD_GotoLine2c38 &HE5         'Cursor in Zeile 2, Spalte 38
define LCD_GotoLine2c39 &HE6         'Cursor in Zeile 2, Spalte 39
define LCD_GotoLine2c40 &HE7         'Cursor in Zeile 2, Spalte 40

'****************************************************************************
'*   ASCII-Codes                                                            *
'****************************************************************************
define BLANK               &H20   'Zeichen ' '
define LEERZ               &H20   'Zeichen ' '
define char_Rufzeichen     &H21   'Zeichen !
define char_AnfZeichen     &H22   'Zeichen "
define char_Doppelkreuz    &H23   'Zeichen #
define char_Dollar         &H24   'Zeichen $
define char_Prozent        &H25   'Zeichen %
define char_Ampersand      &H26   'Zeichen &
define char_Apostroph      &H27   'Zeichen '
define char_KlammerAuf     &H28   'Zeichen (
define char_KlammerZu      &H29   'Zeichen )
define char_Stern          &H2A   'Zeichen *
define char_Plus           &H2B   'Zeichen +
define char_Komma          &H2C   'Zeichen ,
define char_Minus          &H2D   'Zeichen -
define char_Punkt          &H2E   'Zeichen .
define char_Schraegstrich  &H2F   'Zeichen /
define ziff_0              &H30   'Ziffer 0
define ziff_1              &H31   'Ziffer 1
define ziff_2              &H32   'Ziffer 2
define ziff_3              &H33   'Ziffer 3
define ziff_4              &H34   'Ziffer 4
define ziff_5              &H35   'Ziffer 5
define ziff_6              &H36   'Ziffer 6
define ziff_7              &H37   'Ziffer 7
define ziff_8              &H38   'Ziffer 8
define ziff_9              &H39   'Ziffer 9
define char_Doppelpunkt    &H3A   'Zeichen :
define char_Semikolon      &H3B   'Zeichen ;
define char_KleinerAls     &H3C   'Zeichen <
define char_Gleich         &H3D   'Zeichen =
define char_GroesserAls    &H3E   'Zeichen >
define char_Fragezeichen   &H3F   'Zeichen ?
define a_   &H61
define b_   &H62
define c_   &H63
define d_   &H64
define e_   &H65
define f_   &H66
define g_   &H67
define h_   &H68
define i_   &H69
define j_   &H6A
define k_   &H6B
define l_   &H6C
define m_   &H6D
define n_   &H6E
define o_   &H6F
define p_   &H70
define q_   &H71
define r_   &H72
define s_   &H73
define t_   &H74
define u_   &H75
define v_   &H76
define w_   &H77
define x_   &H78
define y_   &H79
define z_   &H7A
define ae_  &HE1
define oe_  &HEF
define ue_  &HF6
define sz_  &HE2
define AG_  &H41
define BG_  &H42
define CG_  &H43
define DG_  &H44
define EG_  &H45
define FG_  &H46
define GG_  &H47
define HG_  &H48
define IG_  &H49
define JG_  &H4A
define KG_  &H4B
define LG_  &H4C
define MG_  &H4D
define NG_  &H4E
define OG_  &H4F
define PG_  &H50
define QG_  &H51
define RG_  &H52
define SG_  &H53
define TG_  &H54
define UG_  &H55
define VG_  &H56
define WG_  &H57
define XG_  &H58
define YG_  &H59
define ZG_  &H5A
define char_EckKlammAuf    &H5B   'Zeichen [
define char_EckKlammZu     &H5D   'Zeichen ]
define char_Caret          &H5E   'Zeichen ^
define char_Unterstrich    &H5F   'Zeichen _
define char_GeschwKlammAuf &H7B   'Zeichen {
define char_VertStrich     &H7C   'Zeichen |
define char_GeschwKlammZu  &H7D   'Zeichen }
define char_PfeilRechts    &H7E   'Pfeil nach rechts
define char_PfeilLinks     &H7F   'Pfeil nach links
define char_Spot           &HA5   'Zeichen ''
define char_HorStrich      &HB0   'Zeichen 'ƒ'
define char_Grad           &HDF   'Zeichen ¯
define char_Mykro          &HE4   'Zeichen Ê
define char_Unendlich      &HF4   'Zeichen Ï
define char_Ohm            &HF5   'Zeichen Í
define char_Block          &HFF   'Zeichen '€'



'****************************************************************************
'*--------------------------------------------------------------------------*
'*   Hauptroutine                                                           *
'*--------------------------------------------------------------------------*
'****************************************************************************
  gosub LCD_INIT

  '--------------------------------------------------------------------------
  ' Wir definieren die Zeichen &H00 bis &H07 im LCD Display Controller
  '--------------------------------------------------------------------------

  'Nach dem Schreiben eines Bytes aufwÑrts zÑhlen
  lcd_param = &B00000110 : gosub LCD_WRITECMD

  'Zeichen &H00 definieren. Ab Adresse &B000000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: Dreieck nach rechts   
  lcd_param = &B01000000 : gosub LCD_WRITECMD
    lcd_param = &B00001000 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00001100 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00001110 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00001111 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00001110 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00001100 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00001000 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile

  'Zeichen &H01 definieren. Ab Adresse &B001000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: Dreieck nach links
  lcd_param = &B01001000 : gosub LCD_WRITECMD
    lcd_param = &B00000001 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000011 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00000111 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00001111 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00000111 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00000011 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00000001 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H02 definieren. Ab Adresse &B010000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: é (gro·es A Umlaut)
  lcd_param = &B01010000 : gosub LCD_WRITECMD
    lcd_param = &B00001010 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000100 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00001010 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00011111 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H03 definieren. Ab Adresse &B011000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: ô (gro·es O Umlaut)
  lcd_param = &B01011000 : gosub LCD_WRITECMD
    lcd_param = &B00001010 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00001110 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00001110 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H04 definieren. Ab Adresse &B100000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: ö (gro·es U Umlaut)
  lcd_param = &B01100000 : gosub LCD_WRITECMD
    lcd_param = &B00001010 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00010001 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00001110 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H05 definieren. Ab Adresse &B101000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: (leer)
  lcd_param = &B01101000 : gosub LCD_WRITECMD
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H06 definieren. Ab Adresse &B110000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: (leer)
  lcd_param = &B01110000 : gosub LCD_WRITECMD
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile
    
  'Zeichen &H07 definieren. Ab Adresse &B111000 im CGRAM.
  'Es sind nur die 5 rechten Bits relevant.
  'Zeichen: (leer)
  lcd_param = &B01111000 : gosub LCD_WRITECMD
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '1. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '2. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '3. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '4. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '5. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '6. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '7. Zeile
    lcd_param = &B00000000 : gosub LCD_WRITECHAR '8. Zeile

  'Ab jetzt wieder in den normalen DDRAM (Display Data RAM) schreiben
  lcd_param = &B10000000 : gosub LCD_WRITECMD

  '--------------------------------------------------------------------------
  ' Ende der Definition von Zeichen
  '--------------------------------------------------------------------------
    
    
    
  'Ausgabe von 'Zeichen 00-07:' auf dem Display
  lcd_param = zG_ : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = e_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = i_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = c_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = h_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = e_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = n_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = BLANK : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = ziff_0 : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = ziff_0 : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = char_Minus : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = ziff_0  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = ziff_7  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = char_Doppelpunkt : gosub LCD_WRITECHAR   'Zeichen ausgeben

  lcd_param = LCD_GotoLine2c1 : gosub LCD_WRITECMD '2. Zeile, 1. Zeichen
  for i=0 to 7
    lcd_param = i   'Zeichen 00 - 07 ausgeben
    gosub LCD_WRITECHAR
  next 'i

  lcd_param = BLANK : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = &H00 : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = nG_ : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = e_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = u_  : gosub LCD_WRITECHAR   'Zeichen ausgeben
  lcd_param = &H01 : gosub LCD_WRITECHAR   'Zeichen ausgeben


  '--------------------------------------------------------------------------
  '   P r o g r a m m e n d e
  '--------------------------------------------------------------------------
  end



'****************************************************************************
'*--------------------------------------------------------------------------*
'*   Unterprogramme                                                         *
'*--------------------------------------------------------------------------*
'****************************************************************************



'****************************************************************************
'*   LCD_INIT                                                               *
'*--------------------------------------------------------------------------*
'*   Initialisieren des LCD Displays, Anzeige lîschen                       *
'*   keine Parameter                                                        *
'****************************************************************************
#LCD_INIT

  'alle ports 0
  lcd_port = OFF

  '8-Bit-Modus aktivieren
  lcd_param=&H38 : gosub LCD_WRITECMD

  'mit 8-Bit-Command in 4-Bit-Modus umschalten
  lcd_port=&B00000010
  tog lcd_e
  tog lcd_e

  'ab jetzt 4-Bit-Modus
  lcd_param = &H28 : gosub LCD_WRITECMD
  lcd_param = &H0C : gosub LCD_WRITECMD



'****************************************************************************
'*   LCD_CLS                                                                *
'*--------------------------------------------------------------------------*
'*   LCD Anzeige lîschen                                                    *
'*                                                                          *
'****************************************************************************
#LCD_CLS
  lcd_param = &H02 : gosub LCD_WRITECMD
  lcd_param = &H01 : gosub LCD_WRITECMD
return



'****************************************************************************
'*   LCD_WRITECMD                                                           *
'*--------------------------------------------------------------------------*
'*   intern: Befehl an LCD Display senden                                   *
'*   Parameter: lcd_param : Kommando                                        *
'****************************************************************************
#LCD_WRITECMD
  lcd_buf = OFF
  goto LCD_WRITE



'****************************************************************************
'*   LCD_WRITECHAR                                                          *
'*--------------------------------------------------------------------------*
'*   Zeichen auf dem Display an der nÑchsten Position ausgeben              *
'*   Parameter: lcd_param : Zeichen (ASCII)                                 *
'****************************************************************************
#LCD_WRITECHAR
  lcd_buf = &B00100000



'****************************************************************************
'*   LCD_WRITE                                                              *
'*--------------------------------------------------------------------------*
'*   intern: Kommando oder Zeichen an Display senden                        *
'*   Parameter: lcd_param : Zeichen oder Kommando                           *
'****************************************************************************
#LCD_WRITE
  lcd_port = lcd_buf or (lcd_param shr 4) ' Hi-Nibble
  tog lcd_e
  tog lcd_e
  lcd_port = lcd_buf or (lcd_param and &H0F)  ' Lo-Nibble
  tog lcd_e
  tog lcd_e
return
