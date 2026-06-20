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

__gmpn_mul_2 PROC

         push  rdi                             ; SysV-to-MSVC ABI (save rdi)
         push  rsi                             ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
                                               ; function parameter #4 in R9 (gcc assumes RCX)
         mov   rdi,rcx                         ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov   rsi,rdx                         ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov   rdx,r8                          ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov   rcx,r9                          ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         push  rbx                             ; 
         push  rbp                             ; 
         mov   r8,qword ptr [rcx]              ; 
         mov   r9,qword ptr [rcx+08h]          ; 
         mov   rax,qword ptr [rsi]             ; 
         mov   r11,rdx                         ; 
         neg   r11                             ; 
         lea   rsi,[rsi+rdx*8-08h]             ; 
         lea   rdi,[rdi+rdx*8-08h]             ; 
         and   edx,03h                         ; 
         je    l_0048                          ; 
         cmp   edx,02h                         ; 
         jb    l_0055                          ; 
         je    l_0065                          ; 
         mul   r8                              ; 
         xor   r10d,r10d                       ; 
         mov   rcx,rax                         ; 
         mov   rbp,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+08h]   ; 
         add   r11,0ffffffffffffffffh          ; 
         mul   r9                              ; 
         add   rbp,rax                         ; 
         jmp   l_00E6                          ; 
         ALIGN 16                              ;
l_0048:  mul   r8                              ; 
         xor   ebp,ebp                         ; 
         mov   rbx,rax                         ; 
         mov   rcx,rdx                         ; 
         jmp   l_00B0                          ; 
         ALIGN 16                              ;
l_0055:  mul   r8                              ; 
         xor   r10d,r10d                       ; 
         xor   ebx,ebx                         ; 
         xor   ecx,ecx                         ; 
         add   r11,01h                         ; 
         jmp   l_0080                          ; 
         ALIGN 16                              ;
l_0065:  mul   r8                              ; 
         xor   ebx,ebx                         ; 
         xor   ecx,ecx                         ; 
         mov   rbp,rax                         ; 
         mov   r10,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+08h]   ; 
         add   r11,0fffffffffffffffeh          ; 
         jmp   l_010E                          ; 
         ALIGN 16                              ;
l_0080:  add   r10,rax                         ; 
         adc   rbx,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8]       ; 
         adc   ecx,00h                         ; 
         mov   ebp,00h                         ; 
         mul   r9                              ; 
         add   rbx,rax                         ; 
         mov   qword ptr [rdi+r11*8],r10       ; 
         adc   rcx,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+08h]   ; 
         mul   r8                              ; 
         add   rbx,rax                         ; 
         adc   rcx,rdx                         ; 
         adc   ebp,00h                         ; 
         ALIGN 16                              ;
l_00B0:  mov   rax,qword ptr [rsi+r11*8+08h]   ; 
         mul   r9                              ; 
         add   rcx,rax                         ; 
         adc   rbp,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+010h]  ; 
         mov   r10d,00h                        ; 
         mul   r8                              ; 
         add   rcx,rax                         ; 
         mov   rax,qword ptr [rsi+r11*8+010h]  ; 
         adc   rbp,rdx                         ; 
         adc   r10d,00h                        ; 
         mul   r9                              ; 
         add   rbp,rax                         ; 
         mov   qword ptr [rdi+r11*8+08h],rbx   ; 
l_00E6:  adc   r10,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+018h]  ; 
         mul   r8                              ; 
         mov   ebx,00h                         ; 
         add   rbp,rax                         ; 
         adc   r10,rdx                         ; 
         mov   qword ptr [rdi+r11*8+010h],rcx  ; 
         mov   rax,qword ptr [rsi+r11*8+018h]  ; 
         mov   ecx,00h                         ; 
         adc   ebx,00h                         ; 
l_010E:  mul   r9                              ; 
         add   r10,rax                         ; 
         mov   qword ptr [rdi+r11*8+018h],rbp  ; 
         adc   rbx,rdx                         ; 
         mov   rax,qword ptr [rsi+r11*8+020h]  ; 
         mul   r8                              ; 
         add   r11,04h                         ; 
         js    l_0080                          ; 
         add   r10,rax                         ; 
         adc   rbx,rdx                         ; 
         adc   ecx,00h                         ; 
         mov   rax,qword ptr [rsi]             ; 
         mul   r9                              ; 
         mov   qword ptr [rdi],r10             ; 
         add   rbx,rax                         ; 
         adc   rcx,rdx                         ; 
         mov   qword ptr [rdi+08h],rbx         ; 
         mov   rax,rcx                         ; 
         pop   rbp                             ; 
         pop   rbx                             ; 
         pop   rsi                             ; SysV-to-MSVC ABI (restore rsi)
         pop   rdi                             ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_mul_2 ENDP

            END
