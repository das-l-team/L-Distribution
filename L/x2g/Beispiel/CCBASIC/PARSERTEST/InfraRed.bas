' _bas_FileVersion: $03AB
' Entrypoints for asm_FileVersion $0010
define Inizialize	&H0101
define Drv_On		&H010C
define Drv_Off		&H010F
define IRQ		&H0112
define DELAY1		&H0125
define DELAY2		&H012A
define TTL_Test		&H012D
define InFrame		&H0142
define FrameReady	&H0144
define IRQ_Exit0	&H014B
define CAP_Common	&H014D
define CAP2_Common	&H014D
define CAP1_Common	&H014D
define CAP1_LoHi	&H014D
define CAP1_HiLo	&H014D
define CAP_Exit_1	&H014D
define CMP_Common	&H014D
define CMP_UserTimer	&H0153
define CMP_Exit0	&H0158
define CMP_SysTimer	&H0159
define CMP_Exit1	&H0159
' some Sony-IR-KeyCodes
' Amplifier
define Amp_Power	&H5620
define Amp_VolUp	&H4A20
define Amp_VolDown	&H4E20
define Amp_CD		&H9620
define Amp_Tuner	&H8620
define Amp_Phono	&H8220
define Amp_Tape		&H8E20
define Amp_MD		&H9220
define Amp_AUX		&H7620
' Tuner
define Tuner_Minus	&H461A
define Tuner_Plus	&H421A
' CD-Player
define CD_Play		&HCA22
define CD_Pause		&HE622
define CD_Stop		&HE222
define CD_SkipDisk	&HFA22
define CD_SkipBackward	&HC222
define CD_SkipForeward	&HC622
define CD_FastBackward	&HCE22
define CD_FastForeward	&HD222
define CD_LineOutMinus	&H4E22
define CD_LineOutPlus	&H4A22
define CD_Fader		&H7E23
' MD-Recorder
define MD_Power		&H561E
define MD_Play		&HAA1E
define MD_Pause		&HA61E
define MD_Stop		&HA21E
define MD_Record	&HB61E
define MD_BufRecord	&HC21E
define MD_PeekRecord	&HFE1E
define MD_Eject		&H5A1E
define MD_SkipBackward	&H821E
define MD_SkipForeward	&H861E
define MD_FastBackward	&HAE1E
define MD_FastForeward	&HB21E
' TapeDeck-A
define TA_PlayBackward	&HDE20
define TA_PlayForeward	&HCA20
define TA_Stop		&HE220
define TA_FastBackward	&HCE20
define TA_FastForeward	&HD220
' TapeDeck-B
define TB_PlayBackward	&H821C
define TB_PlayForeward	&H6A1C
define TB_Stop		&H621C
define TB_FastBackward	&H6E1C
define TB_FastForeward	&H721C

define VAR01		byte[01]
define VAR02		byte[02]
define VAR03		byte[03]
define VAR04		byte[04]
define VAR05		byte[05]
define VAR06		byte[06]
define VAR07		byte[07]
define VAR08		byte[08]
define VAR09		byte[09]
define VAR10		byte[10]
define VAR11		byte[11]
define VAR12		byte[12]
define VAR13		byte[13]
define VAR14		byte[14]
define VAR15		byte[15]
define VAR16		byte[16]
define VAR17		byte[17]
define VAR18		byte[18]
define VAR19		byte[19]
define VAR20		byte[20]
define VAR21		byte[21]
define VAR22		byte[22]
define VAR23		byte[23]
define VAR24		byte[24]

define Frame		word[01]
define FrameHi		byte[01]
define FrameLo		byte[02]
define DrvFlgs		byte[03]
define BitsCnt		byte[04]

interrupt OnIrRx

#Inizialize
  sys Inizialize
  beep 300, 3, 0
#Loop

goto Loop

#OnIrRx
  sys Drv_Off
  put FrameHi
  put FrameLo
  sys Drv_On
return interrupt