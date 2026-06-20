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

__gmpn_div_qr_2u_pi1 PROC
                                                ; #1 = mp_ptr, #2 = mp_ptr, #3 = mp_srcptr, #4 = mp_size_t, 
                                                ; #5 = mp_limb_t, #6 = mp_limb_t, #7 = int, #8 = mp_limb_t
         push    rdi                            ; SysV-to-MSVC ABI (save rdi)
         push    rsi                            ; SysV-to-MSVC ABI (save rsi)
                                                ; function parameter #1 in RCX (gcc assumes RDI)
                                                ; function parameter #2 in RDX (gcc assumes RSI)
                                                ; function parameter #3 in R8 (gcc assumes RDX)
                                                ; function parameter #4 in R9 (gcc assumes RCX)
                                                ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                                ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                                ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
                                                ; function parameter #8 on stack [RSP+0x50] (gcc assumes [RSP+0x10]
         mov     rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov     r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov     r9,qword ptr [rsp+040h]        ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
                                                ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
                                                ; SysV-to-MSVC ABI (parameter #8 on stack at 0x50 - now)
         mov     r10,qword ptr [rsp+050h]       ; 
         mov     r11,rdx                        ; 
         push    r15                            ; 
         push    r14                            ; 
         push    r13                            ; 
         push    r12                            ; 
         push    rbx                            ; 
         push    rbp                            ; 
         push    rsi                            ; 
         lea     rbp,[rcx-02h]                  ; 
         mov     r15,r8                         ; 
         neg     r15                            ; 
         mov     ecx,dword ptr [rsp+080h]       ; SysV-to-MSVC ABI (parameter #7 on stack at 0x80 - now) -> already OK (32bit)
         xor     ebx,ebx                        ; 
         mov     r12,qword ptr [r11+rbp*8+08h]  ; 
         shld    rbx,r12,cl                     ; 
         mov     rax,r10                        ; 
         mul     rbx                            ; 
         mov     rsi,qword ptr [r11+rbp*8]      ; 
         shld    r12,rsi,cl                     ; 
         mov     r14,r12                        ; 
         add     r14,rax                        ; 
         adc     rdx,rbx                        ; 
         mov     r13,rdx                        ; 
         imul    rdx,r15                        ; 
         mov     rax,r9                         ; 
         lea     rbx,[rdx+r12*1]                ; 
         mul     r13                            ; 
         mov     r12,rsi                        ; 
         shl     r12,cl                         ; 
         sub     r12,r9                         ; 
         sbb     rbx,r8                         ; 
         sub     r12,rax                        ; 
         sbb     rbx,rdx                        ; 
         xor     eax,eax                        ; 
         xor     edx,edx                        ; 
         cmp     rbx,r14                        ; 
         cmovae  rax,r9                         ; 
         cmovae  rdx,r8                         ; 
         adc     r13,00h                        ; 
         nop                                    ;
         add     r12,rax                        ; 
         adc     rbx,rdx                        ; 
         cmp     rbx,r8                         ; 
         jae     l_012C                         ; 
         ALIGN   16                             ;
l_0089:  push    r13                            ; 
         jmp     l_00F3                         ; 
         ALIGN   16                             ; 
l_0090:  mov     rax,r10                        ; 
         mul     rbx                            ; 
         mov     rsi,qword ptr [r11+rbp*8]      ; 
         xor     r13d,r13d                      ; 
         shld    r13,rsi,cl                     ; 
         or      r12,r13                        ; 
         mov     r14,r12                        ; 
         add     r14,rax                        ; 
         adc     rdx,rbx                        ; 
         mov     r13,rdx                        ; 
         imul    rdx,r15                        ; 
         mov     rax,r9                         ; 
         lea     rbx,[rdx+r12*1]                ; 
         mul     r13                            ; 
         mov     r12,rsi                        ; 
         shl     r12,cl                         ; 
         sub     r12,r9                         ; 
         sbb     rbx,r8                         ; 
         sub     r12,rax                        ; 
         sbb     rbx,rdx                        ; 
         xor     eax,eax                        ; 
         xor     edx,edx                        ; 
         cmp     rbx,r14                        ; 
         cmovae  rax,r9                         ; 
         cmovae  rdx,r8                         ; 
         adc     r13,00h                        ; 
         ALIGN   16                             ; 
         add     r12,rax                        ; 
         adc     rbx,rdx                        ; 
         cmp     rbx,r8                         ; 
         jae     l_0114                         ; 
l_00EF:  mov     qword ptr [rdi+rbp*8],r13      ; 
l_00F3:  sub     rbp,01h                        ; 
         jae     l_0090                         ; 
         pop     rax                            ; 
         pop     rsi                            ; 
         shrd    r12,rbx,cl                     ; 
         shr     rbx,cl                         ; 
         mov     qword ptr [rsi+08h],rbx        ; 
         mov     qword ptr [rsi],r12            ; 
         pop     rbp                            ; 
         pop     rbx                            ; 
         pop     r12                            ; 
         pop     r13                            ; 
         pop     r14                            ; 
         pop     r15                            ; 
         pop     rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ;
         ALIGN   16                             ;
l_0114:  seta    dl                             ; 
         cmp     r12,r9                         ; 
         setae   al                             ; 
         or      al,dl                          ; 
         je      l_00EF                         ; 
         inc     r13                            ; 
         sub     r12,r9                         ; 
         sbb     rbx,r8                         ; 
         jmp     l_00EF                         ; 
         ALIGN   16                             ;
l_012C:  seta    dl                             ; 
         cmp     r12,r9                         ; 
         setae   al                             ; 
         or      al,dl                          ; 
         je      l_0089                         ; 
         inc     r13                            ; 
         sub     r12,r9                         ; 
         sbb     rbx,r8                         ; 
         jmp     l_0089                         ; 

__gmpn_div_qr_2u_pi1 ENDP

                    END
