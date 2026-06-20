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

__gmpn_sublsh1_n PROC

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
         push   rbp                       ; 
         push   r15                       ; 
         xor    ebp,ebp                   ; 
         mov    eax,ecx                   ; 
         and    eax,03h                   ; 
         je     l_00B4                    ; 
         cmp    eax,02h                   ; 
         je     l_003A                    ; 
         jg     l_006F                    ; 
         mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         lea    rdx,[rdx+08h]             ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+08h]             ; 
         lea    rdi,[rdi+08h]             ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_003A:  mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         lea    rdx,[rdx+010h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_006F:  mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx+010h]  ; 
         adc    r10,r10                   ; 
         lea    rdx,[rdx+018h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         mov    r15,qword ptr [rsi+010h]  ; 
         sbb    r15,r10                   ; 
         mov    qword ptr [rdi+010h],r15  ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+018h]            ; 
         lea    rdi,[rdi+018h]            ; 
l_00B4:  test   cl,04h                    ; 
         je     l_0112                    ; 
         add    eax,eax                   ; 
         mov    r8,qword ptr [rdx]        ; 
         adc    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx+010h]  ; 
         adc    r10,r10                   ; 
         mov    r11,qword ptr [rdx+018h]  ; 
         adc    r11,r11                   ; 
         lea    rdx,[rdx+020h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         mov    r15,qword ptr [rsi+010h]  ; 
         sbb    r15,r10                   ; 
         mov    qword ptr [rdi+010h],r15  ; 
         mov    r15,qword ptr [rsi+018h]  ; 
         sbb    r15,r11                   ; 
         mov    qword ptr [rdi+018h],r15  ; 
         lea    rsi,[rsi+020h]            ; 
         lea    rdi,[rdi+020h]            ; 
         sbb    ebp,ebp                   ; 
l_0112:  cmp    rcx,08h                   ; 
         jl     l_01E2                    ; 
         push   r12                       ; 
         push   r13                       ; 
         push   r14                       ; 
         push   rbx                       ; 
         lea    rdi,[rdi-040h]            ; 
         jmp    l_01D1                    ; 
         ALIGN  16                        ; 
l_0130:  mov    r8,qword ptr [rdx]        ; 
         add    eax,eax                   ; 
         lea    rdx,[rdx+040h]            ; 
         adc    r8,r8                     ; 
         mov    r9,qword ptr [rdx-038h]   ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx-030h]  ; 
         adc    r10,r10                   ; 
         mov    r11,qword ptr [rdx-028h]  ; 
         adc    r11,r11                   ; 
         mov    r12,qword ptr [rdx-020h]  ; 
         adc    r12,r12                   ; 
         mov    r13,qword ptr [rdx-018h]  ; 
         adc    r13,r13                   ; 
         mov    r14,qword ptr [rdx-010h]  ; 
         adc    r14,r14                   ; 
         mov    r15,qword ptr [rdx-08h]   ; 
         adc    r15,r15                   ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    rbp,qword ptr [rsi]       ; 
         lea    rdi,[rdi+040h]            ; 
         mov    rbx,qword ptr [rsi+08h]   ; 
         sbb    rbp,r8                    ; 
         mov    r8,qword ptr [rsi+020h]   ; 
         mov    qword ptr [rdi],rbp       ; 
         sbb    rbx,r9                    ; 
         mov    rbp,qword ptr [rsi+010h]  ; 
         mov    qword ptr [rdi+08h],rbx   ; 
         sbb    rbp,r10                   ; 
         mov    rbx,qword ptr [rsi+018h]  ; 
         mov    qword ptr [rdi+010h],rbp  ; 
         sbb    rbx,r11                   ; 
         mov    qword ptr [rdi+018h],rbx  ; 
         sbb    r8,r12                    ; 
         mov    r9,qword ptr [rsi+028h]   ; 
         mov    qword ptr [rdi+020h],r8   ; 
         sbb    r9,r13                    ; 
         mov    rbp,qword ptr [rsi+030h]  ; 
         mov    qword ptr [rdi+028h],r9   ; 
         sbb    rbp,r14                   ; 
         mov    rbx,qword ptr [rsi+038h]  ; 
         mov    qword ptr [rdi+030h],rbp  ; 
         sbb    rbx,r15                   ; 
         lea    rsi,[rsi+040h]            ; 
         mov    qword ptr [rdi+038h],rbx  ; 
         sbb    ebp,ebp                   ; 
l_01D1:  sub    rcx,08h                   ; 
         jge    l_0130                    ; 
         pop    rbx                       ; 
         pop    r14                       ; 
         pop    r13                       ; 
         pop    r12                       ; 
l_01E2:  add    eax,ebp                   ; 
         neg    eax                       ; 
         pop    r15                       ; 
         pop    rbp                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_sublsh1_n ENDP

                  ALIGN 16

