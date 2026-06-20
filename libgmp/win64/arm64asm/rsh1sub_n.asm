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

            EXPORT  __gmpn_rsh1sub_n

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_rsh1sub_n
            lsr     x6, x3, #2
            tbz     x3, #0, Lbx0

Lbx1        ldr     x5, [x1],#8
            ldr     x9, [x2],#8
            tbnz    x3, #1, Lb11

Lb01        subs    x13, x5, x9
            and     x10, x13, #1
            cbz     x6, L1
            ldp     x4, x5, [x1],#48
            ldp     x8, x9, [x2],#48
            sbcs    x14, x4, x8
            sbcs    x15, x5, x9
            ldp     x4, x5, [x1,#-32]
            ldp     x8, x9, [x2,#-32]
            extr    x17, x14, x13, #1
            sbcs    x12, x4, x8
            sbcs    x13, x5, x9
            str     x17, [x0], #24
            sub     x6, x6, #1
            cbz     x6, Lend
            b       Ltop

            ALIGN   16

L1          cset    x14, cc
            extr    x17, x14, x13, #1
            str     x17, [x0]
            mov     x0, x10
            ret

            ALIGN   16

Lb11        subs    x15, x5, x9
            and     x10, x15, #1
            ldp     x4, x5, [x1],#32
            ldp     x8, x9, [x2],#32
            sbcs    x12, x4, x8
            sbcs    x13, x5, x9
            cbz     x6, L3
            ldp     x4, x5, [x1,#-16]
            ldp     x8, x9, [x2,#-16]
            extr    x17, x12, x15, #1
            sbcs    x14, x4, x8
            sbcs    x15, x5, x9
            str     x17, [x0], #8
            b       Lmid

            ALIGN   16

L3          extr    x17, x12, x15, #1
            str     x17, [x0], #8
            b       L2

            ALIGN   16

Lbx0        tbz     x3, #1, Lb00

Lb10        ldp     x4, x5, [x1],#32
            ldp     x8, x9, [x2],#32
            subs    x12, x4, x8
            sbcs    x13, x5, x9
            and     x10, x12, #1
            cbz     x6, L2
            ldp     x4, x5, [x1,#-16]
            ldp     x8, x9, [x2,#-16]
            sbcs    x14, x4, x8
            sbcs    x15, x5, x9
            b       Lmid

            ALIGN   16

Lb00        ldp     x4, x5, [x1],#48
            ldp     x8, x9, [x2],#48
            subs    x14, x4, x8
            sbcs    x15, x5, x9
            and     x10, x14, #1
            ldp     x4, x5, [x1,#-32]
            ldp     x8, x9, [x2,#-32]
            sbcs    x12, x4, x8
            sbcs    x13, x5, x9
            add     x0, x0, #16
            sub     x6, x6, #1
            cbz     x6, Lend

            ;align  16
Ltop        ldp     x4, x5, [x1,#-16]
            ldp     x8, x9, [x2,#-16]
            extr    x16, x15, x14, #1
            extr    x17, x12, x15, #1
            sbcs    x14, x4, x8
            sbcs    x15, x5, x9
            stp     x16, x17, [x0,#-16]
Lmid        ldp     x4, x5, [x1],#32
            ldp     x8, x9, [x2],#32
            extr    x16, x13, x12, #1
            extr    x17, x14, x13, #1
            sbcs    x12, x4, x8
            sbcs    x13, x5, x9
            stp     x16, x17, [x0],#32
            sub     x6, x6, #1
            cbnz    x6, Ltop

Lend        extr    x16, x15, x14, #1
            extr    x17, x12, x15, #1
            stp     x16, x17, [x0,#-16]
L2          cset    x14, cc
            extr    x16, x13, x12, #1
            extr    x17, x14, x13, #1
            stp     x16, x17, [x0]

Lret        mov     x0, x10
            ret

            END
