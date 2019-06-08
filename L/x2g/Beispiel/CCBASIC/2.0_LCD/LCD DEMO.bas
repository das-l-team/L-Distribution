'-------------------------------------------------------------------------------------------------------------------------'
'          *************************************************************************************************'
'          *                                      WINDT SYSTEMS                                            *'
'          *               LCD Possibilitiy Examples v1.3 For The C-Control 1 Unit M2.01                   *'
'          *                                        H.J. WINDT                                             *'
'          *                                          2004                                                 *'
'          *************************************************************************************************'
'-------------------------------------------------------------------------------------------------------------------------'
'This program shows the possibilities of the lcd display which are not used in ccbasic 2.0.'
'The possibilities include reverse printing on lcd, 3 different cursors, cursor shifting, character generation AND display ON-'
'on/ off'
'NEW----->> SCROLL DOWN AND SCROLL UP'
'Character generation is the possibility to design your own 8 characters.'
'Feel free to use and share this software in any way you want!'
'****************************************************** IN and OUTS ******************************************************'
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
gosub initialize_lcd
beep 4,2,4
beep 4,2,4
'*************************************************************************************************************************'
lcd_light_off = 0
#start
print"#ON_LCD#";

print"#CLR#"; 'scroll down'
print"#L101#";
print"  SCROLL DOWN";
gosub scroll_down

print"#CLR#"; 'scroll up'
print"#L201#";
print"    SCROLL UP";
gosub scroll_up

print"#CLR#"; 'forward and reverse printing on lcd'
gosub entry_mode_set_left_to_right
print"#L101#";
print"Entry Mode LR";
gosub entry_mode_set_right_to_left
print"#L216#";
print"Entry Mode RL";
gosub entry_mode_set_left_to_right
pause 200

for loop = 0 to 3 'no cursor and 3 different cursors'
print"#CLR#";
print"Cursor ";
print loop;
print" ";
on loop gosub lcd_cursor_0, lcd_cursor_1, lcd_cursor_2, lcd_cursor_3
pause 200
next

print"#CLR#";

print"Cursor Movement"; 'moving the cursor left and right'
for loop = 1 to 15
pause 25
gosub lcd_cursor_shift_left
next
for loop = 1 to 15
pause 25
gosub lcd_cursor_shift_right
next
pause 25

gosub lcd_cursor_0

print"#CLR#";

print"Generated Chara."; 'printing 4 example generated characters on the lcd'
print"#L205#";
put&h08                  'antenna'
print" ";
put&h09                  'heart'
print" ";
put&h0a                  'happy'
print" ";
put&h0b                  'window'

pause 200

print"#CLR#";

print"    DiSpLaY     ";  'display off on off on ......'
print"#L201#";
print"     ON/OFF     ";
for loop = 1 to 10
pause 25
gosub display_off
pause 25
gosub display_on_0
next

print"#OFF#";
tog lcd_light_off
goto start

'*************************************************************************************************************************'
#scroll_down 'shifts characters on top row to bottom row of lcd display'
FOR LOOP = 0 TO 15
pause 25  '******delete this line for speed******'
adr = loop : gosub data_from_DD_ram_lcd
dat2 = dat
dat = &h20 : gosub data_to_DD_ram_lcd
dat = dat2
adr = adr + 64 : gosub data_to_DD_ram_lcd
next
pause 25  '******delete this line for speed******'
return

#scroll_up 'shifts characters on bottom row to top row of lcd display'
for loop = 64 to 79
pause 25  '******delete this line for speed******'
adr = loop : gosub data_from_DD_ram_lcd
dat2 = dat
dat = &h20 : gosub data_to_DD_ram_lcd
dat = dat2
adr = adr - 64 : gosub data_to_DD_ram_lcd
next
pause 25  '******delete this line for speed******'
return

#display_off                         'lcd display OFF/ cursor OFF / understripe OFF'
cmd = &b00001000:goto command_to_lcd

#display_on_0                        'lcd display ON and'
#lcd_cursor_0                        'cursor OFF / understripe OFF'
cmd = &b00001100:goto command_to_lcd

#display_on_1                        'lcd display ON and'
#lcd_cursor_1                        'cursor BLINKS / understripe BLINKS'
cmd = &b00001101:goto command_to_lcd

#display_on_2                        'lcd display ON and'
#lcd_cursor_2                        'cursor OFF / understripe ON'
cmd = &b00001110:goto command_to_lcd

#display_on_3                        'lcd display ON and'
#lcd_cursor_3                        'cursor BLINKS / understripe ON'
cmd = &b00001111:goto command_to_lcd

#lcd_cursor_shift_left               'shifts cursor left without clearing character'
cmd = &b00010000:goto command_to_lcd

#lcd_cursor_shift_right              'shifts cursor right without clearing character'
cmd = &b00010100:goto command_to_lcd

