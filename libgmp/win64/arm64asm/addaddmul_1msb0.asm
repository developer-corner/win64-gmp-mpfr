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

            EXPORT  __gmpn_addaddmul_1msb0

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_addaddmul_1msb0
            lsr     x7, x3, #1
            adds    x6, xzr, xzr
            tbz     x3, #0, Ltop

            ldr     x11, [x1], #8   
            ldr     x15, [x2], #8   
            mul     x10, x11, x4    
            umulh   x11, x11, x4    
            mul     x14, x15, x5    
            umulh   x15, x15, x5    
            adds    x10, x10, x14   
            adcs    x6, x11, x15    
            str     x10, [x0], #8   
            cbz     x7, Lend

            ;ALIGN   16 => bug in armasm64, we need to align the code manually
            HINT    #0x0
            HINT    #0x0
            HINT    #0x0
Ltop        ldp     x11, x13, [x1], #16 
            ldp     x15, x17, [x2], #16 
            mul     x10, x11, x4    
            umulh   x11, x11, x4    
            mul     x14, x15, x5    
            umulh   x15, x15, x5    
            adcs    x10, x10, x14   
            adc     x11, x11, x15   
            adds    x10, x10, x6    
            mul     x12, x13, x4    
            umulh   x13, x13, x4    
            mul     x14, x17, x5    
            umulh   x17, x17, x5    
            adcs    x12, x12, x14   
            adc     x6, x13, x17    
            adds    x11, x12, x11   
            stp     x10, x11, [x0], #16 
            sub     x7, x7, #1
            cbnz    x7, Ltop

Lend        adc     x0, x6, xzr
            ret

            END
