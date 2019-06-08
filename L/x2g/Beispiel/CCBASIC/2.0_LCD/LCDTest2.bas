'-----port 2 lcd connections-----'
define db4 port[9]  'databus 4'
define db5 port[10] 'databus 5'
define db6 port[11] 'databus 6'
define db7 port[12] 'databus 7'
define rw port[13] '0 = write to lcd display / 1 = read from lcd display'
define rs port[14] '0 = command / 1 = data'
define en port[15] '1 to 0 = enable'
define lcd_light_off port[16] '(off)0 = light on / (on)1 = light off'

'******************************************************* VARIABLES *******************************************************'
define data byte[1]'data / used for translating byte into bits and vice versa for I/O of port 2 (lcd port), -'
define bit1 bit[1] '- needed because of a bug in the CC1 M2.01 system'
define bit2 bit[2]
define bit3 bit[3]
define bit4 bit[4]
define bit5 bit[5]
define bit6 bit[6]
define bit7 bit[7]
define bit8 bit[8] '-----------------------------------------------------------------------------------------'

define adr byte[2] 'address code'
define cmd byte[3] 'command code'
define dat byte[4] 'data code'
define dat2 byte[5]

define loop byte[6]
'******************************************************** SET UP *********************************************************'
print"#ON_LCD#";:print"#INIT#";:print"#CLR#";:print"#OFF#";:lcd_light_off = 0  'initialize lcd display'
gosub character_build
'*************************************************************************************************************************'
DEFINE UP       PORT[1]
DEFINE DOWN   PORT[2]
DEFINE I             BYTE[7]
DEFINE AanTal        BYTE[8]
DEFINE IngangTotaal  WORD[5]
DEFINE TEMP          WORD[6]
DEFINE AantalTot     BYTE[13]
define start_print byte[14]

define last_start_print byte[15]
define last_IngangTotaal word[9]

start_print = 1
last_IngangTotaal = 0
last_start_print = 0


print"#ON_LCD#";

#Start
IngangTotaal=31    'voor simulate aantaltot is then 5

gosub keys
if (IngangTotaal = last_IngangTotaal) and (start_print = last_start_print) then goto start
last_IngangTotaal = IngangTotaal
last_start_print = start_print

GOSUB TelaantalTot

#SetDisplay
PRINT "#L101#";         'Regel 1, POSITON 1
PRINT "Er zijn ";
PRINT AantalTot;
PRINT "meldingen ";
Temp=InGangTotaal
if AantalTot = 0 then gosub clear_last_three_lines
Aantal = 0
FOR I=1 TO 16
if I >= start_print then IF (Temp AND 1)<>0 THEN GOSUB Tekst
Temp=Temp SHR 1
NEXT
if (AantalTot > 3) and (start_print < (AantalTot - 2)) then gosub DOWNSet
if (AantalTot > 3) and (start_print > 1) then gosub UPSet

GOTO Start

#Tekst
Aantal=Aantal+1
if aantal = 1 then gosub clear_last_three_lines
if aantal = 2 then gosub clear_last_two_lines
if aantal = 3 then gosub clear_last_line
IF aantal=1 THEN PRINT "#L201#";       'Regel 2, POSITON 1
IF aantal=2 THEN PRINT "#L121#";       'Regel 3, POSITON 1
IF Aantal=3 THEN print"#L221#";        'Regel 4, POSITON 1
if aantal > 3 then return
IF I=1  THEN print"Ingang 1            ";
IF I=2  THEN print"Ingang 2            ";
IF I=3  THEN print"Ingang 3            ";
IF I=4  THEN print"Ingang 4            ";
IF I=5  THEN print"Ingang 5            ";
IF I=6  THEN print"Ingang 6            ";
IF I=7  THEN print"Ingang 7            ";
IF I=8  THEN print"Ingang 8            ";
IF I=9  THEN print"Ingang 9            ";
IF I=10 THEN print"Ingang 10           ";
IF I=11 THEN print"Ingang 11           ";
IF I=12 THEN print"Ingang 12           ";
RETURN

#clear_last_three_lines
print "#L201#";
print"                    ";
#clear_last_two_lines
print "#L121#";
print"                    ";
#clear_last_line
print"#L221#";
print"                    ";
return

#TelAantalTot
AantalTot = 0
Temp=InGangTotaal
FOR I=1 TO 16
IF (Temp AND 1)<>0 THEN AantalTot=AantalTot+1
Temp=Temp SHR 1
NEXT
RETURN

#DOWNSet
print"#L240#";           'Regel 4, POSITON 20
put&h08                  'UP'
RETURN

#UPSet
PRINT "#L220#";       'Regel 2, POSITON 20
put&h09                  'DOWN'
RETURN

#keys
IF DOWN=ON THEN if start_print - 1 < 1 then start_print = 1 else start_print = start_print - 1
if down = on then pause 10
if up = on then start_print = start_print + 1
if up = on then pause 10
if AantalTot < 4 then start_print = 1
if AantalTot > 3 then if start_print > (AantalTot - 2) then start_print = AantalTot - 2
return
'*************************************************************************************************************************'
#command_to_lcd
gosub busy_flag_check_from_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 0:en = 0           'setup for transmitting command to lcd display'
data = cmd / 16:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en   'HIGH NIBBLE command to lcd'
data = cmd mod 16:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en 'LOW NIBBLE command to lcd'
return
'*************************************************************************************************************************'
#data_to_CG_ram_lcd
cmd = &b01000000 or adr : gosub command_to_lcd
#put_data_into_lcd
gosub busy_flag_check_from_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 1:en = 0           'setup for transmitting data to lcd display'
data = dat / 16:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en   'HIGH NIBBLE data to lcd'
data = dat mod 16:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en 'LOW NIBBLE data to lcd'
return
'*************************************************************************************************************************'
#busy_flag_check_from_lcd
deact db7 : deact db6 : deact db5 : deact db4:rw = 1:rs = 0:en = 1 'setup for reading busy flag'
bit8 = db7:bit7 = db6:bit6 = db5:bit5 = db4                        'HIGH NIBBLE data from lcd'
pulse en:bit4 = db7:bit3 = db6:bit2 = db5:bit1 = db4:en = 0        'LOW NIBBLE data from lcd'
if bit8 then goto busy_flag_check_from_lcd 'bit 8 of data is the busy flag bit / 1 = lcd is busy / 0 = lcd is ready'
return
'*************************************************************************************************************************'

