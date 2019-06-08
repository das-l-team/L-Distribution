
 *** Hints for installation on Windows 10 (and better) operating
     systems. How To Choose The Right 'One' Drive ***
     and recommended installation path.

=================================
...OR just click the Next Button.
=================================




During extensive testing under different Windows versions some
issues have been identified:

- when running Windows 10

    When choosing the cloud-transparent 'OneDrive',
    results may vary. Specifically, our script-based
    toolchain will likely cease to function in some
    cases. This is due to slowing or failing file-time
    updates which the |_ Distribution depends upon for
    tool sequencing and dynamic editor tabs.
    Note: We observed this testing on a pre-release
    (build 9926) Windows 10 OneDrive implementation.
   
Update:  (Following Microsoft on Cebit 2015)

    Further tests conducted under subsequent
    Windows 10 builds (10049, 10061, 10166) no longer
    exhibit the aforementioned failure in file-time updates.
    Hence, the |_ Distribution may be successfully utilized
    when installed in Windows 10 OneDrive Folder as well.


- when running Vista, W7, W8, W10:

    Windows Access Control List (ACL) settings must
    allow Read, Write, Delete, Execute in any folder
    descendent of the selected installation directory.

    Currently this installation script does not adjust
    ACL settings automatically. As a remedy you may
    avoid installing into directories "C:\programs\"
    and "C:\programs (x86)\", respectively.

- when installing on existing drive "L:":

    Not problematic if there is an existing drive "L:\"
    on your system. The shortcoming however is that on
    existing drive L: you may not select a different
    installation path other than "L:\x2g\" for the
    system to work.

Hint:  Please make the installation path read "L:\x2g\"