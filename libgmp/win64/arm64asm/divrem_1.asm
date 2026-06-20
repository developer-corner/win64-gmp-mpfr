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

            EXPORT  __gmpn_preinv_divrem_1
            EXPORT  __gmpn_divrem_1
            IMPORT  __gmpn_invert_limb

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_preinv_divrem_1
            cbz     x3, Lfz
            stp     x29, x30, [sp, #-80]!
            mov     x29, sp
            stp     x19, x20, [sp, #16]
            stp     x21, x22, [sp, #32]
            stp     x23, x24, [sp, #48]

            sub     x21, x3, #1
            add     x7, x21, x1
            add     x20, x2, x21, lsl #3
            add     x19, x0, x7, lsl #3
            mov     x24, x1
            mov     x22, x4
            mov     x0, x5
            tbnz    x4, #63, Lnentry
            mov     x23, x6
            b       Luentry

            ALIGN   16

__gmpn_divrem_1
            cbz     x3, Lfz
            stp     x29, x30, [sp, #-80]!
            mov     x29, sp
            stp     x19, x20, [sp, #16]
            stp     x21, x22, [sp, #32]
            stp     x23, x24, [sp, #48]

            sub     x21, x3, #1
            add     x7, x21, x1
            add     x20, x2, x21, lsl #3
            add     x19, x0, x7, lsl #3
            mov     x24, x1
            mov     x22, x4
            tbnz    x4, #63, Lnormalised

Lunnorm
            clz     x23, x22
            lsl     x0, x22, x23
            bl      __gmpn_invert_limb
Luentry
            lsl     x22, x22, x23
            ldr     x7, [x20], #-8
            sub     x8, xzr, x23
            lsr     x11, x7, x8   
            lsl     x1, x7, x23
            cbz     x21, Luend

Lutop       ldr     x7, [x20], #-8
            add     x2, x11, #1
            mul     x10, x11, x0
            umulh   x17, x11, x0
            lsr     x9, x7, x8
            orr     x1, x1, x9
            adds    x10, x1, x10
            adc     x2, x2, x17
            msub    x11, x22, x2, x1
            lsl     x1, x7, x23
            cmp     x10, x11
            add     x14, x11, x22
            csel    x11, x14, x11, cc
            sbc     x2, x2, xzr
            cmp     x11, x22
            bcs     Lufx

Luok        str     x2, [x19], #-8
            sub     x21, x21, #1
            cbnz    x21, Lutop

Luend       add     x2, x11, #1
            mul     x10, x11, x0
            umulh   x17, x11, x0
            adds    x10, x1, x10
            adc     x2, x2, x17
            msub    x11, x22, x2, x1
            cmp     x10, x11
            add     x14, x11, x22
            csel    x11, x14, x11, cc
            sbc     x2, x2, xzr
            subs    x14, x11, x22
            adc     x2, x2, xzr
            csel    x11, x14, x11, cs
            str     x2, [x19], #-8

            cbnz    x24, Lftop
            lsr     x0, x11, x23
            ldp     x19, x20, [sp, #16]
            ldp     x21, x22, [sp, #32]
            ldp     x23, x24, [sp, #48]
            ldp     x29, x30, [sp], #80
            ret

            ALIGN   16  

Lufx        add     x2, x2, #1
            sub     x11, x11, x22
            b       Luok

            ALIGN   16

Lnormalised
            mov     x0, x22
            bl      __gmpn_invert_limb

Lnentry
            ldr     x7, [x20], #-8
            subs    x14, x7, x22
            adc     x2, xzr, xzr    
            csel    x11, x14, x7, cs
            b       Lnok

            ALIGN   16

Lntop       ldr     x1, [x20], #-8
            add     x2, x11, #1
            mul     x10, x11, x0
            umulh   x17, x11, x0
            adds    x10, x1, x10
            adc     x2, x2, x17
            msub    x11, x22, x2, x1
            cmp     x10, x11
            add     x14, x11, x22
            csel    x11, x14, x11, cc 
            sbc     x2, x2, xzr
            cmp     x11, x22
            bcs     Lnfx
Lnok        str     x2, [x19], #-8
            sub     x21, x21, #1
            tbz     x21, #63, Lntop

Lnend       cbnz    x24, Lfrac
            mov     x0, x11
            ldp     x19, x20, [sp, #16]
            ldp     x21, x22, [sp, #32]
            ldp     x23, x24, [sp, #48]
            ldp     x29, x30, [sp], #80
            ret

            ALIGN   16

Lnfx        add     x2, x2, #1
            sub     x11, x11, x22
            b       Lnok

            ALIGN   16

Lfrac       mov     x23, #0
Lftop       add     x2, x11, #1
            mul     x10, x11, x0
            umulh   x17, x11, x0
            add     x2, x2, x17
            msub    x11, x22, x2, xzr
            cmp     x10, x11
            add     x14, x11, x22
            csel    x11, x14, x11, cc 
            sbc     x2, x2, xzr
            str     x2, [x19], #-8
            sub     x24, x24, #1
            cbnz    x24, Lftop

            lsr     x0, x11, x23
            ldp     x19, x20, [sp, #16]
            ldp     x21, x22, [sp, #32]
            ldp     x23, x24, [sp, #48]
            ldp     x29, x30, [sp], #80
            ret

            ALIGN   16

Lfz         cbz     x1, Lzend
            
            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
            HINT    #0x0
            HINT    #0x0
Lztop       str     xzr, [x0], #8
            sub     x1, x1, #1
            cbnz    x1, Lztop
Lzend       mov     x0, #0
            ret

            END