#character_build 'generates characters in lcd ram from characterbuild table / 8 characters of 5X8 pixels'
for adr = 0 to 63                'lcd display character generation (CG) address'
looktab characterbuild, adr, dat 'lcd data for character generation'
gosub data_to_CG_ram_lcd         'set character generation data in CG address'
next
return
'*************************************************************************************************************************'
'                 (CG    dat     adr) 000/XXXXX  first 3 bits are not used/ last 5 bits are for character generation   '

table characterbuild &b00000100 '(0)  000/  1  ' character build data for antenna symbol/ read from DD-ram address &h08'
                     &b00001110 '(1)  000/ 111 '                                                               *put&h08*'
                     &b00011111 '(2)  000/11111'
                     &b00000100 '(3)  000/  1  '
                     &b00000100 '(4)  000/  1  '
                     &b00000100 '(5)  000/  1  '
                     &b00000100 '(6)  000/  1  '
                     &b00000000 '(7)  000/     '-----------------------------------------'
                     &b00000100 '(8)  000/  1  ' character build data for heart/ read from DD-ram address &h09'
                     &b00000100 '(9)  000/  1  '                                                      *put&h09*'
                     &b00000100 '(10) 000/  1  '
                     &b00000100 '(11) 000/  1  '
                     &b00011111 '(12) 000/11111'
                     &b00001110 '(13) 000/ 111 '
                     &b00000100 '(14) 000/  1  '
                     &b00000000 '(15) 000/     '-----------------------------------------'
                     &b00000000 '(16) 000/     ' character build data for happy/ read from DD-ram address &h0a'
                     &b00000000 '(17) 000/     '                                                      *put&h0a*'
                     &b00001010 '(18) 000/ 1 1 '
                     &b00000000 '(19) 000/     '
                     &b00000100 '(20) 000/  1  '
                     &b00010001 '(21) 000/1   1'
                     &b00001110 '(22) 000/ 111 '
                     &b00000000 '(23) 000/     '-----------------------------------------'
                     &b00011111 '(24) 000/11111 character build data for window/ read from DD-ram address &h0b'
                     &b00010101 '(25) 000/1 1 1'                                                      *put&h0b*'
                     &b00010101 '(26) 000/1 1 1'
                     &b00011111 '(27) 000/11111'
                     &b00010101 '(28) 000/1 1 1'
                     &b00010101 '(29) 000/1 1 1'
                     &b00011111 '(30) 000/11111'
                     &b00011111 '(31) 000/11111'-----------------------------------------'
                     &b00000000 '(32) 000/00000 empty place for character build data/ read from DD-ram address &h0c'
                     &b00000000 '(33) 000/00000'                                                           *put&h0c*'
                     &b00000000 '(34) 000/00000'
                     &b00000000 '(35) 000/00000'
                     &b00000000 '(36) 000/00000'
                     &b00000000 '(37) 000/00000'
                     &b00000000 '(38) 000/00000'
                     &b00000000 '(39) 000/00000 -----------------------------------------'
                     &b00000000 '(40) 000/00000 empty place for character build data/ read from DD-ram address &h0d'
                     &b00000000 '(41) 000/00000'                                                           *put&h0d*'
                     &b00000000 '(42) 000/00000'
                     &b00000000 '(43) 000/00000'
                     &b00000000 '(44) 000/00000'
                     &b00000000 '(45) 000/00000'
                     &b00000000 '(46) 000/00000'
                     &b00000000 '(47) 000/00000 -----------------------------------------'
                     &b00000000 '(48) 000/00000 empty place for character build data/ read from DD-ram address &h0e'
                     &b00000000 '(49) 000/00000'                                                           *put&h0e*'
                     &b00000000 '(50) 000/00000'
                     &b00000000 '(51) 000/00000'
                     &b00000000 '(52) 000/00000'
                     &b00000000 '(53) 000/00000'
                     &b00000000 '(54) 000/00000'
                     &b00000000 '(55) 000/00000 -----------------------------------------'
                     &b00000000 '(56) 000/00000 empty place for character build data/ read from DD-ram address &h0f'
                     &b00000000 '(57) 000/00000'                                                           *put&h0f*'
                     &b00000000 '(58) 000/00000'
                     &b00000000 '(59) 000/00000'
                     &b00000000 '(60) 000/00000'
                     &b00000000 '(61) 000/00000'
                     &b00000000 '(62) 000/00000'
                     &b00000000 '(63) 000/00000 -----------------------------------------'
tabend
 

 
' Antwort schreiben


'Bisherige Antworten:

'Re: Display 4x20 Scroll (von Hans - 25.09.2005 15:18)
'    Re: Display 4x20 Scroll (von Windt H.J. - 25.09.2005 21:39)


