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

__gmpn_div_qr_1n_pi1 PROC

         push    rdi                           ; SysV-to-MSVC ABI (save rdi)
         push    rsi                           ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                               ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
         mov     rdi,rcx                       ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                       ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                        ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                        ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov     r8,qword ptr [rsp+038h]       ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov     r9,qword ptr [rsp+040h]       ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
         dec     rdx                           ; 
         jne     l_0041                        ; 
         lea     r10,[rcx+01h]                 ; 
         mov     rax,rcx                       ; 
         mul     r9                            ; 
         mov     r11,qword ptr [rsi]           ; 
         add     rax,r11                       ; 
         adc     rdx,r10                       ; 
         mov     r10,rdx                       ; 
         imul    rdx,r8                        ; 
         sub     r11,rdx                       ; 
         cmp     rax,r11                       ; 
         lea     rax,[r11+r8*1]                ; 
         cmovae  rax,r11                       ; 
         sbb     r10,00h                       ; 
         cmp     rax,r8                        ; 
         jb      l_003D                        ; 
         sub     rax,r8                        ; 
         add     r10,01h                       ; 
         ALIGN   16                            ;
l_003D:  mov     qword ptr [rdi],r10           ; 
         pop     rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 
         ALIGN   16                            ;
l_0041:  push    r15                           ; 
         push    r14                           ; 
         push    r13                           ; 
         push    r12                           ; 
         push    rbx                           ; 
         push    rbp                           ; 
         mov     rbp,r8                        ; 
         imul    rbp,r9                        ; 
         neg     rbp                           ; 
         mov     rbx,rbp                       ; 
         sub     rbx,r8                        ; 
         push    r8                            ; 
         mov     r8,rdx                        ; 
         mov     rax,r9                        ; 
         mul     rcx                           ; 
         mov     r13,rax                       ; 
         add     rdx,rcx                       ; 
         mov     r10,rdx                       ; 
         mov     rax,rbp                       ; 
         mul     rcx                           ; 
         mov     r11,qword ptr [rsi+r8*8-08h]  ; 
         mov     rcx,qword ptr [rsi+r8*8]      ; 
         mov     qword ptr [rdi+r8*8],r10      ; 
         add     r11,rax                       ; 
         adc     rcx,rdx                       ; 
         sbb     r12,r12                       ; 
         dec     r8                            ; 
         mov     rax,rcx                       ; 
         je      l_00FF                        ; 
         ALIGN   16                            ; 
l_00A0:  mov     r14,r9                        ; 
         mov     r15,r12                       ; 
         and     r14,r12                       ; 
         neg     r15                           ; 
         mul     r9                            ; 
         add     r14,rdx                       ; 
         adc     r15,00h                       ; 
         add     r14,r13                       ; 
         mov     r13,rax                       ; 
         mov     rax,rbp                       ; 
         lea     r10,[rbx+r11*1]               ; 
         adc     r15,00h                       ; 
         mul     rcx                           ; 
         and     r12,rbp                       ; 
         add     r11,r12                       ; 
         cmovae  r10,r11                       ; 
         adc     r14,rcx                       ; 
         mov     r11,qword ptr [rsi+r8*8-08h]  ; 
         adc     qword ptr [rdi+r8*8+08h],r15  ; 
         jb      l_016F                        ; 
l_00E7:  add     r11,rax                       ; 
         mov     rax,r10                       ; 
         adc     rax,rdx                       ; 
         mov     qword ptr [rdi+r8*8],r14      ; 
         sbb     r12,r12                       ; 
         dec     r8                            ; 
         mov     rcx,rax                       ; 
         jne     l_00A0                        ; 
l_00FF:  pop     r8                            ; 
         mov     r14,r12                       ; 
         and     r12,r8                        ; 
         sub     rax,r12                       ; 
         neg     r14                           ; 
         mov     rcx,rax                       ; 
         sub     rax,r8                        ; 
         cmovb   rax,rcx                       ; 
         sbb     r14,0ffffffffffffffffh        ; 
         lea     r10,[rax+01h]                 ; 
         mul     r9                            ; 
         add     rax,r11                       ; 
         adc     rdx,r10                       ; 
         mov     r10,rdx                       ; 
         imul    rdx,r8                        ; 
         sub     r11,rdx                       ; 
         cmp     rax,r11                       ; 
         lea     rax,[r11+r8*1]                ; 
         cmovae  rax,r11                       ; 
         sbb     r10,00h                       ; 
         cmp     rax,r8                        ; 
         jb      l_014D                        ; 
         sub     rax,r8                        ; 
         add     r10,01h                       ; 
l_014D:  add     r13,r10                       ; 
         mov     qword ptr [rdi],r13           ; 
         adc     qword ptr [rdi+08h],r14       ; 
         jae     l_0164                        ; 
l_0159:  add     qword ptr [rdi+010h],01h      ; 
         lea     rdi,[rdi+08h]                 ; 
         jb      l_0159                        ; 
l_0164:  pop     rbp                           ; 
         pop     rbx                           ; 
         pop     r12                           ; 
         pop     r13                           ; 
         pop     r14                           ; 
         pop     r15                           ; 
         pop     rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 
         ALIGN   16                            ;
l_016F:  lea     rcx,[rdi+r8*8+010h]           ; 
l_0174:  add     qword ptr [rcx],01h           ; 
         jae     l_00E7                        ; 
         lea     rcx,[rcx+08h]                 ; 
         jmp     l_0174                        ; 

__gmpn_div_qr_1n_pi1 ENDP

                    END
