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

__gmpn_sbpi1_bdiv_r PROC

         push   rdi                             ; SysV-to-MSVC ABI (save rdi)
         push   rsi                             ; SysV-to-MSVC ABI (save rsi)
                                                ; function parameter #1 in RCX (gcc assumes RDI)
                                                ; function parameter #2 in RDX (gcc assumes RSI)
                                                ; function parameter #3 in R8 (gcc assumes RDX)
                                                ; function parameter #4 in R9 (gcc assumes RCX)
                                                ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov    rdi,rcx                         ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                         ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                          ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                          ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]         ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         lea    r10,offset Latab                ; 
         cmp    rcx,08h                         ; 
         jbe    l_0274                          ; 
         push   rbx                             ; 
         push   rbp                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         lea    rbx,[rcx*8-08h]                 ; 
         neg    rbx                             ; 
         mov    rbp,rcx                         ; 
         mov    eax,ecx                         ; 
         shr    rbp,03h                         ; 
         and    eax,07h                         ; 
         mov    rax,qword ptr [r10+rax*8]       ; 
         mov    rdx,qword ptr [rdi]             ; 
         imul   rdx,r8                          ; 
         jmp    l_0195                          ; 
         ALIGN  16                              ;
Lf0:     mulx   r11,r10,qword ptr [r14]         ; 
         lea    rcx,[rcx-01h]                   ; 
         mulx   r9,r12,qword ptr [r14+08h]      ; 
         lea    r14,[r14-08h]                   ; 
         adcx   r12,r11                         ; 
         adox   r10,qword ptr [rdi]             ; 
         lea    rdi,[rdi-08h]                   ; 
         jmp    l_01E3                          ; 
         ALIGN  16                              ;
Lf3:     mulx   r9,r12,qword ptr [r14]          ; 
         mulx   r11,r10,qword ptr [r14+08h]     ; 
         adox   r12,qword ptr [rdi]             ; 
         lea    rdi,[rdi-030h]                  ; 
         lea    r14,[r14+010h]                  ; 
         jmp    l_0254                          ; 
         ALIGN  16                              ;
Lf4:     mulx   r11,r10,qword ptr [r14]         ; 
         mulx   r9,r12,qword ptr [r14+08h]      ; 
         lea    r14,[r14+018h]                  ; 
         adox   r10,qword ptr [rdi]             ; 
         lea    rdi,[rdi-028h]                  ; 
         adcx   r12,r11                         ; 
         jmp    l_0243                          ; 
         ALIGN  16                              ;
Lf5:     mulx   r9,r12,qword ptr [r14]          ; 
         mulx   r11,r10,qword ptr [r14+08h]     ; 
         lea    r14,[r14+020h]                  ; 
         adcx   r10,r9                          ; 
         adox   r12,qword ptr [rdi]             ; 
         lea    rdi,[rdi-020h]                  ; 
         jmp    l_022C                          ; 
         ALIGN  16                              ;
Lf6:     mulx   r11,r10,qword ptr [r14]         ; 
         mulx   r9,r12,qword ptr [r14+08h]      ; 
         lea    r14,[r14+028h]                  ; 
         adox   r10,qword ptr [rdi]             ; 
         lea    rdi,[rdi-018h]                  ; 
         adcx   r12,r11                         ; 
         jmp    l_0215                          ; 
         ALIGN  16                              ;
Lf7:     mulx   r9,r12,qword ptr [r14]          ; 
         mulx   r11,r10,qword ptr [r14+08h]     ; 
         lea    r14,[r14+030h]                  ; 
         adcx   r10,r9                          ; 
         adox   r12,qword ptr [rdi]             ; 
         lea    rdi,[rdi-010h]                  ; 
         jmp    l_01FE                          ; 
         ALIGN  16                              ;
Lf1:     mulx   r9,r12,qword ptr [r14]          ; 
         mulx   r11,r10,qword ptr [r14+08h]     ; 
         adox   r12,qword ptr [rdi]             ; 
         lea    rcx,[rcx-01h]                   ; 
         jmp    l_01C6                          ; 
         ALIGN  16                              ;
Lf2:     mulx   r11,r10,qword ptr [r14]         ; 
         mulx   r9,r12,qword ptr [r14+08h]      ; 
         lea    r14,[r14+08h]                   ; 
         adox   r10,qword ptr [rdi]             ; 
         lea    rdi,[rdi+08h]                   ; 
         adcx   r12,r11                         ; 
         jmp    l_01B3                          ; 
         ALIGN  16                              ;
