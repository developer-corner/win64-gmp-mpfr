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

            EXPORT  __gmpn_submul_1

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_submul_1
            mov     x17, #0   
Lent        lsr     x16, x2, #2
            tbz     x2, #0, Lbx0

Lbx1        ldr     x4, [x1], #8
            mul     x8, x4, x3
            umulh   x4, x4, x3
            tbz     x2, #1, Lb01

Lb11        ldp     x5,x6, [x1], #16
            ldp     x12,x13, [x0]
            ldr     x14, [x0,#16]
            mul     x9, x5, x3
            umulh   x5, x5, x3
            mul     x10, x6, x3
            umulh   x6, x6, x3
            subs    x8, x12, x8
            sbcs    x4, x13, x4
            sbcs    x5, x14, x5
            csinc   x6, x6, x6, cs
            subs    x8, x8, x17
            sbcs    x4, x4, x9
            sbcs    x5, x5, x10
            csinc   x17, x6, x6, cs
            stp     x8, x4, [x0], #16
            str     x5, [x0], #8
            cbnz    x16, Ltop
            mov     x0, x17
            ret

            ALIGN   16

Lb01        ldr     x12, [x0]
            subs    x8, x12, x8
            csinc   x4, x4, x4, cs
            subs    x8, x8, x17
            csinc   x17, x4, x4, cs
            str     x8, [x0], #8
            cbnz    x16, Ltop
            mov     x0, x17
            ret

            ALIGN   16

Lbx0        ldp     x4,x5, [x1], #16
            tbz     x2, #1, Ltop+4

Lb10        ldp     x12,x13, [x0]
            mul     x8, x4, x3
            umulh   x4, x4, x3
            mul     x9, x5, x3
            umulh   x5, x5, x3
            subs    x8, x12, x8
            sbcs    x4, x13, x4
            csinc   x5, x5, x5, cs
            subs    x8, x8, x17
            sbcs    x4, x4, x9
            csinc   x17, x5, x5, cs
            stp     x8, x4, [x0], #16
            cbz     x16, Ldone

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
Ltop        ldp     x4,x5, [x1], #16  
            ldp     x6,x7, [x1], #16  
            ldp     x12,x13, [x0]   
            ldp     x14,x15, [x0,#16] 
            mul     x8, x4, x3    
            umulh   x4, x4, x3    
            mul     x9, x5, x3    
            umulh   x5, x5, x3    
            mul     x10, x6, x3   
            umulh   x6, x6, x3    
            mul     x11, x7, x3   
            umulh   x7, x7, x3    
            subs    x8, x12, x8   
            sbcs    x4, x13, x4   
            sbcs    x5, x14, x5   
            sbcs    x6, x15, x6   
            csinc   x7, x7, x7, cs  
            subs    x8, x8, x17   
            sbcs    x4, x4, x9    
            sbcs    x5, x5, x10   
            sbcs    x6, x6, x11   
            csinc   x17, x7, x7, cs 
            stp     x8, x4, [x0], #16
            stp     x5, x6, [x0], #16
            sub     x16, x16, #1
            cbnz    x16, Ltop

Ldone       mov     x0, x17
            ret

            END
