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

__gmpn_mullo_basecase PROC

         push   rdi                                 ; SysV-to-MSVC ABI (save rdi)
         push   rsi                                 ; SysV-to-MSVC ABI (save rsi)
                                                    ; function parameter #1 in RCX (gcc assumes RDI)
                                                    ; function parameter #2 in RDX (gcc assumes RSI)
                                                    ; function parameter #3 in R8 (gcc assumes RDX)
                                                    ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                             ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                             ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                              ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                              ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         cmp    ecx,04h                             ; 
         jae    Lbig                                ; 
         mov    r11,rdx                             ; 
         mov    rdx,qword ptr [rsi]                 ; 
         cmp    ecx,02h                             ; 
         jae    Lgt1                                ; 
Ln1:     imul   rdx,qword ptr [r11]                 ; 
         mov    qword ptr [rdi],rdx                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ;  
Lgt1:    ja     Lgt2                                ; 
Ln2:     mov    r9,qword ptr [r11]                  ; 
         mulx   rdx,rax,r9                          ; 
         mov    qword ptr [rdi],rax                 ; 
         mov    rax,qword ptr [rsi+08h]             ; 
         imul   rax,r9                              ; 
         add    rdx,rax                             ; 
         mov    r9,qword ptr [r11+08h]              ; 
         mov    rcx,qword ptr [rsi]                 ; 
         imul   rcx,r9                              ; 
         add    rdx,rcx                             ; 
         mov    qword ptr [rdi+08h],rdx             ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ;  
Lgt2:    mov    r9,qword ptr [r11]                  ; 
Ln3:     mulx   r10,rax,r9                          ; 
         mov    qword ptr [rdi],rax                 ; 
         mov    rdx,qword ptr [rsi+08h]             ; 
         mulx   rdx,rax,r9                          ; 
         imul   r9,qword ptr [rsi+010h]             ; 
         add    r10,rax                             ; 
         adc    r9,rdx                              ; 
         mov    r8,qword ptr [r11+08h]              ; 
         mov    rdx,qword ptr [rsi]                 ; 
         mulx   rdx,rax,r8                          ; 
         add    r10,rax                             ; 
         adc    r9,rdx                              ; 
         imul   r8,qword ptr [rsi+08h]              ; 
         add    r9,r8                               ; 
         mov    qword ptr [rdi+08h],r10             ; 
         mov    r10,qword ptr [r11+010h]            ; 
         mov    rax,qword ptr [rsi]                 ; 
         imul   r10,rax                             ; 
         add    r9,r10                              ; 
         mov    qword ptr [rdi+010h],r9             ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ; 
Lbig:    push   r15                                 ; 
         push   r14                                 ; 
         push   r13                                 ; 
         push   r12                                 ; 
         push   rbp                                 ; 
         push   rbx                                 ; 
         mov    r9,qword ptr [rsi]                  ; 
         lea    rsi,[rsi+rcx*8-08h]                 ; 
         lea    rdi,[rdi+rcx*8-028h]                ; 
         mov    r14d,04h                            ; 
         sub    r14,rcx                             ; 
         mov    rbp,qword ptr [rdx+rcx*8-08h]       ; 
         imul   rbp,r9                              ; 
         lea    r15,[rdx+08h]                       ; 
         mov    rdx,qword ptr [rdx]                 ; 
         test   r14b,01h                            ; 
         jne    Lmx0                                ; 
Lmx1:    test   r14b,02h                            ; 
         je     Lmb3                                ; 
Lmb1:    mulx   rax,rbx,r9                          ; 
         lea    rcx,[r14-02h]                       ; 
         mulx   r8,r9,qword ptr [rsi+r14*8-010h]    ; 
         mulx   r10,r11,qword ptr [rsi+r14*8-08h]   ; 
         jmp    Lmlo1                               ; 
         ALIGN  16                                  ;  