l_015A:  adox   r12,qword ptr [rdi]             ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi],r12             ; 
         adc    r9,rcx                          ; 
         mov    rdx,qword ptr [rdi+rbx*1+08h]   ; 
         mulx   r12,rdx,r8                      ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+08h],r9          ; 
         setb   r13b                            ; 
         dec    rsi                             ; 
         je     l_0268                          ; 
         lea    r14,[r14+rbx*1]                 ; 
         lea    rdi,[rdi+rbx*1+08h]             ; 
l_0195:  mov    rcx,rbp                         ; 
         test   eax,eax                         ; 
         jmp    rax                             ; 
         ALIGN  16                              ; 
l_01A0:  adox   r10,qword ptr [rdi-08h]         ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi-08h],r10         ; 
         jrcxz  l_015A                          ; 
l_01B3:  mulx   r11,r10,qword ptr [r14+08h]     ; 
         adox   r12,qword ptr [rdi]             ; 
         lea    rcx,[rcx-01h]                   ; 
         mov    qword ptr [rdi],r12             ; 
l_01C6:  adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14+010h]     ; 
         adcx   r12,r11                         ; 
         adox   r10,qword ptr [rdi+08h]         ; 
         mov    qword ptr [rdi+08h],r10         ; 
l_01E3:  mulx   r11,r10,qword ptr [r14+018h]    ; 
         lea    r14,[r14+040h]                  ; 
         adcx   r10,r9                          ; 
         adox   r12,qword ptr [rdi+010h]        ; 
         mov    qword ptr [rdi+010h],r12        ; 
l_01FE:  mulx   r9,r12,qword ptr [r14-020h]     ; 
         adox   r10,qword ptr [rdi+018h]        ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi+018h],r10        ; 
l_0215:  mulx   r11,r10,qword ptr [r14-018h]    ; 
         adcx   r10,r9                          ; 
         adox   r12,qword ptr [rdi+020h]        ; 
         mov    qword ptr [rdi+020h],r12        ; 
l_022C:  mulx   r9,r12,qword ptr [r14-010h]     ; 
         adox   r10,qword ptr [rdi+028h]        ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi+028h],r10        ; 
l_0243:  adox   r12,qword ptr [rdi+030h]        ; 
         mulx   r11,r10,qword ptr [r14-08h]     ; 
         mov    qword ptr [rdi+030h],r12        ; 
l_0254:  lea    rdi,[rdi+040h]                  ; 
         adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14]          ; 
         jmp    l_01A0                          ; 
         ALIGN  16                              ;
l_0268:  mov    rax,r13                         ; 
         pop    r14                             ; 
         pop    r13                             ; 
         pop    r12                             ; 
         pop    rbp                             ; 
         pop    rbx                             ; 
         pop    rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 
         ALIGN  16                              ;
l_0274:  mov    rax,qword ptr [r10+rcx*8+038h]  ; 
         jmp    rax                             ; 
         ALIGN  16                              ;
L1:      mov    r10,qword ptr [rdx]             ; 
         xor    eax,eax                         ; 
         mov    rdx,qword ptr [rdi]             ; 
         dec    rsi                             ; 
         mov    r9,rdx                          ; 
l_0289:  mulx   r11,rdx,r8                      ; 
         lea    rdi,[rdi+08h]                   ; 
         mulx   rdx,rcx,r10                     ; 
         add    rcx,r9                          ; 
         adc    rdx,rax                         ; 
         add    rdx,qword ptr [rdi]             ; 
         setb   al                              ; 
         mov    r9,rdx                          ; 
         dec    rsi                             ; 
         jne    l_0289                          ; 
         mov    qword ptr [rdi],r9              ; 
         pop    rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 
         ALIGN  16                              ;
L2:      push   r12                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         sub    rsi,rcx                         ; 
         mov    rdx,qword ptr [rdi]             ; 
         imul   rdx,r8                          ; 
         push   rbx                             ; 
         push   r13                             ; 
         xor    r13d,r13d                       ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
l_02CD:  xor    ecx,ecx                         ; 
         mulx   r11,r10,qword ptr [r14]         ; 
         mulx   r9,rdx,qword ptr [r14+08h]      ; 
         adox   r10,rax                         ; 
         adcx   rdx,r11                         ; 
         adox   rdx,rbx                         ; 
         adox   r9,rcx                          ; 
         mov    rax,rdx                         ; 
         adc    r9,rcx                          ; 
         imul   rdx,r8                          ; 
         bt     r13d,00h                        ; 
         adc    r9,qword ptr [rdi+010h]         ; 
         mov    rbx,r9                          ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_02CD                          ; 
         mov    qword ptr [rdi],rax             ; 
         mov    qword ptr [rdi+08h],rbx         ; 
         mov    rax,r13                         ; 
         pop    r13                             ; 
         pop    rbx                             ; 
         pop    r14                             ; 
         pop    r12                             ; 
         pop    rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 
         ALIGN  16                              ;
