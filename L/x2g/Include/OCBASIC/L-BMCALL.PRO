'Diese Datei, "L:\X2G\L-PRG\OCBASIC\INCLUDE\L-BMCALL.PRO", enthaelt die symbolischen
'Einsprungadressen der 'Lbit'-Exportfunktionen. Sie ist für die Syntaxpruefung
'von OCBASIC (getestet bis einschliesslich Version 1.10a) leider noch erforderlich,
'weil die hierin definierten symbolischen Konstanten und Literale nicht direkt als
'in GOTO-, GOSUB-, und Unterfunktionsaufrufen (Function, Procedure) verwendet
'werden koennen.

'Format dieser Hilfsdatei:
'Fuer jede 'Lbit'-Exportfunktion existiert in der Tabelle eine Zeile:
'
' Byte Nr. 1:  &h03 (GOTO Token)
' Byte Nr. 2:  Hi-Byte der Adresse (beginnend mit &hff)
' Byte Nr. 3:  Lo-Byte der Adresse (absteigend: &hf7, &hf6, &hf5, usw.)
'
'Die symbolischen Einsprungadressen des 'Lbit'-Virtualisierungsmodul (LVM) beginnen
'am oberen Ende des Adressraums der Virtuellen Maschine (Beginn bei: &Hfff7).
'Sie 'wandern' mit steigenden Funktionsnummern abwaerts, in Richtung Adressraum
'des Anwenderprogramms.
'
'Die oberen 8 Bytes (&hfff8...&hffff) des 64 KiB umfassenden virtuellen Adressraums
'bleiben dabei fuer zukuenftige Erweiterungen reserviert (daher besitzt die erste
'Lbit'-Exportfunktion auch die symbolische Adresse &hfff7, und nicht &hffff).

'Lbit' ersetzt die symbolischen Adressen vor der 1. Programmausfuehrung mit den zur
'Laufzeit verwendeten Vektoren. Durch diese Vorverareitung entsteht beim spaeteren
'Programmlauf kein overhead. Die Latenz einer der 'Lbit'-Exportfunktion ist grund-
'saetzlich nicht hoeher als die von herkoemmlichen Funktionen und Prozeduren welche
'in den jeweiligen Anwenderprogrammen selbst enthalten sein koennen. Sie ist in
'erster Naeherung durch die vom Zielsystem zur Ausfuehrung eines 'GOSUB-Sprung-
'befehls benoetigte Zeitdauer definiert.

'Die Verwendung von 'L-BMCALL.PRO' besitzt den Nachteil pro _definierter_ 'Lbit'-
'Exportfunktion 3 Bytes Programmspeicher zu belegen. Zusaetzlich erhoeht sich
'durch das enthaltene GOTO leider doch die Latenz gegenueber lokalen Unterprogrammen
'und Funktionen (vgl. vorstehenden Absatz).
'
'Es gibt also begruendeten Anlass um den Einsatz dieser Hilfsdatei moeglichst
'uberfluessig zu machen. Leider faellt uns dazu keine Moeglichkeit ein, die
'ohne entsprechende Erweiterung des OCBASIC-Kompilers auskommt.

'
'*** Nachteile der Verwendung von L-BMCALL.PRO:
'
'  - Pro *definierter* 'Lbit'-Exportfunktion werden 3 Byte Programmspeicherplatz belegt,
'    unabhaengig davon ob bzw. welche der 56 'Lbit'-Exportfunktionen genutzt werden.
'
'  - Die Exportfunktion wird durch einen zusaetzlichen GOTO Sprung etwas verlangsamt.
'
'
' Idee an die OCBASIC-Entwickler:
'  Per define deklarierte symbolische Konstanten als Argument fuer
'  Sprunganweisungen (speziell GOTO,GOSUB) ermoeglichen. Unter OCBASIC 1.09(a), 1.10a
'  liefert der Kompiler keine Fehlermeldung, wenn man per define deklarierte Adressen
'  als Ziel eines Funktionsaufrufs schreibt, scheint diese aber zur LZ nicht zu verwenden.
'  Sonst waere ja alles klar.
'
'Beispiele:
'_______________________________
'
'  DEFINE L_Prozedur_Name &h1234
'  DEFINE L_Funktion_Name &h5678
'  DEFINE PrintDEC        &habcd

'  "GOSUB L_Prozedur_Name" -> entspraeche also -> "GOSUB &h1234"
'
'  "FOR n=0 TO 1000 : PrintDEC(n) : NEXT"

