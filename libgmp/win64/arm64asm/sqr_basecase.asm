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

            EXPORT  __gmpn_sqr_basecase

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_sqr_basecase
            cmp     x2, #3
            bls     Lle3
            ldr     x3, [x1],#8
            sub     x2, x2, #1
            mul     x6, x3, x3
            umulh   x4, x3, x3
            str     x6, [x0],#8
            lsl     x3, x3, 1
            lsl     x2, x2, #3
            lsr     x16, x2, #5
            tbnz    x2, #3, Lmbx1

Lmbx0       adds    x11, x4, xzr    
            tbz     x2, #4, Lmb00

Lmb10       ldp     x4, x5, [x1],#16
            mul     x8, x4, x3
            umulh   x10, x4, x3
            cbz     x16, Lm2e
            ldp     x6, x7, [x1],#16
            mul     x9, x5, x3
            b       LmmidM8             ; originally but unintuitive: Lmmid-8 (-8 on ARM is 'minus two instructions'

            ALIGN   16

Lmbx1       ldr     x7, [x1],#8
            mul     x9, x7, x3
            umulh   x11, x7, x3
            adds    x9, x9, x4
            str     x9, [x0],#8
            tbnz    x2, #4, Lmb10
Lmb00       ldp     x6, x7, [x1],#16
            mul     x8, x6, x3
            umulh   x10, x6, x3
            ldp     x4, x5, [x1],#16
            mul     x9, x7, x3
            adcs    x12, x8, x11
            umulh   x11, x7, x3
            sub     x16, x16, #1
            cbz     x16, Lmend

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
Lmtop       mul     x8, x4, x3
            ldp     x6, x7, [x1],#16
            adcs    x13, x9, x10
            umulh   x10, x4, x3
            mul     x9, x5, x3
            stp     x12, x13, [x0],#16
LmmidM8     adcs    x12, x8, x11
            umulh   x11, x5, x3
Lmmid       mul     x8, x6, x3
            ldp     x4, x5, [x1],#16
            adcs    x13, x9, x10
            umulh   x10, x6, x3
            mul     x9, x7, x3
            stp     x12, x13, [x0],#16
            adcs    x12, x8, x11
            umulh   x11, x7, x3
            sub     x16, x16, #1
            cbnz    x16, Lmtop

Lmend       mul     x8, x4, x3
            adcs    x13, x9, x10
            umulh   x10, x4, x3
            stp     x12, x13, [x0],#16
Lm2e        mul     x9, x5, x3
            adcs    x12, x8, x11
            umulh   x11, x5, x3
            adcs    x13, x9, x10
            stp     x12, x13, [x0],#16
            adc     x11, x11, xzr
            str     x11, [x0],#8

Louter      sub     x2, x2, #8
            sub     x0, x0, x2
            sub     x1, x1, x2
            ldp     x6, x7, [x1,#-16]
            ldr     x3, [x0,#-8]
            and     x8, x7, x6, asr 63
            mul     x9, x7, x7
            adds    x3, x3, x8
            umulh   x4, x7, x7
            adc     x4, x4, xzr
            adds    x3, x3, x9
            str     x3, [x0,#-8]
            adc     x17, x4, xzr
            adds    xzr, x6, x6
            adc     x3, x7, x7
            cmp     x2, #16
            beq     Lcor2
            lsr     x16, x2, #5
            tbz     x2, #3, Lbx0

Lbx1        ldr     x4, [x1],#8
            mul     x8, x4, x3
            umulh   x4, x4, x3
            tbz     x2, #4, Lb01

Lb11        ldp     x5, x6, [x1],#16
            ldp     x12, x13, [x0]
            ldr     x14, [x0,#16]
            mul     x9, x5, x3
            umulh   x5, x5, x3
            mul     x10, x6, x3
            umulh   x6, x6, x3
            adds    x8, x12, x8
            adcs    x4, x13, x4
            adcs    x5, x14, x5
            adc     x6, x6, xzr
            adds    x8, x8, x17
            adcs    x4, x4, x9
            adcs    x5, x5, x10
            adc     x17, x6, xzr
            stp     x8, x4, [x0],#16
            str     x5, [x0],#8
            cbnz    x16, Ltop
            b       Lend

            ALIGN   16

Lb01        ldr     x12, [x0]
            adds    x8, x12, x8
            adc     x4, x4, xzr
            adds    x8, x8, x17
            adc     x17, x4, xzr
            str     x8, [x0],#8
            b       Ltop

            ALIGN   16

Lbx0        ldp     x4, x5, [x1],#16
            tbz     x2, #4, Ltop+4

Lb10        ldp     x12, x13, [x0]
            mul     x8, x4, x3
            umulh   x4, x4, x3
            mul     x9, x5, x3
            umulh   x5, x5, x3
            adds    x8, x12, x8
            adcs    x4, x13, x4
            adc     x5, x5, xzr
            adds    x8, x8, x17
            adcs    x4, x4, x9
            adc     x17, x5, xzr
            stp     x8, x4, [x0],#16

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
            HINT    #0x0
Ltop        ldp     x4, x5, [x1],#16
            ldp     x6, x7, [x1],#16
            ldp     x12, x13, [x0]
            ldp     x14, x15, [x0,#16]
            mul     x8, x4, x3
            umulh   x4, x4, x3
            mul     x9, x5, x3
            umulh   x5, x5, x3
            mul     x10, x6, x3
            umulh   x6, x6, x3
            mul     x11, x7, x3
            umulh   x7, x7, x3
            adds    x8, x12, x8
            adcs    x4, x13, x4
            adcs    x5, x14, x5
            adcs    x6, x15, x6
            adc     x7, x7, xzr
            adds    x8, x8, x17
            adcs    x4, x4, x9
            adcs    x5, x5, x10
            adcs    x6, x6, x11
            adc     x17, x7, xzr
            stp     x8, x4, [x0],#16
            stp     x5, x6, [x0],#16
            sub     x16, x16, #1
            cbnz    x16, Ltop

Lend        str     x17, [x0],#8
            b       Louter

            ALIGN   16

Lcor2       ldp     x10, x11, [x1]
            ldp     x12, x13, [x0]
            mul     x8, x10, x3
            umulh   x4, x10, x3
            mul     x9, x11, x3
            umulh   x5, x11, x3
            adds    x8, x12, x8
            adcs    x4, x13, x4
            adc     x5, x5, xzr
            adds    x8, x8, x17
            adcs    x13, x4, x9
            adc     x12, x5, xzr
            str     x8, [x0]
            and     x8, x10, x7, asr 63
            mul     x9, x10, x10
            adds    x13, x13, x8
            umulh   x4, x10, x10
            adc     x4, x4, xzr
            adds    x13, x13, x9
            adc     x17, x4, xzr
            adds    xzr, x7, x7
            adc     x3, x10, x10
            mul     x8, x11, x3
            umulh   x4, x11, x3
            adds    x8, x12, x8
            adc     x4, x4, xzr
            adds    x8, x8, x17
            adc     x3, x4, xzr
            stp     x13, x8, [x0,#8]
            and     x2, x11, x10, asr 63
            mul     x5, x11, x11
            adds    x3, x3, x2
            umulh   x4, x11, x11
            adc     x4, x4, xzr
            adds    x3, x3, x5
            adc     x4, x4, xzr
            stp     x3, x4, [x0,#24]
            ret

            ALIGN   16

Lle3        ldr     x3, [x1]
            mul     x4, x3, x3  
            umulh   x5, x3, x3  
            cmp     x2, #2
            bhs     L2o3
            stp     x4, x5, [x0]
            ret

            ALIGN   16

L2o3        ldr     x6, [x1,#8]
            mul     x7, x6, x6  
            umulh   x8, x6, x6  
            mul     x9, x3, x6  
            umulh   x10, x3, x6 
            bhi     L3
            adds    x5, x5, x9  
            adcs    x7, x7, x10 
            adc     x8, x8, xzr 
            adds    x5, x5, x9  
            adcs    x7, x7, x10 
            adc     x8, x8, xzr 
            stp     x4, x5, [x0]
            stp     x7, x8, [x0,#16]
            ret

            ALIGN   16

L3          ldr     x11, [x1,#16]
            mul     x12, x11, x11 
            umulh   x13, x11, x11 
            mul     x14, x3, x11  
            umulh   x15, x3, x11  
            mul     x16, x6, x11  
            umulh   x17, x6, x11  
            adds    x5, x5, x9
            adcs    x7, x7, x10
            adcs    x8, x8, x15
            adcs    x12, x12, x17
            adc     x13, x13, xzr
            adds    x5, x5, x9
            adcs    x7, x7, x10
            adcs    x8, x8, x15
            adcs    x12, x12, x17
            adc     x13, x13, xzr
            adds    x7, x7, x14
            adcs    x8, x8, x16
            adcs    x12, x12, xzr
            adc     x13, x13, xzr
            adds    x7, x7, x14
            adcs    x8, x8, x16
            adcs    x12, x12, xzr
            adc     x13, x13, xzr
            stp     x4, x5, [x0]
            stp     x7, x8, [x0,#16]
            stp     x12, x13, [x0,#32]
            ret

            END
