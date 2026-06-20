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

            EXPORT  __gmpn_hamdist

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__gmpn_hamdist
            movz    x11, #0x1fff
            subs    xzr, x2, x11
            b.hi    L134

LC
            movi    v4.16b, #0x0
            movi    v5.16b, #0x0
            tbz     w2, #0, L30
            sub     x2, x2, #0x1
            ld1     {v0.1d}, [x0], #8
            ld1     {v16.1d}, [x1], #8
            eor     v0.16b, v0.16b, v16.16b
            cnt     v6.16b, v0.16b
            uadalp  v4.8h, v6.16b

L30
            tbz     w2, #1, L4C
            sub     x2, x2, #0x2
            ld1     {v0.2d}, [x0], #16
            ld1     {v16.2d}, [x1], #16
            eor     v0.16b, v0.16b, v16.16b
            cnt     v6.16b, v0.16b
            uadalp  v4.8h, v6.16b

L4C
            tbz     w2, #2, L80
            subs    x2, x2, #0x4
            ld1     {v0.2d-v1.2d}, [x0], #32
            ld1     {v16.2d-v17.2d}, [x1], #32
            b.ls    L100
            ld1     {v2.2d-v3.2d}, [x0], #32
            ld1     {v18.2d-v19.2d}, [x1], #32
            eor     v0.16b, v0.16b, v16.16b
            eor     v1.16b, v1.16b, v17.16b
            sub     x2, x2, #0x4
            cnt     v6.16b, v0.16b
            cnt     v7.16b, v1.16b
            b       LD0

            ALIGN   16
L80
            subs    x2, x2, #0x8
            b.cc    L11C

L88
            ld1     {v2.2d-v3.2d}, [x0], #32
            ld1     {v0.2d-v1.2d}, [x0], #32
            ld1     {v18.2d-v19.2d}, [x1], #32
            ld1     {v16.2d-v17.2d}, [x1], #32
            eor     v2.16b, v2.16b, v18.16b
            eor     v3.16b, v3.16b, v19.16b
            cnt     v6.16b, v2.16b
            cnt     v7.16b, v3.16b
            subs    x2, x2, #0x8
            b.cc    LF8

LB0
            ld1     {v2.2d-v3.2d}, [x0], #32
            ld1     {v18.2d-v19.2d}, [x1], #32
            eor     v0.16b, v0.16b, v16.16b
            eor     v1.16b, v1.16b, v17.16b
            uadalp  v4.8h, v6.16b
            cnt     v6.16b, v0.16b
            uadalp  v5.8h, v7.16b
            cnt     v7.16b, v1.16b

LD0
            ld1     {v0.2d-v1.2d}, [x0], #32
            ld1     {v16.2d-v17.2d}, [x1], #32
            eor     v2.16b, v2.16b, v18.16b
            eor     v3.16b, v3.16b, v19.16b
            subs    x2, x2, #0x8
            uadalp  v4.8h, v6.16b
            cnt     v6.16b, v2.16b
            uadalp  v5.8h, v7.16b
            cnt     v7.16b, v3.16b
            b.cs    LB0

LF8
            uadalp  v4.8h, v6.16b
            uadalp  v5.8h, v7.16b

L100
            eor     v0.16b, v0.16b, v16.16b
            eor     v1.16b, v1.16b, v17.16b
            cnt     v6.16b, v0.16b
            cnt     v7.16b, v1.16b
            uadalp  v4.8h, v6.16b
            uadalp  v5.8h, v7.16b
            add     v4.8h, v4.8h, v5.8h

L11C
            uaddlp  v4.4s, v4.8h
            uaddlp  v4.2d, v4.4s
            umov    x0, v4.d[0]
            umov    x1, v4.d[1]
            add     x0, x0, x1
            ret

            ALIGN   16
L134
            orr     x8, xzr, x30
            orr     x7, xzr, x2
            movz    x4, #0x0
            movz    x9, #0xff80
            movz    x10, #0x1ff0

L148
            add     x5, x0, x9
            add     x6, x1, x9
            movz    x2, #0x1fe8
            movi    v4.16b, #0x0
            movi    v5.16b, #0x0
            bl      L88
            add     x4, x4, x0
            orr     x0, xzr, x5
            orr     x1, xzr, x6
            sub     x7, x7, x10
            subs    xzr, x7, x11
            b.hi    L148
            orr     x2, xzr, x7
            bl      LC
            add     x0, x4, x0
            orr     x30, xzr, x8
            ret

            END
