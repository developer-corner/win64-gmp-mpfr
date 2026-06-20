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

__gmpn_div_qr_2n_pi1 PROC

         push    rdi                             ; SysV-to-MSVC ABI (save rdi)
         push    rsi                             ; SysV-to-MSVC ABI (save rsi)
                                                 ; function parameter #1 in RCX (gcc assumes RDI)
                                                 ; function parameter #2 in RDX (gcc assumes RSI)
                                                 ; function parameter #3 in R8 (gcc assumes RDX)
                                                 ; function parameter #4 in R9 (gcc assumes RCX)
                                                 ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                                 ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                                 ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
         mov     rdi,rcx                         ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                         ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                          ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                          ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov     r8,qword ptr [rsp+038h]         ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov     r9,qword ptr [rsp+040h]         ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
                                                 ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
         mov     r10,qword ptr [rsp+048h]        ; 
         mov     r11,rdx                         ; 
         push    r15                             ; 
         push    r14                             ; 
         push    r13                             ; 
         push    r12                             ; 
         push    rbx                             ; 
         mov     r12,qword ptr [r11+rcx*8-010h]  ; 
         mov     rbx,qword ptr [r11+rcx*8-08h]   ; 
         mov     r14,r12                         ; 
         mov     r13,rbx                         ; 
         sub     r14,r9                          ; 
         sbb     r13,r8                          ; 
         cmovae  r12,r14                         ; 
         cmovae  rbx,r13                         ; 
         sbb     rax,rax                         ; 
         inc     rax                             ; 
         push    rax                             ; 
         lea     rcx,[rcx-02h]                   ; 
         mov     r15,r8                          ; 
         neg     r15                             ; 
         jmp     l_00A3                          ; 
         ALIGN   16                              ; 
l_0050:  mov     rax,r10                         ; 
         mul     rbx                             ; 
         mov     r14,r12                         ; 
         add     r14,rax                         ; 
         adc     rdx,rbx                         ; 
         mov     r13,rdx                         ; 
         imul    rdx,r15                         ; 
         mov     rax,r9                          ; 
         lea     rbx,[rdx+r12*1]                 ; 
         mul     r13                             ; 
         mov     r12,qword ptr [r11+rcx*8]       ; 
         sub     r12,r9                          ; 
         sbb     rbx,r8                          ; 
         sub     r12,rax                         ; 
         sbb     rbx,rdx                         ; 
         xor     eax,eax                         ; 
         xor     edx,edx                         ; 
         cmp     rbx,r14                         ; 
         cmovae  rax,r9                          ; 
         cmovae  rdx,r8                          ; 
         adc     r13,00h                         ; 
         ALIGN   16                              ; 
         add     r12,rax                         ; 
         adc     rbx,rdx                         ; 
         cmp     rbx,r8                          ; 
         jae     l_00BB                          ; 
l_009F:  mov     qword ptr [rdi+rcx*8],r13       ; 
l_00A3:  sub     rcx,01h                         ; 
         jae     l_0050                          ; 
         mov     qword ptr [rsi+08h],rbx         ; 
         mov     qword ptr [rsi],r12             ; 
         pop     rax                             ; 
         pop     rbx                             ; 
         pop     r12                             ; 
         pop     r13                             ; 
         pop     r14                             ; 
         pop     r15                             ; 
         pop     rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                     ; 
         ALIGN   16                              ;
l_00BB:  seta    dl                              ; 
         cmp     r12,r9                          ; 
         setae   al                              ; 
         or      al,dl                           ; 
         je      l_009F                          ; 
         inc     r13                             ; 
         sub     r12,r9                          ; 
         sbb     rbx,r8                          ; 
         jmp     l_009F                          ; 

__gmpn_div_qr_2n_pi1 ENDP

                    END
