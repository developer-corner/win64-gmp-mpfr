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

__gmpn_nior_n PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rdx]             ; 
         mov    eax,ecx                        ; 
         lea    rdx,[rdx+rcx*8]                ; 
         lea    rsi,[rsi+rcx*8]                ; 
         lea    rdi,[rdi+rcx*8]                ; 
         neg    rcx                            ; 
         and    eax,03h                        ; 
         je     l_0054                         ; 
         cmp    eax,02h                        ; 
         jb     l_0040                         ; 
         je     l_0030                         ; 
         or     r8,qword ptr [rsi+rcx*8]       ; 
         not    r8                             ; 
         mov    qword ptr [rdi+rcx*8],r8       ; 
         dec    rcx                            ; 
         jmp    l_0071                         ; 
         ALIGN  16                             ;
l_0030:  add    rcx,0fffffffffffffffeh         ; 
         jmp    l_0076                         ; 
         ALIGN  16                             ; 
l_0040:  or     r8,qword ptr [rsi+rcx*8]       ; 
         not    r8                             ; 
         mov    qword ptr [rdi+rcx*8],r8       ; 
         inc    rcx                            ; 
         je     l_009B                         ; 
         ALIGN  16                             ;
l_0050:  mov    r8,qword ptr [rdx+rcx*8]       ; 
l_0054:  mov    r9,qword ptr [rdx+rcx*8+08h]   ; 
         or     r8,qword ptr [rsi+rcx*8]       ; 
         not    r8                             ; 
         or     r9,qword ptr [rsi+rcx*8+08h]   ; 
         not    r9                             ; 
         mov    qword ptr [rdi+rcx*8],r8       ; 
         mov    qword ptr [rdi+rcx*8+08h],r9   ; 
l_0071:  mov    r8,qword ptr [rdx+rcx*8+010h]  ; 
l_0076:  mov    r9,qword ptr [rdx+rcx*8+018h]  ; 
         or     r8,qword ptr [rsi+rcx*8+010h]  ; 
         not    r8                             ; 
         or     r9,qword ptr [rsi+rcx*8+018h]  ; 
         not    r9                             ; 
         mov    qword ptr [rdi+rcx*8+010h],r8  ; 
         mov    qword ptr [rdi+rcx*8+018h],r9  ; 
         add    rcx,04h                        ; 
         jae    l_0050                         ; 
l_009B:  pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_nior_n ENDP

             END
