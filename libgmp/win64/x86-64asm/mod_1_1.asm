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

__gmpn_mod_1_1p PROC

         push    rdi                             ; SysV-to-MSVC ABI (save rdi)
         push    rsi                             ; SysV-to-MSVC ABI (save rsi)
                                                 ; function parameter #1 in RCX (gcc assumes RDI)
                                                 ; function parameter #2 in RDX (gcc assumes RSI)
                                                 ; function parameter #3 in R8 (gcc assumes RDX)
                                                 ; function parameter #4 in R9 (gcc assumes RCX)
         mov     rdi,rcx                         ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                         ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                          ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                          ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         push    rbp                             ; 
         push    rbx                             ; 
         mov     rbx,rdx                         ; 
         mov     r8,rcx                          ; 
         mov     rax,qword ptr [rdi+rsi*8-08h]   ; 
         cmp     rsi,03h                         ; 
         jae     l_001A                          ; 
         mov     rbp,qword ptr [rdi+rsi*8-010h]  ; 
         jmp     l_006D                          ; 
         ALIGN   16                              ;
l_001A:  mov     r11,qword ptr [r8+018h]         ; 
         mul     r11                             ; 
         mov     rbp,qword ptr [rdi+rsi*8-018h]  ; 
         add     rbp,rax                         ; 
         mov     rax,qword ptr [rdi+rsi*8-010h]  ; 
         adc     rax,rdx                         ; 
         sbb     rcx,rcx                         ; 
         sub     rsi,04h                         ; 
         jb      l_0067                          ; 
         mov     r10,r11                         ; 
         sub     r10,rbx                         ; 
         ALIGN   16                              ;
l_0040:  and     rcx,r11                         ; 
         lea     r9,[r10+rbp*1]                  ; 
         mul     r11                             ; 
         add     rcx,rbp                         ; 
         mov     rbp,qword ptr [rdi+rsi*8]       ; 
         cmovb   rcx,r9                          ; 
         add     rbp,rax                         ; 
         mov     rax,rcx                         ; 
         adc     rax,rdx                         ; 
         sbb     rcx,rcx                         ; 
         sub     rsi,01h                         ; 
         jae     l_0040                          ; 
l_0067:  and     rcx,rbx                         ; 
         sub     rax,rcx                         ; 
l_006D:  mov     ecx,dword ptr [r8+08h]          ; 
         test    ecx,ecx                         ; 
         je      l_008E                          ; 
         mul     qword ptr [r8+010h]             ; 
         xor     r9,r9                           ; 
         add     rbp,rax                         ; 
         adc     r9,rdx                          ; 
         mov     rax,r9                          ; 
         shld    rax,rbp,cl                      ; 
         shl     rbp,cl                          ; 
         jmp     l_0098                          ; 
         ALIGN   16                              ;
l_008E:  mov     r9,rax                          ; 
         sub     r9,rbx                          ; 
         cmovae  rax,r9                          ; 
l_0098:  lea     r9,[rax+01h]                    ; 
         mul     qword ptr [r8]                  ; 
         add     rax,rbp                         ; 
         adc     rdx,r9                          ; 
         imul    rdx,rbx                         ; 
         sub     rbp,rdx                         ; 
         cmp     rax,rbp                         ; 
         lea     rax,[rbx+rbp*1]                 ; 
         cmovae  rax,rbp                         ; 
         cmp     rax,rbx                         ; 
         jae     l_00C2                          ; 
l_00BC:  shr     rax,cl                          ; 
         pop     rbx                             ; 
         pop     rbp                             ; 
         pop     rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                     ; 
         ALIGN   16                              ;
l_00C2:  sub     rax,rbx                         ; 
         jmp     l_00BC                          ; 
         ALIGN   16                              ; 

__gmpn_mod_1_1p ENDP

                    ALIGN 16

__gmpn_mod_1_1p_cps PROC

         push  rdi                          ; SysV-to-MSVC ABI (save rdi)
         push  rsi                          ; SysV-to-MSVC ABI (save rsi)
                                            ; function parameter #1 in RCX (gcc assumes RDI)
                                            ; function parameter #2 in RDX (gcc assumes RSI)
         mov   rdi,rcx                      ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov   rsi,rdx                      ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         push  rbp                          ; 
         bsr   rcx,rsi                      ; 
         push  rbx                          ; 
         mov   rbx,rdi                      ; 
         push  r12                          ; 
         xor   ecx,03fh                     ; 
         mov   r12,rsi                      ; 
         mov   ebp,ecx                      ; 
         shl   r12,cl                       ; 
         mov   rdi,r12                      ; 
         call   __gmpn_invert_limb_sysv_abi ; SPECIAL: call SysV ABI version of this function here!!!
         neg   r12                          ; 
         mov   r8,r12                       ; 
         mov   qword ptr [rbx],rax          ; 
         mov   qword ptr [rbx+08h],rbp      ; 
         imul  r12,rax                      ; 
         mov   qword ptr [rbx+018h],r12     ; 
         mov   ecx,ebp                      ; 
         test  ecx,ecx                      ; 
         je    l_011D                       ; 
         mov   edx,01h                      ; 
         shld  rdx,rax,cl                   ; 
         imul  r8,rdx                       ; 
         shr   r8,cl                        ; 
         mov   qword ptr [rbx+010h],r8      ; 
l_011D:  pop   r12                          ; 
         pop   rbx                          ; 
         pop   rbp                          ; 
         pop   rsi                          ; SysV-to-MSVC ABI (restore rsi)
         pop   rdi                          ; SysV-to-MSVC ABI (restore rdi)
         ret                                ; 

__gmpn_mod_1_1p_cps ENDP

               END
