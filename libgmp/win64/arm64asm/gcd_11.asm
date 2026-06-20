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

            EXPORT  __gmpn_gcd_11

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_gcd_11
            subs    x3, x0, x1    
            beq     Lend      

            ;ALIGN    16 => bug in armasm64.exe, does NOT pad with NOPs but with zeros instead...
            HINT    #0x0
            HINT    #0x0
Ltop        rbit    x12, x3     
            clz     x12, x12    
            csneg   x3, x3, x3, cs    
            csel    x0, x1, x0, cs    
            lsr     x1, x3, x12   
            subs    x3, x0, x1    
            bne     Ltop      

Lend        ret

            END
