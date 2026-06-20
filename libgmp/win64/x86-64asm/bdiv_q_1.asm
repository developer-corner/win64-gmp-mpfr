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

                EXTERN __gmp_binvert_limb_table : BYTE

                ALIGN 16

__gmpn_bdiv_q_1 PROC

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
         push   rbx                                 ; 
         mov    rax,rcx                             ; 
         xor    ecx,ecx                             ; 
         mov    r10,rdx                             ; 
         bt     eax,00h                             ; 
         jae    l_004C                              ; 
         ALIGN  16                                  ;
l_000F:  mov    rbx,rax                             ; 
         shr    eax,1                               ; 
         and    eax,07fh                            ; 
         mov    rdx,offset __gmp_binvert_limb_table ; 
         movzx  eax,byte ptr [rdx+rax*1]            ; 
         mov    r11,rbx                             ; 
         lea    edx,[rax+rax*1]                     ; 
         imul   eax,eax                             ; 
         imul   eax,ebx                             ; 
         sub    edx,eax                             ; 
         lea    eax,[rdx+rdx*1]                     ; 
         imul   edx,edx                             ; 
         imul   edx,ebx                             ; 
         sub    eax,edx                             ; 
         lea    r8,[rax+rax*1]                      ; 
         imul   rax,rax                             ; 
         imul   rax,rbx                             ; 
         sub    r8,rax                              ; 
         jmp    l_005F                              ; 
         ALIGN  16                                  ;
l_004C:  bsf    rcx,rax                             ; 
         shr    rax,cl                              ; 
         jmp    l_000F                              ; 
         push   rbx                                 ; 
         mov    r11,rcx                             ; 
         mov    r10,rdx                             ; 
         mov    rcx,r9                              ; 
l_005F:  mov    rax,qword ptr [rsi]                 ; 
         dec    r10                                 ; 
         je     l_0103                              ; 
         lea    rsi,[rsi+r10*8+08h]                 ; 
         lea    rdi,[rdi+r10*8]                     ; 
         neg    r10                                 ; 
         test   ecx,ecx                             ; 
         jne    l_00A7                              ; 
         xor    ebx,ebx                             ; 
         jmp    l_0094                              ; 
         ALIGN  16                                  ; 
l_0080:  mul    r11                                 ; 
         mov    rax,qword ptr [rsi+r10*8-08h]       ; 
         sub    rax,rbx                             ; 
         setb   bl                                  ; 
         sub    rax,rdx                             ; 
         adc    ebx,00h                             ; 
l_0094:  imul   rax,r8                              ; 
         mov    qword ptr [rdi+r10*8],rax           ; 
         inc    r10                                 ; 
         jne    l_0080                              ; 
         mov    r9,qword ptr [rsi-08h]              ; 
         jmp    l_00F1                              ; 
l_00A7:  mov    r9,qword ptr [rsi+r10*8]            ; 
         shr    rax,cl                              ; 
         neg    ecx                                 ; 
         shl    r9,cl                               ; 
         neg    ecx                                 ; 
         or     rax,r9                              ; 
         xor    ebx,ebx                             ; 
         jmp    l_00DB                              ; 
         ALIGN  16                                  ; 
l_00C0:  mul    r11                                 ; 
         mov    rax,qword ptr [rsi+r10*8]           ; 
         shl    rax,cl                              ; 
         neg    ecx                                 ; 
         or     rax,r9                              ; 
         sub    rax,rbx                             ; 
         setb   bl                                  ; 
         sub    rax,rdx                             ; 
         adc    ebx,00h                             ; 
l_00DB:  imul   rax,r8                              ; 
         mov    r9,qword ptr [rsi+r10*8]            ; 
         shr    r9,cl                               ; 
         neg    ecx                                 ; 
         mov    qword ptr [rdi+r10*8],rax           ; 
         inc    r10                                 ; 
         jne    l_00C0                              ; 
l_00F1:  mul    r11                                 ; 
         sub    r9,rbx                              ; 
         sub    r9,rdx                              ; 
         imul   r9,r8                               ; 
         mov    qword ptr [rdi],r9                  ; 
         pop    rbx                                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ;
l_0103:  shr    rax,cl                              ; 
         imul   rax,r8                              ; 
         mov    qword ptr [rdi],rax                 ; 
         pop    rbx                                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 

__gmpn_bdiv_q_1 ENDP

         ALIGN  16

__gmpn_pi1_bdiv_q_1 PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                               ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    r9,qword ptr [rsp+040h]        ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
         push   rbx                            ; 
         mov    r11,rcx                        ; 
         mov    r10,rdx                        ; 
         mov    rcx,r9                         ; 
         mov    rax,qword ptr [rsi]            ; 
         dec    r10                            ; 
         je     l_0103                         ; 
         lea    rsi,[rsi+r10*8+08h]            ; 
         lea    rdi,[rdi+r10*8]                ; 
         neg    r10                            ; 
         test   ecx,ecx                        ; 
         jne    l_00A7                         ; 
         xor    ebx,ebx                        ; 
         jmp    l_0094                         ; 
         ALIGN  16                             ; 
l_0080:  mul    r11                            ; 
         mov    rax,qword ptr [rsi+r10*8-08h]  ; 
         sub    rax,rbx                        ; 
         setb   bl                             ; 
         sub    rax,rdx                        ; 
         adc    ebx,00h                        ; 
l_0094:  imul   rax,r8                         ; 
         mov    qword ptr [rdi+r10*8],rax      ; 
         inc    r10                            ; 
         jne    l_0080                         ; 
         mov    r9,qword ptr [rsi-08h]         ; 
         jmp    l_00F1                         ; 
         ALIGN  16                             ;
l_00A7:  mov    r9,qword ptr [rsi+r10*8]       ; 
         shr    rax,cl                         ; 
         neg    ecx                            ; 
         shl    r9,cl                          ; 
         neg    ecx                            ; 
         or     rax,r9                         ; 
         xor    ebx,ebx                        ; 
         jmp    l_00DB                         ; 
         ALIGN  16                             ; 
l_00C0:  mul    r11                            ; 
         mov    rax,qword ptr [rsi+r10*8]      ; 
         shl    rax,cl                         ; 
         neg    ecx                            ; 
         or     rax,r9                         ; 
         sub    rax,rbx                        ; 
         setb   bl                             ; 
         sub    rax,rdx                        ; 
         adc    ebx,00h                        ; 
l_00DB:  imul   rax,r8                         ; 
         mov    r9,qword ptr [rsi+r10*8]       ; 
         shr    r9,cl                          ; 
         neg    ecx                            ; 
         mov    qword ptr [rdi+r10*8],rax      ; 
         inc    r10                            ; 
         jne    l_00C0                         ; 
l_00F1:  mul    r11                            ; 
         sub    r9,rbx                         ; 
         sub    r9,rdx                         ; 
         imul   r9,r8                          ; 
         mov    qword ptr [rdi],r9             ; 
         pop    rbx                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 
         ALIGN  16                             ;
l_0103:  shr    rax,cl                         ; 
         imul   rax,r8                         ; 
         mov    qword ptr [rdi],rax            ; 
         pop    rbx                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_pi1_bdiv_q_1 ENDP

               END
