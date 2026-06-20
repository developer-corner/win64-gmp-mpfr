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

            EXPORT  __gmpn_sqr_diag_addlsh1

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_sqr_diag_addlsh1
            ldr     x15, [x2],#8
            lsr     x14, x3, #1
            tbz     x3, #0, Lbx0

Lbx1        adds    x7, xzr, xzr
            mul     x12, x15, x15
            ldr     x16, [x2],#8
            ldp     x4, x5, [x1],#16
            umulh   x11, x15, x15
            b       Lmid

            ALIGN   16

Lbx0        adds    x5, xzr, xzr
            mul     x12, x15, x15
            ldr     x17, [x2],#16
            ldp     x6, x7, [x1],#32
            umulh   x11, x15, x15
            sub     x14, x14, #1
            cbz     x14, Lend

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
Ltop        extr    x9, x6, x5, #63
            mul     x10, x17, x17
            ldr     x16, [x2,#-8]
            adcs    x13, x9, x11
            ldp     x4, x5, [x1,#-16]
            umulh   x11, x17, x17
            extr    x8, x7, x6, #63
            stp     x12, x13, [x0],#16
            adcs    x12, x8, x10
Lmid        extr    x9, x4, x7, #63
            mul     x10, x16, x16
            ldr     x17, [x2],#16
            adcs    x13, x9, x11
            ldp     x6, x7, [x1],#32
            umulh   x11, x16, x16
            extr    x8, x5, x4, #63
            stp     x12, x13, [x0],#16
            adcs    x12, x8, x10
            sub     x14, x14, #1
            cbnz    x14, Ltop

Lend        extr    x9, x6, x5, #63
            mul     x10, x17, x17
            adcs    x13, x9, x11
            umulh   x11, x17, x17
            extr    x8, x7, x6, #63
            stp     x12, x13, [x0]
            adcs    x12, x8, x10
            extr    x9, xzr, x7, #63
            adcs    x13, x9, x11
            stp     x12, x13, [x0,#16]

            ret

            END
