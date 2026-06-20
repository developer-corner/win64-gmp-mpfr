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

__gmpn_add_err2_n PROC
                                               ; #1 = mp_ptr rp, #2 = mp_srcptr up, #3 = mp_srcptr vp, #4 = mp_ptr ep, #5 = mp_srcptr yp1, #6 = mp_srcptr yp2, #7 = mp_size_t n, #8 = mp_limb_t cy
         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                               ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                               ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
                                               ; function parameter #8 on stack [RSP+0x50] (gcc assumes [RSP+0x10]
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    r9,qword ptr [rsp+040h]        ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
                                               ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
                                               ; SysV-to-MSVC ABI (parameter #8 on stack at 0x50 - now)
         mov    rax,qword ptr [rsp+050h]       ; 
IF FULL_64BIT                                  ;
         mov    r10,qword ptr [rsp+048h]       ;
ELSE                                           ;
         mov    r10d,dword ptr [rsp+048h]      ; do NOT use r10 here because of possible 'stack polution'
ENDIF                                          ;
         push   rbx                            ; 
         push   rbp                            ; 
         push   r12                            ; 
         push   r13                            ; 
         push   r14                            ; 
         xor    ebp,ebp                        ; 
         xor    r11d,r11d                      ; 
         xor    r12d,r12d                      ; 
         xor    r13d,r13d                      ; 
         sub    r9,r8                          ; 
         lea    rdi,[rdi+r10*8]                ; 
         lea    rsi,[rsi+r10*8]                ; 
         lea    rdx,[rdx+r10*8]                ; 
         test   r10,01h                        ; 
         jne    l_0040                         ; 
         lea    r8,[r8+r10*8-08h]              ; 
         neg    r10                            ; 
         jmp    l_0070                         ; 
         ALIGN  16                             ; 
l_0040:  lea    r8,[r8+r10*8-010h]             ; 
         neg    r10                            ; 
         shr    rax,1                          ; 
         mov    rbx,qword ptr [rsi+r10*8]      ; 
         adc    rbx,qword ptr [rdx+r10*8]      ; 
         cmovb  rbp,qword ptr [r8+08h]         ; 
         cmovb  r12,qword ptr [r8+r9*1+08h]    ; 
         mov    qword ptr [rdi+r10*8],rbx      ; 
         sbb    rax,rax                        ; 
         inc    r10                            ; 
         je     l_00D3                         ; 
         ALIGN  16                             ; 
l_0070:  mov    rbx,qword ptr [rsi+r10*8]      ; 
         shr    rax,1                          ; 
         adc    rbx,qword ptr [rdx+r10*8]      ; 
         mov    qword ptr [rdi+r10*8],rbx      ; 
         sbb    r14,r14                        ; 
         mov    rbx,qword ptr [rsi+r10*8+08h]  ; 
         adc    rbx,qword ptr [rdx+r10*8+08h]  ; 
         mov    qword ptr [rdi+r10*8+08h],rbx  ; 
         sbb    rax,rax                        ; 
         mov    rbx,qword ptr [r8]             ; 
         and    rbx,r14                        ; 
         add    rbp,rbx                        ; 
         adc    r11,00h                        ; 
         and    r14,qword ptr [r8+r9*1]        ; 
         add    r12,r14                        ; 
         adc    r13,00h                        ; 
         mov    rbx,qword ptr [r8-08h]         ; 
         and    rbx,rax                        ; 
         add    rbp,rbx                        ; 
         adc    r11,00h                        ; 
         mov    rbx,qword ptr [r8+r9*1-08h]    ; 
         and    rbx,rax                        ; 
         add    r12,rbx                        ; 
         adc    r13,00h                        ; 
         add    r10,02h                        ; 
         lea    r8,[r8-010h]                   ; 
         jne    l_0070                         ; 
l_00D3:  mov    qword ptr [rcx],rbp            ; 
         mov    qword ptr [rcx+08h],r11        ; 
         mov    qword ptr [rcx+010h],r12       ; 
         mov    qword ptr [rcx+018h],r13       ; 
         and    eax,01h                        ; 
         pop    r14                            ; 
         pop    r13                            ; 
         pop    r12                            ; 
         pop    rbp                            ; 
         pop    rbx                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_add_err2_n ENDP

                 END
