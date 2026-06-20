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

            .CODE

            ALIGN  16

__builtin_clzll PROC                  ; returns 64 if RCX (parameter #1) is zero
                                      
            bsr   rax,rcx             ; search for most significant 1-bit in RCX, stores bit position in RAX (if RCX is zero, then target undefined)
			mov   edx,64              ; see cmovz below
            xor   rax,63              ; recall: RAX ^ 63 = 63 - RAX
            test  rcx,rcx             ; if input is zero, set zero flag
            cmovz eax,edx             ; if input was zero, set EAX to 64, else: leave EAX as it is (bit position of most significant 1-bit)
            ret                       ;

__builtin_clzll ENDP

            ALIGN  16

__builtin_ctzll PROC                  ; returns 64 if RCX (parameter #1) is zero

            bsf   rax,rcx             ; search for least significant 1-bit in RCX, stores bit position in RAX (if RCX is zero, then target undefined)
			mov   edx,64              ; see cmovz below
            test  rcx,rcx             ; if input is zero, set zero flag
            cmovz eax,edx             ; if input was zero, set EAX to 64, else: leave EAX as it is (bit position of least significant 1-bit)
            ret                       ;

__builtin_ctzll ENDP

             END
