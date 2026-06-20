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

            EXPORT  __gmpn_bdiv_dbm1c

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_bdiv_dbm1c
            ldr     x5, [x1], #8
            ands    x6, x2, #3
            beq     Lfi0
            cmp     x6, #2
            bcc     Lfi1
            beq     Lfi2

Lfi3        mul     x12, x5, x3
            umulh   x13, x5, x3
            ldr     x5, [x1], #8
            b       Llo3

            ALIGN   16
Lfi0        mul     x10, x5, x3
            umulh   x11, x5, x3
            ldr     x5, [x1], #8
            b       Llo0

            ALIGN   16
Lfi1        subs  x2, x2, #1
            mul     x12, x5, x3
            umulh   x13, x5, x3
            bls     Lwd1
            ldr     x5, [x1], #8
            b       Llo1

            ALIGN   16
Lfi2        mul     x10, x5, x3
            umulh   x11, x5, x3
            ldr     x5, [x1], #8
            b       Llo2

            ALIGN   16
Ltop        ldr     x5, [x1], #8
            subs    x4, x4, x10
            str     x4, [x0], #8
            sbc     x4, x4, x11
Llo1        mul     x10, x5, x3
            umulh   x11, x5, x3
            ldr     x5, [x1], #8
            subs    x4, x4, x12
            str     x4, [x0], #8
            sbc     x4, x4, x13
Llo0        mul     x12, x5, x3
            umulh   x13, x5, x3
            ldr     x5, [x1], #8
            subs    x4, x4, x10
            str     x4, [x0], #8
            sbc     x4, x4, x11
Llo3        mul     x10, x5, x3
            umulh   x11, x5, x3
            ldr     x5, [x1], #8
            subs    x4, x4, x12
            str     x4, [x0], #8
            sbc     x4, x4, x13
Llo2        subs    x2, x2, #4
            mul     x12, x5, x3
            umulh   x13, x5, x3
            bhi     Ltop

Lwd2        subs    x4, x4, x10
            str     x4, [x0], #8
            sbc     x4, x4, x11
Lwd1        subs    x4, x4, x12
            str     x4, [x0]
            sbc     x0, x4, x13
            ret

            END
