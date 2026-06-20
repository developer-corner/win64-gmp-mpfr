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

__gmpn_sec_tabselect PROC
                                          ; #1 = volatile mp_limb_t *, #2 = volatile const mp_limb_t *, #3 = mp_size_t, #4 = mp_size_t, #5 = mp_size_t
         push   rdi                       ; SysV-to-MSVC ABI (save rdi)
         push   rsi                       ; SysV-to-MSVC ABI (save rsi)
                                          ; function parameter #1 in RCX (gcc assumes RDI)
                                          ; function parameter #2 in RDX (gcc assumes RSI)
                                          ; function parameter #3 in R8 (gcc assumes RDX)
                                          ; function parameter #4 in R9 (gcc assumes RCX)
                                          ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov    rdi,rcx                   ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                   ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                    ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                    ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
IF FULL_64BIT                             ;
         mov    r8,qword ptr [rsp+038h]   ; SysV-to-MSVC ABI (parameter #5 from stack to r8) (64bit)
ELSE                                      ;
         mov    r8d,dword ptr [rsp+038h]  ; SysV-to-MSVC ABI (parameter #5 from stack to r8) (32bit)
ENDIF                                     ;
         push   rbx                       ; 
         push   rbp                       ; 
         push   r12                       ; 
         push   r13                       ; 
         push   r14                       ; 
         push   r15                       ; 
         mov    r9,rdx                    ; 
         add    r9,0fffffffffffffffch     ; 
         js     l_0086                    ; 
l_0013:  mov    rbp,rcx                   ; 
         push   rsi                       ; 
         xor    r12d,r12d                 ; 
         xor    r13d,r13d                 ; 
         xor    r14d,r14d                 ; 
         xor    r15d,r15d                 ; 
         mov    rbx,r8                    ; 
         ALIGN  16                        ; 
l_0030:  sub    rbx,01h                   ; 
         sbb    rax,rax                   ; 
         mov    r10,qword ptr [rsi]       ; 
         mov    r11,qword ptr [rsi+08h]   ; 
         and    r10,rax                   ; 
         and    r11,rax                   ; 
         or     r12,r10                   ; 
         or     r13,r11                   ; 
         mov    r10,qword ptr [rsi+010h]  ; 
         mov    r11,qword ptr [rsi+018h]  ; 
         and    r10,rax                   ; 
         and    r11,rax                   ; 
         or     r14,r10                   ; 
         or     r15,r11                   ; 
         lea    rsi,[rsi+rdx*8]           ; 
         add    rbp,0ffffffffffffffffh    ; 
         jne    l_0030                    ; 
         mov    qword ptr [rdi],r12       ; 
         mov    qword ptr [rdi+08h],r13   ; 
         mov    qword ptr [rdi+010h],r14  ; 
         mov    qword ptr [rdi+018h],r15  ; 
         pop    rsi                       ; 
         lea    rsi,[rsi+020h]            ; 
         lea    rdi,[rdi+020h]            ; 
         add    r9,0fffffffffffffffch     ; 
         jns    l_0013                    ; 
         ALIGN  16                        ; 
l_0086:  test   dl,02h                    ; 
         je     l_00D4                    ; 
         mov    rbp,rcx                   ; 
         push   rsi                       ; 
         xor    r12d,r12d                 ; 
         xor    r13d,r13d                 ; 
         mov    rbx,r8                    ; 
         ALIGN  16                        ; 
l_00A0:  sub    rbx,01h                   ; 
         sbb    rax,rax                   ; 
         mov    r10,qword ptr [rsi]       ; 
         mov    r11,qword ptr [rsi+08h]   ; 
         and    r10,rax                   ; 
         and    r11,rax                   ; 
         or     r12,r10                   ; 
         or     r13,r11                   ; 
         lea    rsi,[rsi+rdx*8]           ; 
         add    rbp,0ffffffffffffffffh    ; 
         jne    l_00A0                    ; 
         mov    qword ptr [rdi],r12       ; 
         mov    qword ptr [rdi+08h],r13   ; 
         pop    rsi                       ; 
         lea    rsi,[rsi+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         ALIGN  16                        ; 
l_00D4:  test   dl,01h                    ; 
         je     l_010D                    ; 
         mov    rbp,rcx                   ; 
         xor    r12d,r12d                 ; 
         mov    rbx,r8                    ; 
         ALIGN  16                        ; 
l_00F0:  sub    rbx,01h                   ; 
         sbb    rax,rax                   ; 
         mov    r10,qword ptr [rsi]       ; 
         and    r10,rax                   ; 
         or     r12,r10                   ; 
         lea    rsi,[rsi+rdx*8]           ; 
         add    rbp,0ffffffffffffffffh    ; 
         jne    l_00F0                    ; 
         mov    qword ptr [rdi],r12       ; 
l_010D:  pop    r15                       ; 
         pop    r14                       ; 
         pop    r13                       ; 
         pop    r12                       ; 
         pop    rbp                       ; 
         pop    rbx                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_sec_tabselect ENDP

                    END
