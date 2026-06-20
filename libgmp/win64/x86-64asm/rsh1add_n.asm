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

__gmpn_rsh1add_n PROC

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
         push   rbx                       ; 
         xor    eax,eax                   ; 
         mov    rbx,qword ptr [rsi]       ; 
         add    rbx,qword ptr [rdx]       ; 
         rcr    rbx,1                     ; 
         adc    eax,eax                   ; 
         mov    r11d,ecx                  ; 
         and    r11d,03h                  ; 
         cmp    r11d,01h                  ; 
         je     l_00D1                    ; 
         cmp    r11d,02h                  ; 
         jne    l_0058                    ; 
         add    rbx,rbx                   ; 
         mov    r10,qword ptr [rsi+08h]   ; 
         adc    r10,qword ptr [rdx+08h]   ; 
         lea    rsi,[rsi+08h]             ; 
         lea    rdx,[rdx+08h]             ; 
         lea    rdi,[rdi+08h]             ; 
         rcr    r10,1                     ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-08h],rbx   ; 
         jmp    l_00CE                    ; 
         ALIGN  16                        ;
l_0058:  cmp    r11d,03h                  ; 
         jne    l_008C                    ; 
         add    rbx,rbx                   ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         mov    r10,qword ptr [rsi+010h]  ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         lea    rsi,[rsi+010h]            ; 
         lea    rdx,[rdx+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-010h],rbx  ; 
         jmp    l_00CA                    ; 
         ALIGN  16                        ;
l_008C:  dec    rcx                       ; 
         add    rbx,rbx                   ; 
         mov    r8,qword ptr [rsi+08h]    ; 
         mov    r9,qword ptr [rsi+010h]   ; 
         adc    r8,qword ptr [rdx+08h]    ; 
         adc    r9,qword ptr [rdx+010h]   ; 
         mov    r10,qword ptr [rsi+018h]  ; 
         adc    r10,qword ptr [rdx+018h]  ; 
         lea    rsi,[rsi+018h]            ; 
         lea    rdx,[rdx+018h]            ; 
         lea    rdi,[rdi+018h]            ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    r8,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-018h],rbx  ; 
         mov    qword ptr [rdi-010h],r8   ; 
l_00CA:  mov    qword ptr [rdi-08h],r9    ; 
l_00CE:  mov    rbx,r10                   ; 
l_00D1:  shr    rcx,02h                   ; 
         je     l_0135                    ; 
         ALIGN  16                        ; 
l_00E0:  add    rbx,rbx                   ; 
         mov    r8,qword ptr [rsi+08h]    ; 
         mov    r9,qword ptr [rsi+010h]   ; 
         adc    r8,qword ptr [rdx+08h]    ; 
         adc    r9,qword ptr [rdx+010h]   ; 
         mov    r10,qword ptr [rsi+018h]  ; 
         mov    r11,qword ptr [rsi+020h]  ; 
         adc    r10,qword ptr [rdx+018h]  ; 
         adc    r11,qword ptr [rdx+020h]  ; 
         lea    rsi,[rsi+020h]            ; 
         lea    rdx,[rdx+020h]            ; 
         rcr    r11,1                     ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    r8,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi],rbx       ; 
         mov    qword ptr [rdi+08h],r8    ; 
         mov    qword ptr [rdi+010h],r9   ; 
         mov    qword ptr [rdi+018h],r10  ; 
         mov    rbx,r11                   ; 
         lea    rdi,[rdi+020h]            ; 
         dec    rcx                       ; 
         jne    l_00E0                    ; 
l_0135:  mov    qword ptr [rdi],rbx       ; 
         pop    rbx                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_rsh1add_n ENDP

                  ALIGN 16

__gmpn_rsh1add_nc PROC

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
         push   rbx                       ; 
         xor    eax,eax                   ; 
         neg    r8                        ; 
         mov    rbx,qword ptr [rsi]       ; 
         adc    rbx,qword ptr [rdx]       ; 
         rcr    rbx,1                     ; 
         adc    eax,eax                   ; 
         mov    r11d,ecx                  ; 
         and    r11d,03h                  ; 
         cmp    r11d,01h                  ; 
         je     l_00D1                    ; 
         cmp    r11d,02h                  ; 
         jne    l_0058                    ; 
         add    rbx,rbx                   ; 
         mov    r10,qword ptr [rsi+08h]   ; 
         adc    r10,qword ptr [rdx+08h]   ; 
         lea    rsi,[rsi+08h]             ; 
         lea    rdx,[rdx+08h]             ; 
         lea    rdi,[rdi+08h]             ; 
         rcr    r10,1                     ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-08h],rbx   ; 
         jmp    l_00CE                    ; 
         ALIGN  16                        ;
l_0058:  cmp    r11d,03h                  ; 
         jne    l_008C                    ; 
         add    rbx,rbx                   ; 
         mov    r9,qword ptr [rsi+08h]    ; 
         mov    r10,qword ptr [rsi+010h]  ; 
         adc    r9,qword ptr [rdx+08h]    ; 
         adc    r10,qword ptr [rdx+010h]  ; 
         lea    rsi,[rsi+010h]            ; 
         lea    rdx,[rdx+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-010h],rbx  ; 
         jmp    l_00CA                    ; 
         ALIGN  16                        ;
l_008C:  dec    rcx                       ; 
         add    rbx,rbx                   ; 
         mov    r8,qword ptr [rsi+08h]    ; 
         mov    r9,qword ptr [rsi+010h]   ; 
         adc    r8,qword ptr [rdx+08h]    ; 
         adc    r9,qword ptr [rdx+010h]   ; 
         mov    r10,qword ptr [rsi+018h]  ; 
         adc    r10,qword ptr [rdx+018h]  ; 
         lea    rsi,[rsi+018h]            ; 
         lea    rdx,[rdx+018h]            ; 
         lea    rdi,[rdi+018h]            ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    r8,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi-018h],rbx  ; 
         mov    qword ptr [rdi-010h],r8   ; 
l_00CA:  mov    qword ptr [rdi-08h],r9    ; 
l_00CE:  mov    rbx,r10                   ; 
l_00D1:  shr    rcx,02h                   ; 
         je     l_0135                    ; 
         ALIGN  16                        ; 
l_00E0:  add    rbx,rbx                   ; 
         mov    r8,qword ptr [rsi+08h]    ; 
         mov    r9,qword ptr [rsi+010h]   ; 
         adc    r8,qword ptr [rdx+08h]    ; 
         adc    r9,qword ptr [rdx+010h]   ; 
         mov    r10,qword ptr [rsi+018h]  ; 
         mov    r11,qword ptr [rsi+020h]  ; 
         adc    r10,qword ptr [rdx+018h]  ; 
         adc    r11,qword ptr [rdx+020h]  ; 
         lea    rsi,[rsi+020h]            ; 
         lea    rdx,[rdx+020h]            ; 
         rcr    r11,1                     ; 
         rcr    r10,1                     ; 
         rcr    r9,1                      ; 
         rcr    r8,1                      ; 
         rcr    rbx,1                     ; 
         mov    qword ptr [rdi],rbx       ; 
         mov    qword ptr [rdi+08h],r8    ; 
         mov    qword ptr [rdi+010h],r9   ; 
         mov    qword ptr [rdi+018h],r10  ; 
         mov    rbx,r11                   ; 
         lea    rdi,[rdi+020h]            ; 
         dec    rcx                       ; 
         jne    l_00E0                    ; 
l_0135:  mov    qword ptr [rdi],rbx       ; 
         pop    rbx                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_rsh1add_nc ENDP

                 END
