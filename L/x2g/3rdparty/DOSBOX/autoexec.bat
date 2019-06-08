@echo off

:: // |_:  ( weird!) "Try mounting non-existent 'A' and 'B' drives seems working on SOME systems but not ALL"


:try_a
rem IF not exists a: goto try_b
rem  mount a: a:\
:try_b
rem  IF not exists b: goto try_c
rem  mount b: b:\

:try_C
 IF not exist c:\ try_d
 mount c: c:\
:try_d
 IF not exist d:\ try_e
 rem mount d: d:\
:try_e
 IF not exist e:\ try_f
 rem mount e: e:\
:try_f
 IF not exist f:\ try_g
 mount f: f:\
:try_g
 IF not exist g:\ try_h
 mount g: g:\
:try_h
 IF not exist h:\ try_i
 mount h: h:\
:try_i
 IF not exist i:\ try_j
 mount i: i:\
:try_j
 IF not exist j:\ try_k
 mount j: j:\
:try_k
 IF not exist k:\ try_l
 mount k: k:\
:try_l
 IF not exist l:\ try_m
 mount l: l:\
:try_m
 IF not exist m:\ try_n
 mount m: m:\
:try_n
 IF not exist n:\ try_o
 mount n: n:\
:try_o
 IF not exist o:\ try_p
 mount o: o:\
:try_p
 IF not exist p:\ try_q
 mount p: p:\
:try_q
 IF not exist q:\ try_r
 mount q: q:\
:try_r
 IF not exist r:\ try_s
 mount r: r:\
:try_s
 IF not exist s:\ try_t
 mount s: s:\
:try_t
 IF not exist t:\ try_u
 mount t: t:\
:try_u
 IF not exist u:\ try_v
 mount u: u:\
:try_v
 IF not exist v:\ goto :try_w
 mount v: v:\
:try_w
 IF not exist w:\ try_x
 mount w: w:\
:try_x
 IF not exist x:\ try_y
 mount x: x:\

:try_y
 IF not exist y:\ try_z
 mount y: y:\


rem contents of Host's computers 'z' will never be mounted since 'z' is DOSBox's Internal Virtual Drive 'z'..?
:try_z
 rem IF not exists z:\ try_end
 rem mount z: z:\
:try_end

@L: > NUL:
@cd L:\x2g > NUL:
cls