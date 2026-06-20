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

__gmpn_modexact_1_odd PROC

         push   rdi                                ; SysV-to-MSVC ABI (save rdi)
         push   rsi                                ; SysV-to-MSVC ABI (save rsi)
                                                   ; function parameter #1 in RCX (gcc assumes RDI)
                                                   ; function parameter #2 in RDX (gcc assumes RSI)
                                                   ; function parameter #3 in R8 (gcc assumes RDX)
         mov    rdi,rcx                            ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                            ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                             ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         xor    ecx,ecx                            ; 
         mov    r8,rdx                             ; 
         shr    edx,1                              ; 
         mov    r9,offset __gmp_binvert_limb_table ; 
         and    edx,07fh                           ; 
         mov    r10,rcx                            ; 
         movzx  edx,byte ptr [r9+rdx*1]            ; 
         mov    rax,qword ptr [rdi]                ; 
         lea    r11,[rdi+rsi*8]                    ; 
         mov    rdi,r8                             ; 
         lea    ecx,[rdx+rdx*1]                    ; 
         imul   edx,edx                            ; 
         neg    rsi                                ; 
         imul   edx,edi                            ; 
         sub    ecx,edx                            ; 
         lea    edx,[rcx+rcx*1]                    ; 
         imul   ecx,ecx                            ; 
         imul   ecx,edi                            ; 
         sub    edx,ecx                            ; 
         xor    ecx,ecx                            ; 
         lea    r9,[rdx+rdx*1]                     ; 
         imul   rdx,rdx                            ; 
         imul   rdx,r8                             ; 
         sub    r9,rdx                             ; 
         mov    rdx,r10                            ; 
         inc    rsi                                ; 
         je     l_007D                             ; 
         ALIGN  16                                 ; 
l_0060:  sub    rax,rdx                            ; 
         adc    rcx,00h                            ; 
         imul   rax,r9                             ; 
         mul    r8                                 ; 
         mov    rax,qword ptr [r11+rsi*8]          ; 
         sub    rax,rcx                            ; 
         setb   cl                                 ; 
         inc    rsi                                ; 
         jne    l_0060                             ; 
l_007D:  sub    rax,rdx                            ; 
         adc    rcx,00h                            ; 
         imul   rax,r9                             ; 
         mul    r8                                 ; 
         lea    rax,[rcx+rdx*1]                    ; 
         pop    rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                       ; 

__gmpn_modexact_1_odd ENDP

                       ALIGN 16

__gmpn_modexact_1c_odd PROC

         push   rdi                                ; SysV-to-MSVC ABI (save rdi)
         push   rsi                                ; SysV-to-MSVC ABI (save rsi)
                                                   ; function parameter #1 in RCX (gcc assumes RDI)
                                                   ; function parameter #2 in RDX (gcc assumes RSI)
                                                   ; function parameter #3 in R8 (gcc assumes RDX)
                                                   ; function parameter #4 in R9 (gcc assumes RCX)
         mov    rdi,rcx                            ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx                            ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,r8                             ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov    rcx,r9                             ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov    r8,rdx                             ; 
         shr    edx,1                              ; 
         mov    r9,offset __gmp_binvert_limb_table ; 
         and    edx,07fh                           ; 
         mov    r10,rcx                            ; 
         movzx  edx,byte ptr [r9+rdx*1]            ; 
         mov    rax,qword ptr [rdi]                ; 
         lea    r11,[rdi+rsi*8]                    ; 
         mov    rdi,r8                             ; 
         lea    ecx,[rdx+rdx*1]                    ; 
         imul   edx,edx                            ; 
         neg    rsi                                ; 
         imul   edx,edi                            ; 
         sub    ecx,edx                            ; 
         lea    edx,[rcx+rcx*1]                    ; 
         imul   ecx,ecx                            ; 
         imul   ecx,edi                            ; 
         sub    edx,ecx                            ; 
         xor    ecx,ecx                            ; 
         lea    r9,[rdx+rdx*1]                     ; 
         imul   rdx,rdx                            ; 
         imul   rdx,r8                             ; 
         sub    r9,rdx                             ; 
         mov    rdx,r10                            ; 
         inc    rsi                                ; 
         je     l_007D                             ; 
         ALIGN  16                                 ; 
l_0060:  sub    rax,rdx                            ; 
         adc    rcx,00h                            ; 
         imul   rax,r9                             ; 
         mul    r8                                 ; 
         mov    rax,qword ptr [r11+rsi*8]          ; 
         sub    rax,rcx                            ; 
         setb   cl                                 ; 
         inc    rsi                                ; 
         jne    l_0060                             ; 
l_007D:  sub    rax,rdx                            ; 
         adc    rcx,00h                            ; 
         imul   rax,r9                             ; 
         mul    r8                                 ; 
         lea    rax,[rcx+rdx*1]                    ; 
         pop    rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                       ; 

__gmpn_modexact_1c_odd ENDP

                     END
