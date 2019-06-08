'----------------------------------------------------------------------------------------------------'
'***********************************************************************'
'*                         WINDT SYSTEMS                               *'
'*          MAZE GAME v1.0 for CC1M2.01 with CC1AB2.0                  *'
'*                           H.J. WINDT                                *'
'*                             2004                                    *'
'***********************************************************************'
'----------------------------------------------------------------------------------------------------'
'FIND YOUR WAY OUT OF THE MAZE!!!!'
'USE THE KEYS TO MOVE.'
'KEY 2 = UP'
'KEY 4 = LEFT'
'KEY 6 = RIGHT'
'KEY 8 = DOWN'
'HAVE FUN!!'
'----------------------------------------------------------------------------------------------------'
'*************** INS and OUTS ***************'
define db4 port[9]
define db5 port[10]
define db6 port[11]
define db7 port[12]
define rw port[13]
define rs port[14]
define en port[15]
define lcd_light_off port[16]
define in_key ad[8]
'*******************************************'
'**************** VARIABLES ****************'
define data byte[1]
define bit1 bit[1]
define bit2 bit[2]
define bit3 bit[3]
define bit4 bit[4]
define bit5 bit[5]
define bit6 bit[6]
define bit7 bit[7]
define bit8 bit[8]
define adr byte[2]
define cmd byte[3]
define dat byte[4]
define area_build_data byte[6]
define bottom_wall bit[41]
define right_wall bit[42]
define top_wall bit[43]
define left_wall bit[44]
define player_position byte[7]
define last_player_position byte[8]
define steps word[5]
'*******************************************'
'**************** CONSTANTS ****************'
'*******************************************'
'****************** SETUP ******************'
gosub initialize_lcd
beep 4,2,4
beep 4,2,4
lcd_light_off = 0
player_position = 0
'*******************************************'
'***************** PROGRAM *****************'
#start
looktab maze, player_position, area_build_data
gosub print_maze_on_display
if player_position = 246 then goto is_out
gosub get_player_direction
goto start
'*******************************************'
'*************** SUBROUTINES ***************'
#is_out
pause 50
print"#CLR#";
print" YOU ARE OUT!!!";
print"#L201#";
print"IN ";
print steps;
print" STEPS";
print"#OFF#";
beep 1,10,4:beep 2,9,4:beep 3,8,4:beep 4,7,4:beep 5,6,4:beep 6,5,4:beep 7,4,4:beep 8,3,4:beep 9,2,4:beep 10,1,4
end
#get_player_direction
if in_key < 8 then goto get_player_direction
if top_wall = 0 then if in_key > 45 and in_key < 55 then player_position = player_position - 16
if left_wall = 0 then if in_key > 77 and in_key < 87 then player_position = player_position - 1
if right_wall = 0 then if in_key > 109 and in_key < 119 then player_position = player_position + 1
if bottom_wall = 0 then if in_key > 142 and in_key < 152 then player_position = player_position + 16
#wait
pause 10
if in_key > 8 then goto wait
if last_player_position <> player_position then beep 4,2,4
if last_player_position <> player_position then steps = steps + 1
last_player_position = player_position
return
#print_maze_on_display
print"#L101#";
if left_wall <> 0 then put&h0b else put&h0e
if top_wall <> 0 then put&h0a else put&h0f
if top_wall <> 0 then put&h0a else put&h0e
if right_wall <> 0 then put&h09 else put&h0f
print"Steps Taken:"
print"#L201#";
if left_wall <> 0 then put&h0b else put&h0c
if bottom_wall <> 0 then put&h08 else put&h0d
if bottom_wall <> 0 then put&h08 else put&h0c
if right_wall <> 0 then put&h09 else put&h0d
print"   ";
print steps;
return
#command_to_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 0:en = 0
data = &b00000000 or cmd shr 4:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en
data = &b00000000 or (cmd - (cmd shr 4 shl 4)):db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en
return
#data_to_CG_ram_lcd
cmd = &b01000000 or adr : gosub command_to_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 1:en = 0
data = &b00000000 or dat shr 4:db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en
data = &b00000000 or (dat - (dat shr 4 shl 4)):db7 = bit4:db6 = bit3:db5 = bit2:db4 = bit1:pulse en
return
#initialize_lcd
print"#ON_LCD#";:print"#INIT#";:print"#CLR#";
#character_build
for adr = 0 to 63
looktab characterbuild, adr, dat
gosub data_to_CG_ram_lcd
next
return
'*******************************************'
'****************** DATA *******************'
table characterbuild &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00011111 &b00011111
                     &b00011000 &b00011000 &b00011000 &b00011000 &b00011000 &b00011000 &b00011000 &b00011000
                     &b00011111 &b00011111 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000
                     &b00000011 &b00000011 &b00000011 &b00000011 &b00000011 &b00000011 &b00000011 &b00000011
                     &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000011 &b00000011
                     &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00011000 &b00011000
                     &b00000011 &b00000011 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000
                     &b00011000 &b00011000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000 &b00000000
tabend

table maze 12  5  5  4  5  5  6 12  5  5  5  5  5  5  5  6
           10 13  6 10 12  5  3 10 13  5  5  5  4  5  5  3
           10 14 10 10 10 12  5  0  5  4  4  5  0  4  4  6
            8  1  3 10 10 10 13  3 15 10  8  7 10  9  3 10
           10 13  5  3 10 10 12  5  5  3  8  6  8  5  5  2
           10 14 12  5  3 10 10 12  5  5  3 10 10 13  6 10
            9  0  1  5  5  3 10 10 12  6 15 10  9  6 10 11
           14 10 12  4  5  6 10 10 10  8  5  3 12  3 10 14
           10 10 10 10 13  3 10 10  9  1  5  5  1  7 10 10
           10 10 11  8  5  5  3  9  5  5  5  5  5  6 10 10
            8  1  5  2 12  4  5  5  7  13 4  5  5  2  8  2
           10 12  7 11 11 10 13  5  5  5  1  5  7 10 10 10
           10  8  4  5  5  1  5  5  4  5  5  5  5  0  3 10
           10 10  8  5  5  5  5  5  2 14 12  5  5  1  7 11
           10 10  9  5  5  5  4  7 10  9  1  5  5  5  5  6
           11  9  5  5  5  7  0 13  1  5  5  5  5  5  5  3
tabend
'*******************************************'