L3:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_0345:  xor    ecx,ecx                         ; 
         mulx   r9,r12,qword ptr [r14]          ; 
         adox   r12,rax                         ; 
         mulx   r11,rax,qword ptr [r14+08h]     ; 
         adcx   rax,r9                          ; 
         adox   rax,rbx                         ; 
         mulx   r9,rbx,qword ptr [r14+010h]     ; 
         mov    rdx,r8                          ; 
         mulx   r12,rdx,rax                     ; 
         adcx   rbx,r11                         ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         adox   r9,rcx                          ; 
         adc    r9,00h                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+018h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_0345                          ; 
         jmp    Lesma                           ; 
         ALIGN  16                              ;
L4:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_03C2:  xor    ecx,ecx                         ; 
         mulx   r11,r10,qword ptr [r14]         ; 
         adox   r10,rax                         ; 
         mulx   r9,rax,qword ptr [r14+08h]      ; 
         adcx   rax,r11                         ; 
         adox   rax,rbx                         ; 
         mulx   r11,rbx,qword ptr [r14+010h]    ; 
         adcx   rbx,r9                          ; 
         mulx   r9,r12,qword ptr [r14+018h]     ; 
         mov    rdx,r8                          ; 
         mulx   r10,rdx,rax                     ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         adcx   r12,r11                         ; 
         adox   r12,qword ptr [rdi+018h]        ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi+018h],r12        ; 
         adc    r9,rcx                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+020h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_03C2                          ; 
         jmp    Lesma                           ; 
         ALIGN  16                              ;
L5:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_0455:  xor    ecx,ecx                         ; 
         mulx   r9,r12,qword ptr [r14]          ; 
         adox   r12,rax                         ; 
         mulx   r11,rax,qword ptr [r14+08h]     ; 
         adcx   rax,r9                          ; 
         adox   rax,rbx                         ; 
         mulx   r9,rbx,qword ptr [r14+010h]     ; 
         adcx   rbx,r11                         ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         mulx   r11,r10,qword ptr [r14+018h]    ; 
         adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14+020h]     ; 
         adox   r10,qword ptr [rdi+018h]        ; 
         adcx   r12,r11                         ; 
         mov    rdx,r8                          ; 
         mulx   r11,rdx,rax                     ; 
         mov    qword ptr [rdi+018h],r10        ; 
         adox   r12,qword ptr [rdi+020h]        ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi+020h],r12        ; 
         adc    r9,rcx                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+028h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_0455                          ; 
         jmp    Lesma                           ; 
         ALIGN  16                              ;
L6:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_0503:  xor    ecx,ecx                         ; 
         mulx   r11,r10,qword ptr [r14]         ; 
         adox   r10,rax                         ; 
         mulx   r9,rax,qword ptr [r14+08h]      ; 
         adcx   rax,r11                         ; 
         adox   rax,rbx                         ; 
         mulx   r11,rbx,qword ptr [r14+010h]    ; 
         adcx   rbx,r9                          ; 
         mulx   r9,r12,qword ptr [r14+018h]     ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         adcx   r12,r11                         ; 
         adox   r12,qword ptr [rdi+018h]        ; 
         mulx   r11,r10,qword ptr [r14+020h]    ; 
         mov    qword ptr [rdi+018h],r12        ; 
         adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14+028h]     ; 
         adox   r10,qword ptr [rdi+020h]        ; 
         adcx   r12,r11                         ; 
         mov    rdx,r8                          ; 
         mulx   r11,rdx,rax                     ; 
         mov    qword ptr [rdi+020h],r10        ; 
         adox   r12,qword ptr [rdi+028h]        ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi+028h],r12        ; 
         adc    r9,rcx                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+030h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_0503                          ; 
         jmp    Lesma                           ; 
         ALIGN  16                              ;
