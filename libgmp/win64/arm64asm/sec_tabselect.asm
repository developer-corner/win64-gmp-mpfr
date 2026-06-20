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

            EXPORT  __gmpn_sec_tabselect

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_sec_tabselect
  
        dup     v7.2d, x4
        movz    x10, #0x1
        dup     v6.2d, x10
        subs    x6, x2, #0x4
        b.mi    L_60

L_14

        orr     x5, xzr, x3
        orr     x12, xzr, x1
        movi    v5.16b, #0x0
        movi    v2.16b, #0x0
        movi    v3.16b, #0x0

        hint    #0x0          ; ALIGN 16
        hint    #0x0

L_30

        cmeq    v4.2d, v5.2d, v7.2d
        ld1     {v0.2d-v1.2d}, [x1]
        add     v5.2d, v5.2d, v6.2d
        bit     v2.16b, v0.16b, v4.16b
        bit     v3.16b, v1.16b, v4.16b
        add     x1, x1, x2, lsl #3
        sub     x5, x5, #0x1
        cbnz    x5, L_30
        st1     {v2.2d-v3.2d}, [x0], #32
        add     x1, x12, #0x20
        subs    x6, x6, #0x4
        b.pl    L_14

L_60

        tbz     w2, #1, L_A4
        orr     x5, xzr, x3
        orr     x12, xzr, x1
        movi    v5.16b, #0x0
        movi    v2.16b, #0x0

        hint    #0x0      ; ALIGN 16
        hint    #0x0
        hint    #0x0

L_80

        cmeq    v4.2d, v5.2d, v7.2d
        ld1     {v0.2d}, [x1]
        add     v5.2d, v5.2d, v6.2d
        bit     v2.16b, v0.16b, v4.16b
        add     x1, x1, x2, lsl #3
        sub     x5, x5, #0x1
        cbnz    x5, L_80
        st1     {v2.2d}, [x0], #16
        add     x1, x12, #0x10

L_A4

        tbz     w2, #0, L_E4
        orr     x5, xzr, x3
        orr     x12, xzr, x1
        movi    v5.16b, #0x0
        movi    v2.16b, #0x0
        hint    #0x0      ; ALIGN 16
        hint    #0x0

L_C0

        cmeq    v4.2d, v5.2d, v7.2d
        ld1     {v0.1d}, [x1]
        add     v5.2d, v5.2d, v6.2d
        bit     v2.8b, v0.8b, v4.8b
        add     x1, x1, x2, lsl #3
        sub     x5, x5, #0x1
        cbnz    x5, L_C0
        st1     {v2.1d}, [x0], #8
        add     x1, x12, #0x8

L_E4

        ret

        END
