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

            EXPORT  __gmpn_iorn_n

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_iorn_n
            lsr     x17, x3, #2
            tbz     x3, #0, Lbx0

Lbx1        ldr     x7, [x1]
            ldr     x11, [x2]
            orn     x15, x7, x11
            str     x15, [x0],#8
            tbnz    x3, #1, Lb11

Lb01        cbz     x17, Lret
            ldp     x4, x5, [x1,#8]
            ldp     x8, x9, [x2,#8]
            sub     x1, x1, #8
            sub     x2, x2, #8
            b       Lmid

            ALIGN   16

Lb11        ldp     x6, x7, [x1,#8]
            ldp     x10, x11, [x2,#8]
            add     x1, x1, #8
            add     x2, x2, #8
            cbz     x17, Lend
            b       Ltop

            ALIGN   16

Lbx0        tbnz    x3, #1, Lb10

Lb00        ldp     x4, x5, [x1],#-16
            ldp     x8, x9, [x2],#-16
            b       Lmid

            ALIGN   16

Lb10        ldp     x6, x7, [x1]
            ldp     x10, x11, [x2]
            cbz     x17, Lend

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
Ltop        ldp     x4, x5, [x1,#16]
            ldp     x8, x9, [x2,#16]
            orn     x12, x6, x10
            orn     x13, x7, x11
            stp     x12, x13, [x0],#16

Lmid        ldp     x6, x7, [x1,#32]!
            ldp     x10, x11, [x2,#32]!
            orn     x12, x4, x8
            orn     x13, x5, x9
            stp     x12, x13, [x0],#16
            sub     x17, x17, #1
            cbnz    x17, Ltop

Lend        orn     x12, x6, x10
            orn     x13, x7, x11
            stp     x12, x13, [x0]
Lret        ret

            END
