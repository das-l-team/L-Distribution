Congratulations, this installation is almost complete!

This ReadMe file is a Get Started on how to use |_ Distribution.

With next click, the ConTEXT editor and IDE window will open.

===
HINT: Should the ConTEXT window appear somewhat distorted,
      please execute the following steps:

      1. Minimize the ConTEXT window from the taskbar
       - then
      2. Maximize the ConTEXT window from the taskbat.

      This is a cosmetic bug known in the ConTEXT editor.
      It only occurs on some computer graphics cards though.
===

The ConTEXT editor is used as the IDE and makes it very
easy to edit, compile, and upload your programs to the
target system, e.g. your microcontroller board.

Here is a Quick Start Reference:

  All functions can be accessed by selecting one
  of the four keys, shown below.
     _____       _____       _____       _____
    ||F9_||     ||F10||     ||F11||     ||F12||
    ||___||     ||___||     ||___||     ||___||
    |/___\|     |/___\|     |/___\|     |/___\|

 (To make tool tips appear, you can hover the mouse over
  the corresponding head-shaped icon in the menu bar.)

  Depending on file name extension these keys will be
  automatically re-assigned different tasks. That's why
  the tool tips will change depending on the file type
  opened in ConTEXT editor window.

  Here's an example of how this works:
  ====================================

  Let's assume you are going to write an Open-Control/BASIC program.

  First, create a new empty file choosing from "File->Open..." menu.

  Save the empty file under any filename but make sure it has the
  file name extension ".OCB".  This is important because toolchain
  is automatically sslected by the file's name extension.


 Note: While it may appear that the pulldown menu right next to the
       four head-shaped icons can be used to actually select the
       toolchain, this is not the case.

       The pulldown menu only switches syntax highlighting and
       has no effect on the toolchain used.


  Now, let's write your first program!
  ------------------------------------

  'My first program <- This is a comment line, as indicated by the " ' "

   WHILE NOT rxd      '<- Program will run while there is no input detected
                                              'on the serial port connction.
     PRINT "It is so choice!"
     PAUSE 50

   WEND



  After typing in the code above press the F9 key to compile your program:

                COMPILE
                 _____
                ||F9_||
                ||___||
                |/___\|

  Several status messages will now be displayed in the output console.
  If you do not see them, you can toggle the console output window by
  pressing key combination <CTRL>+<SHIFT>+O

  After compiling has finished, just press either the F10 or the F11 key.
  This will transfer the program to the target system.
  
  
You may have to select a COM port first: To do this, open the file L:\x2g\Info.L
Then press one of the function keys F9, F10, F11, F12, according to the number of
the COM port that the target system is connected to (using COM1 through COM4 are
supported at this time). You don't need to select the COM port every time you upload
a program but only when you connect your target system to another COM port.

Now you can start

                   TRANSFER YOUR PROGRAM
                 _____              _____
                ||F10||            ||F11||
                ||___||            ||___||
                |/___\|            |/___\|


  After transfer is complete, a terminal emulator window will automatically
  open. You are now connected to the target system, e.g. your microcontroller
  experimetation board.

  Some microcontrollers let you issue commands to it while they are in hostmode.
  Others start the program you just transferred right away.

  For instance, you may start the program by pressing either the <ENTER> or <SPACE>
  while the microcontroller is in hostmode.

  If everything went right, you should now be able to observe the following lines
  appear inside the terminal window, until you send any key to terminate the program:

It is so choice!
It is so choice!
It is so choice!
It is so choice!
...

  Congratulations! You just wrote, compiled, uploaded, and started, your first
  Open-Control/BASIc program. You see, there is really no rocket-science to it.

  There a 6 programming languages already configured inside this IDE:

Name:                          File type associations:        Platform:
===
Assembly code                             .asm, .a05               6805
BASIC++                                   .bpp, .blib               all
C-Control/BASIC                           .bas                      all
C-Control/C-Cross-Compiler (CCCCC)        .c5                       all
Open-Control/BASIC                        .ocb, .pro, .def          all
Open-Control/BASIC (INLINE assembly code) .iar, .iia   6808, Open-Micro
===



  Did you know?

   - We have included 2 magic files for you!
     The first one is located here:  L:\x2g\Info.L
     The second one is located here:  L:\x2g\Help.L

   - The magic files provide you with information just as you need it
     without distracting you. This way, your workflow won't be stalled
     by having to spend time searching through 3rd-party resources yourself.

  Try it out: Just keep open the magic files in the editor and let
     the magic work!

     We think of this as a rather efficient way to credit the merit of
     the many contributors who have graciously provided all 3rd-party
     components to the community which this freeware distribution builds upon.

     We highly recommend taking a look at the works of the many individual
     contributors, located in the following directory: L:\x2g\3rdparty\

Note: Some of the content is in German and has not yet been translated
      into English.
      However, this just may be your opportunity to pick up those
     long-abandoned German lessons… ;-)

      Thank you for supporting this community-driven project.


  das |_ Team, February 2018
  
 
 Links:
  This project started in July 2014. You can find our original post:
  http://ccintern.dharlos.de/forum/lesen.php?eintrag=16212

 Quotes:
 ”It is so choice” quote by F.B.D.O.
