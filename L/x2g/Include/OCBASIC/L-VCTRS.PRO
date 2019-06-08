 'Name..........: L:/x2g/include/ocbasic/L-VCTRS.PRO
 'Compiler......: OCBASIC 1.09(a), OCBASIC 1.10a
 'Zweck.........: Ermittlung der Startadresse einer Sprungmarke zur Laufzeit.
 'Status........: Version mit Hilfskonstrukt / 21. November 2013
 'Lizenz........: Gnu General Public License, Version 3
 '
 '
 '
 '

' Die nachfolgende 'LOOKTAB' Anweisung beendet Linkvorgang ab Adresse 'vectors'.
' Alle vorstehenden Anweisungen werden durch |_>EL< reloziert - auch der obere
' Teil der Tabelle 'vectors' selbst. Die unteren Eintraege von vectors hingegen
' werden nicht veraendert, da diese bereits im Datenbereich stehen.

  LOOKTAB vectors,-1,w12'<--(Kann entfallen, wenn schon im Programm verwendet) =
'===============================================================================
' Besonderheit der Tabelle 'vectors' ist die Verwendung eines negativen Index
' beim Auslesen mittels LOOKTAB. Dadurch kann auf die obere Haelfte der Tabellen-
' eintraege zugegriffen werden. Diese werden von |_>EL< vor dem ersten Programm-
' start mit den zur Laufzeit gueltigen Startadressen der enthaltenen Sprungmarken
' ersetzt.



 END:GOTO  HTML_Begin
 END:GOTO  HTML_End
 ''''''''''''''''= Mittels LOOKTAB auf die OBERE Haelfte de Tabelle koennen die
 END:GOTO  LEND '= zur Laufzeit gueltigen (tatsaechlichen) Startadressen von im
 END:GOTO  DATA '= Programm enthaltenen Sprungmarken, (z.B. 'INIT','MAIN' usw.)
 END:GOTO  SUBS '= ermittelt werden. LOOKTAB auf die _untere_ Haelfte dieser
 END:GOTO  MAIN '= Tabelle liest dagegen die vom Open-Control/BASIC Kompiler zum
 END:GOTO  INIT '= Zeitpunkt der Kompilierung ermittelten Startadressen.
 TABLE     LBM_actual'<-- eigentlich: 'END:GOTO LBM', leider Hilfskonstrukt, siehe
 ''''''''''''''''''''''''''''''''''''  L:\x2x\INCLUDE\OCBASIC\L-BMCALL.PRO fuer Details.
 &hff03 &hffc0 TABEND'<--'LBM' ist in "L:\x2g\INCLUDE\OCBASIC\L-INIT.PRO" definiert.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 TABLE VECTORS TABEND ' +++  Grenze fuer den |_ Linker +++
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 TABLE     LxBM_compiled'<-- Leider Hilfskonstrukt (Eigentlich: 'END:GOTO LBM', wobei=                                                     =
 &hff03 &hffc0 TABEND  '<--'LBM' der in L-INIT.PRO definierten Konstante entspricht.
 END:GOTO  INIT
 END:GOTO  MAIN
 END:GOTO  SUBS
 END:GOTO  DATA
 END:GOTO  LEND
 END:GOTO  HTML_End
 END:GOTO  HTML_Begin
' TABLE     PLZ_vct     '<-- Hilfskonstrukt (Eigentlich: 'END:GOTO PLZ_vct', wobei=                                                     =
' &hff03 &hffc1 TABEND  '<--'LXBM' die in L-INIT.PRO definierte Konstante ist)GOTO  PLZ_cmpd



'Beispiel:                  Ergebnis:


  'LOOKTAB Vectors,vidx_INIT,w12 ' Adresse von 'INIT' in w12
  'LOOKTAB Vectors,vidx_MAIN,w2  ' Adresse von 'MAIN' in w2
  'LOOKTAB Vectors,vidx_SUBS,w3  ' Adresse von 'SUBS' in w3
  'LOOKTAB Vectors,vidx_DATA,w4  ' Adresse von 'DATA' in w4
  'LOOKTAB Vectors,vidx_XEND,w5  ' Adresse von 'XEND' in w5


'Achtung:

  'LOOKTAB Vectors,idx_LXBM,w1  ' Liefert Adresse des |_>BM< die zum Zeitpunkt
  '                             ' des Linkens vorgelegen hat.
  'VvR: LGet_BMADDR             ' Liefert die Adresse des aktuell verwendeten
  '                             ' Basismoduls. (fuer Testzwecke bei mehreren
  '                             ' gleichzeitig installierten BM sinnvoll)



 ' Alle Programmelemente _VOR_ der Linkgrenze
' werden von |_>EL< als Programmanweisungen moderiert.     (Dies gilt auch  ---
' fuer Tabellen, die evt. in den Abschnitten 'INIT', 'MAIN' oder 'SUBS'     ---
' enthalten sind.) Die in einigen Tokenkombinationen (GOTO, GOSUB, LOOKTAB, ---
' IF..THEN..ELSE, u.a.) enthaltenen (absoluten) Sprungadressen werden an    ---
' die aktuelle Ladeposition des Programms angepasst, damit dieses an der    ---
' neuen Speicherposition lauffaehig ist. Der "Tabellentrick" nach Dietmar   ---
' Harlos kann also in Anwenderprogrammen weiterhin verwendet werden.
'
' Linkgrenze sicherstellen:
' Damit die Grenze zum Datenbereich vo |_>EL< erkannt wird, auch wenn kein
' LOOKTAB auf die Daten existiert, z.B. weil das Programm per Maschinensprache
' auf die Daten zugreift.


  '#PC04 GOTO OFF4'<-- Diese Adresse 'OFF4' wird vom LEL nicht veraendert,
               '    weil sie bereits im Datenbereich des Programms steht!
               '
               'Erklaerung:
               'Der Linkvorgang stoppt bei Erreichen der ersten Tabelle,
               'fuer die im vorangehenden Quelltext ein zugehoeriges
               'LOOKTAB existiert. (Normalfall)
               '
               'Der Linker stoppt ebenfalls wenn ein LOOKTAB existiert,
               'das auf eine im vorlaufenden Quelltext befindliche
               'Tabelle verweist. (Deren Inhalte der Linker zu diesem
               'Zeitpunkt dann allerdings schon als Programmtoken
               'verarbeitet hat -> Es erfolgte KEINE Fehlermeldung!)
               '
               'In beiden Faellen werden alle weiteren Token direkt,
               'd.h. ohne Adressanpassung eventuell enthaltener
               'Sprunganweisungen, bis zum Quelltextende uebernommen.

' Der Linkvorgang stoppt, sobald eine durch vorlaufendes LOOKTAB referenzierte
' Tabelle erreicht wird. (Normaler Ablauf) Der LV stoppt ebenfalls sobald ein
' LOOKTAB erreicht wird, das auf eine weiter vorn im Programm stehende Tabelle
' zugreift.
