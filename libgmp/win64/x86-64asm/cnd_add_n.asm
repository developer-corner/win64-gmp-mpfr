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

__gmpn_cnd_add_n PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
IF FULL_64BIT                                  ;
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8) (64bit)
ELSE                                           ;
         mov    r8d,dword ptr [rsp+038h]       ; SysV-to-MSVC ABI (parameter #5 from stack to r8) (32bit)
ENDIF                                          ;
         push   rbx                            ; 
         push   rbp                            ; 
         push   r12                            ; 
         push   r13                            ; 
         push   r14                            ; 
         neg    rdi                            ; 
         sbb    rdi,rdi                        ; 
         lea    rcx,[rcx+r8*8]                 ; 
         lea    rdx,[rdx+r8*8]                 ; 
         lea    rsi,[rsi+r8*8]                 ; 
         mov    eax,r8d                        ; 
         neg    r8                             ; 
         and    eax,03h                        ; 
         je     l_00D0                         ; 
         cmp    eax,02h                        ; 
         jb     l_00AD                         ; 
         je     l_0079                         ; 
         mov    r12,qword ptr [rcx+r8*8]       ; 
         mov    r13,qword ptr [rcx+r8*8+08h]   ; 
         mov    r14,qword ptr [rcx+r8*8+010h]  ; 
         and    r12,rdi                        ; 
         mov    r10,qword ptr [rdx+r8*8]       ; 
         and    r13,rdi                        ; 
         mov    rbx,qword ptr [rdx+r8*8+08h]   ; 
         and    r14,rdi                        ; 
         mov    rbp,qword ptr [rdx+r8*8+010h]  ; 
         add    r10,r12                        ; 
         mov    qword ptr [rsi+r8*8],r10       ; 
         adc    rbx,r13                        ; 
         mov    qword ptr [rsi+r8*8+08h],rbx   ; 
         adc    rbp,r14                        ; 
         mov    qword ptr [rsi+r8*8+010h],rbp  ; 
         sbb    eax,eax                        ; 
         add    r8,03h                         ; 
         js     l_00D0                         ; 
         jmp    l_012B                         ; 
         ALIGN  16                             ;
l_0079:  mov    r12,qword ptr [rcx+r8*8]       ; 
         mov    r13,qword ptr [rcx+r8*8+08h]   ; 
         mov    r10,qword ptr [rdx+r8*8]       ; 
         and    r12,rdi                        ; 
         mov    rbx,qword ptr [rdx+r8*8+08h]   ; 
         and    r13,rdi                        ; 
         add    r10,r12                        ; 
         mov    qword ptr [rsi+r8*8],r10       ; 
         adc    rbx,r13                        ; 
         mov    qword ptr [rsi+r8*8+08h],rbx   ; 
         sbb    eax,eax                        ; 
         add    r8,02h                         ; 
         js     l_00D0                         ; 
         jmp    l_012B                         ; 
         ALIGN  16                             ;
l_00AD:  mov    r12,qword ptr [rcx+r8*8]       ; 
         mov    r10,qword ptr [rdx+r8*8]       ; 
         and    r12,rdi                        ; 
         add    r10,r12                        ; 
         mov    qword ptr [rsi+r8*8],r10       ; 
         sbb    eax,eax                        ; 
         add    r8,01h                         ; 
         jns    l_012B                         ; 
         ALIGN  16                             ; 
l_00D0:  mov    r12,qword ptr [rcx+r8*8]       ; 
         mov    r13,qword ptr [rcx+r8*8+08h]   ; 
         mov    r14,qword ptr [rcx+r8*8+010h]  ; 
         mov    r11,qword ptr [rcx+r8*8+018h]  ; 
         and    r12,rdi                        ; 
         mov    r10,qword ptr [rdx+r8*8]       ; 
         and    r13,rdi                        ; 
         mov    rbx,qword ptr [rdx+r8*8+08h]   ; 
         and    r14,rdi                        ; 
         mov    rbp,qword ptr [rdx+r8*8+010h]  ; 
         and    r11,rdi                        ; 
         mov    r9,qword ptr [rdx+r8*8+018h]   ; 
         add    eax,eax                        ; 
         adc    r10,r12                        ; 
         mov    qword ptr [rsi+r8*8],r10       ; 
         adc    rbx,r13                        ; 
         mov    qword ptr [rsi+r8*8+08h],rbx   ; 
         adc    rbp,r14                        ; 
         mov    qword ptr [rsi+r8*8+010h],rbp  ; 
         adc    r9,r11                         ; 
         mov    qword ptr [rsi+r8*8+018h],r9   ; 
         sbb    eax,eax                        ; 
         add    r8,04h                         ; 
         js     l_00D0                         ; 
l_012B:  neg    eax                            ; 
         pop    r14                            ; 
         pop    r13                            ; 
         pop    r12                            ; 
         pop    rbp                            ; 
         pop    rbx                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_cnd_add_n ENDP

                END
