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

__gmpn_addlsh2_n PROC

         push   rdi                             ; SysV-to-MSVC ABI (save rdi)
         push   rsi                             ; SysV-to-MSVC ABI (save rsi)
                                                ; function parameter #1 in RCX (gcc assumes RDI)
                                                ; function parameter #2 in RDX (gcc assumes RSI)
                                                ; function parameter #3 in R8 (gcc assumes RDX)
                                                ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                         ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                         ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                          ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                          ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         push   r15                             ; 
         mov    r8,qword ptr [rdx]              ; 
         lea    r12,[r8*4+00h]                  ; 
         shr    r8,03eh                         ; 
         mov    eax,ecx                         ; 
         lea    rdi,[rdi+rcx*8]                 ; 
         lea    rsi,[rsi+rcx*8]                 ; 
         lea    rdx,[rdx+rcx*8]                 ; 
         neg    rcx                             ; 
         and    al,03h                          ; 
         je     l_00BA                          ; 
         cmp    al,02h                          ; 
         jb     l_0079                          ; 
         je     l_0091                          ; 
         mov    r10,qword ptr [rdx+rcx*8+08h]   ; 
         lea    r14,[r8+r10*4]                  ; 
         shr    r10,03eh                        ; 
         mov    r11,qword ptr [rdx+rcx*8+010h]  ; 
         lea    r15,[r10+r11*4]                 ; 
         shr    r11,03eh                        ; 
         add    r12,qword ptr [rsi+rcx*8]       ; 
         adc    r14,qword ptr [rsi+rcx*8+08h]   ; 
         adc    r15,qword ptr [rsi+rcx*8+010h]  ; 
         sbb    eax,eax                         ; 
         mov    qword ptr [rdi+rcx*8],r12       ; 
         mov    qword ptr [rdi+rcx*8+08h],r14   ; 
         mov    qword ptr [rdi+rcx*8+010h],r15  ; 
         add    rcx,03h                         ; 
         js     l_00D0                          ; 
         jmp    l_0133                          ; 
         ALIGN  16                              ;
l_0079:  mov    r11,r8                          ; 
         add    r12,qword ptr [rsi+rcx*8]       ; 
         sbb    eax,eax                         ; 
         mov    qword ptr [rdi+rcx*8],r12       ; 
         add    rcx,01h                         ; 
         js     l_00D0                          ; 
         jmp    l_0133                          ; 
         ALIGN  16                              ;
l_0091:  mov    r11,qword ptr [rdx+rcx*8+08h]   ; 
         lea    r15,[r8+r11*4]                  ; 
         shr    r11,03eh                        ; 
         add    r12,qword ptr [rsi+rcx*8]       ; 
         adc    r15,qword ptr [rsi+rcx*8+08h]   ; 
         sbb    eax,eax                         ; 
         mov    qword ptr [rdi+rcx*8],r12       ; 
         mov    qword ptr [rdi+rcx*8+08h],r15   ; 
         add    rcx,02h                         ; 
         js     l_00D0                          ; 
         jmp    l_0133                          ; 
         ALIGN  16                              ;
l_00BA:  mov    r9,qword ptr [rdx+rcx*8+08h]    ; 
         mov    r10,qword ptr [rdx+rcx*8+010h]  ; 
         jmp    l_00E6                          ; 
         ALIGN  16                              ; 
l_00D0:  mov    r10,qword ptr [rdx+rcx*8+010h]  ; 
         mov    r8,qword ptr [rdx+rcx*8]        ; 
         mov    r9,qword ptr [rdx+rcx*8+08h]    ; 
         lea    r12,[r11+r8*4]                  ; 
         shr    r8,03eh                         ; 
l_00E6:  lea    r13,[r8+r9*4]                   ; 
         shr    r9,03eh                         ; 
         mov    r11,qword ptr [rdx+rcx*8+018h]  ; 
         lea    r14,[r9+r10*4]                  ; 
         shr    r10,03eh                        ; 
         lea    r15,[r10+r11*4]                 ; 
         shr    r11,03eh                        ; 
         add    eax,eax                         ; 
         adc    r12,qword ptr [rsi+rcx*8]       ; 
         adc    r13,qword ptr [rsi+rcx*8+08h]   ; 
         adc    r14,qword ptr [rsi+rcx*8+010h]  ; 
         adc    r15,qword ptr [rsi+rcx*8+018h]  ; 
         mov    qword ptr [rdi+rcx*8],r12       ; 
         mov    qword ptr [rdi+rcx*8+08h],r13   ; 
         mov    qword ptr [rdi+rcx*8+010h],r14  ; 
         sbb    eax,eax                         ; 
         mov    qword ptr [rdi+rcx*8+018h],r15  ; 
         add    rcx,04h                         ; 
         js     l_00D0                          ; 
l_0133:  sub    eax,r11d                        ; 
         neg    eax                             ; 
         pop    r15                             ; 
         pop    r14                             ; 
         pop    r13                             ; 
         pop    r12                             ; 
         pop    rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 

__gmpn_addlsh2_n ENDP

                END
