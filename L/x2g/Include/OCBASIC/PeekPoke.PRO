FUNCTION Poke16(w11, w10)  '(adr, data)
         OPEN# FOR WRITE
         CC_FILESTART_lo=lxpokeaddr : CC_FILESTART_hi=lxpokeaddr SHR 8
         PRINT# lxpokedata
         RETURN


FUNCTION Peek16(w11)       '(adr)
         OPEN# FOR READ
         CC_FILESTART_lo=lxpeekaddr : CC_FILESTART_hi=lxpeekaddr SHR 8
         INPUT# lxpeekdata
         RETURN lxpeekdata