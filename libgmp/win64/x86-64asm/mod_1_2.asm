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

__gmpn_mod_1s_2p PROC

         push   rdi                            ; SysV-to-MSVC ABI (save rdi)
         push   rsi                            ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         push   r14                            ; 
         test   sil,01h                        ; 
         mov    r14,rdx                        ; 
         push   r13                            ; 
         mov    r13,rcx                        ; 
         push   r12                            ; 
         push   rbp                            ; 
         push   rbx                            ; 
         mov    r10,qword ptr [rcx+010h]       ; 
         mov    rbx,qword ptr [rcx+018h]       ; 
         mov    rbp,qword ptr [rcx+020h]       ; 
         je     l_004F                         ; 
         dec    rsi                            ; 
         je     l_015C                         ; 
         mov    rax,qword ptr [rdi+rsi*8-08h]  ; 
         mul    r10                            ; 
         mov    r9,rax                         ; 
         mov    r8,rdx                         ; 
         mov    rax,qword ptr [rdi+rsi*8]      ; 
         add    r9,qword ptr [rdi+rsi*8-010h]  ; 
         adc    r8,00h                         ; 
         mul    rbx                            ; 
         add    r9,rax                         ; 
         adc    r8,rdx                         ; 
         jmp    l_0059                         ; 
         ALIGN  16                             ;
l_004F:  mov    r8,qword ptr [rdi+rsi*8-08h]   ; 
         mov    r9,qword ptr [rdi+rsi*8-010h]  ; 
l_0059:  sub    rsi,04h                        ; 
         jb     l_00F6                         ; 
         lea    rdi,[rdi+rsi*8+028h]           ; 
         mov    r11,qword ptr [rdi-028h]       ; 
         mov    rax,qword ptr [rdi-020h]       ; 
         jmp    l_00C1                         ; 
         ALIGN  16                             ; 
l_0080:  mov    r9,qword ptr [rdi-018h]        ; 
         add    r11,rax                        ; 
         mov    rax,qword ptr [rdi-010h]       ; 
         adc    r12,rdx                        ; 
         mul    r10                            ; 
         add    r9,rax                         ; 
         mov    rax,r11                        ; 
         mov    r8,rdx                         ; 
         adc    r8,00h                         ; 
         mul    rbx                            ; 
         add    r9,rax                         ; 
         mov    rax,r12                        ; 
         adc    r8,rdx                         ; 
         mul    rbp                            ; 
         sub    rsi,02h                        ; 
         jb     l_00F0                         ; 
         mov    r11,qword ptr [rdi-028h]       ; 
         add    r9,rax                         ; 
         mov    rax,qword ptr [rdi-020h]       ; 
         adc    r8,rdx                         ; 
l_00C1:  mul    r10                            ; 
         add    r11,rax                        ; 
         mov    rax,r9                         ; 
         mov    r12,rdx                        ; 
         adc    r12,00h                        ; 
         mul    rbx                            ; 
         add    r11,rax                        ; 
         lea    rdi,[rdi-020h]                 ; 
         mov    rax,r8                         ; 
         adc    r12,rdx                        ; 
         mul    rbp                            ; 
         sub    rsi,02h                        ; 
         jae    l_0080                         ; 
         mov    r9,r11                         ; 
         mov    r8,r12                         ; 
l_00F0:  add    r9,rax                         ; 
         adc    r8,rdx                         ; 
l_00F6:  mov    edi,dword ptr [r13+08h]        ; 
         mov    rax,r8                         ; 
         mov    r8,r9                          ; 
         mul    r10                            ; 
         add    r8,rax                         ; 
         adc    rdx,00h                        ; 
l_010A:  xor    ecx,ecx                        ; 
         mov    r9,r8                          ; 
         sub    ecx,edi                        ; 
         shr    r9,cl                          ; 
         mov    ecx,edi                        ; 
         shl    rdx,cl                         ; 
         or     r9,rdx                         ; 
         shl    r8,cl                          ; 
         mov    rax,r9                         ; 
         mul    qword ptr [r13+00h]            ; 
         mov    rsi,rax                        ; 
         inc    r9                             ; 
         add    rsi,r8                         ; 
         adc    rdx,r9                         ; 
         imul   rdx,r14                        ; 
         sub    r8,rdx                         ; 
         lea    rax,[r8+r14*1]                 ; 
         cmp    rsi,r8                         ; 
         cmovb  r8,rax                         ; 
         mov    rax,r8                         ; 
         sub    rax,r14                        ; 
         cmovb  rax,r8                         ; 
         mov    ecx,edi                        ; 
         shr    rax,cl                         ; 
         pop    rbx                            ; 
         pop    rbp                            ; 
         pop    r12                            ; 
         pop    r13                            ; 
         pop    r14                            ; 
         pop    rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 
         ALIGN  16                             ;
l_015C:  mov    r8,qword ptr [rdi]             ; 
         mov    edi,dword ptr [rcx+08h]        ; 
         xor    rdx,rdx                        ; 
         jmp    l_010A                         ; 
         ALIGN  16                             ; 

__gmpn_mod_1s_2p ENDP

                     ALIGN 16

__gmpn_mod_1s_2p_cps PROC

  push    rdi                         ; SysV-to-MSVC ABI (save rdi)
  push    rsi                         ; SysV-to-MSVC ABI (save rsi)
                                      ; function parameter #1 in RCX (gcc assumes RDI)
                                      ; function parameter #2 in RDX (gcc assumes RSI)
  mov     rdi,rcx                     ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
  mov     rsi,rdx                     ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
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
  add     r12,rdx                     ; 
  cmp     rax,rdx                     ; 
  cmovae  r12,rdx                     ; 
  shr     r12,cl                      ; 
  mov     qword ptr [rbx+020h],r12    ; 
  pop     r12                         ; 
  pop     rbx                         ; 
  pop     rbp                         ; 
  pop     rsi                         ; SysV-to-MSVC ABI (restore rsi)
  pop     rdi                         ; SysV-to-MSVC ABI (restore rdi)
  ret                                 ; 

__gmpn_mod_1s_2p_cps ENDP

                END
