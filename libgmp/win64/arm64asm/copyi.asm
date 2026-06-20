; Copyright 2003-2026 Free Software Foundation, Inc.
;
; This file is part of the GNU MP Library.
;
; The GNU MP Library is free software; you can redistribute it and/or modify
; it under the terms of either:
;
;   * the GNU Lesser General Public License as published by the Free
;     Software Foundation; either version 3 of the License, or (at your
;     option) any later version.
;
; or
;
;   * the GNU General Public License as published by the Free Software
;     Foundation; either version 2 of the License, or (at your option) any
;     later version.
;
; or both in parallel, as here.
;
; The GNU MP Library is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
; for more details.
;
; You should have received copies of the GNU General Public License and the
; GNU Lesser General Public License along with the GNU MP Library.  If not,
; see https://www.gnu.org/licenses/.
;
; '.s' GNU AS files converted by Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
; to armasm64 format (much lesser effort than for x86-64 - no ABI conversion
; necessary)
;
; PLEASE DO NOTE that the 'long' type is 32bit on MS Windows for 
; -------------- Aarch64/ARM64, too. But: Because ARM64 has a lot of Xn
;                registers for parameter passing, we always get 'for free' 
;                the zero-extented 64bit Xn-register even if only the 
;                Wn-registers (lower 32bit) is written to.
;

            AREA    |.drectve|, DRECTVE

            EXPORT  __gmpn_copyi

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_copyi
            cmp     x2, #3
            ble     Lbc

            tbz     x0, #3, Lal2
            ldr     x4, [x1],#8
            sub     x2, x2, #1
            str     x4, [x0],#8

Lal2        ldp     x4, x5, [x1],#16
            sub     x2, x2, #6
            tbnz    x2, #63, Lend

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
            HINT    #0x0
            HINT    #0x0
Ltop        ldp     x6,x7, [x1],#32
            stp     x4,x5, [x0],#32
            ldp     x4,x5, [x1,#-16]
            stp     x6,x7, [x0,#-16]
            sub     x2, x2, #4
            tbz     x2, #63, Ltop

Lend        stp     x4,x5, [x0],#16

Lbc         tbz     x2, #1, Ltl1
            ldp     x4,x5, [x1],#16
            stp     x4,x5, [x0],#16
Ltl1        tbz     x2, #0, Ltl2
            ldr     x4, [x1]
            str     x4, [x0]
Ltl2        ret

            END
