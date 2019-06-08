[ Das Programm PuTTYtel von Simon Tatham wird innerhalb der |_ Distribution verwendet
  um die Terminalverbindung zum Zielsystem zu erhalten. Diese ist lokal ueber einen
  einen COM-Port moeglich, oder per Telnetprotokoll auch ueber das Internet.
  Das verschluesselte SSH-Protokoll wird von PuTTYtel nicht unterstuetzt.

  PuTTYtel speicher Einstellungen in der Windows Registry. Deshalb liegt
  der |_ Distribution die Datei L:\x2g\system\de\PuTTY.reg bei, die vom User
  in die Windows Registry importiert werden sollte.

  Wir ueberlegen zukuenftig eine angepasste Version von PuTTYtel zu verwenden,
  um diverse Konfigurationseinstellungen von PuTTYtel nicht in der Registry
  speichern zu muessen, und eine portable Installation zu ermoeglichen.
  
  Eine Moeglickeit waere auf die PuTTY-Abwandlung 'KiTTY' umzustellen. KiTTY kann
  offenbar die Konfigurationsdateien auch in einer Datei speichern. Der Nachteil
  ist, dass KiTTY zum Betrieb das .NET Framework benötigt.

  das |_ Team

 ]
 
Please see http://www.chiark.greenend.org.uk/~sgtatham/putty/ for more info
and the complete file list of the PuTTY tool.