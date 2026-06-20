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

            EXPORT  __gmpn_popcount

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16

__gmpn_popcount
        movz    x11, #0x1fff
        subs    xzr, x1, x11
        b.hi    L_E4

L_C
        movi    v4.16b, #0x0
        movi    v5.16b, #0x0
        tbz     w1, #0, L_28
        sub     x1, x1, #0x1
        ld1     {v0.1d}, [x0], #8
        cnt     v6.16b, v0.16b
        uadalp  v4.8h, v6.16b

L_28
        tbz     w1, #1, L_3C
        sub     x1, x1, #0x2
        ld1     {v0.2d}, [x0], #16
        cnt     v6.16b, v0.16b
        uadalp  v4.8h, v6.16b

L_3C
        tbz     w1, #2, L_60
        subs    x1, x1, #0x4
        ld1     {v0.2d-v1.2d}, [x0], #32
        b.ls    L_B8
        ld1     {v2.2d-v3.2d}, [x0], #32
        sub     x1, x1, #0x4
        cnt     v6.16b, v0.16b
        cnt     v7.16b, v1.16b
        b       L_94

        ALIGN   16

L_60
        subs    x1, x1, #0x8
        b.cc    L_CC

L_68
        ld1     {v2.2d-v3.2d}, [x0], #32
        ld1     {v0.2d-v1.2d}, [x0], #32
        cnt     v6.16b, v2.16b
        cnt     v7.16b, v3.16b
        subs    x1, x1, #0x8
        b.cc    L_B0

        ;ALIGN   16
LTop
        ld1     {v2.2d-v3.2d}, [x0], #32
        uadalp  v4.8h, v6.16b
        cnt     v6.16b, v0.16b
        uadalp  v5.8h, v7.16b
        cnt     v7.16b, v1.16b

L_94
        ld1     {v0.2d-v1.2d}, [x0], #32
        subs    x1, x1, #0x8
        uadalp  v4.8h, v6.16b
        cnt     v6.16b, v2.16b
        uadalp  v5.8h, v7.16b
        cnt     v7.16b, v3.16b
        b.cs    LTop

L_B0
        uadalp  v4.8h, v6.16b
        uadalp  v5.8h, v7.16b

L_B8
        cnt     v6.16b, v0.16b
        cnt     v7.16b, v1.16b
        uadalp  v4.8h, v6.16b
        uadalp  v5.8h, v7.16b
        add     v4.8h, v4.8h, v5.8h

L_CC
        uaddlp  v4.4s, v4.8h
        uaddlp  v4.2d, v4.4s
        umov    x0, v4.d[0]
        umov    x1, v4.d[1]
        add     x0, x0, x1
        ret

        ALIGN   16

L_E4
        orr     x8, xzr, x30
        orr     x7, xzr, x1
        movz    x4, #0x0
        movz    x9, #0xff80
        movz    x10, #0x1ff0

L_F8
        add     x5, x0, x9
        movz    x1, #0x1fe8
        movi    v4.16b, #0x0
        movi    v5.16b, #0x0
        bl      L_68
        add     x4, x4, x0
        orr     x0, xzr, x5
        sub     x7, x7, x10
        subs    xzr, x7, x11
        b.hi    L_F8
        orr     x1, xzr, x7
        bl      L_C
        add     x0, x4, x0
        orr     x30, xzr, x8
        ret

        END
