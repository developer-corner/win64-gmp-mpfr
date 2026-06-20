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

__gmpn_sub_err3_n PROC
                                           ; mp_ptr, mp_srcptr, mp_srcptr, mp_ptr, | mp_srcptr, mp_srcptr, mp_srcptr, mp_size_t, mp_limb_t
         push   rdi                        ; SysV-to-MSVC ABI (save rdi)
         push   rsi                        ; SysV-to-MSVC ABI (save rsi)
                                           ; function parameter #1 in RCX (gcc assumes RDI)
                                           ; function parameter #2 in RDX (gcc assumes RSI)
                                           ; function parameter #3 in R8 (gcc assumes RDX)
                                           ; function parameter #4 in R9 (gcc assumes RCX)
                                           ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                           ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                           ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
                                           ; function parameter #8 on stack [RSP+0x50] (gcc assumes [RSP+0x10]
                                           ; function parameter #9 on stack [RSP+0x58] (gcc assumes [RSP+0x18]
         mov    rdi,rcx                    ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                    ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                     ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                     ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]    ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    r9,qword ptr [rsp+040h]    ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
                                           ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
                                           ; SysV-to-MSVC ABI (parameter #8 on stack at 0x50 - now)
                                           ; SysV-to-MSVC ABI (parameter #9 on stack at 0x58 - now)
         mov    rax,qword ptr [rsp+058h]   ; 
IF FULL_64BIT                              ;
         mov    r10,qword ptr [rsp+050h]   ; (parameter #8, 64bit)
ELSE                                       ;
         mov    r10d,dword ptr [rsp+050h]  ; (parameter #8, 32bit)
ENDIF                                      ;
         push   rbx                        ; 
         push   rbp                        ; 
         push   r12                        ; 
         push   r13                        ; 
         push   r14                        ; 
         push   r15                        ; 
         push   rcx                        ; 
         mov    rcx,qword ptr [rsp+080h]   ; parameter #7
         xor    ebp,ebp                    ; 
         xor    r11d,r11d                  ; 
         xor    r12d,r12d                  ; 
         xor    r13d,r13d                  ; 
         xor    r14d,r14d                  ; 
         xor    r15d,r15d                  ; 
         sub    r9,r8                      ; 
         sub    rcx,r8                     ; 
         lea    r8,[r8+r10*8-08h]          ; 
         lea    rdi,[rdi+r10*8]            ; 
         lea    rsi,[rsi+r10*8]            ; 
         lea    rdx,[rdx+r10*8]            ; 
         neg    r10                        ; 
         ALIGN  16                         ; 
l_0050:  shr    rax,1                      ; 
         mov    rax,qword ptr [rsi+r10*8]  ; 
         sbb    rax,qword ptr [rdx+r10*8]  ; 
         mov    qword ptr [rdi+r10*8],rax  ; 
         sbb    rax,rax                    ; 
         mov    rbx,qword ptr [r8]         ; 
         and    rbx,rax                    ; 
         add    rbp,rbx                    ; 
         adc    r11,00h                    ; 
         mov    rbx,qword ptr [r8+r9*1]    ; 
         and    rbx,rax                    ; 
         add    r12,rbx                    ; 
         adc    r13,00h                    ; 
         mov    rbx,qword ptr [r8+rcx*1]   ; 
         and    rbx,rax                    ; 
         add    r14,rbx                    ; 
         adc    r15,00h                    ; 
         lea    r8,[r8-08h]                ; 
         inc    r10                        ; 
         jne    l_0050                     ; 
         and    eax,01h                    ; 
         pop    rcx                        ; 
         mov    qword ptr [rcx],rbp        ; 
         mov    qword ptr [rcx+08h],r11    ; 
         mov    qword ptr [rcx+010h],r12   ; 
         mov    qword ptr [rcx+018h],r13   ; 
         mov    qword ptr [rcx+020h],r14   ; 
         mov    qword ptr [rcx+028h],r15   ; 
         pop    r15                        ; 
         pop    r14                        ; 
         pop    r13                        ; 
         pop    r12                        ; 
         pop    rbp                        ; 
         pop    rbx                        ; 
         pop    rsi                        ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                        ; SysV-to-MSVC ABI (restore rdi)
         ret                               ; 

__gmpn_sub_err3_n ENDP

                 END
