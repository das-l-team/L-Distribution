'----------------------------------------------------------------------------------------------------'
'***********************************************************************'
'*                         WINDT SYSTEMS                               *'
'*    64 BYTES EXTRA VARIABLE RAM v1.4 for CC1M2.01 with CC1AB2.0      *'
'*                           H.J. WINDT                                *'
'*                             2004                                    *'
'***********************************************************************'
'----------------------------------------------------------------------------------------------------'
'This program demonstrates storing variables in the 64 bytes of CG RAM located in the LCD mounted'
'on the Application Board 2.0'
'Writing to or reading from the CG RAM will NOT disturb the characters displayed on the LCD'
'in any way because displayed characters are stored in the DD RAM of the LCD.'
'CG RAM is usually used by the programmer to create his or her own characters,'
'(C)haracter (G)eneration, but can be used to store data.'
'So, if you need to store variables in a RAM and are not planning to create you own characters then'
'feel free to use this software!!'
'For demonstration purpose use a terminal program like the one I found >>'
'RS232 TERMINAL at www.b-kainka.de/pcmessfaq.htm'
''
'NEW NEW NEW NEW:'
'Safety built into the subroutines'
'Subroutines for reading or writing bits, bytes and words to CG RAM'
'Bit addressing = 1 to 512'
'Byte addressing = 1 to 64'
'Word addressing = 1 to 32'
'For reading a bit, byte or word from the CG RAM, address must contain the address number, then just gosub to'
'read_bit_from_cg_ram_lcd or read_byte_from_cg_ram_lcd or read_word_from_cg_ram_lcd and the variable will be'
'returned in data'
'For writing a bit, byte or word to the CG RAM, address must contain the address number and data the variable,'
'then just gosub to write_bit_to_cg_ram_lcd or write_byte_to_cg_ram_lcd or write_word_to_cg_ram_lcd and'
'the variable is saved'
'----------------------------------------------------------------------------------------------------'
'*************** INS and OUTS ***************'
'-----port 2 lcd connections-----'
define db4 port[9]  'databus 4'
define db5 port[10] 'databus 5'
define db6 port[11] 'databus 6'
define db7 port[12] 'databus 7'
define rw port[13] '0 = write to lcd display / 1 = read from lcd display'
define rs port[14] '0 = command / 1 = data'
define en port[15] '1 to 0 = enable'
define lcd_light_off port[16] '(off)0 = light on / (on)1 = light off'
'*******************************************'
'**************** VARIABLES ****************'
define port_data byte[1]'port_data / used for translating byte into bits and vice versa for I/O of port 2 (lcd port), -'
define pd_bit1 bit[1] '- needed because of a bug in the CC1M2.01 system/ also used in other subroutines'
define pd_bit2 bit[2]
define pd_bit3 bit[3]
define pd_bit4 bit[4]
define pd_bit5 bit[5]
define pd_bit6 bit[6]
define pd_bit7 bit[7]
define pd_bit8 bit[8]

define cmd byte[2] 'command code for subroutines'
define adr byte[3] 'address code for subroutines'
define dat byte[4] 'data code for subroutines'

define address word[3] 'address code from user'

define data word[4] 'data code from or to user'
define first_byte_of_data byte[7]
define second_byte_of_data byte[8]

define loop word[5]
define number word[6]
'*******************************************'
'**************** CONSTANTS ****************'

'*******************************************'
'****************** SETUP ******************'
print"#ON_LCD#";:print"#INIT#";:print"#CLR#";:print" 64 BYTE EXTRA  ";:print"#L201#";:print" VARIABLE RAM!  ";:print"#OFF#";
lcd_light_off = 0
beep 4,2,4: beep 4,2,4
'*******************************************'
'***************** PROGRAM *****************'
#start
print" Enter (0 to write bit) (1 to read bit) (2 to write byte) (3 to read byte) (4 to write word) (5 to read word)"
gosub input_number_via_232
if number < 0 or number > 5 then end '<- changed by L-Team for use with 'Lbit' firmware. 'goto start
on number goto write_bit, read_bit, write_byte, read_byte, write_word, read_word

#write_bit
print"Enter address (1 to 512)"
gosub input_number_via_232
address = number
print"Enter bit (0 or 1)"
gosub input_number_via_232
data = number
gosub write_bit_to_cg_ram_lcd
print"BIT SAVED!"
goto start

#read_bit
print"Enter address (1 to 512)"
gosub input_number_via_232
address = number
gosub read_bit_from_cg_ram_lcd
print"Bit ";address;" = ";data
goto start

#write_byte
print"Enter address (1 to 64)"
gosub input_number_via_232
address = number
print"Enter byte (0 to 255)"
gosub input_number_via_232
data = number
gosub write_byte_to_cg_ram_lcd
print"BYTE SAVED!"
goto start

#read_byte
print"Enter address (1 to 64)"
gosub input_number_via_232
address = number
gosub read_byte_from_cg_ram_lcd
print"In address ";address;" data = ";data
print" ";
goto start

#write_word
print"Enter address (1 to 32)"
gosub input_number_via_232
address = number
print"Enter word (-32768 to 32767)"
gosub input_number_via_232
data = number
gosub write_word_to_cg_ram_lcd
print"WORD SAVED!"
goto start

