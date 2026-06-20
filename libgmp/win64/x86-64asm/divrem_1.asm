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

                EXTERN  __gmpn_invert_limb_sysv_abi : PROC

                ALIGN 16

__gmpn_divrem_1 PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x28] (gcc assumes R8)
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         xor    eax,eax                        ; 
         push   r13                            ; 
         push   r12                            ; 
         push   rbp                            ; 
         push   rbx                            ; 
         mov    r12,rsi                        ; 
         mov    rbx,rcx                        ; 
         add    rcx,rsi                        ; 
         mov    rsi,rdx                        ; 
         je     l_0244                         ; 
         lea    rdi,[rdi+rcx*8-08h]            ; 
         xor    ebp,ebp                        ; 
         test   r8,r8                          ; 
         jns    l_00EF                         ; 
         test   rbx,rbx                        ; 
         je     l_007C                         ; 
         mov    rbp,qword ptr [rsi+rbx*8-08h]  ; 
         dec    rbx                            ; 
         mov    rax,rbp                        ; 
         sub    rbp,r8                         ; 
         cmovb  rbp,rax                        ; 
         sbb    eax,eax                        ; 
         inc    eax                            ; 
         mov    qword ptr [rdi],rax            ; 
         lea    rdi,[rdi-08h]                  ; 
l_007C:  push   rdi                            ; 
         push   rsi                            ; 
         push   r8                             ; 
         mov    rdi,r8                         ; 
         call   __gmpn_invert_limb_sysv_abi    ; 
         pop    r8                             ; 
         pop    rsi                            ; 
         pop    rdi                            ; 
         mov    r9,rax                         ; 
         mov    rax,rbp                        ; 
         jmp    l_00D7                         ; 
         ALIGN  16                             ; 
l_00A0:  mov    r10,qword ptr [rsi+rbx*8]      ; 
         mul    r9                             ; 
         add    rax,r10                        ; 
         adc    rdx,rbp                        ; 
         mov    rbp,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    r10,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,r10                        ; 
         cmp    r10,rbp                        ; 
         cmovb  rax,r10                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_00E7                         ; 
         ALIGN  16                             ;
l_00D0:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_00D7:  lea    rbp,[rax+01h]                  ; 
         dec    rbx                            ; 
         jns    l_00A0                         ; 
         xor    ecx,ecx                        ; 
         jmp    l_01F9                         ; 
         ALIGN  16                             ;
l_00E7:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_00D0                         ; 
         ALIGN  16                             ;
l_00EF:  test   rbx,rbx                        ; 
         je     l_0111                         ; 
         mov    rax,qword ptr [rsi+rbx*8-08h]  ; 
         cmp    rax,r8                         ; 
         jae    l_0111                         ; 
         mov    qword ptr [rdi],rbp            ; 
         mov    rbp,rax                        ; 
         lea    rdi,[rdi-08h]                  ; 
         je     l_0244                         ; 
         dec    rbx                            ; 
l_0111:  bsr    rcx,r8                         ; 
         not    ecx                            ; 
         shl    r8,cl                          ; 
         shl    rbp,cl                         ; 
         push   rcx                            ; 
         push   rdi                            ; 
         push   rsi                            ; 
         push   r8                             ; 
;         sub    rsp,08h                        ; 
         mov    rdi,r8                         ; 
         call   __gmpn_invert_limb_sysv_abi    ; 
;         add    rsp,08h                        ; 
         pop    r8                             ; 
         pop    rsi                            ; 
         pop    rdi                            ; 
         pop    rcx                            ; 
         mov    r9,rax                         ; 
         mov    rax,rbp                        ; 
         test   rbx,rbx                        ; 
         je     l_01F9                         ; 
         dec    rbx                            ; 
         mov    rbp,qword ptr [rsi+rbx*8]      ; 
         neg    ecx                            ; 
         shr    rbp,cl                         ; 
         neg    ecx                            ; 
         or     rax,rbp                        ; 
         jmp    l_01A4                         ; 
         ALIGN  16                             ; 
l_0160:  mov    r10,qword ptr [rsi+rbx*8]      ; 
         shl    rbp,cl                         ; 
         neg    ecx                            ; 
         shr    r10,cl                         ; 
         neg    ecx                            ; 
         or     rbp,r10                        ; 
         mul    r9                             ; 
         add    rax,rbp                        ; 
         adc    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    rbp,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,rbp                        ; 
         cmp    rbp,r11                        ; 
         cmovb  rax,rbp                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_01E9                         ; 
