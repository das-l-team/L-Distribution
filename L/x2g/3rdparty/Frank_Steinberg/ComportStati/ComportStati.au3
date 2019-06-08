;- ComportStati.au3 --------------------------------------------- >>fst'12<< -
; - set/unset output statuslines (plus TxD) of serial port
; - read input statuslines of serial port
; - uses WinAPI only, no special DLLs, no extra UDFs
; - should work with native comport and serial-USB-Adapters
; - for AutoIt3 - www.autoitscript.com - www.autoit.de
;- V 20120407 --------------------------------- http://www.FrankSteinberg.de -

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;*** Build GUI:
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\WinSpr\AutoIt\_Eigenes\COMStati.kxf
$Form1 = GUICreate(" ComportStati    >>fst'12<<", 225, 211, -1, -1, $WS_SYSMENU)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
$Combo_Port = GUICtrlCreateCombo("No Port", 8, 8, 73, -1)
GUICtrlSetOnEvent(-1, "Combo_PortChange")
$Group_IN = GUICtrlCreateGroup(" IN ", 112, 40, 97, 113)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Check_TxD = GUICtrlCreateCheckbox(" TxD   Pin 3", 16, 80, 80, 24)
GUICtrlSetOnEvent(-1, "Check_TxDClick")
$Check_DTR = GUICtrlCreateCheckbox(" DTR  Pin 4", 16, 104, 80, 24)
GUICtrlSetOnEvent(-1, "Check_DTRClick")
$Check_RTS = GUICtrlCreateCheckbox(" RTS  Pin 7", 16, 128, 80, 24)
GUICtrlSetOnEvent(-1, "Check_RTSClick")
$Group_OUT = GUICtrlCreateGroup(" OUT ", 8, 64, 97, 89)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Check_DCD = GUICtrlCreateCheckbox(" DCD  Pin 1", 120, 56, 80, 24)
$Check_DSR = GUICtrlCreateCheckbox(" DSR  Pin 6", 120, 80, 80, 24)
$Check_CTS = GUICtrlCreateCheckbox(" CTS   Pin 8", 120, 104, 80, 24)
$Check_RI = GUICtrlCreateCheckbox(" RI      Pin 9", 120, 128, 80, 24)
$Label_Info = GUICtrlCreateLabel("choose a COMport", 96, 12, 98, 17, 0)
$Label_URL = GUICtrlCreateLabel("www.FrankSteinberg.de", 47, 160, 118, 17, 0)
GUICtrlSetOnEvent(-1, "Label_URLClick")
GUICtrlSetColor(-1, 0x3399FF)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;*** Declare global variables:
Global $hSerialPort[1] ;handle for seruial port
Global $lpModemStat    ;pointer to status of serial input-lines
Global $sComboVal      ;comport selected by user (combobox)
Global $sPortList      ;list of all valid ports

;*** Create struct with one element to store input-line values - see Func Pin_Read():
$lpModemStat = DllStructCreate("DWORD")

;*** Main loop:
While 1
  Port_Search()  ;read valid ports from registry and add to combobox
  Pin_Read()     ;read status of comport input lines and show as checkboxes
  Sleep(100)     ;give some time to windows
WEnd
;*** Main loop end

