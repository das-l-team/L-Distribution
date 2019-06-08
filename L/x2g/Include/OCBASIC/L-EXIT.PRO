 'Name..........: L-EXIT.PRO
 'Kompiler......: OCBASIC 1.09(a), 1.10a
 'Zweck.........: Standardfunktion fuer 'Lbit'-Programme
 'erfordert.....: L-INIT.PRO, und 'Lbit'
 'Version.......: 29. Maerz 2017

INCLUDE "L:\x2g\Include\OCBASIC\L-BMCALL.PRO"

 #SansLbit
  Msg_Braucht
  Msg_URL
  RETURN

 #Msg_BmVersLow 'Nicht von OM-Micro/Conrad-Micro aufrufen, weil 16-bit Variablen verwendet werden.
  LOOKTAB Dieses_Programm_wurde_entworfen_fuer_L_Modul, 0, w12
  PRINT "'Lbit' v.";w12; : w12=0 : Print " (ist: v.";Lbit_Version; ") ";  'w12=0 f- v.853 vorsehen
  'RETURN

 #Msg_URL
  PRINT " http://Lbit.ghn-sensorik.de  ";
  RETURN
 
 #Msg_Braucht
  'PRINT " Braucht: ";
   PRINT " Braucht: ";
  RETURN
  'Oben: Leerzeichen zu Beginn fuer C-Control I 2.0 (OS v2.07, 28.03.07),
  'da diese nach Reset das erste Zeichen der RS232-Ausgabe verschluckt:
  
