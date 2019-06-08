
; Macros fuer die neuen Befehle der 6808-CPU

sthx macro value
  db $35
  db value
endm

ldhx_imm macro value
  db $45
  dw value
endm

ldhx_dir macro value
  db $55
  db value
endm

pusha macro
  db $87
endm

pushh macro
  db $8b
endm

pushx macro
  db $89
endm

popa macro
  db $86
endm

poph macro
  db $8a
endm

popx macro
  db $88
endm

clrh macro
  db $8c
endm

aix_imm macro value
  db $af
  db value
endm

cmphx_dir macro value
  db $75
  db value
endm

cmphx_imm macro value
  db $65
  dw value
endm

div macro
  db $52
endm

mov_dir macro from,to
  db $4e,from,to
endm

mov_imm macro value,to
  db $6e,value,to
endm

dbnzx macro label
  db $5b,-*-2+label
endm

dbnza macro label
  db $4b,-*-2+label
endm

dbnz_dir macro adr,label
  db $3b,adr,-*-3+label
endm

cbeqx_imm macro value,label
  db $51,value,-*-3+label
endm

cbeqa_imm macro value,label
  db $41,value,-*-3+label
endm

cbeq_dir macro adr,label
  db $31,adr,-*-3+label
endm

bgt macro label
  db $92,-*-2+label
endm

nsa macro
  db $62
endm

daa macro
  db $72
endm

txs macro
  db $94
endm

tap macro
  db $84
endm

ais_imm macro value
  db $a7,value
endm

fill macro count
  if count=0
    exitm
  endif
  if count&1
    db $ff
  endif
  if count&2
    db $ff,$ff
  endif
  if count&4
    db $ff,$ff,$ff,$ff
  endif
  if count>=8
    db $ff,$ff,$ff,$ff
    db $ff,$ff,$ff,$ff
    fill ((count & %11111000)-8)
  endif
endm
