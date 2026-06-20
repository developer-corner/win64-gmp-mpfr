; Copyright 2003-2026 Free Software Foundation, Inc.
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
; The System V AMD64 ABI (gcc) was converted by Ingo A. Kubbilun
; <ingo.kubbilun@gmail.com> at 05/01/2026 to the MS Visual C/C++ 64bit ABI.
; The MS Visual C/C++ 64bit ABI heavily differs from the System V AMD64 ABI.
; (with greetings from good 'old' Germany)...
;
; Some register renamings WOULD HAVE BEEN helped reducing the ABI compatibility
; prologue or epilogue, respectively (TODO - although this is small O(1)
; overhead, i.e. just a small bunch of extra CPU cycles).
;

               .CODE

                ALIGN 16

__gmpn_popcount PROC

         push    rdi                       ; SysV-to-MSVC ABI (save rdi)
         push    rsi                       ; SysV-to-MSVC ABI (save rsi)
                                           ; function parameter #1 in RCX (gcc assumes RDI)
                                           ; function parameter #2 in RDX (gcc assumes RSI)
         mov     rdi,rcx                   ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                   ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     r8d,esi                   ; 
         and     r8d,07h                   ; 
         popcnt  rax,qword ptr [rdi]       ; 
         xor     ecx,ecx                   ; 
         mov     r9,offset Ltab            ; 
         jmp     qword ptr [r9+r8*8]       ;
         ALIGN   16                        ;
L3:      popcnt  r10,qword ptr [rdi+08h]   ; 
         popcnt  r11,qword ptr [rdi+010h]  ; 
         add     rdi,018h                  ; 
         sub     rsi,08h                   ; 
         jg      l_0090                    ; 
         add     rax,r10                   ; 
         add     rax,r11                   ; 
l_0035:  pop     rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                               ; 
         ALIGN  16                         ;  
L1:      sub     rsi,08h                   ; 
         jle     l_0035                    ; 
         popcnt  r8,qword ptr [rdi+08h]    ; 
         popcnt  r9,qword ptr [rdi+010h]   ; 
         add     rdi,08h                   ; 
         jmp     l_00A1                    ; 
         ALIGN  16                         ;  
L7:      popcnt  r10,qword ptr [rdi+08h]   ; 
         popcnt  r11,qword ptr [rdi+010h]  ; 
         add     rdi,0fffffffffffffff8h    ; 
         jmp     l_00B3                    ; 
         ALIGN  16                         ;  
L0:      popcnt  rcx,qword ptr [rdi+08h]   ; 
         popcnt  r10,qword ptr [rdi+010h]  ; 
         popcnt  r11,qword ptr [rdi+018h]  ; 
         jmp     l_00B3                    ; 
         ALIGN  16                         ;  
L4:      popcnt  rcx,qword ptr [rdi+08h]   ; 
         popcnt  r10,qword ptr [rdi+010h]  ; 
         popcnt  r11,qword ptr [rdi+018h]  ; 
         add     rdi,020h                  ; 
         sub     rsi,08h                   ; 
         jle     l_00E1                    ; 
         ALIGN   16                        ;
l_0090:  popcnt  r8,qword ptr [rdi]        ; 
         popcnt  r9,qword ptr [rdi+08h]    ; 
         add     rcx,r10                   ; 
         add     rax,r11                   ; 
l_00A1:  popcnt  r10,qword ptr [rdi+010h]  ; 
         popcnt  r11,qword ptr [rdi+018h]  ; 
         add     rcx,r8                    ; 
         add     rax,r9                    ; 
l_00B3:  popcnt  r8,qword ptr [rdi+020h]   ; 
         popcnt  r9,qword ptr [rdi+028h]   ; 
         add     rcx,r10                   ; 
         add     rax,r11                   ; 
l_00C5:  popcnt  r10,qword ptr [rdi+030h]  ; 
         popcnt  r11,qword ptr [rdi+038h]  ; 
         add     rdi,040h                  ; 
         add     rcx,r8                    ; 
         add     rax,r9                    ; 
         sub     rsi,08h                   ; 
         jg      l_0090                    ; 
l_00E1:  add     rcx,r10                   ; 
         add     rax,r11                   ; 
l_00E7:  add     rax,rcx                   ; 
         pop     rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                               ; 
         ALIGN  16                         ;  
L2:      popcnt  rcx,qword ptr [rdi+08h]   ; 
         sub     rsi,08h                   ; 
         jle     l_00E7                    ; 
         popcnt  r8,qword ptr [rdi+010h]   ; 
         popcnt  r9,qword ptr [rdi+018h]   ; 
         add     rdi,010h                  ; 
         jmp     l_00A1                    ; 
         ALIGN  16                         ;  
L5:      popcnt  r8,qword ptr [rdi+08h]    ; 
         popcnt  r9,qword ptr [rdi+010h]   ; 
         add     rdi,0ffffffffffffffe8h    ; 
         jmp     l_00C5                    ; 
         ALIGN  16                         ;  
L6:      popcnt  rcx,qword ptr [rdi+08h]   ; 
         popcnt  r8,qword ptr [rdi+010h]   ; 
         popcnt  r9,qword ptr [rdi+018h]   ; 
         add     rdi,0fffffffffffffff0h    ; 
         jmp     l_00C5                    ; 
                                           ;
         ALIGN   16                        ;
                                           ;
Ltab:	                                     ;
         dq      offset L0                 ;
         dq      offset L1                 ;
         dq      offset L2                 ;
         dq      offset L3                 ;
         dq      offset L4                 ;
         dq      offset L5                 ;
         dq      offset L6                 ;
         dq      offset L7                 ;

__gmpn_popcount ENDP

               END
