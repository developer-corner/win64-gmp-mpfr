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

                 EXTERN __gmpn_invert_limb_sysv_abi : PROC

                 ALIGN 16

__gmpn_mod_1s_4p PROC

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
         push   r15                       ; 
         push   r14                       ; 
         push   r13                       ; 
         push   r12                       ; 
         push   rbp                       ; 
         push   rbx                       ; 
         mov    r15,rdx                   ; 
         mov    r14,rcx                   ; 
         mov    r11,qword ptr [rcx+010h]  ; 
         mov    rbx,qword ptr [rcx+018h]  ; 
         mov    rbp,qword ptr [rcx+020h]  ; 
         mov    r13,qword ptr [rcx+028h]  ; 
         mov    r12,qword ptr [rcx+030h]  ; 
         xor    r8d,r8d                   ; 
         mov    edx,esi                   ; 
         and    edx,03h                   ; 
         je     l_0058                    ; 
         cmp    edx,02h                   ; 
         jb     l_0088                    ; 
         je     l_0098                    ; 
         lea    rdi,[rdi+rsi*8-018h]      ; 
         mov    rax,qword ptr [rdi+08h]   ; 
         mul    r11                       ; 
         mov    r9,qword ptr [rdi]        ; 
         add    r9,rax                    ; 
         adc    r8,rdx                    ; 
         mov    rax,qword ptr [rdi+010h]  ; 
         mul    rbx                       ; 
         jmp    l_00FC                    ; 
         ALIGN  16                        ;
l_0058:  lea    rdi,[rdi+rsi*8-020h]      ; 
         mov    rax,qword ptr [rdi+08h]   ; 
         mul    r11                       ; 
         mov    r9,qword ptr [rdi]        ; 
         add    r9,rax                    ; 
         adc    r8,rdx                    ; 
         mov    rax,qword ptr [rdi+010h]  ; 
         mul    rbx                       ; 
         add    r9,rax                    ; 
         adc    r8,rdx                    ; 
         mov    rax,qword ptr [rdi+018h]  ; 
         mul    rbp                       ; 
         jmp    l_00FC                    ; 
         ALIGN  16                        ; 
l_0088:  lea    rdi,[rdi+rsi*8-08h]       ; 
         mov    r9,qword ptr [rdi]        ; 
         jmp    l_0102                    ; 
         ALIGN  16                        ; 
l_0098:  lea    rdi,[rdi+rsi*8-010h]      ; 
         mov    r8,qword ptr [rdi+08h]    ; 
         mov    r9,qword ptr [rdi]        ; 
         jmp    l_0102                    ; 
         ALIGN  16                        ; 
l_00B0:  mov    rax,qword ptr [rdi-018h]  ; 
         mov    r10,qword ptr [rdi-020h]  ; 
         mul    r11                       ; 
         add    r10,rax                   ; 
         mov    rax,qword ptr [rdi-010h]  ; 
         mov    ecx,00h                   ; 
         adc    rcx,rdx                   ; 
         mul    rbx                       ; 
         add    r10,rax                   ; 
         mov    rax,qword ptr [rdi-08h]   ; 
         adc    rcx,rdx                   ; 
         sub    rdi,020h                  ; 
         mul    rbp                       ; 
         add    r10,rax                   ; 
         mov    rax,r13                   ; 
         adc    rcx,rdx                   ; 
         mul    r9                        ; 
         add    r10,rax                   ; 
         mov    rax,r12                   ; 
         adc    rcx,rdx                   ; 
         mul    r8                        ; 
         mov    r9,r10                    ; 
         mov    r8,rcx                    ; 
l_00FC:  add    r9,rax                    ; 
         adc    r8,rdx                    ; 
l_0102:  sub    rsi,04h                   ; 
         ja     l_00B0                    ; 
         mov    esi,dword ptr [r14+08h]   ; 
         mov    rax,r8                    ; 
         mul    r11                       ; 
         mov    r8,rax                    ; 
         add    r8,r9                     ; 
         adc    rdx,00h                   ; 
         xor    ecx,ecx                   ; 
         sub    ecx,esi                   ; 
         mov    rdi,r8                    ; 
         shr    rdi,cl                    ; 
         mov    ecx,esi                   ; 
         shl    rdx,cl                    ; 
         or     rdi,rdx                   ; 
         mov    rax,rdi                   ; 
         mul    qword ptr [r14]           ; 
         mov    rbx,r15                   ; 
         mov    r9,rax                    ; 
         shl    r8,cl                     ; 
         inc    rdi                       ; 
         add    r9,r8                     ; 
         adc    rdx,rdi                   ; 
         imul   rdx,rbx                   ; 
         sub    r8,rdx                    ; 
         lea    rax,[r8+rbx*1]            ; 
         cmp    r9,r8                     ; 
         cmovb  r8,rax                    ; 
         mov    rax,r8                    ; 
         sub    rax,rbx                   ; 
         cmovb  rax,r8                    ; 
         shr    rax,cl                    ; 
         pop    rbx                       ; 
         pop    rbp                       ; 
         pop    r12                       ; 
         pop    r13                       ; 
         pop    r14                       ; 
         pop    r15                       ; 
         pop    rsi                       ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                       ; SysV-to-MSVC ABI (restore rdi)
         ret                              ; 

