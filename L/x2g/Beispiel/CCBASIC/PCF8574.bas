'----------------------------------------------------------------------------------------------------'
'***********************************************************************'
'*                         WINDT SYSTEMS                               *'
'*           DATA TO PCF8574 V1.0 for CCIMainU1.1 with CCISB           *'
'*                           H.J. WINDT                                *'
'*                             2004                                    *'
'***********************************************************************'
'----------------------------------------------------------------------------------------------------'
'This program will demonstrate sending data to a PCF8574 using the I2C protocol.'
'i2c_address must contain the PCF8574 address/ &b0100(A2)(A1)(A0)0.'
'i2c_data must contain the byte to be sent.'                                                                                                     
'Port 1 is the SDA line.'
'Port 2 is the SCL line.'
'Feel free to use and share this software!!'
'----------------------------------------------------------------------------------------------------'
'*************** INS and OUTS ***************'
define sda port[9]
define scl port[10]
'*******************************************'
'**************** VARIABLES ****************'    ll
define i2c_byte byte[1]
define d7 bit[8]
define d0 bit[1]

define i2c_error bit[9]

define i2c_address byte[3]
define i2c_data byte[4]

define loop byte[5]

'*******************************************'
'**************** CONSTANTS ****************'

'*******************************************'
'****************** SETUP ******************'

'*******************************************'
'***************** PROGRAM *****************'
#start
i2c_address = &b01001110 '------>> PCF8574 ADDRESS/ 0100(A2)(A1)(A0)0 <<------'

for i2c_data = 0 to 255

gosub send_data_to_pcf8574

'pause 50

next

end


'*******************************************'
'*************** SUBROUTINES ***************'
#send_data_to_pcf8574

#start_i2c
i2c_error = 0
sda = 0
scl = 0

i2c_byte = i2c_address 'Transmit address (i2c_address) over the I2C bus'
for loop = 1 to 8
sda = d7
gosub scl_pulse
i2c_byte = i2c_byte shl 1
next
gosub get_ack_i2c

i2c_byte = i2c_data 'Transmit byte (i2c_data) over the I2C bus'
for loop = 1 to 8
sda = d7
gosub scl_pulse
i2c_byte = i2c_byte shl 1
next
gosub get_ack_i2c

#stop_i2c
deact scl
deact sda

if i2c_error then goto send_data_to_pcf8574 'If I2C error then try again'
return


#get_ack_i2c
deact sda
if sda then i2c_error = 1
#scl_pulse
deact scl
#clock_stretch
if scl = 0 then goto clock_stretch
deact scl
scl = 0
return

'*******************************************'
'****************** DATA *******************'

'*******************************************'
