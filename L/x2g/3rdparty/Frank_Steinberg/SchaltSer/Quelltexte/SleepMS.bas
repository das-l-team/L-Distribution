Dim Millisek As Integer
Millisek = VAL(Command$)
If Millisek < 1 Then
	Print
	Print "SleepMS      Wartezeit erzeugen     >>fst'08<<"
	Print 
	Print "Syntax:   sleepms [Wartezeit in Millisekunden]
	Print "Beispiel: sleepms 2000       wartet 2 Sekunden
	'Sleep 2000
	End 	 
EndIf
Sleep VAL(Command$)