__gmpn_sublsh1_nc PROC

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
         push   rbp                       ; 
         push   r15                       ; 
         neg    r8                        ; 
         sbb    ebp,ebp                   ; 
         mov    eax,ecx                   ; 
         and    eax,03h                   ; 
         je     l_00B4                    ; 
         cmp    eax,02h                   ; 
         je     l_003A                    ; 
         jg     l_006F                    ; 
         mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         lea    rdx,[rdx+08h]             ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+08h]             ; 
         lea    rdi,[rdi+08h]             ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_003A:  mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         lea    rdx,[rdx+010h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         jmp    l_00B4                    ; 
         ALIGN  16                        ;
l_006F:  mov    r8,qword ptr [rdx]        ; 
         add    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx+010h]  ; 
         adc    r10,r10                   ; 
         lea    rdx,[rdx+018h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         mov    r15,qword ptr [rsi+010h]  ; 
         sbb    r15,r10                   ; 
         mov    qword ptr [rdi+010h],r15  ; 
         sbb    ebp,ebp                   ; 
         lea    rsi,[rsi+018h]            ; 
         lea    rdi,[rdi+018h]            ; 
l_00B4:  test   cl,04h                    ; 
         je     l_0112                    ; 
         add    eax,eax                   ; 
         mov    r8,qword ptr [rdx]        ; 
         adc    r8,r8                     ; 
         mov    r9,qword ptr [rdx+08h]    ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx+010h]  ; 
         adc    r10,r10                   ; 
         mov    r11,qword ptr [rdx+018h]  ; 
         adc    r11,r11                   ; 
         lea    rdx,[rdx+020h]            ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    r15,qword ptr [rsi]       ; 
         sbb    r15,r8                    ; 
         mov    qword ptr [rdi],r15       ; 
         mov    r15,qword ptr [rsi+08h]   ; 
         sbb    r15,r9                    ; 
         mov    qword ptr [rdi+08h],r15   ; 
         mov    r15,qword ptr [rsi+010h]  ; 
         sbb    r15,r10                   ; 
         mov    qword ptr [rdi+010h],r15  ; 
         mov    r15,qword ptr [rsi+018h]  ; 
         sbb    r15,r11                   ; 
         mov    qword ptr [rdi+018h],r15  ; 
         lea    rsi,[rsi+020h]            ; 
         lea    rdi,[rdi+020h]            ; 
         sbb    ebp,ebp                   ; 
l_0112:  cmp    rcx,08h                   ; 
         jl     l_01E2                    ; 
         push   r12                       ; 
         push   r13                       ; 
         push   r14                       ; 
         push   rbx                       ; 
         lea    rdi,[rdi-040h]            ; 
         jmp    l_01D1                    ; 
         ALIGN  16                        ; 
l_0130:  mov    r8,qword ptr [rdx]        ; 
         add    eax,eax                   ; 
         lea    rdx,[rdx+040h]            ; 
         adc    r8,r8                     ; 
         mov    r9,qword ptr [rdx-038h]   ; 
         adc    r9,r9                     ; 
         mov    r10,qword ptr [rdx-030h]  ; 
         adc    r10,r10                   ; 
         mov    r11,qword ptr [rdx-028h]  ; 
         adc    r11,r11                   ; 
         mov    r12,qword ptr [rdx-020h]  ; 
         adc    r12,r12                   ; 
         mov    r13,qword ptr [rdx-018h]  ; 
         adc    r13,r13                   ; 
         mov    r14,qword ptr [rdx-010h]  ; 
         adc    r14,r14                   ; 
         mov    r15,qword ptr [rdx-08h]   ; 
         adc    r15,r15                   ; 
         sbb    eax,eax                   ; 
         add    ebp,ebp                   ; 
         mov    rbp,qword ptr [rsi]       ; 
         lea    rdi,[rdi+040h]            ; 
         mov    rbx,qword ptr [rsi+08h]   ; 
         sbb    rbp,r8                    ; 
         mov    r8,qword ptr [rsi+020h]   ; 
         mov    qword ptr [rdi],rbp       ; 
         sbb    rbx,r9                    ; 
         mov    rbp,qword ptr [rsi+010h]  ; 
         mov    qword ptr [rdi+08h],rbx   ; 
         sbb    rbp,r10                   ; 
         mov    rbx,qword ptr [rsi+018h]  ; 
         mov    qword ptr [rdi+010h],rbp  ; 
         sbb    rbx,r11                   ; 
         mov    qword ptr [rdi+018h],rbx  ; 
         sbb    r8,r12                    ; 
         mov    r9,qword ptr [rsi+028h]   ; 
         mov    qword ptr [rdi+020h],r8   ; 
         sbb    r9,r13                    ; 
         mov    rbp,qword ptr [rsi+030h]  ; 
         mov    qword ptr [rdi+028h],r9   ; 
         sbb    rbp,r14                   ; 
         mov    rbx,qword ptr [rsi+038h]  ; 
         mov    qword ptr [rdi+030h],rbp  ; 
         sbb    rbx,r15                   ; 
         lea    rsi,[rsi+040h]            ; 
         mov    qword ptr [rdi+038h],rbx  ; 
         sbb    ebp,ebp                   ; 
l_01D1:  sub    rcx,08h                   ; 
         jge    l_0130                    ; 
         pop    rbx                       ; 
         pop    r14                       ; 
         pop    r13                       ; 
         pop    r12                       ; 
l_01E2:  add    eax,ebp                   ; 
         neg    eax                       ; 
         pop    r15                       ; 
         pop    rbp                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_sublsh1_nc ENDP

                END
