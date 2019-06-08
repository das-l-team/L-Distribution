;Sie sollten niemals auf die Idee kommen, und den Anwender auffordern, sein System in irgendeiner
;Form zu verstellen. Sie sollten eher sich selbst fragen, ob es zwingend nötig ist, auf spezielle
;Bereiche des Systems oder der Registry zuzugreifen. Ist es nicht unbedingt erforderlich, dann
;lassen Sie es.

#define MyAppName "L-Distribution"
#define MyAppVersion "0.29 beta"
#define MyAppPublisher "das |_ Team"
#define MyAppURL "http://visit.ghn-sensorik.de/L-Team/Distribution/beta/"
#define MyAppExeName "Context.exe"

[Setup]
AppId={{L-Distribution-abcdefghijklmnopqrstuvwxyz-0123456789}}
;Uninstallable=no
Password=lks300714
LanguageDetectionMethod=uilanguage
SetupLogging=yes
DisableStartupPrompt=yes
DisableWelcomePage=yes
;MinVersion=4.0,5.0
PrivilegesRequired=admin
ShowLanguageDialog=yes
AppName=L-Distribution 
AppVersion=0.29 (beta)
AppComments=---
DefaultDirName=c:\L\ 
;AppContact=http://xyz.de
AppCopyright=Collaborative Work
AppSupportURL=http://visit.ghn-sensorik.de/L-Team/Distribution/beta/
AppPublisher=das |_ Team
;AppPublisherURL=http://unknown
AppUpdatesURL=http://update.ghn-sensorik.de/L-Team/Distribution_0.29/




;Compression=none
Compression=lzma2
LZMAUseSeparateProcess=yes
LZMANumFastBytes=64
LZMADictionarySize=13107
LZMAMatchFinder=BT
LZMANumBlockThreads=1
LZMABlockSize=126210
SolidCompression=yes



;DisableDirPage=yes
UsePreviousAppDir=yes
DirExistsWarning=yes
DefaultGroupName=das L Team
UninstallDisplayIcon={app}\|_ Distribution 0.29
UninstallDisplayName=L-Distribution



OutputBaseFilename="L-Distribution-Setup"
OutputDir=L:\ 
OutputManifestFile=L_Setup-Manifest_0.29.txt
SetupIconFile=L:\x2g\System\Setup\L_Setup_Icon.ico
UninstallIconFile=L:\x2g\System\Setup\L_Setup_Icon.ico

;SignedUninstaller=yes
;SignedUninstallerDir

ChangesAssociations=yes
ChangesEnvironment=yes


[Languages]

Name: "en"; LicenseFile: "L:\x2g\System\SETUP\EN\WhyPassword.L"; InfoBeforeFile: "L:\x2g\System\SETUP\EN\ChooseDir.L"; InfoAfterFile: "L:\x2g\System\SETUP\EN\Readme.L"; MessagesFile: "compiler:Default.isl"    
Name: "de"; LicenseFile: "L:\x2g\System\SETUP\DE\WhyPassword.L"; InfoBeforeFile: "L:\x2g\System\SETUP\DE\ChooseDir.L"; InfoAfterFile: "L:\x2g\System\SETUP\DE\Readme.L"; MessagesFile: "compiler:Languages\German.isl"
Name: "nl"; LicenseFile: "L:\x2g\System\SETUP\NL\WhyPassword.L"; InfoBeforeFile: "L:\x2g\System\SETUP\NL\ChooseDir.L"; InfoAfterFile: "L:\x2g\System\SETUP\NL\Readme.L"; MessagesFile: "compiler:Languages\Dutch.isl"


; according to www.jrsoftware.org/ishelp/index.php?topic=tasksection 

;Denken Sie bei allen Angaben, ob in "[Messages]" oder "[CustomMessages]", immer
;an das Sprachpräfix. Lassen Sie es weg, dann gilt der Text global für alle Sprachen.


;VersionInfoDescription=Collection of Coding Tools Revised by |_



[Messages]
en.BeveledLabel=password: L K S 3 0 0 7 1 4 (lower case letters)
de.BeveledLabel=Passwort: L K S 3 0 0 7 1 4 (Kleinbuchstaben)
nl.BeveledLabel=password: L K S 3 0 0 7 1 4 (lower case letters)
en.ConfirmUninstall=Do you want to remove %1?
de.ConfirmUninstall=Soll %1 jetzt entfernt werden?
nl.ConfirmUninstall=(nl)Do you want to remove %1?

[CustomMessages]
en.MyDescription= 
en.MyAppName=The |_ Distribution [beta]
en.MyAppVerName=The |_ Distribution [beta] %1

de.MyDescription=
de.MyAppName=die |_ Distribution [beta]
de.MyAppVerName=die |_ Distribution [beta]%1

nl.MyDescription=
nl.MyAppName=The |_ Distribution [beta]
nl.MyAppVerName=The |_ Distribution [beta] %1


VersionInfoCompany=das |_ Team
VersionInfoCopyright=Collaborative work
;erscheint im Windows-XP Explorer bei mouse over:
VersionInfoDescription=The |_ Distribution   
VersionInfoProductName=The |_ Distrubution [beta]
VersionInfoProductVersion=0.29
VersionInfoVersion=0.29

