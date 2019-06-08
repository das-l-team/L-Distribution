'------------------------------------------
' Definitionen der I2C-Einsprungadressen
'------------------------------------------
define I2C_START        &h101
define I2C_STOP         &h10e
define I2C_READ         &h12f
define I2C_WRITE        &h119
define I2C_GETACK       &h156
define I2C_SENDACK      &h173
define I2C_SENDNACK     &h17C

'------------------------------------------
' Definitionen der Uebergabe-Variable
'------------------------------------------
define BASIC_IO 	byte[1] 		' Uebergabe mit 1. BASIC-Variablen-Byte ($A1)

define BaseAdr  	byte[2] 		' Basis-Adresse fuer's scannen
define i2c_devices      byte[3] 		' angeschlossene Devices
                             '(Bit X = 1 => Board mit Subardresse X vorhanden)
define i		byte[4] 		' Schleifenvariable
define j		byte[6] 		' fuer diverse Zwecke

define Base8574 	&b01000000      	' Basis-Adresse PCF 8574
define Base1624 	&b10010000      	' Basis-Adresse DS 1624
define Base3115A2       &b11000000              ' Basis-Adresse MPL 3115A2 (Altimeter/Barometer/Temperatur)