l_019D:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_01A4:  mov    rbp,qword ptr [rsi+rbx*8]      ; 
         dec    rbx                            ; 
         lea    r11,[rax+01h]                  ; 
         jns    l_0160                         ; 
         shl    rbp,cl                         ; 
         mul    r9                             ; 
         add    rax,rbp                        ; 
         adc    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    rbp,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,rbp                        ; 
         cmp    rbp,r11                        ; 
         cmovb  rax,rbp                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_01F1                         ; 
l_01E0:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
         jmp    l_01F9                         ; 
         ALIGN  16                             ;
l_01E9:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_019D                         ; 
         ALIGN  16                             ;
l_01F1:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_01E0                         ; 
         ALIGN  16                             ;
l_01F9:  mov    rbp,r8                         ; 
         neg    rbp                            ; 
         jmp    l_0238                         ; 
         ALIGN  16                             ; 
l_0210:  mul    r9                             ; 
         add    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,rbp                        ; 
         mov    rax,r8                         ; 
         add    rax,rdx                        ; 
         cmp    rdx,r11                        ; 
         cmovb  rax,rdx                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_0238:  lea    r11,[rax+01h]                  ; 
         dec    r12                            ; 
         jns    l_0210                         ; 
         shr    rax,cl                         ; 
l_0244:  pop    rbx                            ; 
         pop    rbp                            ; 
         pop    r12                            ; 
         pop    r13                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_divrem_1 ENDP

                       ALIGN 16

__gmpn_preinv_divrem_1 PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
                                               ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                               ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                               ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,qword ptr [rsp+038h]        ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
         mov    r9,qword ptr [rsp+040h]        ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
                                               ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
         xor    eax,eax                        ; 
         push   r13                            ; 
         push   r12                            ; 
         push   rbp                            ; 
         push   rbx                            ; 
         mov    r12,rsi                        ; 
         mov    rbx,rcx                        ; 
         add    rcx,rsi                        ; 
         mov    rsi,rdx                        ; 
         lea    rdi,[rdi+rcx*8-08h]            ; 
         test   r8,r8                          ; 
         js     l_00D7                         ; 
         mov    cl,byte ptr [rsp+068h]         ; 
         shl    r8,cl                          ; 
         jmp    l_0146                         ; 
         xchg   ax,ax                          ; 
         xor    eax,eax                        ; 
         push   r13                            ; 
         push   r12                            ; 
         push   rbp                            ; 
         push   rbx                            ; 
         mov    r12,rsi                        ; 
         mov    rbx,rcx                        ; 
         add    rcx,rsi                        ; 
         mov    rsi,rdx                        ; 
         je     l_0244                         ; 
         lea    rdi,[rdi+rcx*8-08h]            ; 
         xor    ebp,ebp                        ; 
         test   r8,r8                          ; 
         jns    l_00EF                         ; 
         test   rbx,rbx                        ; 
         je     l_007C                         ; 
         mov    rbp,qword ptr [rsi+rbx*8-08h]  ; 
         dec    rbx                            ; 
         mov    rax,rbp                        ; 
         sub    rbp,r8                         ; 
         cmovb  rbp,rax                        ; 
         sbb    eax,eax                        ; 
         inc    eax                            ; 
         mov    qword ptr [rdi],rax            ; 
         lea    rdi,[rdi-08h]                  ; 
l_007C:  push   rdi                            ; 
         push   rsi                            ; 
         push   r8                             ; 
         mov    rdi,r8                         ; 
         call   __gmpn_invert_limb_sysv_abi    ; 
         pop    r8                             ; 
         pop    rsi                            ; 
         pop    rdi                            ; 
         mov    r9,rax                         ; 
         mov    rax,rbp                        ; 
         jmp    l_00D7                         ; 
         ALIGN  16                             ; 
l_00A0:  mov    r10,qword ptr [rsi+rbx*8]      ; 
         mul    r9                             ; 
         add    rax,r10                        ; 
         adc    rdx,rbp                        ; 
         mov    rbp,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    r10,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,r10                        ; 
         cmp    r10,rbp                        ; 
         cmovb  rax,r10                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_00E7                         ; 
         ALIGN  16                             ;
