 'Name..........: L-INIT.PRO
 'Kompiler......: OCBASIC 1.09(a), 1.10a
 'Zweck.........: Standardfunktion fuer 'Lbit'-Programme
 'erfordert.....: L-EXIT.PRO, und 'Lbit'
 'Version.......: 29. Maerz 2017
 '
 'Besonderheit..: Damit dies auch auf den Open-Micro Kontrollern und der Conrad Micro
 '                lauffaehig ist, werden innerhalb der 'IsLBM'-Funktion keine 16 bit
 '                Variablen direkt angesprochen.
 '
 ' Die |_ Funktionsnamen sind bis OCBASIC-Version 1.10(a) hilfsweise in L-BMCALL.PRO enthalten.

option ccbas  'Abwaertskompatibilitaet beibehalten.
 #INIT
'Ab |_>BM< Version 0.840: ("x2g") optimierte Aufrufe zum Basismodul:
'      |_>EL< bildet die |_ Funktionsadressen (siehe L-BMCALL.PRO)
'      direkt auf das |_ Funktionsmodul ab. Auf sonstige Adressen
'      wird wie bisher schon der Ladeoffset addiert.

  INCLUDE "L:\X2G\INCLUDE\OCBASIC\DEFS\L-DEFS.DEF"
'  DEFINE PLZ_vctr  &hffc1
 ' DEFINE LXBM_vctr &hffC0


  'DEFINE idx_PLZ_vctr  -13
  'DEFINE idx_XEND_vctr -11
  DEFINE idx_DATA_vctr -9
  DEFINE idx_SUBS_vctr -7
  DEFINE idx_MAIN_vctr -5
  DEFINE idx_INIT_vctr -3
  DEFINE idx_LxBM_vctr -1
  DEFINE idx_LxBM       0
  DEFINE idx_LxBM_cmpd  1
  DEFINE idx_INIT_cmpd  3
  DEFINE idx_MAIN_cmpd  5
  DEFINE idx_SUBS_cmpd  7
  DEFINE idx_DATA_cmpd  9
  'DEFINE idx_XEND_cmpd 11
  'DEFINE idx_PLZ_cmpd  13


 'Ist das 'Lbit' System auf dem Host aktiviert? Falls ja, enthaelt word[11] die Slotnummer,
 'word[12] ist hingegen leer.
 'Fuer Kompatibilitaet mit Zielsystemen ohne Wordvariablen werden hier zunaechst nur Bytevariablen verwendet:

   IF (b21 OR b22) THEN GOTO Is_LBM '(Nur 'Lbit': Slotnummer dieses Programms in Word-Variable 11)

 'Gut waere, wenn die Adressen dieser zwei ivar's in allen
  DEFINE End2Host ivar [88] 'zukuenftigen OM-OS Versionen erhalten blieben,
  DEFINE UseEsci  ivar [64] 'um somit Aufwaertskompatibel zu bleiben.

  IF b24 >127 THEN 'MSB gesetzt? Ja = OM-OS, Nein = Conrad-Micro

      'Fuer Open-Micro/Macro/Maxi:
       End2Host=ON
       'UseEsci =ON

     ELSE

       'Conrad-Micro oder unbekannt.

   END IF

   GOSUB SansLbit

 END
'Oben:
'Diese Pruefung soll das Programm bei Nichtvorhandensein der 'Lbit' Firmware
'kontolliert beenden, um Beschaedigungen durch unkoordinierte Ansteuerung von
'moeglicherweise vorhandenen externen Schaltungen zu verhindern.

'Fuer OM-OS:
'Nach Test die internen Variablen zur Rueckkehr in den Hostmodus setzen.
'Dadurch wechseln Open-Micro/Mini, Open-Midi, Open-Macro zurueck in den
'Hostmodus und es kann ohne manuellen Reset sofort erneut programmiert werden.
'
'Fuer Conrad-OS:
'Bei Conrad Micro ist Bit 7 von b24 nicht gesetzt. Die ivar's sind dort
'nicht verwendbar.
'
'Anmerkung: Eigentlich sollten End2Host und UseEsci nur bei OpenMicro
'V0.4 bis OpenMacro 1.0 (Mai 2010) abgefragt werden, weil nicht garantiert
'ist dass alle zukuenftigen OM-OS Versionen diese ivar's beibehalten werden.
'Ohne das End2Host=ON muesste vor erneuter Programmierung manuell ein Reset
'ausgeloest und der Kontroller durch Druecken der Host-Taste wieder in den
'Programmiermodus gebracht werden. Bei der Open-Midi und Open-Macro waere
'sogar, falls die Hardware RS232 (Esci) verwendet wird, das Umstecken von
'Jumpern auf der Platine erforderlich.
'Dabei ist zu bedenken, dass die Jumper zur Schnittstellenauswahl bei der
'OM-Station, Version 1, erst nach Oeffnen des Gehauses zugaenglich sind.


#Is_LBM

 LOOKTAB Dieses_Programm_wurde_entworfen_fuer_L_Modul, 0, w12

   IF LbitVersOK THEN

           '(Programm wird bei #START_L_PROGRM fortgesetzt)

        ELSE

           '(Programm wird mit Versionsmeldung abgebrochen)

           GOSUB Msg_Braucht
           GOSUB Msg_BmVersLow  '(in L-EXIT.PRO)
           END

   END IF

#START_L_PROGRAM




