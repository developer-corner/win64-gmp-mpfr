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

            EXPORT  __gmpn_sublsh2_n

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_sublsh2_n
            lsr     x6, x3, #2
            tbz     x3, #0, Lbx0

Lbx1        ldr     x5, [x1]
            tbnz    x3, #1, Lb11

Lb01        ldr     x11, [x2]
            cbz     x6, L1
            ldp     x8, x9, [x2,#8]
            lsl     x13, x11, #2
            subs    x15, x5, x13
            str     x15, [x0],#8
            sub     x1, x1, #24
            sub     x2, x2, #8
            b       Lmid

            ALIGN   16

L1          lsl     x13, x11, #2
            subs    x15, x5, x13
            str     x15, [x0]
            lsr     x0, x11, 62
            cinc    x0, x0, cc
            ret

            ALIGN   16

Lb11        ldr     x9, [x2]
            ldp     x10, x11, [x2,#8]!
            lsl     x13, x9, #2
            subs    x17, x5, x13
            str     x17, [x0],#8
            sub     x1, x1, #8
            cbz     x6, Lend
            b       Ltop

            ALIGN   16

Lbx0        tbnz    x3, #1, Lb10

Lb00        subs    x11, xzr, xzr
            ldp     x8, x9, [x2],#-16
            sub     x1, x1, #32
            b       Lmid

            ALIGN   16

Lb10        subs    x9, xzr, xzr
            ldp     x10, x11, [x2]
            sub     x1, x1, #16
            cbz     x6, Lend

            ;align  16
Ltop        ldp     x4, x5, [x1,#16]
            extr    x12, x10, x9, #62
            ldp     x8, x9, [x2,#16]
            extr    x13, x11, x10, #62
            sbcs    x14, x4, x12
            sbcs    x15, x5, x13
            stp     x14, x15, [x0],#16
Lmid        ldp     x4, x5, [x1,#32]!
            extr    x12, x8, x11, #62
            ldp     x10, x11, [x2,#32]!
            extr    x13, x9, x8, #62
            sbcs    x16, x4, x12
            sbcs    x17, x5, x13
            stp     x16, x17, [x0],#16
            sub     x6, x6, #1
            cbnz    x6, Ltop

Lend        ldp     x4, x5, [x1,#16]
            extr    x12, x10, x9, #62
            extr    x13, x11, x10, #62
            sbcs    x14, x4, x12
            sbcs    x15, x5, x13
            stp     x14, x15, [x0]
            lsr     x0, x11, 62
            cinc    x0, x0, cc
            ret

            END

