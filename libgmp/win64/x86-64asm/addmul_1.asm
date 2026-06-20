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

__gmpn_addmul_1 PROC

         push   rdi                          ; SysV-to-MSVC ABI (save rdi)
         push   rsi                          ; SysV-to-MSVC ABI (save rsi)
                                             ; function parameter #1 in RCX (gcc assumes RDI)
                                             ; function parameter #2 in RDX (gcc assumes RSI)
                                             ; function parameter #3 in R8 (gcc assumes RDX)
                                             ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                      ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                      ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                       ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                       ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r10,rcx                      ; 
         mov    rcx,rdx                      ; 
         mov    r8d,edx                      ; 
         shr    rcx,03h                      ; 
         and    r8d,07h                      ; 
         mov    rdx,r10                      ; 
         mov    r10,offset Ltab              ; 
         jmp    qword ptr [r10+r8*8]         ; 
         ALIGN  16                           ;
Ltab     dq     offset Lf0                   ;
         dq     offset Lf1                   ;
         dq     offset Lf2                   ;
         dq     offset Lf3                   ;
         dq     offset Lf4                   ;
         dq     offset Lf5                   ;
         dq     offset Lf6                   ;
         dq     offset Lf7                   ;
         ALIGN  16                           ;
Lf0:     mulx   r8,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi-08h]                ; 
         lea    rdi,[rdi-08h]                ; 
         lea    rcx,[rcx-01h]                ; 
         jmp    Lb0                          ; 
         ALIGN  16                           ;
Lf3:     mulx   rax,r9,qword ptr [rsi]       ; 
         lea    rsi,[rsi+010h]               ; 
         lea    rdi,[rdi-030h]               ; 
         jmp    Lb3                          ; 
         ALIGN  16                           ;
Lf4:     mulx   r8,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+018h]               ; 
         lea    rdi,[rdi-028h]               ; 
         jmp    Lb4                          ; 
         ALIGN  16                           ;
Lf5:     mulx   rax,r9,qword ptr [rsi]       ; 
         lea    rsi,[rsi+020h]               ; 
         lea    rdi,[rdi-020h]               ; 
         jmp    Lb5                          ; 
         ALIGN  16                           ;
Lf6:     mulx   r8,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+028h]               ; 
         lea    rdi,[rdi-018h]               ; 
         jmp    Lb6                          ; 
         ALIGN  16                           ;
Lf1:     mulx   rax,r9,qword ptr [rsi]       ; 
         jrcxz  L1                           ; 
         jmp    Lb1                          ; 
         ALIGN  16                           ;
L1:      add    r9,qword ptr [rdi]           ; 
         mov    qword ptr [rdi],r9           ; 
         adc    rax,rcx                      ; 
         pop    rsi                          ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                          ; SysV-to-MSVC ABI (restore rdi)
         ret                                 ; 
         ALIGN  16                           ;
Lend:    adox   r9,qword ptr [rdi]           ; 
         mov    qword ptr [rdi],r9           ; 
         adox   rax,rcx                      ; 
         adc    rax,rcx                      ; 
         pop    rsi                          ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                          ; SysV-to-MSVC ABI (restore rdi)
         ret                                 ; 
         ALIGN  16                           ; 
Lf2:     mulx   r8,r10,qword ptr [rsi]       ; 
         lea    rsi,[rsi+08h]                ; 
         lea    rdi,[rdi+08h]                ; 
         mulx   rax,r9,qword ptr [rsi]       ; 
         ALIGN  16                           ;
Ltop:    adox   r10,qword ptr [rdi-08h]      ; 
         adcx   r9,r8                        ; 
         mov    qword ptr [rdi-08h],r10      ; 
         jrcxz  Lend                         ; 
Lb1:     mulx   r8,r10,qword ptr [rsi+08h]   ; 
         adox   r9,qword ptr [rdi]           ; 
         lea    rcx,[rcx-01h]                ; 
         mov    qword ptr [rdi],r9           ; 
         adcx   r10,rax                      ; 
Lb0:     mulx   rax,r9,qword ptr [rsi+010h]  ; 
         adcx   r9,r8                        ; 
         adox   r10,qword ptr [rdi+08h]      ; 
         mov    qword ptr [rdi+08h],r10      ; 
Lb7:     mulx   r8,r10,qword ptr [rsi+018h]  ; 
         lea    rsi,[rsi+040h]               ; 
         adcx   r10,rax                      ; 
         adox   r9,qword ptr [rdi+010h]      ; 
         mov    qword ptr [rdi+010h],r9      ; 
Lb6:     mulx   rax,r9,qword ptr [rsi-020h]  ; 
         adox   r10,qword ptr [rdi+018h]     ; 
         adcx   r9,r8                        ; 
         mov    qword ptr [rdi+018h],r10     ; 
Lb5:     mulx   r8,r10,qword ptr [rsi-018h]  ; 
         adcx   r10,rax                      ; 
         adox   r9,qword ptr [rdi+020h]      ; 
         mov    qword ptr [rdi+020h],r9      ; 
Lb4:     mulx   rax,r9,qword ptr [rsi-010h]  ; 
         adox   r10,qword ptr [rdi+028h]     ; 
         adcx   r9,r8                        ; 
         mov    qword ptr [rdi+028h],r10     ; 
Lb3:     adox   r9,qword ptr [rdi+030h]      ; 
         mulx   r8,r10,qword ptr [rsi-08h]   ; 
         mov    qword ptr [rdi+030h],r9      ; 
         lea    rdi,[rdi+040h]               ; 
         adcx   r10,rax                      ; 
         mulx   rax,r9,qword ptr [rsi]       ; 
         jmp    Ltop                         ; 
Lf7:     mulx   rax,r9,qword ptr [rsi]       ; 
         lea    rsi,[rsi-010h]               ; 
         lea    rdi,[rdi-010h]               ; 
         jmp    Lb7                          ; 

__gmpn_addmul_1 ENDP

               END
