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

            EXPORT  __gmpn_bdiv_q_1
            EXPORT  __gmpn_pi1_bdiv_q_1
            IMPORT  __gmp_binvert_limb_table

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_bdiv_q_1
            rbit    x6, x3
            clz     x5, x6
            lsr     x3, x3, x5

            adrp    x7, __gmp_binvert_limb_table      ; use imported offset of __gmp_binvert_limb_table
            ubfx    x6, x3, 1, 7
            add     x7, x7, #0x0                      ; multiply x7 by 2 (because binvert_limb_table is an array of 16bit values)
            ldrb    w6, [x7, x6]
            ubfiz   x7, x6, 1, 8
            umull   x6, w6, w6
            msub    x6, x6, x3, x7
            lsl     x7, x6, 1
            mul     x6, x6, x6
            msub    x6, x6, x3, x7
            lsl     x7, x6, 1
            mul     x6, x6, x6
            msub    x4, x6, x3, x7

            b       __gmpn_pi1_bdiv_q_1

            ALIGN   16
__gmpn_pi1_bdiv_q_1
            sub     x2, x2, #1
            subs    x6, x6, x6    
            ldr     x9, [x1],#8
            cbz     x5, Lnorm

Lunorm      lsr     x12, x9, x5
            cbz     x2, Leu1
            sub     x8, xzr, x5

Ltpu        ldr     x9, [x1],#8
            lsl     x7, x9, x8
            orr     x7, x7, x12
            sbcs    x6, x7, x6
            mul     x7, x6, x4
            str     x7, [x0],#8
            lsr     x12, x9, x5
            umulh   x6, x7, x3
            sub     x2, x2, #1
            cbnz    x2, Ltpu

Leu1        sbcs    x6, x12, x6
            mul     x6, x6, x4
            str     x6, [x0]
            ret

            ALIGN   16
Lnorm       mul     x5, x9, x4
            str     x5, [x0],#8
            cbz     x2, Len1

Ltpn        ldr     x9, [x1],#8
            umulh   x5, x5, x3
            sbcs    x5, x9, x5
            mul     x5, x5, x4
            str     x5, [x0],#8
            sub     x2, x2, #1
            cbnz    x2, Ltpn

Len1        ret

            END
