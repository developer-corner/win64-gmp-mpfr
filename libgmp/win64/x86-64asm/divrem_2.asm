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

                EXTERN  __gmpn_invert_limb_sysv_abi : PROC

                ALIGN 16

__gmpn_divrem_2 PROC

         push    rdi                         ; SysV-to-MSVC ABI (save rdi)
         push    rsi                         ; SysV-to-MSVC ABI (save rsi)
                                             ; function parameter #1 in RCX (gcc assumes RDI)
                                             ; function parameter #2 in RDX (gcc assumes RSI)
                                             ; function parameter #3 in R8 (gcc assumes RDX)
                                             ; function parameter #4 in R9 (gcc assumes RCX)
                                             ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov     rdi,rcx                     ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                     ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                      ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                      ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov     r8,qword ptr [rsp+038h]     ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         push    r15                         ; 
         push    r14                         ; 
         push    r13                         ; 
         push    r12                         ; 
         lea     r12,[rdx+rcx*8-018h]        ; 
         mov     r13,rsi                     ; 
         push    rbp                         ; 
         mov     rbp,rdi                     ; 
         push    rbx                         ; 
         mov     r11,qword ptr [r8+08h]      ; 
         mov     rbx,qword ptr [r12+010h]    ; 
         mov     r8,qword ptr [r8]           ; 
         mov     r10,qword ptr [r12+08h]     ; 
         xor     r15d,r15d                   ; 
         cmp     r11,rbx                     ; 
         ja      l_0044                      ; 
         setb    dl                          ; 
         cmp     r8,r10                      ; 
         setbe   al                          ; 
         or      dl,al                       ; 
         je      l_0044                      ; 
         inc     r15d                        ; 
         sub     r10,r8                      ; 
         sbb     rbx,r11                     ; 
l_0044:  lea     r14,[rcx+r13*1-03h]         ; 
         test    r14,r14                     ; 
         js      l_0108                      ; 
         push    r8                          ; 
         push    r10                         ; 
         push    r11                         ; 
         mov     rdi,r11                     ; 
         call    __gmpn_invert_limb_sysv_abi ; SPECIAL: call SysV ABI version of this function here!!!
         pop     r11                         ; 
         pop     r10                         ; 
         pop     r8                          ; 
         mov     rdx,r11                     ; 
         mov     rdi,rax                     ; 
         imul    rdx,rax                     ; 
         mov     r9,rdx                      ; 
         mul     r8                          ; 
         xor     ecx,ecx                     ; 
         add     r9,r8                       ; 
         adc     rcx,0ffffffffffffffffh      ; 
         add     r9,rdx                      ; 
         adc     rcx,00h                     ; 
         js      l_0094                      ; 
l_0088:  dec     rdi                         ; 
         sub     r9,r11                      ; 
         sbb     rcx,00h                     ; 
         jns     l_0088                      ; 
l_0094:  lea     rbp,[rbp+r14*8+00h]         ; 
         mov     rsi,r11                     ; 
         neg     rsi                         ; 
         ALIGN   16                          ; 
l_00A0:  mov     rax,rdi                     ; 
         mul     rbx                         ; 
         mov     rcx,r10                     ; 
         add     rcx,rax                     ; 
         adc     rdx,rbx                     ; 
         mov     r9,rdx                      ; 
         imul    rdx,rsi                     ; 
         mov     rax,r8                      ; 
         lea     rbx,[rdx+r10*1]             ; 
         xor     r10d,r10d                   ; 
         mul     r9                          ; 
         cmp     r13,r14                     ; 
         jg      l_00D0                      ; 
         mov     r10,qword ptr [r12]         ; 
         sub     r12,08h                     ;
         ALIGN   16                          ;
l_00D0:  sub     r10,r8                      ; 
         sbb     rbx,r11                     ; 
         sub     r10,rax                     ; 
         sbb     rbx,rdx                     ; 
         xor     eax,eax                     ; 
         xor     edx,edx                     ; 
         cmp     rbx,rcx                     ; 
         cmovae  rax,r8                      ; 
         cmovae  rdx,r11                     ; 
         adc     r9,00h                      ; 
         ALIGN   16                          ; 
         add     r10,rax                     ; 
         adc     rbx,rdx                     ; 
         cmp     rbx,r11                     ; 
         jae     l_0120                      ; 
l_00FB:  mov     qword ptr [rbp],r9          ; 
         sub     rbp,08h                     ; 
         dec     r14                         ; 
         jns     l_00A0                      ; 
l_0108:  mov     qword ptr [r12+08h],r10     ; 
         mov     qword ptr [r12+010h],rbx    ; 
         pop     rbx                         ; 
         pop     rbp                         ; 
         pop     r12                         ; 
         pop     r13                         ; 
         pop     r14                         ; 
         mov     rax,r15                     ; 
         pop     r15                         ; 
         pop     rsi                         ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                         ; SysV-to-MSVC ABI (restore rdi)
         ret                                 ; 
         ALIGN   16                          ;
l_0120:  seta    dl                          ; 
         cmp     r10,r8                      ; 
         setae   al                          ; 
         or      al,dl                       ; 
         je      l_00FB                      ; 
         inc     r9                          ; 
         sub     r10,r8                      ; 
         sbb     rbx,r11                     ; 
         jmp     l_00FB                      ; 

__gmpn_divrem_2 ENDP

               END
