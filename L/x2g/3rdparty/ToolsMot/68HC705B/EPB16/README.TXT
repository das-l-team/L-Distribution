The file on this disk called EPB16.EXE (rev C.0) is a utility to help
downloading of S-records from a PC to the HC705B16 installed in the
M68HC705BPGMR during serial programming.

Notes
        1.       That this software is NOT suitable to program HC705B5, or
HC805B6 devices.
        2.      That the timing of the serial communication between the PC
and teh HC705B16 is critical, this timing is affected by some fast 386 PC's
(25Mhz or faster), for this reason a delay loop has been incorporated
and can be activated by teh use of a -2 option e.g :-

                EPB16 -2 [file] <return>

Bugs and limitations
        None Known at this time.
