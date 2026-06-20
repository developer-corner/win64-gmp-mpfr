; Copyright 2026 Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
;
; This file is part of the GNU MP Library (MS Windows port).
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

            AREA   |.drectve|, DRECTVE

            ; please note: Intel bsf/bsr do NOT return the bitsize (here: 64)
            ; if the input was zero, but instead return an undefined value
            ; ARM64 is better here: clz /ctz return the bitsize (here: 64) if the input was zero,
            ; so we can 'live' with the MS Visual C/C++ provided intrinsics instead
            ; this source code is for demonstration / learning purposes only

            EXPORT  __builtin_clzll2
            EXPORT  __builtin_ctzll2

            AREA    |.text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16
__builtin_clzll2
            clz     x0, x0              ; count leading zero bits (it returns already 64 if input was zero)
            ret

            ALIGN   16
__builtin_ctzll2
            rbit    x0, x0               ; trick #17: mirror x0
            clz     x0, x0               ; because of rbit (see above), this is count trailing zeros not leading zeros
            ret

            END
