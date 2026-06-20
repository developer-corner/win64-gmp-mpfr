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

            EXPORT  __gmpn_lshift

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_lshift
            add     x16, x0, x2, lsl #3
            add     x1, x1, x2, lsl #3
            sub     x8, xzr, x3
            lsr     x17, x2, #2
            tbz     x2, #0, Lbx0

Lbx1        ldr     x4, [x1,#-8]
            tbnz    x2, #1, Lb11

Lb01        lsr     x0, x4, x8
            lsl     x2, x4, x3
            cbnz    x17, Lgt1
            str     x2, [x16,#-8]
            ret

            ALIGN   16

Lgt1        ldp     x4, x5, [x1,#-24]
            sub     x1, x1, #8
            add     x16, x16, #16
            b       Llo2

            ALIGN   16

Lb11        lsr     x0, x4, x8
            lsl     x2, x4, x3
            ldp     x6, x7, [x1,#-24]!
            b       Llo3

            ALIGN   16

Lbx0        ldp     x4, x5, [x1,#-16]
            tbz     x2, #1, Lb00

Lb10        lsr     x0, x5, x8
            lsl     x13, x5, x3
            lsr     x10, x4, x8
            lsl     x2, x4, x3
            cbnz    x17, Lgt2
            orr     x10, x10, x13
            stp     x2, x10, [x16,#-16]
            ret

            ALIGN   16

Lgt2        ldp     x4, x5, [x1,#-32]
            orr     x10, x10, x13
            str     x10, [x16,#-8]
            sub     x1, x1, #16
            add     x16, x16, #8
            b       Llo2

            ALIGN   16

Lb00        lsr     x0, x5, x8
            lsl     x13, x5, x3
            lsr     x10, x4, x8
            lsl     x2, x4, x3
            ldp     x6, x7, [x1,#-32]!
            orr     x10, x10, x13
            str     x10, [x16,#-8]!
            b       Llo0

            ALIGN   16

Ltop        ldp     x4, x5, [x1,#-16]
            orr     x10, x10, x13
            orr     x11, x12, x2
            stp     x10, x11, [x16,#-16]
            lsl     x2, x6, x3

Llo2        lsr     x10, x4, x8
            lsl     x13, x5, x3
            lsr     x12, x5, x8
            ldp     x6, x7, [x1,#-32]!
            orr     x10, x10, x13
            orr     x11, x12, x2
            stp     x10, x11, [x16,#-32]!
            lsl     x2, x4, x3

Llo0        sub     x17, x17, #1

Llo3        lsr     x10, x6, x8
            lsl     x13, x7, x3
            lsr     x12, x7, x8
            cbnz    x17, Ltop

Lend        orr     x10, x10, x13
            orr     x11, x12, x2
            lsl     x2, x6, x3
            stp     x10, x11, [x16,#-16]
            str     x2, [x16,#-24]
            ret

            END