L7:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_05C8:  xor    ecx,ecx                         ; 
         mulx   r9,r12,qword ptr [r14]          ; 
         adox   r12,rax                         ; 
         mulx   r11,rax,qword ptr [r14+08h]     ; 
         adcx   rax,r9                          ; 
         adox   rax,rbx                         ; 
         mulx   r9,rbx,qword ptr [r14+010h]     ; 
         adcx   rbx,r11                         ; 
         mulx   r11,r10,qword ptr [r14+018h]    ; 
         adcx   r10,r9                          ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         mulx   r9,r12,qword ptr [r14+020h]     ; 
         adox   r10,qword ptr [rdi+018h]        ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi+018h],r10        ; 
         adox   r12,qword ptr [rdi+020h]        ; 
         mulx   r11,r10,qword ptr [r14+028h]    ; 
         mov    qword ptr [rdi+020h],r12        ; 
         adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14+030h]     ; 
         adox   r10,qword ptr [rdi+028h]        ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi+028h],r10        ; 
         mov    rdx,rax                         ; 
         mulx   r10,rdx,r8                      ; 
         adox   r12,qword ptr [rdi+030h]        ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi+030h],r12        ; 
         adc    r9,rcx                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+038h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_05C8                          ; 
         jmp    Lesma                           ; 
         ALIGN  16                              ;
L8:      push   rbx                             ; 
         push   r12                             ; 
         push   r13                             ; 
         push   r14                             ; 
         mov    r14,rdx                         ; 
         xor    r13,r13                         ; 
         sub    rsi,rcx                         ; 
         mov    rax,qword ptr [rdi]             ; 
         mov    rbx,qword ptr [rdi+08h]         ; 
         mov    rdx,rax                         ; 
         imul   rdx,r8                          ; 
l_06A4:  xor    ecx,ecx                         ; 
         mulx   r11,r10,qword ptr [r14]         ; 
         adox   r10,rax                         ; 
         mulx   r9,rax,qword ptr [r14+08h]      ; 
         adcx   rax,r11                         ; 
         adox   rax,rbx                         ; 
         mulx   r11,rbx,qword ptr [r14+010h]    ; 
         adcx   rbx,r9                          ; 
         mulx   r9,r12,qword ptr [r14+018h]     ; 
         adox   rbx,qword ptr [rdi+010h]        ; 
         adcx   r12,r11                         ; 
         mulx   r11,r10,qword ptr [r14+020h]    ; 
         adcx   r10,r9                          ; 
         adox   r12,qword ptr [rdi+018h]        ; 
         mov    qword ptr [rdi+018h],r12        ; 
         mulx   r9,r12,qword ptr [r14+028h]     ; 
         adox   r10,qword ptr [rdi+020h]        ; 
         adcx   r12,r11                         ; 
         mov    qword ptr [rdi+020h],r10        ; 
         adox   r12,qword ptr [rdi+028h]        ; 
         mulx   r11,r10,qword ptr [r14+030h]    ; 
         mov    qword ptr [rdi+028h],r12        ; 
         adcx   r10,r9                          ; 
         mulx   r9,r12,qword ptr [r14+038h]     ; 
         adox   r10,qword ptr [rdi+030h]        ; 
         adcx   r12,r11                         ; 
         mov    rdx,r8                          ; 
         mulx   r11,rdx,rax                     ; 
         mov    qword ptr [rdi+030h],r10        ; 
         adox   r12,qword ptr [rdi+038h]        ; 
         adox   r9,rcx                          ; 
         mov    qword ptr [rdi+038h],r12        ; 
         adc    r9,rcx                          ; 
         bt     r13d,00h                        ; 
         adc    qword ptr [rdi+040h],r9         ; 
         setb   r13b                            ; 
         lea    rdi,[rdi+08h]                   ; 
         dec    rsi                             ; 
         jne    l_06A4                          ; 
;         jmp    Lesma                           ; 
         ALIGN  16                              ;
Lesma:   mov    qword ptr [rdi],rax             ; 
         mov    qword ptr [rdi+08h],rbx         ; 
         mov    rax,r13                         ; 
         pop    r14                             ; 
         pop    r13                             ; 
         pop    r12                             ; 
         pop    rbx                             ; 
         pop    rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 

         ALIGN  16

Latab:
         dq     offset Lf0
         dq     offset Lf1
         dq     offset Lf2
         dq     offset Lf3
         dq     offset Lf4
         dq     offset Lf5
         dq     offset Lf6
         dq     offset Lf7
         dq     offset L1
         dq     offset L2
         dq     offset L3
         dq     offset L4
         dq     offset L5
         dq     offset L6
         dq     offset L7
         dq     offset L8

__gmpn_sbpi1_bdiv_r ENDP

                   END