#entry_mode_set_left_to_right 'sets printing to left to right ex. HELLO'
cmd = &b00000110
goto command_to_lcd

#entry_mode_set_right_to_left 'sets printing to right to left (backwards) ex. OLLEH'
cmd = &b00000100
goto command_to_lcd

'*************************************************************************************************************************'
#command_to_lcd
gosub busy_flag_check_from_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 0:en = 0                                        'setup for transmitting command to lcd display'
data = &b00000000 or cmd shr 4:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en                 'HIGH NIBBLE command to lcd'
data = &b00000000 or (cmd - (cmd shr 4 shl 4)):db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en 'LOW NIBBLE command to lcd'
return
'*************************************************************************************************************************'
#data_to_DD_ram_lcd
cmd = &b10000000 or adr : gosub command_to_lcd
goto put_data_into_lcd
#data_to_CG_ram_lcd
cmd = &b01000000 or adr : gosub command_to_lcd
#put_data_into_lcd
gosub busy_flag_check_from_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 1:en = 0                                        'setup for transmitting data to lcd display'
data = &b00000000 or dat shr 4:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en                 'HIGH NIBBLE data to lcd'
data = &b00000000 or (dat - (dat shr 4 shl 4)):db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en 'LOW NIBBLE data to lcd'
return
'*************************************************************************************************************************'
#data_from_DD_ram_lcd
cmd = &b10000000 or adr : gosub command_to_lcd
goto get_data_from_lcd
#data_from_CG_ram_lcd
cmd = &b01000000 or adr : gosub command_to_lcd
#get_data_from_lcd
deact db7 : deact db6 : deact db5 : deact db4:rw = 1:rs =1 : en = 1    'setup for reading data'
bit4 = db7:bit3 = db6:bit2 = db5:bit1 = db4:data = data shl 4          'HIGH NIBBLE data from lcd'
pulse en:bit4 = db7:bit3 = db6:bit2 = db5:bit1 = db4:en = 0            'LOW NIBBLE data from lcd'
dat = data
command_to_lcd
return
'*************************************************************************************************************************'
#busy_flag_check_from_lcd
deact db7 : deact db6 : deact db5 : deact db4:rw = 1:rs = 0:en = 1     'setup for reading busy flag'
bit4 = db7:bit3 = db6:bit2 = db5:bit1 = db4:data = data shl 4          'HIGH NIBBLE data from lcd'
pulse en:bit4 = db7:bit3 = db6:bit2 = db5:bit1 = db4:en = 0            'LOW NIBBLE data from lcd'
if bit8 <> 0 then goto busy_flag_check_from_lcd                        'bit 8 of data is the busy flag bit / 1 = lcd is busy / 0 = lcd is ready'
return
'*************************************************************************************************************************'
#initialize_lcd
print"#ON_LCD#";:print"#INIT#";:print"#CLR#";                                    'initialize lcd display'
#character_build 'generates characters in lcd ram from characterbuild table / 8 characters of 5X8 pixels'
for loop = 0 to 63
adr = loop                         'lcd display character generation (CG) address'
looktab characterbuild, loop, dat  'lcd data for character generation'
gosub data_to_CG_ram_lcd                  'set character generation data in CG address'
next
print"#OFF#";
return
'*************************************************************************************************************************'
'                 (CG    dat     adr) 000/XXXXX  first 3 bits are not used/ last 5 bits are for character generation   '

table characterbuild &b00010001 '(0)  000/1   1' character build data for antenna symbol/ read from DD-ram address &h08'
                     &b00011111 '(1)  000/11111'                                                               *put&h08*'
                     &b00010101 '(2)  000/1 1 1'
                     &b00000100 '(3)  000/  1  '
                     &b00000100 '(4)  000/  1  '
                     &b00000100 '(5)  000/  1  '
                     &b00000100 '(6)  000/  1  '
                     &b00000000 '(7)  000/     '-----------------------------------------'
                     &b00000000 '(8)  000/     ' character build data for heart/ read from DD-ram address &h09'
                     &b00000000 '(9)  000/     '                                                      *put&h09*'
                     &b00001010 '(10) 000/ 1 1 '
                     &b00011111 '(11) 000/11111'
                     &b00001110 '(12) 000/ 111 '
                     &b00000100 '(13) 000/  1  '
                     &b00000000 '(14) 000/     '
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
                     &b00000000 '(57) 000/00000'                                                           *put&h0f*
                     &b00000000 '(58) 000/00000'
                     &b00000000 '(59) 000/00000'
                     &b00000000 '(60) 000/00000'
                     &b00000000 '(61) 000/00000'
                     &b00000000 '(62) 000/00000'
                     &b00000000 '(63) 000/00000 -----------------------------------------'
tabend
