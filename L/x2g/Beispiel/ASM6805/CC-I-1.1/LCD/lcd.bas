'****************************************************************************
'
'  LCD driver includes for Conrads C-Control 1 Application Board
'
'  written Jan-2003 by Klaus Dormann - K@2m5.de
'
'****************************************************************************
'
define  p  word         'used for print using example. if your numbers do not
                        'exceed 256 you can use byte instead of word
'
'LCD Ports
'
define lcd_port byteport[2]     'Port C, Bits 0:3 data or command nibble
define lcd_rs port[14]          'rs=0 command, rs=1 data
define lcd_rw port[13]          'r/-w=0 write, r/-w=1 read
define lcd_e port[15]           'enable 0->1=latch select, 1->0=latch data
'
'LCD SYS entry-points
'
define  lcmd   &h101    'send command to LCD (SYS lcmd byte)
define  lput   &h107    'send character to LCD (SYS lput byte)
define  lps    &h121    'LCD print string - usage: SYS lps:PRINT "blabla"
define  lpn    &h14a    'LCD print numeric - usage: SYS lpn var/1000
                        '    example displays 10^3 digit on LCD
                        '    implies (stack mod 10) or &h30
'
'LCD command table for SYS lcmd command
'
define  forw    &h06    'move cursor forward during write   Default!
define  backw   &h04    'move cursor backward during write (write backward)
define  forshft &h07    'shifts display forward during write
define  bakshft &h05    'shifts display backward during write (write backward)
'
define  curoff  &h0c    'cursor off   Default!
define  curall  &h0f    'cursor on, underscore & blinking block
define  curlin  &h0e    'cursor on, underscore
define  curblk  &h0d    'cursor on, blinking block
define  curon   curall  'set your personal preference
'
define  cur_r   &h14    'cursor right 1 (content unchanged)
define  cur_l   &h10    'cursor left 1 (content unchanged)
define  dspl_r  &h18    'display shift right 1
define  dspl_l  &h1c    'display shift left 1
'
define  cg_ram  &h40    'set cursor to character generator ram loc 0
                        'next writes will be to cg ram
define line1    &h80    'set cursor to display ram line 1 pos 1
                        'SYS lcmd line1+10 to set 11th character
define line2    &hc0    'set cursor to display ram line 2 pos 1
'
'the following LCD commands require an additional delay (1.64ms)
'use GOSUB lcd_clear and GOSUB lcd_home instead
'
define  clear   1       'LCD home and clear
define  home    2       'LCD home, set cursor & display to line 1 pos 1
'
'LCD character table for SYS lput char
'
define  zero   &h30     '"0"
define  space  &h20     '" "
define  minus  &h2d     '"-"
define  comma  &h2c     '","
define  colon  &h3a     '":"
define  period &h2e     '"."
'
'****************************************************************************
'
'  Main program
'
gosub lcd_init
'
'  Put your program here!
'
end
'
'****************************************************************************
'
'LCD PRINT USING examples
' usage: comment unwanted digits, commas and signs - uncomment all else
' default comments configured for 3 digits unsigned numbers
'
#print_fill_zero
' if p<0 then sys lput minus else sys lput space  'if you want negative numbers
if p<0 then p=abs(p)
' sys lpn p/10000 '5 digits
' sys lpn p/1000  '4 digits
sys lpn p/100   '3 digits
sys lpn p/10    '2 digits
' sys lput comma  'comma
sys lpn p       '1 digit
return
'
#print_fill_space
' if abs(p)<10000 then sys lput space  '5 digits
' if abs(p)<1000 then sys lput space   '4 digits
if abs(p)<100 then sys lput space    '3 digits
if abs(p)<10 then sys lput space     '2 digits
' if p<0 then sys lput minus else sys lput space  'if you want negative numbers
if p<0 then p=abs(p)
' if p>=10000 then sys lpn p/10000 '5 digits
' if p>=1000 then sys lpn p/1000   '4 digits
if p>=100 then sys lpn p/100     '3 digits
if p>=10 then sys lpn p/10       '2 digits
' sys lput comma                   'comma
sys lpn p                        '1 digit
return
'
'this allows the comma to be preceeded by a zero
'
#print_mixed
' if abs(p)<10000 then sys lput space  '5 digits
' if abs(p)<1000 then sys lput space   '4 digits
if abs(p)<100 then sys lput space    '3 digits
' if abs(p)<10 then sys lput space     '2 digits - replaced by a zero
' if p<0 then sys lput minus else sys lput space  'if you want negative numbers
if p<0 then p=abs(p)
' if p>=10000 then sys lpn p/10000 '5 digits
' if p>=1000 then sys lpn p/1000   '4 digits
if p>=100 then sys lpn p/100     '3 digits
sys lpn p/10                     '2 digits - zero filled
sys lput comma                   'comma
sys lpn p                        '1 digit
return
'
'basic part of LCD driver
'
'Initializing done from basic rather then machine code
'
#lcd_init
pause 1                 'sync with timer
lcd_port = &h23         'command 8-bit (attention)
pulse lcd_e             '2 times in case we are 4-bit mode
pulse lcd_e
pause 1                 'allow time and repeat
pulse lcd_e
pause 1
lcd_port = &h22         'set 4-bit mode
pulse lcd_e
sys lcmd &h28           'set 2-lines, font 0 with 4-bit datalength
sys lcmd curoff         'set display on, cursor and blinking off
sys lcmd forw           'cursor increment after write, no shift
'
#lcd_clear
sys lcmd clear          'clear and home LCD
wait on                 'nop (dummy wait) - overclocked may need more
return
'
#lcd_home
sys lcmd home           'unshift and home cursor
wait on
return
'
'machine code driver - load only once - then comment
syscode "lcd.s19"