Lmb3:    mulx   r10,r11,r9                          ; 
         mulx   r12,r13,qword ptr [rsi+r14*8-010h]  ; 
         mulx   rax,rbx,qword ptr [rsi+r14*8-08h]   ; 
         lea    rcx,[r14]                           ; 
         jrcxz  Lx                                  ; 
         jmp    Lmlo3                               ; 
         ALIGN  16                                  ;  
Lx:      jmp    Lmcor                               ; 
         ALIGN  16                                  ;  
Lmb2:    mulx   r12,r13,r9                          ; 
         mulx   rax,rbx,qword ptr [rsi+r14*8-010h]  ; 
         lea    rcx,[r14-01h]                       ; 
         mulx   r8,r9,qword ptr [rsi+r14*8-08h]     ; 
         jmp    Lmlo2                               ; 
         ALIGN  16                                  ;  
Lmx0:    test   r14b,02h                            ; 
         je     Lmb2                                ; 
Lmb0:    mulx   r8,r9,r9                            ; 
         mulx   r10,r11,qword ptr [rsi+r14*8-010h]  ; 
         mulx   r12,r13,qword ptr [rsi+r14*8-08h]   ; 
         lea    rcx,[r14-03h]                       ; 
         jmp    Lmlo0                               ; 
         ALIGN  16                                  ; 
Lmtop:   jrcxz  Lmend                               ; 
         adc    r11,r8                              ; 
         mov    qword ptr [rdi+rcx*8],r9            ; 
Lmlo3:   mulx   r8,r9,qword ptr [rsi+rcx*8]         ; 
         adc    r13,r10                             ; 
         mov    qword ptr [rdi+rcx*8+08h],r11       ; 
Lmlo2:   mulx   r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         adc    rbx,r12                             ; 
         mov    qword ptr [rdi+rcx*8+010h],r13      ; 
Lmlo1:   mulx   r12,r13,qword ptr [rsi+rcx*8+010h]  ; 
         adc    r9,rax                              ; 
         mov    qword ptr [rdi+rcx*8+018h],rbx      ; 
Lmlo0:   mulx   rax,rbx,qword ptr [rsi+rcx*8+018h]  ; 
         lea    rcx,[rcx+04h]                       ; 
         jmp    Lmtop                               ; 
         ALIGN  16                                  ;  
Lmend:   mov    qword ptr [rdi],r9                  ; 
         adc    r11,r8                              ; 
         mov    qword ptr [rdi+08h],r11             ; 
         adc    r13,r10                             ; 
         mov    qword ptr [rdi+010h],r13            ; 
         adc    rbx,r12                             ; 
         mov    qword ptr [rdi+018h],rbx            ; 
Louter:  mulx   r8,r10,qword ptr [rsi]              ; 
         adc    rbp,rax                             ; 
         add    rbp,r10                             ; 
         mov    rdx,qword ptr [r15]                 ; 
         add    r15,08h                             ; 
         mov    r8,qword ptr [rsi+r14*8-018h]       ; 
         lea    rsi,[rsi-08h]                       ; 
         test   r14b,01h                            ; 
         je     Lx0                                 ; 
Lx1:     test   r14b,02h                            ; 
         jne    Lb3                                 ; 
Lb1:     mulx   rax,rbx,r8                          ; 
         lea    rcx,[r14-01h]                       ; 
         mulx   r8,r9,qword ptr [rsi+rcx*8]         ; 
         mulx   r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         jmp    Llo1                                ; 
         ALIGN  16                                  ;  
Lx0:     test   r14b,02h                            ; 
         je     Lb2                                 ; 
Lb0:     mulx   r8,r9,r8                            ; 
         lea    rcx,[r14-02h]                       ; 
         mulx   r10,r11,qword ptr [rsi+r14*8-08h]   ; 
         mulx   r12,r13,qword ptr [rsi+r14*8]       ; 
         jmp    Llo0                                ; 
         ALIGN  16                                  ;  