'(Idee/geplant:)
'     Anordnung der Lbit Funktionsnummern im 3-zu-2 Interleave Schema.
'     Hierbei werden Lbit Funktionen fuer das Basismodul 3-stellig, solche fuer das
'     Virtualisierungsmodul weiterhin 2-stellig jeweils abwechselnd angeordnet.
'     Das Lbit Basismodul (LBM) mit den Exportfunktionen koennte dann auch eigenstaendig,
'     ohne Unterstuetzung durch das Lbit Virtualisierungsmodul (LVM) verwendet werden.
'
'Dateiname................: L:\x2g\Include\OCBASIC\L-BMCALL.PRO
'Versionsstand............: 20. Juni 2017, fuer 'Lbit' bis 'v.854'
'Kompiler.................: OCBASIC 1.09(a), 1.10a
'Kompilierte Groesse......: 176 Bytes

#NotYetImplemented          TABLE L_CALL_59 byte &h03 &hff &hbd TABEND'-117 'LBM 59
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#LGet_PMEMFREE              TABLE L_CALL_58 byte &h03 &hff &hbd TABEND'-115 'LBM 58 'ab Version v.856 ?
#LReg_VAST                  TABLE L_CALL_57 byte &h03 &hff &hbe TABEND'-113 'LBM 57 'ab Version v.855
#Lbit_Version #BmVers       TABLE L_CALL_56 byte &h03 &hff &hbf TABEND'-111 'LBM 56 <-- Oberhalb und hier: mind. 'Lbit' 'v.854' erforderlich
#LGet_BaudErr               TABLE L_CALL_55 byte &h03 &hff &hc0 TABEND'-109 'LBM 55 Abweichung der Baudrate
#LGet_WRC                   TABLE L_CALL_54 byte &h03 &hff &hc1 TABEND'-107 'LBM 54 Watchdog Reset Counter
#LGet_ERC                   TABLE L_CALL_53 byte &h03 &hff &hc2 TABEND'-105 'LBM 53 External Reset Counter
#LGet_SRC                   TABLE L_CALL_52 byte &h03 &hff &hc3 TABEND'-103 'LBM 52 Software Reset Counter
#LGet_freemem_rem           TABLE L_CALL_51 byte &h03 &hff &hc4 TABEND'-101 'LBM 51
#LGet_MAXBAUD               TABLE L_CALL_50 byte &h03 &hff &hc5 TABEND '-99 'LBM 50
#LGet_SLTOFFST              TABLE L_CAll_49 byte &h03 &hff &hc6 TABEND '-97 'LBM 49
#LGet_NOM                   TABLE L_CAll_48 byte &h03 &hff &hc7 TABEND '-95 'LBM 48
#LGet_POC                   TABLE L_CAll_47 byte &h03 &hff &hc8 TABEND '-93 'LBM 47
#LGet_EEC                   TABLE L_CAll_46 byte &h03 &hff &hc9 TABEND '-91 'LBM 46
#LGet_IEC                   TABLE L_CAll_45 byte &h03 &hff &hca TABEND '-89 'LBM 45
#LHst_DeepReset             TABLE L_CAll_44 byte &h03 &hff &hcb TABEND '-87 'LBM 44
#LHst_Warmstart             TABLE L_CAll_43 byte &h03 &hff &hcc TABEND '-85 'LBM 43
#LGet_baudreg               TABLE L_CAll_42 byte &h03 &hff &hcd TABEND '-83 'LBM 42
#LGet_nextADDR              TABLE L_CAll_41 byte &h03 &hff &hce TABEND '-81 'LBM 41
#LGet_filelen               TABLE L_CAll_40 byte &h03 &hff &hcf TABEND '-79 'LBM 40
#LGet_freemem               TABLE L_CAll_39 byte &h03 &hff &hd0 TABEND '-77 'LBM 39
#LGet_hostIDS               TABLE L_CAll_38 byte &h03 &hff &hd1 TABEND '-75 'LBM 38
#LReg_hostIDS               TABLE L_CAll_37 byte &h03 &hff &hd2 TABEND '-73 'LBM 37
#LReg_busclock              TABLE L_CAll_36 byte &h03 &hff &hd3 TABEND '-71 'LBM 36
#LGet_ASJSLOT               TABLE L_CAll_35 byte &h03 &hff &hd4 TABEND '-69 'LBM 35
#LPrg_END                   TABLE L_CAll_34 byte &h03 &hff &hd5 TABEND '-67 'LBM 34
#LGet_MEMSIZE               TABLE L_CAll_33 byte &h03 &hff &hd6 TABEND '-65 'LBM 33
#LGet_busclock              TABLE L_CAll_32 byte &h03 &hff &hd7 TABEND '-63 'LBM 32
#LPrg_ClearRAM              TABLE L_CAll_31 byte &h03 &hff &hd8 TABEND '-61 'LBM 31
#LGet_filefree              TABLE L_CAll_30 byte &h03 &hff &hd9 TABEND '-59 'LBM 30
#LGet_HOSTTYPE              TABLE L_CAll_29 byte &h03 &hff &hda TABEND '-57 'LBM 29
#LGet_LastErr               TABLE L_Call_28 byte &h03 &hff &hdb TABEND '-55 'LBM 28
#LGet_RxBufSze              TABLE L_Call_27 byte &h03 &hff &hdc TABEND '-53 'LBM 27
#LGet_LCDSlot               TABLE L_Call_26 byte &h03 &hff &hdd TABEND '-51 'LBM 26
#LGet_LCDVctr               TABLE L_Call_25 byte &h03 &hff &hde TABEND '-49 'LBM 25
#LReg_LCDSlot               TABLE L_Call_24 byte &h03 &hff &hdf TABEND '-47 'LBM 24
#LReg_LCDVctr               TABLE L_Call_23 byte &h03 &hff &he0 TABEND '-45 'LBM 23
#LGet_UIPSlot               TABLE L_Call_22 byte &h03 &hff &he1 TABEND '-43 'LBM 22
#LGet_UIPVctr               TABLE L_Call_21 byte &h03 &hff &he2 TABEND '-41 'LBM 21
#LReg_UIPSlot               TABLE L_Call_20 byte &h03 &hff &he3 TABEND '-39 'LBM 20
#LReg_UIPVctr               TABLE L_Call_19 byte &h03 &hff &he4 TABEND '-37 'LBM 19
#LRun_Slot                  TABLE L_Call_18 byte &h03 &hff &he5 TABEND '-35 'LBM 18
#LRun_SlotKeepRam           TABLE L_Call_17 byte &h03 &hff &he6 TABEND '-33 'LBM 17
#LCall_UIP                  TABLE L_Call_16 byte &h03 &hff &he7 TABEND '-31 'LBM 16
#LCall_Slot                 TABLE L_Call_15 byte &h03 &hff &he8 TABEND '-29 'LBM 15
#LSync_MTicks               TABLE L_Call_14 byte &h03 &hff &he9 TABEND '-27 'LBM 14
#Lget_BaudAvail             TABLE L_Call_13 byte &h03 &hff &hea TABEND '-25 'LBM 13
#Lget_DA3                   TABLE L_Call_12 byte &h03 &hff &heb TABEND '-23 'LBM 12
#Lget_DA2                   TABLE L_Call_11 byte &h03 &hff &hec TABEND '-21 'LBM 11
#Lget_DA1                   TABLE L_Call_10 byte &h03 &hff &hed TABEND '-19 'LBM 10
#Lpoke8                     TABLE L_Call_09 byte &h03 &hff &hee TABEND '-17 'LBM 9
#Lpeek8                     TABLE L_Call_08 byte &h03 &hff &hef TABEND '-15 'LBM 8
#Lpoke16                    TABLE L_Call_07 byte &h03 &hff &hf0 TABEND '-13 'LBM 7
#Lpeek16                    TABLE L_Call_06 byte &h03 &hff &hf1 TABEND '-11 'LBM 6
#Lreg_TmpBaud               TABLE L_Call_05 byte &h03 &hff &hf2 TABEND ' -9 'LBM 5
#PrintLZ                    TABLE L_Call_04 byte &h03 &hff &hf3 TABEND ' -7 'LBM 4
#PrintDEC                   TABLE L_Call_03 byte &h03 &hff &hf4 TABEND ' -5 'LBM 3
#BmVersOK #LbitVersOK       TABLE L_Call_02 byte &h03 &hff &hf5 TABEND ' -3 'LBM 2
#L #Call #Success #Register TABLE L_Call_01 byte &h03 &hff &hf6 TABEND ' -1 'LBM 1
#Unknown_Cmd                TABLE L_Call_00 byte &h03 &hff &hf7 TABEND '     LBM 0