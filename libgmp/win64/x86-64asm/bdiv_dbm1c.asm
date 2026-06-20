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

__gmpn_bdiv_dbm1c PROC

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
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    rax,qword ptr [rsi]            ; 
         mov    r9,rdx                         ; 
         mov    r11d,edx                       ; 
         mul    rcx                            ; 
         lea    rsi,[rsi+r9*8]                 ; 
         lea    rdi,[rdi+r9*8]                 ; 
         neg    r9                             ; 
         and    r11d,03h                       ; 
         je     l_0037                         ; 
         lea    r9,[r9+r11*1-04h]              ; 
         cmp    r11d,02h                       ; 
         jb     l_006F                         ; 
         je     l_005C                         ; 
         jmp    l_0049                         ; 
         ALIGN  16                             ; 
l_0030:  mov    rax,qword ptr [rsi+r9*8]       ; 
         mul    rcx                            ; 
l_0037:  sub    r8,rax                         ; 
         mov    qword ptr [rdi+r9*8],r8        ; 
         sbb    r8,rdx                         ; 
         mov    rax,qword ptr [rsi+r9*8+08h]   ; 
         mul    rcx                            ; 
l_0049:  sub    r8,rax                         ; 
         mov    qword ptr [rdi+r9*8+08h],r8    ; 
         sbb    r8,rdx                         ; 
         mov    rax,qword ptr [rsi+r9*8+010h]  ; 
         mul    rcx                            ; 
l_005C:  sub    r8,rax                         ; 
         mov    qword ptr [rdi+r9*8+010h],r8   ; 
         sbb    r8,rdx                         ; 
         mov    rax,qword ptr [rsi+r9*8+018h]  ; 
         mul    rcx                            ; 
l_006F:  sub    r8,rax                         ; 
         mov    qword ptr [rdi+r9*8+018h],r8   ; 
         sbb    r8,rdx                         ; 
         add    r9,04h                         ; 
         jne    l_0030                         ; 
         mov    rax,r8                         ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_bdiv_dbm1c ENDP

                 END
