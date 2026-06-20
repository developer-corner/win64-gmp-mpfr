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

__gmpn_mul_basecase PROC

         push   rdi                           ; SysV-to-MSVC ABI (save rdi)
         push   rsi                           ; SysV-to-MSVC ABI (save rsi)
                                              ; function parameter #1 in RCX (gcc assumes RDI)
                                              ; function parameter #2 in RDX (gcc assumes RSI)
                                              ; function parameter #3 in R8 (gcc assumes RDX)
                                              ; function parameter #4 in R9 (gcc assumes RCX)
                                              ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov    rdi,rcx                       ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                       ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                        ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                        ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
IF FULL_64BIT                                 ;
         mov    r8,qword ptr [rsp+038h]       ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
ELSE                                          ;
         mov    r8d,dword ptr [rsp+038h]      ; SysV-to-MSVC ABI (parameter #5 from stack to r8) ; do NOT use r8 here because of possible 'stack polution'
ENDIF                                         ;
         cmp    rdx,02h                       ; 
         ja     Lgen                          ; 
         mov    rdx,qword ptr [rcx]           ; 
         mulx   r9,rax,qword ptr [rsi]        ; 
         je     Ls2x                          ; 
Ls11:    mov    qword ptr [rdi],rax           ; 
         mov    qword ptr [rdi+08h],r9        ; 
         pop    rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                  ; 
         ALIGN  16                            ;
Ls2x:    cmp    r8,02h                        ; 
         mulx   r10,r8,qword ptr [rsi+08h]    ; 
         je     Ls22                          ; 
Ls21:    add    r9,r8                         ; 
         adc    r10,00h                       ; 
         mov    qword ptr [rdi],rax           ; 
         mov    qword ptr [rdi+08h],r9        ; 
         mov    qword ptr [rdi+010h],r10      ; 
         pop    rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                  ; 
         ALIGN  16                            ;
Ls22:    add    r9,r8                         ; 
         adc    r10,00h                       ; 
         mov    rdx,qword ptr [rcx+08h]       ; 
         mov    qword ptr [rdi],rax           ; 
         mulx   r11,r8,qword ptr [rsi]        ; 
         mulx   rdx,rax,qword ptr [rsi+08h]   ; 
         add    rax,r11                       ; 
         adc    rdx,00h                       ; 
         add    r9,r8                         ; 
         adc    r10,rax                       ; 
         adc    rdx,00h                       ; 
         mov    qword ptr [rdi+08h],r9        ; 
         mov    qword ptr [rdi+010h],r10      ; 
         mov    qword ptr [rdi+018h],rdx      ; 
         pop    rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                  ; 
         ALIGN  16                            ;
Lgen:    push   rbx                           ; 
         push   rbp                           ; 
         push   r12                           ; 
         push   r14                           ; 
         mov    r14,rcx                       ; 
         lea    rbx,[rdx+01h]                 ; 
         mov    rbp,rdx                       ; 
         mov    eax,edx                       ; 
         and    rbx,0fffffffffffffff8h        ; 
         shr    rbp,03h                       ; 
         neg    rbx                           ; 
         and    eax,07h                       ; 
         mov    rcx,rbp                       ; 
         mov    rdx,qword ptr [r14]           ; 
         lea    r14,[r14+08h]                 ; 
         mov    r10,offset Lmtab              ; 
         jmp    qword ptr [r10+rax*8]         ; 
         ALIGN  16                            ;  
Lmf0:    mulx   r11,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+038h]                ; 
         lea    rdi,[rdi-08h]                 ; 
         jmp    Lmb0                          ; 
         ALIGN  16                            ;  
Lmf3:    mulx   r9,r12,qword ptr [rsi]        ; 
         lea    rsi,[rsi+010h]                ; 
         lea    rdi,[rdi+010h]                ; 
         inc    rcx                           ; 
         jmp    Lmb3                          ; 
         ALIGN  16                            ;  
Lmf4:    mulx   r11,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+018h]                ; 
         lea    rdi,[rdi+018h]                ; 
         inc    rcx                           ; 
         jmp    Lmb4                          ; 
         ALIGN  16                            ;  
Lmf5:    mulx   r9,r12,qword ptr [rsi]        ; 
         lea    rsi,[rsi+020h]                ; 
         lea    rdi,[rdi+020h]                ; 
         inc    rcx                           ; 
         jmp    Lmb5                          ; 
         ALIGN  16                            ;  
