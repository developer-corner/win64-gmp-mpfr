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

            EXPORT  __gmpn_mod_34lsub1

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_mod_34lsub1
            subs    x1, x1, #3
            mov     x8, #0
            blt     Lle2      

            ldp     x2, x3, [x0, #0]
            ldr     x4, [x0, #16]
            add     x0, x0, #24
            subs    x1, x1, #3
            blt     Lsum      
            cmn     x0, #0      

Ltop        ldp     x5, x6, [x0, #0]
            ldr     x7, [x0, #16]
            add     x0, x0, #24
            sub     x1, x1, #3
            adcs    x2, x2, x5
            adcs    x3, x3, x6
            adcs    x4, x4, x7
            tbz     x1, #63, Ltop

            adc     x8, xzr, xzr    

Lsum        cmn     x1, #2
            mov     x5, #0
            blo     lab1
            ldr     x5, [x0], #8
lab1        mov     x6, #0
            bls     lab2
            ldr     x6, [x0], #8
lab2        adds    x2, x2, x5
            adcs    x3, x3, x6
            adcs    x4, x4, xzr
            adc     x8, x8, xzr   

Lsum2       and     x0, x2, #0xffffffffffff
            add     x0, x0, x2, lsr #48
            add     x0, x0, x8
            lsl     x8, x3, #16
            and     x1, x8, #0xffffffffffff
            add     x0, x0, x1
            add     x0, x0, x3, lsr #32
            lsl     x8, x4, #32
            and     x1, x8, #0xffffffffffff
            add     x0, x0, x1
            add     x0, x0, x4, lsr #16
            ret

            ALIGN   16
Lle2        cmn     x1, #1
            bne     L1
            ldp     x2, x3, [x0]
            mov     x4, #0
            b       Lsum2

            ALIGN   16

L1          ldr     x2, [x0]
            and     x0, x2, #0xffffffffffff
            add     x0, x0, x2, lsr #48
            ret

            END
