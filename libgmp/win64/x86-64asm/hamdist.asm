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

__gmpn_hamdist PROC

         push    rdi                       ; SysV-to-MSVC ABI (save rdi)
         push    rsi                       ; SysV-to-MSVC ABI (save rsi)
                                           ; function parameter #1 in RCX (gcc assumes RDI)
                                           ; function parameter #2 in RDX (gcc assumes RSI)
                                           ; function parameter #3 in R8 (gcc assumes RDX)
         mov     rdi,rcx                   ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                   ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                    ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         push    rbx                       ; 
         push    rbp                       ; 
         mov     r10,qword ptr [rdi]       ; 
         xor     r10,qword ptr [rsi]       ; 
         mov     r8d,edx                   ; 
         and     r8d,03h                   ; 
         xor     ecx,ecx                   ; 
         popcnt  rax,r10                   ; 
         mov     r9,offset Ltab            ; 
         jmp     qword ptr [r9+r8*8]       ; 
         ALIGN   16                        ;
L3:      mov     r10,qword ptr [rdi+08h]   ; 
         mov     r11,qword ptr [rdi+010h]  ; 
         xor     r10,qword ptr [rsi+08h]   ; 
         xor     r11,qword ptr [rsi+010h]  ; 
         xor     ebp,ebp                   ; 
         sub     rdx,04h                   ; 
         jle     Lx3                       ; 
         mov     r8,qword ptr [rdi+018h]   ; 
         mov     r9,qword ptr [rdi+020h]   ; 
         add     rdi,018h                  ; 
         add     rsi,018h                  ; 
         jmp     Le3                       ; 
         ALIGN   16                        ;
L0:      mov     r9,qword ptr [rdi+08h]    ; 
         xor     r9,qword ptr [rsi+08h]    ; 
         mov     r10,qword ptr [rdi+010h]  ; 
         mov     r11,qword ptr [rdi+018h]  ; 
         xor     ebx,ebx                   ; 
         xor     r10,qword ptr [rsi+010h]  ; 
         xor     r11,qword ptr [rsi+018h]  ; 
         add     rdi,020h                  ; 
         add     rsi,020h                  ; 
         sub     rdx,04h                   ; 
         jle     Lx4                       ; 
         ALIGN   16                        ; 
Ltop:                                      ;
Le0:     popcnt  rbp,r9                    ; 
         mov     r8,qword ptr [rdi]        ; 
         mov     r9,qword ptr [rdi+08h]    ; 
         add     rax,rbx                   ; 
Le3:     popcnt  rbx,r10                   ; 
         xor     r8,qword ptr [rsi]        ; 
         xor     r9,qword ptr [rsi+08h]    ; 
         add     rcx,rbp                   ; 
Le2:     popcnt  rbp,r11                   ; 
         mov     r10,qword ptr [rdi+010h]  ; 
         mov     r11,qword ptr [rdi+018h]  ; 
         add     rdi,020h                  ; 
         add     rax,rbx                   ; 
Le1:     popcnt  rbx,r8                    ; 
         xor     r10,qword ptr [rsi+010h]  ; 
         xor     r11,qword ptr [rsi+018h]  ; 
         add     rsi,020h                  ; 
         add     rcx,rbp                   ; 
         sub     rdx,04h                   ; 
         jg      Ltop                      ; 
Lx4:     popcnt  rbp,r9                    ; 
         add     rax,rbx                   ; 
Lx3:     popcnt  rbx,r10                   ; 
         add     rcx,rbp                   ; 
         popcnt  rbp,r11                   ; 
         add     rax,rbx                   ; 
         add     rcx,rbp                   ; 
Lx2:     add     rax,rcx                   ; 
Lx1:     pop     rbp                       ; 
         pop     rbx                       ; 
         pop     rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                               ; 
         ALIGN   16                        ;
L2:      mov     r11,qword ptr [rdi+08h]   ; 
         xor     r11,qword ptr [rsi+08h]   ; 
         sub     rdx,02h                   ; 
         jle     Ln2                       ; 
         mov     r8,qword ptr [rdi+010h]   ; 
         mov     r9,qword ptr [rdi+018h]   ; 
         xor     ebx,ebx                   ; 
         xor     r8,qword ptr [rsi+010h]   ; 
         xor     r9,qword ptr [rsi+018h]   ; 
         add     rdi,010h                  ; 
         add     rsi,010h                  ; 
         jmp     Le2                       ; 
         ALIGN   16                        ;
Ln2:     popcnt  rcx,r11                   ; 
         jmp     Lx2                       ; 
         ALIGN   16                        ;
L1:      dec     rdx                       ; 
         jle     Lx1                       ; 
         mov     r8,qword ptr [rdi+08h]    ; 
         mov     r9,qword ptr [rdi+010h]   ; 
         xor     r8,qword ptr [rsi+08h]    ; 
         xor     r9,qword ptr [rsi+010h]   ; 
         xor     ebp,ebp                   ; 
         mov     r10,qword ptr [rdi+018h]  ; 
         mov     r11,qword ptr [rdi+020h]  ; 
         add     rdi,028h                  ; 
         add     rsi,08h                   ; 
         jmp     Le1                       ; 
                                           ;
         ALIGN   16                        ;
                                           ;
Ltab:	                                     ;
         dq	     offset L0                 ;
	       dq      offset L1                 ;
	       dq      offset L2                 ;
	       dq      offset L3                 ;

__gmpn_hamdist ENDP

              END