Lmf6:    mulx   r11,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+028h]                ; 
         lea    rdi,[rdi+028h]                ; 
         inc    rcx                           ; 
         jmp    Lmb6                          ; 
         ALIGN  16                            ;  
Lmf7:    mulx   r9,r12,qword ptr [rsi]        ; 
         lea    rsi,[rsi+030h]                ; 
         lea    rdi,[rdi+030h]                ; 
         inc    rcx                           ; 
         jmp    Lmb7                          ; 
         ALIGN  16                            ;  
Lmf1:    mulx   r9,r12,qword ptr [rsi]        ; 
         jmp    Lmb1                          ;  
         ALIGN  16                            ;  
Lmf2:    mulx   r11,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+08h]                 ; 
         lea    rdi,[rdi+08h]                 ; 
         mulx   r9,r12,qword ptr [rsi]        ; 
         ALIGN  16                            ;
Lm1top:  mov    qword ptr [rdi-08h],r10       ; 
         adc    r12,r11                       ; 
Lmb1:    mulx   r11,r10,qword ptr [rsi+08h]   ; 
         adc    r10,r9                        ; 
         lea    rsi,[rsi+040h]                ; 
         mov    qword ptr [rdi],r12           ; 
Lmb0:    mov    qword ptr [rdi+08h],r10       ; 
         mulx   r9,r12,qword ptr [rsi-030h]   ; 
         lea    rdi,[rdi+040h]                ; 
         adc    r12,r11                       ; 
Lmb7:    mulx   r11,r10,qword ptr [rsi-028h]  ; 
         mov    qword ptr [rdi-030h],r12      ; 
         adc    r10,r9                        ; 
Lmb6:    mov    qword ptr [rdi-028h],r10      ; 
         mulx   r9,r12,qword ptr [rsi-020h]   ; 
         adc    r12,r11                       ; 
Lmb5:    mulx   r11,r10,qword ptr [rsi-018h]  ; 
         mov    qword ptr [rdi-020h],r12      ; 
         adc    r10,r9                        ; 
Lmb4:    mulx   r9,r12,qword ptr [rsi-010h]   ; 
         mov    qword ptr [rdi-018h],r10      ; 
         adc    r12,r11                       ; 
Lmb3:    mulx   r11,r10,qword ptr [rsi-08h]   ; 
         adc    r10,r9                        ; 
         mov    qword ptr [rdi-010h],r12      ; 
         dec    rcx                           ; 
         mulx   r9,r12,qword ptr [rsi]        ; 
         jne    Lm1top                        ; 
Lm1end:  mov    qword ptr [rdi-08h],r10       ; 
         adc    r12,r11                       ; 
         mov    qword ptr [rdi],r12           ; 
         adc    r9,rcx                        ; 
         mov    qword ptr [rdi+08h],r9        ; 
         dec    r8                            ; 
         je     Ldone                         ; 
         mov    r10,offset Latab              ; 
         mov    rax,qword ptr [r10+rax*8]     ; 
Louter:  lea    rsi,[rsi+rbx*8]               ; 
         mov    rcx,rbp                       ; 
         mov    rdx,qword ptr [r14]           ; 
         lea    r14,[r14+08h]                 ; 
         jmp    rax                           ; 
                                              ;
         ALIGN  16                            ;  
Lf0:     mulx   r11,r10,qword ptr [rsi+08h]   ; 
         lea    rdi,[rdi+rbx*8+08h]           ; 
         lea    rcx,[rcx-01h]                 ; 
         jmp    Lb0                           ; 
                                              ;
         ALIGN  16                            ;  
Lf3:     mulx   r9,r12,qword ptr [rsi-010h]   ; 
         lea    rdi,[rdi+rbx*8-038h]          ; 
         jmp    Lb3                           ; 
                                              ;
         ALIGN  16                            ;  
Lf4:     mulx   r11,r10,qword ptr [rsi-018h]  ; 
         lea    rdi,[rdi+rbx*8-038h]          ; 
         jmp    Lb4                           ; 
                                              ;
         ALIGN  16                            ;  
Lf5:     mulx   r9,r12,qword ptr [rsi-020h]   ; 
         lea    rdi,[rdi+rbx*8-038h]          ; 
         jmp    Lb5                           ; 
                                              ;
         ALIGN  16                            ;  
Lf6:     mulx   r11,r10,qword ptr [rsi-028h]  ; 
         lea    rdi,[rdi+rbx*8-038h]          ; 
         jmp    Lb6                           ; 
                                              ;
         ALIGN  16                            ;  
