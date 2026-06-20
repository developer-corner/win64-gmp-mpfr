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

            EXPORT  __gmpn_mul_1c
            EXPORT  __gmpn_mul_1

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_mul_1c
            adds    xzr, xzr, xzr   
            b       Lcom

            ALIGN   16
__gmpn_mul_1
            adds    x4, xzr, xzr    
Lcom        lsr     x17, x2, #2
            tbnz    x2, #0, Lbx1

Lbx0        mov     x11, x4
            tbz     x2, #1, Lb00

Lb10        ldp     x4, x5, [x1]
            mul     x8, x4, x3
            umulh   x10, x4, x3
            cbz     x17, L2
            ldp     x6, x7, [x1,#16]!
            mul     x9, x5, x3
            b       Lmid_M8       ; was "Lmid-8" but is a little misleading in terms of documentation
                                  ; "-8" means two ARMv8 instructions earlier...

            ALIGN   16
L2          mul     x9, x5, x3
            b       L2e

Lbx1        ldr     x7, [x1],#8
            mul     x9, x7, x3
            umulh   x11, x7, x3
            adds    x9, x9, x4
            str     x9, [x0],#8
            tbnz    x2, #1, Lb10

Lb01        cbz     x17, L1

Lb00        ldp     x6, x7, [x1]
            mul     x8, x6, x3
            umulh   x10, x6, x3
            ldp     x4, x5, [x1,#16]
            mul     x9, x7, x3
            adcs    x12, x8, x11
            umulh   x11, x7, x3
            add     x0, x0, #16
            sub     x17, x17, #1
            cbz     x17, Lend

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
Ltop        mul     x8, x4, x3
            ldp     x6, x7, [x1,#32]!
            adcs    x13, x9, x10
            umulh   x10, x4, x3
            mul     x9, x5, x3
            stp     x12, x13, [x0,#-16]
Lmid_M8     adcs    x12, x8, x11
            umulh   x11, x5, x3
Lmid        mul     x8, x6, x3
            ldp     x4, x5, [x1,#16]
            adcs    x13, x9, x10
            umulh   x10, x6, x3
            mul     x9, x7, x3
            stp     x12, x13, [x0],#32
            adcs    x12, x8, x11
            umulh   x11, x7, x3
            sub     x17, x17, #1
            cbnz    x17, Ltop

Lend        mul     x8, x4, x3
            adcs    x13, x9, x10
            umulh   x10, x4, x3
            mul     x9, x5, x3
            stp     x12, x13, [x0,#-16]
L2e         adcs    x12, x8, x11
            umulh   x11, x5, x3
            adcs    x13, x9, x10
            stp     x12, x13, [x0]
L1          adc     x0, x11, xzr
            ret

            END
