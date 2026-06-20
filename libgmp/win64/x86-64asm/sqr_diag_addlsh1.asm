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

__gmpn_sqr_diag_addlsh1 PROC

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
         push   rbx                            ; 
         dec    rcx                            ; 
         shl    rcx,1                          ; 
         mov    rax,qword ptr [rdx]            ; 
         lea    rdi,[rdi+rcx*8]                ; 
         lea    rsi,[rsi+rcx*8]                ; 
         lea    r11,[rdx+rcx*4]                ; 
         neg    rcx                            ; 
         mul    rax                            ; 
         mov    qword ptr [rdi+rcx*8],rax      ; 
         xor    ebx,ebx                        ; 
         jmp    l_003F                         ; 
         ALIGN  16                             ; 
l_0030:  add    r8,r10                         ; 
         adc    r9,rax                         ; 
         mov    qword ptr [rdi+rcx*8-08h],r8   ; 
         mov    qword ptr [rdi+rcx*8],r9       ; 
l_003F:  mov    rax,qword ptr [r11+rcx*4+08h]  ; 
         mov    r8,qword ptr [rsi+rcx*8]       ; 
         mov    r9,qword ptr [rsi+rcx*8+08h]   ; 
         adc    r8,r8                          ; 
         adc    r9,r9                          ; 
         lea    r10,[rdx+rbx*1]                ; 
         setb   bl                             ; 
         mul    rax                            ; 
         add    rcx,02h                        ; 
         js     l_0030                         ; 
         add    r8,r10                         ; 
         adc    r9,rax                         ; 
         mov    qword ptr [rdi-08h],r8         ; 
         mov    qword ptr [rdi],r9             ; 
         adc    rdx,rbx                        ; 
         mov    qword ptr [rdi+08h],rdx        ; 
         pop    rbx                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_sqr_diag_addlsh1 ENDP

                       END
