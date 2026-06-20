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

            EXPORT  __gmpn_cnd_sub_n

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_cnd_sub_n
            cmp     x0, #1
            sbc     x0, x0, x0

            cmp     xzr, xzr

            lsr     x17, x4, #2
            tbz     x4, #0, Lbx0

Lbx1        ldr     x13, [x3]
            ldr     x11, [x2]
            bic     x7, x13, x0
            sbcs    x9, x11, x7
            str     x9, [x1]
            tbnz    x4, #1, Lb11

Lb01        cbz     x17, Lrt
            ldp     x12, x13, [x3,#8]
            ldp     x10, x11, [x2,#8]
            sub     x2, x2, #8
            sub     x3, x3, #8
            sub     x1, x1, #24
            b       Lmid

            ALIGN   16
Lb11        ldp     x12, x13, [x3,#8]!
            ldp     x10, x11, [x2,#8]!
            sub     x1, x1, #8
            cbz     x17, Lend
            b       Ltop

            ALIGN   16
Lbx0        ldp     x12, x13, [x3]
            ldp     x10, x11, [x2]
            tbnz    x4, #1, Lb10

Lb00        sub     x2, x2, #16
            sub     x3, x3, #16
            sub     x1, x1, #32
            b       Lmid

            ALIGN   16
Lb10        sub     x1, x1, #16
            cbz     x17, Lend

            ;ALIGN    16 => BUG in armasm64.exe, it DOES NOT pad with HINTs but with zeros, which cause CPU exception, MS folks!!!
            HINT      #0x0
            HINT      #0x0
Ltop        bic     x6, x12, x0
            bic     x7, x13, x0
            ldp     x12, x13, [x3,#16]
            sbcs    x8, x10, x6
            sbcs    x9, x11, x7
            ldp     x10, x11, [x2,#16]
            stp     x8, x9, [x1,#16]
Lmid        bic     x6, x12, x0
            bic     x7, x13, x0
            ldp     x12, x13, [x3,#32]!
            sbcs    x8, x10, x6
            sbcs    x9, x11, x7
            ldp     x10, x11, [x2,#32]!
            stp     x8, x9, [x1,#32]!
            sub     x17, x17, #1
            cbnz    x17, Ltop

Lend        bic     x6, x12, x0
            bic     x7, x13, x0
            sbcs    x8, x10, x6
            sbcs    x9, x11, x7
            stp     x8, x9, [x1,#16]
Lrt         cset    x0, cc
            ret

            END