;Legacy Section: Explorer's Version Tab on Windows 98 and earlier, this setting has no effect if UseSetupLdr is set to no:
VersionInfoProductTextVersion=0.29 (beta)
VersionInfoTextVersion=0.29 (beta)



;Colors for Installer Window:
WindowVisible=no

; max picture Size 164 x 314 pixels
WizardImageFile=L:\x2g\System\Setup\L_Setup_Background_Image.bmp
WizardImageBackColor=$400000

; max picture size is 55 x 58 pixels
WizardSmallImageFile=L:\x2g\System\Setup\L_Small_Background_Image.bmp
;obsolete in 5.0.4:(?)
WizardSmallImageBackColor=$005588



ShowTasksTreeLines=yes







; FAT partitions have 2-second time stamp resolution, so the following (2 is default anyway) ensures time stamps are the same on both FAT and NTFS partitions:
;TimeStampRounding=2
;TouchTime=16:00:00    
;TouchDate=2014-07-30
; WARNING:  
; using Touch on all the *.L help files will surely break our minimalistic contex-sensitive help system since ConTEXT.exe determines file changes by keeping
; track of file timestamps only - even if the actual file content should differ.









;  Windows versions:
;
;  4.0.950 Windows 95 
;  4.0.1111 Windows 95 OSR 2 & OSR 2.1 
;  4.0.1212 Windows 95 OSR 2.5 
;  4.10.1998 Windows 98 
;  4.10.2222 Windows 98 Second Edition 
;  4.90.3000 Windows Me 
;
;  Windows NT versions:
;
;  4.0.1381 Windows NT 4.0 
;  5.0.2195 Windows 2000 
;  5.1.2600 Windows XP
;  or Windows XP 64-Bit Edition Version 2002 (Itanium) 
;  5.2.3790 Windows Server 2003
;  or Windows XP x64 Edition (AMD64/EM64T)
;  or Windows XP 64-Bit Edition Version 2003 (Itanium) 
;  or ReactOS (compatible Windows 2003, 32 bit - no 16 Bit DOS-Support - tested: build 66029-r) 
;--------------------------------- definitely no 16 Bit DOS Support below this line --------------------------------- 
;  6.0.6000 Windows Vista 
;  6.0.6001 Windows Vista with Service Pack 1
;  or Windows Server 2008 
;  6.1.7600 Windows 7
;  or Windows Server 2008 R2 
;  6.1.7601 Windows 7 with Service Pack 1
;  or Windows Server 2008 R2 with Service Pack 1 
;  6.2.8102 Windows 8 Developer Preview 
;
;  Note that there is normally no need to specify the build numbers (i.e., you may simply use "5.1" for Windows XP).
;
;  If a major version number less than 5 is specified in combination with a one-digit minor version number, the minor
;  version number will be multiplied by 10. Therefore, 4.1 (Windows 98) is equivalent to 4.10.

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.exe"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.exe"; 
;Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\AACircuit1_28_7\{#MyAppExeName}"; Tasks: quicklaunchicon  


; Installationsstufen:
[Types]

;Languages: en; Name: "L_1";  Description: "EN Full Installation"; 
;Languages: en; Name: "L_2";  Description: "EN Compact Installation"; OnlyBelowVersion: 4.1,5.0 
;Languages: en; Name: "L_3";  Description: "EN Automatic Installation"
;Languages: en; Name: "L_4";  Description: "EN Custom"


;Languages: de;  Name: "L_1";  Description: "Alles installieren"; 
;Languages: de;  Name: "L_2";  Description: "Optimiert für frühe Windows"; OnlyBelowVersion: 4.1,5.0
;Languages: de;  Name: "L_3";  Description: "Automatisch"
;Languages: de;  Name: "L_4";  Description: "Benutzer"


;Languages: nl; Name: "L_1";  Description: "NL Full Installation"; 
;Languages: nl; Name: "L_2";  Description: "NL Compact Installation"; OnlyBelowVersion: 4.1,5.0 
;Languages: nl; Name: "L_3";  Description: "NL Automatic Installation"
;Languages: nl; Name: "L_4";  Description: "NL Custom"




[Components]
;Languages: en; Name: "L_3rdparty" ;   Description: "Full Installation";        Types: L_1 L_2 L_3; Flags: fixed; 
;Languages: en; Name: "ConTEXT";       Description: "ConTEXT IDE";              Types: L_1 L_2 L_3
;Languages: en; Name: "WorkBenchpp";   Description: "CCTrans32";                Types: L_1 L_2; MinVersion: 4.0,4.0

;Languages: en; Name: "|_VM";          Description: "|_";                       Types: L_1 L_3 
;Languages: en; Name: "UserPrograms";  Description: "Programmbeispiele";        Types: L_1

;Languages: de; Name: "L_3rdparty";    Description: "Wenig Speicherplatz";      Types: L_1 L_2 L_3; Flags: fixed; 
;Languages: de; Name: "ConTEXT";       Description: "ConTEXT IDE";              Types: L_1 L_2 L_3
;Languages: de; Name: "WorkBenchpp";   Description: "CCTrans32";                Types: L_1 L_2; MinVersion: 4.0,4.0

;Languages: de; Name: "|_VM";          Description: "|_";   Types: L_1 L_3 
;Languages: de; Name: "UserPrograms";  Description: "Programmbeispiele"; Types: L_1

;Languages: nl; Name: "L_3rdparty";    Description: "NL Wenig Speicherplatz";    Types: L_1 L_2 L_3; Flags: fixed; 
;Languages: nl; Name: "ConTEXT";       Description: "NL ConTEXT IDE";            Types: L_1 L_2 L_3
;Languages: nl; Name: "WorkBenchpp";   Description: "NL CCTrans32";              Types: L_1 L_2; MinVersion: 4.0,4.0

;Languages: nl; Name: "|_VM";          Description: "NL |_";   Types: L_1 L_3 
;Languages: nl; Name: "UserPrograms";  Description: "NL Programmbeispiele";     Types: L_1



[Files]

Source: "L:\x2g\System\SETUP\Fonts\dejavu-lgc-fonts-ttf-2.35\ttf\DejaVuLGCSansMono.ttf"; DestDir: "{fonts}"; FontInstall: "DejaVu LGC Sans Mono"; Flags: onlyifdoesntexist
Source: "L:\x2g\System\SETUP\Fonts\DOSfont7x12\DOS7X12.fon"                            ; DestDir: "{fonts}"; FontInstall: "DOS 7x12 Font"       ; Flags: onlyifdoesntexist


Source: "L:\X2G\*";          DestDir: "{app}\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.ini, *.bak, *.bax, *.map, *.tmp, *.dat, *.log, *.mmd, *.lst, *.ht, *.hex, *.p, *.png, *.gid, *.mne, *.var, *.bin, *.log, *.out, *.ocbasr, stderr.txt, stdout.txt;"
;Source: "L:\X2G\*.zip";          DestDir: "{app}\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs;
;Source: "L:\X2G\*.rar";          DestDir: "{app}\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs;

; Ausnahmen fuer einzelne vorkompilerte .DAT Dateien die mitkopiert werden sollen bitte hier eintragen:
  Source: "L:\X2G\L-TOOLS\MEMVIEW\LMEMVIEW.dat*";  DestDir: "{app}\x2g\L-TOOLS\MEMVIEW\";

;Source: "L:\X2G\3rdparty\*"; DestDir: "{app}\x2g\3rdparty"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: " *.ini, *.bak, *.bax, *.map, *.tmp, *.dat, *.log, *.mmd, *.lst, *.ht, *.hex"; 

;Source: "L:\X2G\3rdparty\CROSS_ASSEMBLERS\*"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs touch;

;Source: "L:\X2G\3rdparty\PDF_READERS\SumatraPDF\Version_Win95_NotAvailable\*.*";               DestDir: "{app}\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\"; OnlyBelowVersion: 4.10,4.10;
;Source: "L:\X2G\3rdparty\PDF_READERS\SumatraPDF\Version_0.7_Win98-NT\*.*";                     DestDir: "{app}\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\"; MinVersion: 4.10,4.10;
;Source: "L:\x2g\3rdparty\PDF_READERS\SumatraPDF\Version_0.9.1_Windows2K\SumatraPDF-0.9.1\*.*"; DestDir: "{app}\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\"; MinVersion: 5.0,5.0;
;Source: "L:\X2G\3rdparty\PDF_READERS\SumatraPDF\Version_3.1.2_WinXP-W10\*.*";                    DestDir: "{app}\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\"; MinVersion: 5.1,5.1;
;removed in 0.26 Source: "L:\X2G\3rdparty\PDF_READERS\SumatraPDF\Version_2.5_WinSrv2003\*.*";                   DestDir: "{app}\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\"; MinVersion: 5.2,5.2; 

;
Source: "L:\X2G\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\as05-DOS_1.40.exe"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\$_L-WORK.DIR\"; DestName: "AS05.exe"; OnlyBelowVersion:  4.10,4.10;
Source: "L:\X2G\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\as05_w32_1.42.exe"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\$_L-WORK.DIR\"; DestName: "AS05.exe"; MinVersion:  4.10,4.10; 
Source: "L:\X2G\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\as05_w32_1.44.exe"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\$_L-WORK.DIR\"; DestName: "AS05.exe"; MinVersion: 5.1,5.1;
;
; Individual file exempts for AS05 testcase program:
Source: "L:\x2g\3rdparty\CROSS_ASSEMBLERS\FRANKS\AS05\testincl.hex"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\";
Source: "L:\x2g\3rdparty\CROSS_ASSEMBLERS\FRANKS\AS05\testincl.bin"; DestDir: "{app}\x2g\3rdparty\CROSS_ASSEMBLERS\Franks\AS05\";

;Weil Uwe Sieber's FCB.EXE unter Win95 und Win98 nicht funktioniert eine Version der 32ocbasR.bat die mit dem Windows-eigenen FC arbeitet:
Source: "L:\x2g\System\BAT\32ocbasR-for-Win95-Win98.bat"; DestDir: "{app}\x2g\System\BAT\"; DestName: "32ocbasR.bat"; OnlyBelowVersion: 5.0,5.0;

;Weil PuTTY unter Win95 (und Win98?) nicht funktioniert stattdessen Terminal.exe von Dietmar Harlos verwenden:
Source: "L:\x2g\3rdparty\Terminal\Windows\Dietmar Harlos\Terminal32.exe"; DestDir: "{app}\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\"; DestName: "L1_PuTTY.exe"; OnlyBelowVersion: 5.0,5.0;
Source: "L:\x2g\3rdparty\Terminal\Windows\Dietmar Harlos\Terminal32.exe"; DestDir: "{app}\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\"; DestName: "L2_PuTTY.exe"; OnlyBelowVersion: 5.0,5.0;
Source: "L:\x2g\3rdparty\Terminal\Windows\Dietmar Harlos\Terminal32.exe"; DestDir: "{app}\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\"; DestName: "L3_PuTTY.exe"; OnlyBelowVersion: 5.0,5.0;
Source: "L:\x2g\3rdparty\Terminal\Windows\Dietmar Harlos\Terminal32.exe"; DestDir: "{app}\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\"; DestName: "L4_PuTTY.exe"; OnlyBelowVersion: 5.0,5.0;
;Oben: Allerdings kommt kommt von anderer Stelle noch eine weitere Fehlermeldung die man wegklicken muss. Das muss auch noch mal geaendert werden


Source: "L:\x2g\System\Setup\DE\Version.L"; DestDir: "{app}\x2g\"; Languages: de;
Source: "L:\x2g\System\Setup\EN\Version.L"; DestDir: "{app}\x2g\"; Languages: en;
Source: "L:\x2g\System\Setup\NL\Version.L"; DestDir: "{app}\x2g\"; Languages: nl;

; Localization   (V.20: seems redundant since already copy'ed using wildcards)
; copy available language translation files into their respective directories. 
;Source: "L:\X2G\System\MSG\EN\*"; DestDir: "{app}\\x2g\System\MSG\EN\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";
;Source: "L:\X2G\System\MSG\DE\*"; DestDir: "{app}\\x2g\System\MSG\DE\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";
;Source: "L:\X2G\System\MSG\NL\*"; DestDir: "{app}\\x2g\System\MSG\NL\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";

Source: "L:\X2G\System\MSG\EN\*"; DestDir: "{app}\\x2g\System\MSG\EN\";  Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";
Source: "L:\X2G\System\MSG\DE\*"; DestDir: "{app}\\x2g\System\MSG\DE\";  Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";
Source: "L:\X2G\System\MSG\NL\*"; DestDir: "{app}\\x2g\System\MSG\NL\";  Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.bak";


;
;Languages: en; Source: "L:\X2G\System\MSG\EN\*"; DestDir: "{app}\\x2g\System\MSG\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: de; Source: "L:\X2G\System\MSG\DE\*"; DestDir: "{app}\\x2g\System\MSG\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: nl; Source: "L:\X2G\System\MSG\NL\*"; DestDir: "{app}\\x2g\System\MSG\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;
;Languages: en; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\EN\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\L-WORK.DIR"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: de; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\DE\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\L-WORK.DIR"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: nl; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\EN\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\L-WORK.DIR"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;
;Languages: en; Source: "L:\X2G\System\SETUP\EN\*.L"; DestDir: "{app}\\x2g\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: de; Source: "L:\X2G\System\SETUP\DE\*.L"; DestDir: "{app}\\x2g\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;
;Languages: nl; Source: "L:\X2G\System\SETUP\NL\*.L"; DestDir: "{app}\\x2g\"; Components: context; Flags: ignoreversion recursesubdirs createallsubdirs;

;
Languages: en; Source: "L:\X2G\System\MSG\EN\*"; DestDir: "{app}\\x2g\System\MSG\"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: de; Source: "L:\X2G\System\MSG\DE\*"; DestDir: "{app}\\x2g\System\MSG\"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: nl; Source: "L:\X2G\System\MSG\NL\*"; DestDir: "{app}\\x2g\System\MSG\"; Flags: ignoreversion recursesubdirs createallsubdirs;
;
Languages: en; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\EN\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\$_L-WORK.DIR"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: de; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\DE\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\$_L-WORK.DIR"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: nl; Source: "L:\X2G\3rdparty\BASICpP\V.2.03.0331\EN\*"; DestDir: "{app}\\x2g\3rdparty\BASICpP\$_L-WORK.DIR"; Flags: ignoreversion recursesubdirs createallsubdirs;
;
Languages: en; Source: "L:\X2G\System\SETUP\EN\*.L"; DestDir: "{app}\\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: de; Source: "L:\X2G\System\SETUP\DE\*.L"; DestDir: "{app}\\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs;
Languages: nl; Source: "L:\X2G\System\SETUP\NL\*.L"; DestDir: "{app}\\x2g\"; Flags: ignoreversion recursesubdirs createallsubdirs;

;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files !

[Tasks]


;Name: desktopicon; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; 
;Name: desktopicon\common; Description: "For all users"; GroupDescription: "Additional icons:"; Flags: exclusive; 
;Name: desktopicon\user; Description: "For the current user only"; GroupDescription: "Additional icons:"; Flags: exclusive unchecked
;Name: quicklaunchicon; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:";  Flags: unchecked

;Languages: en; Name: associate; Description: "&Start the |_ Distribution automatically when I double-click supported source code files."; GroupDescription: "Other tasks:";
;Languages: de; Name: associate; Description: "Zum Bearbeiten von Quelltexten die |_ Distribution &verwenden."; GroupDescription: "Sonstiges:";
;Languages: nl; Name: associate; Description: "NL &Start the |_ Distribution automatically when I double-click supported source code files."; GroupDescription: "Other tasks:";
 
;;;Languages: en; Name: "mount_L";  Description: "(broken)&Mount installation path as L: drive. To successfully run |_ Distribution this is required. However mounting can be done any time, using the command line.";  GroupDescription: "Mount options:";  Flags: unchecked
;;;Languages: de; Name: "mount_L";  Description: "(geht nicht)Den Installationspfad  ({app})  als virtuelles Laufwerk  L:  &einhängen. Dies ist zur korrekten Funktion der |_ Distribution erforderlich - kann aber auch später noch manuell in der Kommandozeile erfolgen."; GroupDescription: "Pfad-Einstellugen:"; Flags: unchecked
;;;Languages: nl; Name: "mount_L";  Description: "(broken)&Mount installation path as L: drive- To successfully run |_ Distribution this is required. However mounting can be done any time, using the command line.";  GroupDescription: "Mount options:";  Flags: unchecked

[Registry]

;workarounds starting from |_ 0.18:                                                                                   "  %  n  "  ,  %  l
;Root: HKCU; Subkey: "Software\Eden\ConTEXT\UserExecKeys\3\F9"; ValueType: string; ValueName: "ParserRule"; ValueData: "\"%n\",%l"



;Automatically mount installation path under virtual drive letter 'L:'
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "MOUNT_L_Distribution_DIR"; ValueData: "subst L: {app}"; Flags: uninsdeletekey;



;"shell\open\command" is the registry key that specifies the program to execute when a file of the type is double-clicked in Explorer. 
;The surrounding quotes are in the command line so it handles long filenames correctly. 
;".ocb" is the extension we're associating. "xxxxxx" is the internal name for the file type as stored in the registry.
;Make sure you use a unique name for this so you don't inadvertently overwrite another application's registry key. 
 


Root: HKCR; Subkey: ".asm";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_ASM";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".a05";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_A05";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".s19";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_S19";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".hex";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_HEX";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".lst";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_LST";  Flags: uninsdeletekey;


Root: HKCR; Subkey: ".bas";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_BAS";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".bax";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_BAX";  Flags: uninsdeletekey;

Root: HKCR; Subkey: ".bpp";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_BPP";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".blib"; ValueType: string; ValueName: ""; ValueData: "L_Filetype_BLIB"; Flags: uninsdeletekey;

Root: HKCR; Subkey: ".c5";   ValueType: string; ValueName: ""; ValueData: "L_Filetype_C5";   Flags: uninsdeletekey;
Root: HKCR; Subkey: ".inc";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_INC";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".h";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_C5H";  Flags: uninsdeletekey;

Root: HKCR; Subkey: ".dat";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_DAT";  Flags: uninsdeletekey;

Root: HKCR; Subkey: ".i";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_I";  Flags: uninsdeletekey;

Root: HKCR; Subkey: ".mne";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_MNE";  Flags: uninsdeletekey;



Root: HKCR; Subkey: ".ocb";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_OCB";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".pro";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_PRO";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".def";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_DEF";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".iia";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_IIA";  Flags: uninsdeletekey;
Root: HKCR; Subkey: ".iar";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_IAR";  Flags: uninsdeletekey;
; + 0.28:
Root: HKCR; Subkey: ".ocbasr";  ValueType: string; ValueName: ""; ValueData: "L_Filetype_OCBASR";  Flags: uninsdeletekey;

Root: HKCR; Subkey: ".l";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_L";   Flags: uninsdeletekey;

;experimental - for ReactOS:
;Root: HKCR; Subkey: ".pdf";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_PDF";   Flags: uninsdeletekey;

Root: HKCR; Subkey: ".var";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_VAR";   Flags: uninsdeletekey;
Root: HKCR; Subkey: ".map";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_MAP";   Flags: uninsdeletekey;
Root: HKCR; Subkey: ".tmp";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_TMP";   Flags: uninsdeletekey;

Root: HKCR; Subkey: ".tab";    ValueType: string; ValueName: ""; ValueData: "L_Filetype_TAB";   Flags: uninsdeletekey;

;++++++++++++++++++++++++++++++++++++++++++++++

;+0.29:
Root: HKCR; Subkey: "telnet\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\Terminal\Windows\PuTTY\$_L-WORK.DIR\L1_putty.exe"" ""%1"""; Flags: uninsdeletekey; MinVersion: 5.2,5.2;

;68HC05 Asssembler
Root: HKCR; Subkey: "L_Filetype_ASM"; ValueType: string; ValueName: ""; ValueData: "Assembly src code"; Flags: uninsdeletekey; Languages: en; 
Root: HKCR; Subkey: "L_Filetype_ASM"; ValueType: string; ValueName: ""; ValueData: "Assembler Quelltext";    Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_ASM"; ValueType: string; ValueName: ""; ValueData: "Assembly src code"; Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_ASM\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

Root: HKCR; Subkey: "L_Filetype_A05"; ValueType: string; ValueName: ""; ValueData: "Assembly src code"; Flags: uninsdeletekey; Languages: en; 
Root: HKCR; Subkey: "L_Filetype_A05"; ValueType: string; ValueName: ""; ValueData: "Assembler Quelltext";    Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_A05"; ValueType: string; ValueName: ""; ValueData: "Assembly src code"; Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_A05\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;S19
Root: HKCR; Subkey: "L_Filetype_s19"; ValueType: string; ValueName: ""; ValueData: "Motorola s19 format";    Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_s19"; ValueType: string; ValueName: ""; ValueData: "Motorola s19 Format";  Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_s19"; ValueType: string; ValueName: ""; ValueData: "Motorola s19 format";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_s19\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;HEX
Root: HKCR; Subkey: "L_Filetype_HEX"; ValueType: string; ValueName: ""; ValueData: "Hexadecimal data";         Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_HEX"; ValueType: string; ValueName: ""; ValueData: "Asm.-Ausgabedatei";  Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_HEX"; ValueType: string; ValueName: ""; ValueData: "Hexadecimal data";         Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_HEX\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;LST
Root: HKCR; Subkey: "L_Filetype_LST"; ValueType: string; ValueName: ""; ValueData: "Assembly out listing";              Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_LST"; ValueType: string; ValueName: ""; ValueData: "Assemblerausgabeliste";      Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_LST"; ValueType: string; ValueName: ""; ValueData: "Assembly out listing";              Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_LST\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;C-Control/BASIC
Root: HKCR; Subkey: "L_Filetype_BAS"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC src code";    Flags: uninsdeletekey; Languages: en; 
Root: HKCR; Subkey: "L_Filetype_BAS"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC-Quelltext";   Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_BAS"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC src code";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_BAS\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

Root: HKCR; Subkey: "L_Filetype_BAX"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC src code";    Flags: uninsdeletekey; Languages: en; 
Root: HKCR; Subkey: "L_Filetype_BAX"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC-Quelltext";   Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_BAX"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC src code";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_BAX\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
;C-Control/BASIC++
Root: HKCR; Subkey: "L_Filetype_BPP"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ project src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_BPP"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ Projekt-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_BPP"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ project src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_BPP\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_BLIB"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ include src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_BLIB"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ Einfüge-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_BLIB"; ValueType: string; ValueName: ""; ValueData: "C-Control/BASIC++ include src code";   Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_BLIB\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
;C-Control/C-Cross-Compiler
Root: HKCR; Subkey: "L_Filetype_C5";  ValueType: string; ValueName: ""; ValueData: "C-Control/C-Cross-Compiler src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_C5";  ValueType: string; ValueName: ""; ValueData: "C-Control/C-Cross-Compiler-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_C5";  ValueType: string; ValueName: ""; ValueData: "C-Control/C-Cross-Compiler src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_C5\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_INC"; ValueType: string; ValueName: ""; ValueData: "Text-based incl file";       Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_INC"; ValueType: string; ValueName: ""; ValueData: "Einfüge-Quelltext";  Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_INC"; ValueType: string; ValueName: ""; ValueData: "Text-based incl file";       Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_INC\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_C5H"; ValueType: string; ValueName: ""; ValueData: "C/C++ include file";      Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_C5H"; ValueType: string; ValueName: ""; ValueData: "C/C++ Einfüge-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_C5H"; ValueType: string; ValueName: ""; ValueData: "C/C++ include file";      Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_C5H\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_I"; ValueType: string; ValueName: ""; ValueData: "Assembly include file";       Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_I"; ValueType: string; ValueName: ""; ValueData: "Assembler Einfüge-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_I"; ValueType: string; ValueName: ""; ValueData: "Assembly include file";       Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_I\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_MNE"; ValueType: string; ValueName: ""; ValueData: "Bytecode mnemonics";        Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_MNE"; ValueType: string; ValueName: ""; ValueData: "Bytekode-Mnemonik Repräsentation"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_MNE"; ValueType: string; ValueName: ""; ValueData: "Bytecode menmonics";        Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_MNE\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;Open-Control/BASIC 
Root: HKCR; Subkey: "L_Filetype_OCB"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC src code";    Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_OCB"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC Quelltext";   Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_OCB"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC src code";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_OCB\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_PRO"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC include src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_PRO"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC Einfüge-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_PRO"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC include src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_PRO\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_DEF"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC constants definition"; Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_DEF"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC Konstantendefinition";  Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_DEF"; ValueType: string; ValueName: ""; ValueData: "Open-Control/BASIC constants definition"; Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_DEF\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_IIA"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Interrupt Assembly src code";   Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_IIA"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Interrupt Assembler-Quelltext"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_IIA"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Interrupt Assembly src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_IIA\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
Root: HKCR; Subkey: "L_Filetype_IAR"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Assembly Routine src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_IAR"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Assembler-Quelltext";             Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_IAR"; ValueType: string; ValueName: ""; ValueData: "Open-Control/Inline Assembly Routine src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_IAR\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;
; + 0.28:
Root: HKCR; Subkey: "L_Filetype_OCBASR"; ValueType: string; ValueName: ""; ValueData: "Intermediate src code";  Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_OCBASR"; ValueType: string; ValueName: ""; ValueData: "OCBASR-Zwischenquellcode";             Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_OCBASR"; ValueType: string; ValueName: ""; ValueData: "Intermediate src code";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_OCBASR\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
; 0.28


;VAR and MAP FILES:
Root: HKCR; Subkey: "L_Filetype_VAR"; ValueType: string; ValueName: ""; ValueData: "List of RAM variables";    Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_VAR"; ValueType: string; ValueName: ""; ValueData: "Liste mit Variablenpositionen"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_VAR"; ValueType: string; ValueName: ""; ValueData: "List of RAM variables";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_VAR\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

Root: HKCR; Subkey: "L_Filetype_MAP"; ValueType: string; ValueName: ""; ValueData: "List of RAM variables";    Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_MAP"; ValueType: string; ValueName: ""; ValueData: "Liste mit Variablenpositionen"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_MAP"; ValueType: string; ValueName: ""; ValueData: "List of RAM variables";    Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_MAP\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
   
;TMP FILES:
Root: HKCR; Subkey: "L_Filetype_TMP"; ValueType: string; ValueName: ""; ValueData: "temporary data";   Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_TMP"; ValueType: string; ValueName: ""; ValueData: "Zwischenspeicher (z.B. CCBAS-Parser)"; Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_TMP"; ValueType: string; ValueName: ""; ValueData: "temporary data";   Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_TMP\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;

;BYTECODE (.DAT):
Root: HKCR; Subkey: "L_Filetype_DAT"; ValueType: string; ValueName: ""; ValueData: "Bytecode 4 microcontroller"; Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_DAT"; ValueType: string; ValueName: ""; ValueData: "Bytekode für Mikrokontroller";   Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_DAT"; ValueType: string; ValueName: ""; ValueData: "Bytecode 4 microcontroller";  Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_DAT\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;


;experimentell, fuer ReactOS:  PDF-Reader
;Root: HKCR; Subkey: "L_Filetype_PDF"; ValueType: string; ValueName: ""; ValueData: "Portable Document Format"; Flags: uninsdeletekey; Languages: en;
;Root: HKCR; Subkey: "L_Filetype_PDF"; ValueType: string; ValueName: ""; ValueData: "Portables Dokumenten Format";             Flags: uninsdeletekey; Languages: de;
;Root: HKCR; Subkey: "L_Filetype_PDF"; ValueType: string; ValueName: ""; ValueData: "Portable Document Format"; Flags: uninsdeletekey; Languages: nl;
;Root: HKCR; Subkey: "L_Filetype_PDF\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\SumatraPDF.exe"" ""%1"""; Flags: uninsdeletekey;



; |_ Distribution  dynamic files
Root: HKCR; Subkey: "L_Filetype_L"; ValueType: string; ValueName: ""; ValueData: "|_ Distribution help file"; Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_L"; ValueType: string; ValueName: ""; ValueData: "|_ Distribution Hilfedatei";    Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_L"; ValueType: string; ValueName: ""; ValueData: "|_ Distribution help file"; Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_L\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;


; + 0.26 Tabellendatei (.TAB)
Root: HKCR; Subkey: "L_Filetype_TAB"; ValueType: string; ValueName: ""; ValueData: "Constants Table"; Flags: uninsdeletekey; Languages: en;
Root: HKCR; Subkey: "L_Filetype_TAB"; ValueType: string; ValueName: ""; ValueData: "Konstantentabelle";    Flags: uninsdeletekey; Languages: de;
Root: HKCR; Subkey: "L_Filetype_TAB"; ValueType: string; ValueName: ""; ValueData: "Constants Table"; Flags: uninsdeletekey; Languages: nl;
Root: HKCR; Subkey: "L_Filetype_TAB\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""; Flags: uninsdeletekey;
;;
;example: "myprogram.exe,0" extracts first ICON from "myprogram.exe"
;Root: HKCR; Subkey: "L_Filetype_OCB\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""
;Root: HKCR; Subkey: "L_Filetype_PRO\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""
;Root: HKCR; Subkey: "L_Filetype_DEF\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """L:\x2g\3rdparty\ConTEXT\ConTEXT.exe"" ""%1"""




;Icons to be displayed alongside file types in Windows explorer and other programs. NOTE: Instead of using the {app} constant, the full path ("L:\x2g\...")
;is provided here. This way, if after booting SUBST L: {app}\L goes missing, the user will gets a hint because customized icons are not displayed.
;It is vital for operating the |_ distribution that at runtime the installation root directory is assigned the drive letter "L". Otherwise the system will not perform.
;
;68HC05 Assembler:
Root: HKCR; Subkey: "L_Filetype_ASM\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Las05_Icon.ico";  Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_A05\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Las05_Icon.ico";  Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_S19\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Ls19_Icon.ico";   Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_I\DefaultIcon";   ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Li_Icon.ico";     Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_HEX\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lhex_Icon.ico";   Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_LST\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\LList_Icon.ico";  Flags: uninsdeletekey;

;C-Control/BASIC: 
Root: HKCR; Subkey: "L_Filetype_BAS\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lccbas_Icon.ico"; Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_BAX\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lbax_Icon.ico";   Flags: uninsdeletekey; 

;C-Control/BASIC++:
Root: HKCR; Subkey: "L_Filetype_BPP\DefaultIcon";  ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lbpp_Icon.ico";  Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_BLIB\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lblib_Icon.ico"; Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_MNE\DefaultIcon";  ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lmne_Icon.ico";  Flags: uninsdeletekey;


;C-Control/C-Cross-Compiler:
Root: HKCR; Subkey: "L_Filetype_C5\DefaultIcon";  ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lc5_Icon.ico";   Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_INC\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lincl_Icon.ico"; Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_C5H\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lh_Icon.ico";    Flags: uninsdeletekey; 
;
;Open-Control/BASIC Open-Control project:
Root: HKCR; Subkey: "L_Filetype_OCB\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_PRO\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_DEF\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_IIA\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
Root: HKCR; Subkey: "L_Filetype_IAR\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
; + 0.28:
Root: HKCR; Subkey: "L_Filetype_OCBASR\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\OM_favicon.ico";  Flags: uninsdeletekey; 
; 0.28

Root: HKCR; Subkey: "L_Filetype_VAR\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lvar_Icon.ico";  Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_MAP\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Lvar_Icon.ico";  Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_TMP\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Ltmp_Icon.ico";  Flags: uninsdeletekey;
Root: HKCR; Subkey: "L_Filetype_L\DefaultIcon";   ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\L_Icon.ico";     Flags: uninsdeletekey; 

; + 0.26:
Root: HKCR; Subkey: "L_Filetype_TAB\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Ltab_Icon.ico";  Flags: uninsdeletekey;

;BYTECODE (.DAT):
Root: HKCR; Subkey: "L_Filetype_DAT\DefaultIcon";   ValueType: string; ValueName: ""; ValueData: "L:\x2g\System\Setup\Ldat_Icon.ico";  Flags: uninsdeletekey; 


;experimentell, fuer ReactOS:  PDF-Reader
;Root: HKCR; Subkey: "L_Filetype_PDF\DefaultIcon";   ValueType: string; ValueName: ""; ValueData: "L:\x2g\3rdparty\PDF_READERS\SumatraPDF\$_L-WORK.DIR\SumatraPDF.exe,0";  Flags: uninsdeletekey;

;Languages: de; Root: HKCR; Subkey: "Open-Control/BASIC Quelltext"; ValueType: string; ValueName: ".ocb"; ValueData: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.EXE"; Flags: uninsdeletekey 
;Languages: nl; Root: HKCR; Subkey: "Open-Control/BASIC (nl) source file"; ValueType: string; ValueName: ".ocb"; ValueData: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.EXE";

;"My Program File" above is the name for the file type as shown in Explorer. 

;Root: HKCR; Subkey: "0"; ValueType: string; ValueName: ""; ValueData: "{app}\3rdparty\ConTEXT\ConTEXT.EXE,0" 
;"DefaultIcon" is the registry key that specifies the filename containing the icon to associate with the file type. ",0" tells Explorer to use the first icon from MYPROG.EXE. (",1" would mean the second icon.) 
 
;Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
;Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1




;Name: "{group}\die |_ Distribution"; Filename: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.exe,1"; WorkingDir: "{app}";
;Name: "{group}\{cm:UninstallProgram,Distribution L}"; Filename: "{uninstallexe}"

;Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\|_ Distribution"; Filename: "{app}\x2g\3rdparty\ConTEXT\ConTEXT.exe"






;Root: HKCU; Subkey: "Software\Eden\ConTEXT\UserExecKeys\3\F9"; ValueType: string; ValueName: "ParserRule="; Value: ""%n",%l"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "Path"; ValueData: "{app}"


[RUN]
Filename: subst.exe; Parameters: "/D L:";
Filename: subst.exe; Parameters: "L: {app}";
;Filename: xcopy;     Parameters: {app}START.lnk L:\;
;
Languages: en; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\EN\x2g_111_EN_16.reg"; OnlyBelowVersion: 0,6;
Languages: de; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\DE\x2g_111_DE_16.reg"; OnlyBelowVersion: 0,6;
Languages: nl; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\NL\x2g_111_NL_16.reg"; OnlyBelowVersion: 0,6;
;
Languages: en; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\EN\x2g_111_EN_32.reg"; MinVersion: 5.2,5.2;
Languages: de; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\DE\x2g_111_DE_32.reg"; MinVersion: 5.2,5.2;
Languages: nl; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\NL\x2g_111_NL_32.reg"; MinVersion: 5.2,5.2;
;
Languages: en; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\EN\L-PuTTY_011_EN_XP.reg";
Languages: de; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\DE\L-PuTTY_011_DE_XP.reg";
Languages: nl; Filename: regedit.exe; Parameters: "/S {app}\x2g\System\SETUP\NL\L-PuTTY_011_NL_XP.reg";
;
Filename: {app}\x2g\3rdparty\ConTEXT\ConTEXT.exe; Description: "{cm:LaunchProgram,|_ Di&stribution }"; Flags: nowait postinstall skipifsilent
