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

__gmpn_submul_1 PROC

         push  rdi                                 ; SysV-to-MSVC ABI (save rdi)
         push  rsi                                 ; SysV-to-MSVC ABI (save rsi)
                                                   ; function parameter #1 in RCX (gcc assumes RDI)
                                                   ; function parameter #2 in RDX (gcc assumes RSI)
                                                   ; function parameter #3 in R8 (gcc assumes RDX)
                                                   ; function parameter #4 in R9 (gcc assumes RCX)
         mov   rdi,rcx                             ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov   rsi,rdx                             ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov   rdx,r8                              ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov   rcx,r9                              ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov   r8,qword ptr [rsi]                  ; 
         push  rbx                                 ; 
         push  r12                                 ; 
         push  r13                                 ; 
         lea   rsi,[rsi+rdx*8]                     ; 
         lea   rdi,[rdi+rdx*8-020h]                ; 
         mov   eax,edx                             ; 
         xchg  rdx,rcx                             ; 
         neg   rcx                                 ; 
         and   al,03h                              ; 
         je    l_0043                              ; 
         cmp   al,02h                              ; 
         je    l_0081                              ; 
         jg    l_005A                              ; 
         mulx  rax,rbx,r8                          ; 
         sub   rcx,0ffffffffffffffffh              ; 
         je    l_00F3                              ; 
         mulx  r8,r9,qword ptr [rsi+rcx*8]         ; 
         mulx  r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         test  eax,eax                             ; 
         jmp   l_00BF                              ; 
         ALIGN 16                                  ;
l_0043:  mulx  r8,r9,r8                            ; 
         mulx  r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         mulx  r12,r13,qword ptr [rsi+rcx*8+010h]  ; 
         xor   eax,eax                             ; 
         jmp   l_00CE                              ; 
         ALIGN 16                                  ;
l_005A:  mulx  r10,r11,r8                          ; 
         mulx  r12,r13,qword ptr [rsi+rcx*8+08h]   ; 
         mulx  rax,rbx,qword ptr [rsi+rcx*8+010h]  ; 
         add   r13,r10                             ; 
         adc   rbx,r12                             ; 
         adc   rax,00h                             ; 
         sub   rcx,0fffffffffffffffdh              ; 
         je    l_00EB                              ; 
         test  eax,eax                             ; 
         jmp   l_00A8                              ; 
         ALIGN 16                                  ;
l_0081:  mulx  r12,r13,r8                          ; 
         mulx  rax,rbx,qword ptr [rsi+rcx*8+08h]   ; 
         add   rbx,r12                             ; 
         adc   rax,00h                             ; 
         sub   rcx,0fffffffffffffffeh              ; 
         je    l_00EF                              ; 
         mulx  r8,r9,qword ptr [rsi+rcx*8]         ; 
         test  eax,eax                             ; 
         jmp   l_00B3                              ; 
         ALIGN 16                                  ;
l_00A4:  sub   qword ptr [rdi+rcx*8],r9            ; 
l_00A8:  mulx  r8,r9,qword ptr [rsi+rcx*8]         ; 
         sbb   qword ptr [rdi+rcx*8+08h],r11       ; 
l_00B3:  mulx  r10,r11,qword ptr [rsi+rcx*8+08h]   ; 
         sbb   qword ptr [rdi+rcx*8+010h],r13      ; 
l_00BF:  mulx  r12,r13,qword ptr [rsi+rcx*8+010h]  ; 
         sbb   qword ptr [rdi+rcx*8+018h],rbx      ; 
         adc   r9,rax                              ; 
l_00CE:  mulx  rax,rbx,qword ptr [rsi+rcx*8+018h]  ; 
         adc   r11,r8                              ; 
         adc   r13,r10                             ; 
         adc   rbx,r12                             ; 
         adc   rax,00h                             ; 
         add   rcx,04h                             ; 
         js    l_00A4                              ; 
         sub   qword ptr [rdi],r9                  ; 
l_00EB:  sbb   qword ptr [rdi+08h],r11             ; 
l_00EF:  sbb   qword ptr [rdi+010h],r13            ; 
l_00F3:  sbb   qword ptr [rdi+018h],rbx            ; 
         adc   rax,rcx                             ; 
         pop   r13                                 ; 
         pop   r12                                 ; 
         pop   rbx                                 ; 
         pop   rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop   rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                       ; 

__gmpn_submul_1 ENDP

               END
