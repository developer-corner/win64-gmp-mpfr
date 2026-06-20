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

__gmpn_addlsh_n PROC
                                          ; #1 = mp_ptr rp, #2 = mp_srcptr up, #3 = mp_srcptr vp, #4 = mp_size_t n, #5 = unsigned int s
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
         mov    r8d,dword ptr [rsp+038h]  ; SysV-to-MSVC ABI (parameter #5 from stack to r8) - always 32bit because this is 'unsigned int'
         mov    r10,qword ptr [rdx]       ; 
         mov    eax,ecx                   ; 
         shr    rcx,03h                   ; 
         xor    r9d,r9d                   ; 
         sub    r9,r8                     ; 
         and    eax,07h                   ; 
         mov    r11,offset Ltab           ; lea	.Ltab(%rip), %r11
         jmp    qword ptr [r11+rax*8]     ; 
         ALIGN  16                        ;
L0:      lea    rsi,[rsi+020h]            ; 
         lea    rdx,[rdx+020h]            ; 
         lea    rdi,[rdi+020h]            ; 
         xor    r11d,r11d                 ; 
         jmp    Le0                       ; 
         ALIGN  16                        ;
L7:      mov    r11,r10                   ; 
         lea    rsi,[rsi+018h]            ; 
         lea    rdx,[rdx+018h]            ; 
         lea    rdi,[rdi+018h]            ; 
         xor    r10d,r10d                 ; 
         jmp    Le7                       ; 
         ALIGN  16                        ;
L6:      lea    rsi,[rsi+010h]            ; 
         lea    rdx,[rdx+010h]            ; 
         lea    rdi,[rdi+010h]            ; 
         xor    r11d,r11d                 ; 
         jmp    Le6                       ; 
         ALIGN  16                        ;
L5:      mov    r11,r10                   ; 
         lea    rsi,[rsi+08h]             ; 
         lea    rdx,[rdx+08h]             ; 
         lea    rdi,[rdi+08h]             ; 
         xor    r10d,r10d                 ; 
         jmp    Le5                       ; 
         ALIGN  16                        ;
Lend:    adc    rax,qword ptr [rsi+018h]  ; 
         mov    qword ptr [rdi-028h],rax  ; 
         shrx   rax,r11,r9                ; 
         adc    rax,rcx                   ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 
         ALIGN  16                        ; 
Ltop:    jrcxz  Lend                      ; 
         mov    r10,qword ptr [rdx-020h]  ; 
         adc    rax,qword ptr [rsi+018h]  ; 
         lea    rsi,[rsi+040h]            ; 
         shrx   r11,r11,r9                ; 
         mov    qword ptr [rdi-028h],rax  ; 
Le0:     dec    rcx                       ; 
         shlx   rax,r10,r8                ; 
         lea    rax,[r11+rax*1]           ; 
         mov    r11,qword ptr [rdx-018h]  ; 
         adc    rax,qword ptr [rsi-020h]  ; 
         shrx   r10,r10,r9                ; 
         mov    qword ptr [rdi-020h],rax  ; 
Le7:     shlx   rax,r11,r8                ; 
         lea    rax,[r10+rax*1]           ; 
         mov    r10,qword ptr [rdx-010h]  ; 
         adc    rax,qword ptr [rsi-018h]  ; 
         shrx   r11,r11,r9                ; 
         mov    qword ptr [rdi-018h],rax  ; 
Le6:     shlx   rax,r10,r8                ; 
         lea    rax,[r11+rax*1]           ; 
         mov    r11,qword ptr [rdx-08h]   ; 
         adc    rax,qword ptr [rsi-010h]  ; 
         shrx   r10,r10,r9                ; 
         mov    qword ptr [rdi-010h],rax  ; 
Le5:     shlx   rax,r11,r8                ; 
         lea    rax,[r10+rax*1]           ; 
         mov    r10,qword ptr [rdx]       ; 
         adc    rax,qword ptr [rsi-08h]   ; 
         shrx   r11,r11,r9                ; 
         mov    qword ptr [rdi-08h],rax   ; 
Le4:     shlx   rax,r10,r8                ; 
         lea    rax,[r11+rax*1]           ; 
         mov    r11,qword ptr [rdx+08h]   ; 
         adc    rax,qword ptr [rsi]       ; 
         shrx   r10,r10,r9                ; 
         mov    qword ptr [rdi],rax       ; 
Le3:     shlx   rax,r11,r8                ; 
         lea    rax,[r10+rax*1]           ; 
         mov    r10,qword ptr [rdx+010h]  ; 
         adc    rax,qword ptr [rsi+08h]   ; 
         shrx   r11,r11,r9                ; 
         mov    qword ptr [rdi+08h],rax   ; 
Le2:     shlx   rax,r10,r8                ; 
         lea    rax,[r11+rax*1]           ; 
         mov    r11,qword ptr [rdx+018h]  ; 
         adc    rax,qword ptr [rsi+010h]  ; 
         lea    rdx,[rdx+040h]            ; 
         shrx   r10,r10,r9                ; 
         mov    qword ptr [rdi+010h],rax  ; 
         lea    rdi,[rdi+040h]            ; 
Le1:     shlx   rax,r11,r8                ; 
         lea    rax,[r10+rax*1]           ; 
         jmp    Ltop                      ; 
         ALIGN  16                        ;
L4:      xor    r11d,r11d                 ; 
         jmp    Le4                       ; 
         ALIGN  16                        ;
L3:      mov    r11,r10                   ; 
         lea    rsi,[rsi-08h]             ; 
         lea    rdx,[rdx-08h]             ; 
         lea    rdi,[rdi-08h]             ; 
         xor    r10d,r10d                 ; 
         jmp    Le3                       ; 
         ALIGN  16                        ;
L2:      lea    rsi,[rsi-010h]            ; 
         lea    rdx,[rdx-010h]            ; 
         lea    rdi,[rdi-010h]            ; 
         xor    r11d,r11d                 ; 
         jmp    Le2                       ; 
         ALIGN  16                        ;
L1:      mov    r11,r10                   ; 
         lea    rsi,[rsi-018h]            ; 
         lea    rdx,[rdx+028h]            ; 
         lea    rdi,[rdi+028h]            ; 
         xor    r10d,r10d                 ; 
         jmp    Le1                       ; 

         ALIGN  16

Ltab:
         dq     offset L0
         dq     offset L1
         dq     offset L2
         dq     offset L3
         dq     offset L4
         dq     offset L5
         dq     offset L6
         dq     offset L7

__gmpn_addlsh_n ENDP

               END
