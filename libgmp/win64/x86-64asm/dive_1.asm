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

                  EXTERN __gmp_binvert_limb_table : BYTE

                  ALIGN 16

__gmpn_divexact_1 PROC

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
         mov    r8,rdx                              ; 
         bt     eax,00h                             ; 
         jae    l_006B                              ; 
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
         lea    r10,[rax+rax*1]                     ; 
         imul   rax,rax                             ; 
         imul   rax,rbx                             ; 
         sub    r10,rax                             ; 
         lea    rsi,[rsi+r8*8]                      ; 
         lea    rdi,[rdi+r8*8-08h]                  ; 
         neg    r8                                  ; 
         mov    rax,qword ptr [rsi+r8*8]            ; 
         inc    r8                                  ; 
         je     l_00BC                              ; 
         mov    rdx,qword ptr [rsi+r8*8]            ; 
         shrd   rax,rdx,cl                          ; 
         xor    ebx,ebx                             ; 
         jmp    l_0096                              ; 
l_006B:  bsf    rcx,rax                             ; 
         shr    rax,cl                              ; 
         jmp    l_000F                              ; 
         ALIGN  16                                  ; 
l_0078:  mul    r11                                 ; 
         mov    rax,qword ptr [rsi+r8*8-08h]        ; 
         mov    r9,qword ptr [rsi+r8*8]             ; 
         shrd   rax,r9,cl                           ; 
         ALIGN  16                                  ; 
         sub    rax,rbx                             ; 
         setb   bl                                  ; 
         sub    rax,rdx                             ; 
         adc    rbx,00h                             ; 
l_0096:  imul   rax,r10                             ; 
         mov    qword ptr [rdi+r8*8],rax            ; 
         inc    r8                                  ; 
         jne    l_0078                              ; 
         mul    r11                                 ; 
         mov    rax,qword ptr [rsi-08h]             ; 
         shr    rax,cl                              ; 
         sub    rax,rbx                             ; 
         sub    rax,rdx                             ; 
         imul   rax,r10                             ; 
         mov    qword ptr [rdi],rax                 ; 
         pop    rbx                                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN  16                                  ;
l_00BC:  shr    rax,cl                              ; 
         imul   rax,r10                             ; 
         mov    qword ptr [rdi],rax                 ; 
         pop    rbx                                 ; 
         pop    rsi                                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                 ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 

__gmpn_divexact_1 ENDP

                 END
