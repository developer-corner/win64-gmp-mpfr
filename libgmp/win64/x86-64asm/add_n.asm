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

__gmpn_add_n PROC

         push   rdi                       ; SysV-to-MSVC ABI (save rdi)
         push   rsi                       ; SysV-to-MSVC ABI (save rsi)
                                          ; function parameter #1 in RCX (gcc assumes RDI)
                                          ; function parameter #2 in RDX (gcc assumes RSI)
                                          ; function parameter #3 in R8 (gcc assumes RDX)
                                          ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                   ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                   ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                    ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                    ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    eax,ecx                   ; 
         shr    rcx,02h                   ; 
         and    eax,03h                   ; 
         jrcxz  l_0037                    ; 
         mov    r8,qword ptr [rsi]        ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         dec    rcx                       ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_0037:  dec    eax                       ; 
         mov    r8,qword ptr [rsi]        ; 
         jne    l_0047                    ; 
         adc    r8,qword ptr [rdx]        ; 
         mov    qword ptr [rdi],r8        ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0047:  dec    eax                       ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         jne    l_0060                    ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0060:  mov    r10,qword ptr [rsi+010h]  ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         setb   al                        ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0080:  adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         adc    r11,qword ptr [rdx+018h]  ; 
         mov    qword ptr [rdi],r8        ; 
         lea    rsi,[rsi+020h]            ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         dec    rcx                       ; 
         mov    qword ptr [rdi+018h],r11  ; 
         lea    rdx,[rdx+020h]            ; 
         mov    r8,qword ptr [rsi]        ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         lea    rdi,[rdi+020h]            ; 
l_00B4:  mov    r10,qword ptr [rsi+010h]  ; 
         mov    r11,qword ptr [rsi+018h]  ; 
         jne    l_0080                    ; 
         lea    rsi,[rsi+020h]            ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         adc    r11,qword ptr [rdx+018h]  ; 
         lea    rdx,[rdx+020h]            ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         mov    qword ptr [rdi+018h],r11  ; 
         lea    rdi,[rdi+020h]            ; 
         inc    eax                       ; 
         dec    eax                       ; 
         jne    l_0037                    ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_add_n ENDP

              ALIGN 16

__gmpn_add_nc PROC

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
         mov    r8,qword ptr [rsp+038h]   ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    eax,ecx                   ; 
         shr    rcx,02h                   ; 
         and    eax,03h                   ; 
         bt     r8,00h                    ; 
         jrcxz  l_0037                    ; 
         mov    r8,qword ptr [rsi]        ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         dec    rcx                       ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ; 
         mov    eax,ecx                   ; 
         shr    rcx,02h                   ; 
         and    eax,03h                   ; 
         jrcxz  l_0037                    ; 
         mov    r8,qword ptr [rsi]        ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         dec    rcx                       ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_0037:  dec    eax                       ; 
         mov    r8,qword ptr [rsi]        ; 
         jne    l_0047                    ; 
         adc    r8,qword ptr [rdx]        ; 
         mov    qword ptr [rdi],r8        ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0047:  dec    eax                       ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         jne    l_0060                    ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0060:  mov    r10,qword ptr [rsi+010h]  ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         setb   al                        ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ;
l_0080:  adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         adc    r11,qword ptr [rdx+018h]  ; 
         mov    qword ptr [rdi],r8        ; 
         lea    rsi,[rsi+020h]            ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         dec    rcx                       ; 
         mov    qword ptr [rdi+018h],r11  ; 
         lea    rdx,[rdx+020h]            ; 
         mov    r8,qword ptr [rsi]        ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         lea    rdi,[rdi+020h]            ; 
l_00B4:  mov    r10,qword ptr [rsi+010h]  ; 
         mov    r11,qword ptr [rsi+018h]  ; 
         jne    l_0080                    ; 
         lea    rsi,[rsi+020h]            ; 
         adc    r8,qword ptr [rdx]        ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         adc    r11,qword ptr [rdx+018h]  ; 
         lea    rdx,[rdx+020h]            ; 
         mov    qword ptr [rdi],r8        ; 
         mov    qword ptr [rdi+08h],r9    ; 
         mov    qword ptr [rdi+010h],r10  ; 
         mov    qword ptr [rdi+018h],r11  ; 
         lea    rdi,[rdi+020h]            ; 
         inc    eax                       ; 
         dec    eax                       ; 
         jne    l_0037                    ; 
         adc    eax,eax                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_add_nc ENDP

             END
