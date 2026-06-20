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

            EXPORT  __gmpn_gcd_22

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_gcd_22
Ltop        subs    x5, x1, x3    
            cbz     x5, Llowz
            sbcs    x6, x0, x2    

            rbit    x7, x5      

            cneg    x5, x5, cc    
            cinv    x6, x6, cc    
Lbck        csel    x3, x3, x1, cs    
            csel    x2, x2, x0, cs    

            clz     x7, x7    
            sub     x8, xzr, x7   

            lsr     x1, x5, x7    
            lsl     x14, x6, x8   
            lsr     x0, x6, x7    
            orr     x1, x1, x14   

            orr     x11, x0, x2
            cbnz    x11, Ltop

            subs    x4, x1, x3    
            beq     Lend1     

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
            HINT    #0x0
Ltop1       rbit    x12, x4     
            clz     x12, x12    
            csneg   x4, x4, x4, cs    
            csel    x1, x3, x1, cs    
            lsr     x3, x4, x12   
            subs    x4, x1, x3    
            bne     Ltop1

Lend1       mov     x0, x1
            mov     x1, #0
            ret

            ALIGN 16
Llowz
            subs    x5, x0, x2
            beq     Lend
            mov     x6, #0
            rbit    x7, x5      
            cneg    x5, x5, cc    
            b       Lbck      

            ALIGN   16
Lend        mov     x0, x3
            mov     x1, x2
            ret

            END