;*** Read valid ports from registry and add to combobox:
Func Port_Search()  ;
 $sPortListOld = $sPortList  ;remember last values
 $sPortList = ""             ;delete last values
 For $i = 1 To 256           ;max. possible comports = COM1 - COM256
  Local $sRegVal = RegEnumVal("HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\SERIALCOMM\", $i)  ;... all valid ports listed here
  If @error <> 0 Then ExitLoop  ;abort after last value
  $sPortList = $sPortList & "|" & RegRead("HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\SERIALCOMM", $sRegVal) ;add value to list
 Next
 If $sPortList = $sPortListOld Then Return                ;exit func when no difference from last call
 GUICtrlSetData($Combo_Port, $sPortList & "|close port")  ;... otherwise replace list in combobox
EndFunc

;*** Open serial port using WinAPI:
Func Port_Open()
 ;** Open Port with 'CreateFile'; prefix '\\.\' adds support for Ports greater than COM9:
 $hSerialPort = DllCall("kernel32.dll","hwnd","CreateFile","str","\\.\"&$sComboVal,"int",0xC0000000,"int",0,"ptr",0,"int",3,"int",0,"int",0)
 GUICtrlSetData($Label_Info, $sComboVal & "  open") ;write success-message to gui
 If Number($hSerialPort[0]) < 1 Or @error Then      ;if no success ...
   GUICtrlSetData($Label_Info, "Com ERROR !")       ;... write to gui
   Return                                           ;... and exit func
 EndIf
 Check_DTRClick()                                   ;switch DTR to current checkbox state
 Check_RTSClick()                                   ;switch RTS to current checkbox state
 Check_TxDClick()                                   ;switch TxD to current checkbox state
EndFunc

;*** Close serial Port:
Func Port_Close()
 $hClose=DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hSerialPort[0])  ;Win-API
 If $hClose >= 0 Then GUICtrlSetData($Label_Info, "COM  closed")                 ;write message to gui
EndFunc

;*** Read input-lines values and show as checkboxes:
Func Pin_Read()
 ;** Read stati of input-lines using WinAPI 'GetCommModemStatus':
 DllCall("kernel32.dll", "long", "GetCommModemStatus", "HWND", $hSerialPort[0], "Ptr", DllStructGetPtr($lpModemStat))
 $iPinState = DllStructGetData($lpModemStat, 1)  ;all values are in $iPinState
;Isolate value for CTS pin:
 If BitAND($iPinState, 0x10) Then                ;0x10 = MS_CTS_ON
   GUICtrlSetState($Check_CTS, $GUI_CHECKED)     ;set checbox, if bit is set
  Else
   GUICtrlSetState($Check_CTS, $GUI_UNCHECKED)   ;uncheck, if bit is unset
 EndIf
 ;Isolate value from DSR pin:
 If BitAND($iPinState, 0x20) Then                ;0x20 = MS_DSR_ON
   GUICtrlSetState($Check_DSR, $GUI_CHECKED)
  Else
   GUICtrlSetState($Check_DSR, $GUI_UNCHECKED)
 EndIf
 ;Isolate value from RI pin:
 If BitAND($iPinState, 0x40) Then                ;0x40 = MS_RING_ON
   GUICtrlSetState($Check_RI, $GUI_CHECKED)
  Else
   GUICtrlSetState($Check_RI, $GUI_UNCHECKED)
 EndIf
 ;Isolate value from DCD pin:
 If BitAND($iPinState, 0x80) Then                ;0x80 = MS_RLSD_ON
   GUICtrlSetState($Check_DCD, $GUI_CHECKED)
  Else
   GUICtrlSetState($Check_DCD, $GUI_UNCHECKED)
 EndIf
EndFunc

;*** Set/unset DTR pin using WinAPI 'EscapeCommFunction', when user clicks checkbox:
Func Check_DTRClick()
 If GUICtrlRead($Check_DTR) = $GUI_CHECKED Then
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 5)  ;5=SETDTR; set DTR high
  Else
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 6)  ;6=CLRDTR; set DTR low
 EndIf
EndFunc

;*** Set/unset RTS pin using WinAPI 'EscapeCommFunction', when user clicks checkbox:
Func Check_RTSClick()
 If GUICtrlRead($Check_RTS) = $GUI_CHECKED Then
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 3)  ;3=SETRTS; set RTS high
  Else
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 4)  ;4=CLRRTS; set RTS low
 EndIf
EndFunc

;*** Set/unset DTR pin using WinAPI 'EscapeCommFunction', when user clicks checkbox:
Func Check_TxDClick()
 If GUICtrlRead($Check_TxD) = $GUI_CHECKED Then
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 8)  ;8=SETBREAK; set TxD high (break)
  Else
	 DllCall("kernel32.dll","long","EscapeCommFunction","hwnd", $hSerialPort[0],"long", 9)  ;9=CLRBREAK; set TxD low
 EndIf
EndFunc

;*** Open/close serial Port, depending on users clicks in combobox:
Func Combo_PortChange()
 $sComboVal = GUICtrlRead($Combo_Port)    ;read user value
 Port_Close()                             ;close previous opened port
 GUICtrlSetState($Check_TxD, $GUI_FOCUS)  ;go to first checkbox
 If GUICtrlRead($Combo_Port) = "close port" Then Return  ;exit func, close-only is selected
 Port_Open()                              ;open selected port
EndFunc

;*** Close port and exit app, when window is closed:
Func Form1Close()
 Port_Close()
 Exit
EndFunc

;*** Show authors website on click on label:
Func Label_URLClick()
 ShellExecute("http://www.franksteinberg.de")
EndFunc