__gmpn_mod_1s_4p ENDP

                     ALIGN 16

__gmpn_mod_1s_4p_cps PROC

  push    rdi                         ; SysV-to-MSVC ABI (save rdi)
  push    rsi                         ; SysV-to-MSVC ABI (save rsi)
                                      ; function parameter #1 in RCX (gcc assumes RDI)
                                      ; function parameter #2 in RDX (gcc assumes RSI)
                                      ; function parameter #3 in R8 (gcc assumes RDX)
                                      ; function parameter #4 in R9 (gcc assumes RCX)
  mov     rdi,rcx                     ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
  mov     rsi,rdx                     ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
  mov     rdx,r8                      ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
  mov     rcx,r9                      ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
  push    rbp                         ; 
  bsr     rcx,rsi                     ; 
  push    rbx                         ; 
  mov     rbx,rdi                     ; 
  push    r12                         ; 
  xor     ecx,03fh                    ; 
  mov     r12,rsi                     ; 
  mov     ebp,ecx                     ; 
  shl     r12,cl                      ; 
  mov     rdi,r12                     ; 
  call    __gmpn_invert_limb_sysv_abi ; SPECIAL: call SysV ABI version of this function here!!!
  mov     r8,r12                      ; 
  mov     r11,rax                     ; 
  mov     qword ptr [rbx],rax         ; 
  mov     qword ptr [rbx+08h],rbp     ; 
  neg     r8                          ; 
  mov     ecx,ebp                     ; 
  mov     esi,01h                     ; 
  shld    rsi,rax,cl                  ; 
  imul    rsi,r8                      ; 
  mul     rsi                         ; 
  add     rdx,rsi                     ; 
  shr     rsi,cl                      ; 
  mov     qword ptr [rbx+010h],rsi    ; 
  not     rdx                         ; 
  imul    rdx,r12                     ; 
  lea     rsi,[rdx+r12*1]             ; 
  cmp     rax,rdx                     ; 
  cmovae  rsi,rdx                     ; 
  mov     rax,r11                     ; 
  mul     rsi                         ; 
  add     rdx,rsi                     ; 
  shr     rsi,cl                      ; 
  mov     qword ptr [rbx+018h],rsi    ; 
  not     rdx                         ; 
  imul    rdx,r12                     ; 
  lea     rsi,[rdx+r12*1]             ; 
  cmp     rax,rdx                     ; 
  cmovae  rsi,rdx                     ; 
  mov     rax,r11                     ; 
  mul     rsi                         ; 
  add     rdx,rsi                     ; 
  shr     rsi,cl                      ; 
  mov     qword ptr [rbx+020h],rsi    ; 
  not     rdx                         ; 
  imul    rdx,r12                     ; 
  lea     rsi,[rdx+r12*1]             ; 
  cmp     rax,rdx                     ; 
  cmovae  rsi,rdx                     ; 
  mov     rax,r11                     ; 
  mul     rsi                         ; 
  add     rdx,rsi                     ; 
  shr     rsi,cl                      ; 
  mov     qword ptr [rbx+028h],rsi    ; 
  not     rdx                         ; 
  imul    rdx,r12                     ; 
  add     r12,rdx                     ; 
  cmp     rax,rdx                     ; 
  cmovae  r12,rdx                     ; 
  shr     r12,cl                      ; 
  mov     qword ptr [rbx+030h],r12    ; 
  pop     r12                         ; 
  pop     rbx                         ; 
  pop     rbp                         ; 
  pop     rsi                         ; SysV-to-MSVC ABI (restore rsi)
  pop     rdi                         ; SysV-to-MSVC ABI (restore rdi)
  ret                                 ; 

__gmpn_mod_1s_4p_cps ENDP

                END