Lb3:     mulx   r10,r11,r8                          ; 
         lea    rcx,[r14+01h]                       ; 
         mulx   r12,r13,qword ptr [rsi+r14*8-08h]   ; 
         mulx   rax,rbx,qword ptr [rsi+r14*8]       ; 
         add    r13,r10                             ; 
         adc    rbx,r12                             ; 
         adc    rax,00h                             ; 
         jrcxz  Lcor                                ; 
         jmp    Llo3                                ; 
         ALIGN  16                                  ;  
Lcor:    add    r11,qword ptr [rdi+08h]             ; 
         mov    r10,qword ptr [rdi+010h]            ; 
         mov    r12,qword ptr [rdi+018h]            ; 
Lmcor:   mov    qword ptr [rdi+08h],r11             ; 
         adc    r13,r10                             ; 
         adc    rbx,r12                             ; 
         mulx   r8,r10,qword ptr [rsi]              ; 
         adc    rbp,rax                             ; 
         add    rbp,r10                             ; 
         mov    rdx,qword ptr [r15]                 ; 
         mov    r8,qword ptr [rsi-018h]             ; 
         mulx   r12,r9,r8                           ; 
         mulx   rax,r14,qword ptr [rsi-010h]        ; 
         add    r14,r12                             ; 
         adc    rax,00h                             ; 
         adc    r13,r9                              ; 
         mov    qword ptr [rdi+010h],r13            ; 
         adc    rbx,r14                             ; 
         mulx   r8,r10,qword ptr [rsi-08h]          ; 
         adc    rbp,rax                             ; 
         add    rbp,r10                             ; 
         mov    rdx,qword ptr [r15+08h]             ; 
         mulx   rax,r14,qword ptr [rsi-018h]        ; 
         add    rbx,r14                             ; 
         mov    qword ptr [rdi+018h],rbx            ; 
         mulx   r8,r10,qword ptr [rsi-010h]         ; 
         adc    rbp,rax                             ; 
         add    rbp,r10                             ; 
         mov    qword ptr [rdi+020h],rbp            ; 
         pop    rbx                                 ; 
         pop    rbp                                 ; 
         pop    r12                                 ; 
         pop    r13                                 ; 
         pop    r14                                 ; 
         pop    r15                                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ;  
Lb2:     mulx   r12,r13,r8                          ; 
         lea    rcx,[r14]                           ; 
         mulx   rax,rbx,qword ptr [rsi+r14*8-08h]   ; 
         add    rbx,r12                             ; 
         adc    rax,00h                             ; 
         mulx   r8,r9,qword ptr [rsi+r14*8]         ; 
         jmp    Llo2                                ; 
         ALIGN  16                                  ; 
Ltop:    add    qword ptr [rdi+rcx*8],r9            ; 
Llo3:    mulx   r8,r9,qword ptr [rsi+rcx*8]         ; 
         adc    qword ptr [rdi+rcx*8+08h],r11       ; 
Llo2:    mulx   r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         adc    qword ptr [rdi+rcx*8+010h],r13      ; 
Llo1:    mulx   r12,r13,qword ptr [rsi+rcx*8+010h]  ; 
         adc    qword ptr [rdi+rcx*8+018h],rbx      ; 
         adc    r9,rax                              ; 
Llo0:    mulx   rax,rbx,qword ptr [rsi+rcx*8+018h]  ; 
         adc    r11,r8                              ; 
         adc    r13,r10                             ; 
         adc    rbx,r12                             ; 
         adc    rax,00h                             ; 
         add    rcx,04h                             ; 
         js     Ltop                                ; 
         add    qword ptr [rdi],r9                  ; 
         adc    qword ptr [rdi+08h],r11             ; 
         adc    qword ptr [rdi+010h],r13            ; 
         adc    qword ptr [rdi+018h],rbx            ; 
         inc    r14                                 ; 
         jmp    Louter                              ; 

__gmpn_mullo_basecase ENDP

                     END