#read_word
print"Enter address (1 to 32)"
gosub input_number_via_232
address = number
gosub read_word_from_cg_ram_lcd
print "In address ";address;" data = ";data
print" ";
goto start
'*******************************************'
'*************** SUBROUTINES ***************'
#input_number_via_232
number = 0
get data                                             'get 8 bit ascii code'
if data = 13 then return                             'look for ascii code for ENTER'
if data = 45 then goto input_negative_dec            'look for ascii code for -'
#input_positive_dec
data = data - 48                                                   'translate ascii code into decimal'
if number <> 0 then number = number * 10 + data else number = data 'build number'
get data                                                           'get 8 bit ascii code'
if data = 13 then return                                           'look for ascii code for ENTER'
goto input_positive_dec
#input_negative_dec
get data                                                                         'get 8 bit ascii code'
if data = 13 then number = number * -1 'look for ascii code for ENTER and make number negative if so'
if data = 13 then return                                              'look for ascii code for ENTER'
data = data - 48                                                    'translate ascii code into decimal'
if number <> 0 then number = number * 10 + data else number = data                       'build number'
goto input_negative_dec

#write_bit_to_cg_ram_lcd
adr = (address - 1) / 8
gosub data_from_CG_ram_lcd
port_data = dat
cmd = 0
for loop = 1 to address
cmd = cmd + 1
if cmd = 9 then cmd = 1
next
cmd = cmd - 1
on cmd gosub wbit1, wbit2, wbit3, wbit4, wbit5, wbit6, wbit7, wbit8
dat = port_data
adr = (address - 1) / 8
goto data_to_CG_ram_lcd
#wbit1
pd_bit1 = data
return
#wbit2
pd_bit2 = data
return
#wbit3
pd_bit3 = data
return
#wbit4
pd_bit4 = data
return
#wbit5
pd_bit5 = data
return
#wbit6
pd_bit6 = data
return
#wbit7
pd_bit7 = data
return
#wbit8
pd_bit8 = data
return

#read_bit_from_cg_ram_lcd
adr = (address - 1) / 8
gosub data_from_CG_ram_lcd
port_data = dat
cmd = 0
for loop = 1 to address
cmd = cmd + 1
if cmd = 9 then cmd = 1
next
cmd = cmd - 1
on cmd goto rbit1, rbit2, rbit3, rbit4, rbit5, rbit6, rbit7, rbit8
#rbit1
data = abs(pd_bit1)
return
#rbit2
data = abs(pd_bit2)
return
#rbit3
data = abs(pd_bit3)
return
#rbit4
data = abs(pd_bit4)
return
#rbit5
data = abs(pd_bit5)
return
#rbit6
data = abs(pd_bit6)
return
#rbit7
data = abs(pd_bit7)
return
#rbit8
data = abs(pd_bit8)
return

#write_byte_to_cg_ram_lcd
adr = address - 1
dat = data
goto data_to_CG_ram_lcd

#read_byte_from_cg_ram_lcd
adr = address -1
gosub data_from_CG_ram_lcd
data = dat
return

#write_word_to_cg_ram_lcd
adr = (address * 2) - 2
dat = first_byte_of_data
gosub data_to_CG_ram_lcd
adr = adr + 1
dat = second_byte_of_data
goto data_to_CG_ram_lcd

#read_word_from_cg_ram_lcd
adr = (address * 2) - 2
gosub data_from_CG_ram_lcd
first_byte_of_data = dat
adr = adr + 1
gosub data_from_CG_ram_lcd
second_byte_of_data = dat
return

#command_to_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 0:en = 0                                        'setup for transmitting command to lcd display'
port_data = &b00000000 or cmd shr 4:db7 = pd_bit4:db6 = pd_bit3:db5 = pd_bit2:db4 = pd_bit1:pulse en                 'HIGH NIBBLE command to lcd'
port_data = &b00000000 or (cmd - (cmd shr 4 shl 4)):db7 = pd_bit4:db6 = pd_bit3:db5 = pd_bit2:db4 = pd_bit1:pulse en 'LOW NIBBLE command to lcd'
return

#data_to_CG_ram_lcd
if adr < 0 then adr = 0 else if adr > 63 then adr = 63
cmd = &b01000000 or adr : gosub command_to_lcd
deact db7:deact db6:deact db5:deact db4:rw = 0:rs = 1:en = 0                                        'setup for transmitting data to lcd display'
port_data = &b00000000 or dat shr 4:db7 = pd_bit4:db6 = pd_bit3:db5 = pd_bit2:db4 = pd_bit1:pulse en                 'HIGH NIBBLE data to lcd'
port_data = &b00000000 or (dat - (dat shr 4 shl 4)):db7 = pd_bit4:db6 = pd_bit3:db5 = pd_bit2:db4 = pd_bit1:pulse en 'LOW NIBBLE data to lcd'
return

#data_from_CG_ram_lcd
if adr < 0 then adr = 0 else if adr > 63 then adr = 63
cmd = &b01000000 or adr : gosub command_to_lcd
deact db7 : deact db6 : deact db5 : deact db4:rw = 1:rs =1 : en = 1    'setup for reading data'
pd_bit4 = db7:pd_bit3 = db6:pd_bit2 = db5:pd_bit1 = db4:port_data = port_data shl 4          'HIGH NIBBLE data from lcd'
pulse en:pd_bit4 = db7:pd_bit3 = db6:pd_bit2 = db5:pd_bit1 = db4:en = 0            'LOW NIBBLE data from lcd'
dat = port_data
goto command_to_lcd
'*******************************************'
'****************** DATA *******************'