l_00D0:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_00D7:  lea    rbp,[rax+01h]                  ; 
         dec    rbx                            ; 
         jns    l_00A0                         ; 
         xor    ecx,ecx                        ; 
         jmp    l_01F9                         ; 
         ALIGN  16                             ;
l_00E7:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_00D0                         ; 
         ALIGN  16                             ;
l_00EF:  test   rbx,rbx                        ; 
         je     l_0111                         ; 
         mov    rax,qword ptr [rsi+rbx*8-08h]  ; 
         cmp    rax,r8                         ; 
         jae    l_0111                         ; 
         mov    qword ptr [rdi],rbp            ; 
         mov    rbp,rax                        ; 
         lea    rdi,[rdi-08h]                  ; 
         je     l_0244                         ; 
         dec    rbx                            ; 
l_0111:  bsr    rcx,r8                         ; 
         not    ecx                            ; 
         shl    r8,cl                          ; 
         shl    rbp,cl                         ; 
         push   rcx                            ; 
         push   rdi                            ; 
         push   rsi                            ; 
         push   r8                             ; 
;         sub    rsp,08h                        ; 
         mov    rdi,r8                         ; 
         call   __gmpn_invert_limb_sysv_abi    ; 
;         add    rsp,08h                        ; 
         pop    r8                             ; 
         pop    rsi                            ; 
         pop    rdi                            ; 
         pop    rcx                            ; 
         mov    r9,rax                         ; 
         mov    rax,rbp                        ; 
         test   rbx,rbx                        ; 
         je     l_01F9                         ; 
l_0146:  dec    rbx                            ; 
         mov    rbp,qword ptr [rsi+rbx*8]      ; 
         neg    ecx                            ; 
         shr    rbp,cl                         ; 
         neg    ecx                            ; 
         or     rax,rbp                        ; 
         jmp    l_01A4                         ; 
         ALIGN  16                             ; 
l_0160:  mov    r10,qword ptr [rsi+rbx*8]      ; 
         shl    rbp,cl                         ; 
         neg    ecx                            ; 
         shr    r10,cl                         ; 
         neg    ecx                            ; 
         or     rbp,r10                        ; 
         mul    r9                             ; 
         add    rax,rbp                        ; 
         adc    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    rbp,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,rbp                        ; 
         cmp    rbp,r11                        ; 
         cmovb  rax,rbp                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_01E9                         ; 
l_019D:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_01A4:  mov    rbp,qword ptr [rsi+rbx*8]      ; 
         dec    rbx                            ; 
         lea    r11,[rax+01h]                  ; 
         jns    l_0160                         ; 
         shl    rbp,cl                         ; 
         mul    r9                             ; 
         add    rax,rbp                        ; 
         adc    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,r8                         ; 
         sub    rbp,rdx                        ; 
         mov    rax,r8                         ; 
         add    rax,rbp                        ; 
         cmp    rbp,r11                        ; 
         cmovb  rax,rbp                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         cmp    rax,r8                         ; 
         jae    l_01F1                         ; 
l_01E0:  mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
         jmp    l_01F9                         ; 
         ALIGN  16                             ;
l_01E9:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_019D                         ; 
         ALIGN  16                             ;
l_01F1:  sub    rax,r8                         ; 
         inc    r13                            ; 
         jmp    l_01E0                         ; 
         ALIGN  16                             ;
l_01F9:  mov    rbp,r8                         ; 
         neg    rbp                            ; 
         jmp    l_0238                         ; 
         ALIGN  16                             ; 
l_0210:  mul    r9                             ; 
         add    rdx,r11                        ; 
         mov    r11,rax                        ; 
         mov    r13,rdx                        ; 
         imul   rdx,rbp                        ; 
         mov    rax,r8                         ; 
         add    rax,rdx                        ; 
         cmp    rdx,r11                        ; 
         cmovb  rax,rdx                        ; 
         adc    r13,0ffffffffffffffffh         ; 
         mov    qword ptr [rdi],r13            ; 
         sub    rdi,08h                        ; 
l_0238:  lea    r11,[rax+01h]                  ; 
         dec    r12                            ; 
         jns    l_0210                         ; 
         shr    rax,cl                         ; 
l_0244:  pop    rbx                            ; 
         pop    rbp                            ; 
         pop    r12                            ; 
         pop    r13                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_preinv_divrem_1 ENDP

                      END