Lf7:     mulx   r9,r12,qword ptr [rsi+010h]   ; 
         lea    rdi,[rdi+rbx*8+08h]           ; 
         jmp    Lb7                           ; 
                                              ;
         ALIGN  16                            ;  
Lf1:     mulx   r9,r12,qword ptr [rsi]        ; 
         lea    rdi,[rdi+rbx*8+08h]           ; 
         jmp    Lb1                           ; 
                                              ;
         ALIGN  16                            ;  
Lam1end: adox   r12,qword ptr [rdi]           ; 
         adox   r9,rcx                        ; 
         mov    qword ptr [rdi],r12           ; 
         adc    r9,rcx                        ; 
         mov    qword ptr [rdi+08h],r9        ; 
         dec    r8                            ; 
         jne    Louter                        ; 
Ldone:   pop    r14                           ; 
         pop    r12                           ; 
         pop    rbp                           ; 
         pop    rbx                           ; 
         pop    rsi                           ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                           ; SysV-to-MSVC ABI (restore rdi)
         ret                                  ; 
                                              ;
         ALIGN  16                            ;  
                                              ;
Lf2:     mulx   r11,r10,qword ptr [rsi-08h]   ; 
         lea    rdi,[rdi+rbx*8+08h]           ; 
         mulx   r9,r12,qword ptr [rsi]        ; 
         ALIGN  16                            ; 
Lam1top: adox   r10,qword ptr [rdi-08h]       ; 
         adcx   r12,r11                       ; 
         mov    qword ptr [rdi-08h],r10       ; 
         jrcxz  Lam1end                       ; 
Lb1:     mulx   r11,r10,qword ptr [rsi+08h]   ; 
         adox   r12,qword ptr [rdi]           ; 
         lea    rcx,[rcx-01h]                 ; 
         mov    qword ptr [rdi],r12           ; 
         adcx   r10,r9                        ; 
Lb0:     mulx   r9,r12,qword ptr [rsi+010h]   ; 
         adcx   r12,r11                       ; 
         adox   r10,qword ptr [rdi+08h]       ; 
         mov    qword ptr [rdi+08h],r10       ; 
Lb7:     mulx   r11,r10,qword ptr [rsi+018h]  ; 
         lea    rsi,[rsi+040h]                ; 
         adcx   r10,r9                        ; 
         adox   r12,qword ptr [rdi+010h]      ; 
         mov    qword ptr [rdi+010h],r12      ; 
Lb6:     mulx   r9,r12,qword ptr [rsi-020h]   ; 
         adox   r10,qword ptr [rdi+018h]      ; 
         adcx   r12,r11                       ; 
         mov    qword ptr [rdi+018h],r10      ; 
Lb5:     mulx   r11,r10,qword ptr [rsi-018h]  ; 
         adcx   r10,r9                        ; 
         adox   r12,qword ptr [rdi+020h]      ; 
         mov    qword ptr [rdi+020h],r12      ; 
Lb4:     mulx   r9,r12,qword ptr [rsi-010h]   ; 
         adox   r10,qword ptr [rdi+028h]      ; 
         adcx   r12,r11                       ; 
         mov    qword ptr [rdi+028h],r10      ; 
Lb3:     adox   r12,qword ptr [rdi+030h]      ; 
         mulx   r11,r10,qword ptr [rsi-08h]   ; 
         mov    qword ptr [rdi+030h],r12      ; 
         lea    rdi,[rdi+040h]                ; 
         adcx   r10,r9                        ; 
         mulx   r9,r12,qword ptr [rsi]        ; 
         jmp    Lam1top                       ; 
                                              ;
         ALIGN  16                            ;
                                              ;
Lmtab:                                        ;
         dq     offset Lmf0                   ;
         dq     offset Lmf1                   ;
         dq     offset Lmf2                   ;
         dq     offset Lmf3                   ;
         dq     offset Lmf4                   ;
         dq     offset Lmf5                   ;
         dq     offset Lmf6                   ;
         dq     offset Lmf7                   ;
                                              ;
Latab:                                        ;
         dq     offset Lf0                    ;
         dq     offset Lf1                    ;
         dq     offset Lf2                    ;
         dq     offset Lf3                    ; 
         dq     offset Lf4                    ;
         dq     offset Lf5                    ;
         dq     offset Lf6                    ;
         dq     offset Lf7                    ;

__gmpn_mul_basecase ENDP

                   END
