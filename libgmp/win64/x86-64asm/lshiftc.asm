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

__gmpn_lshiftc PROC

         push        rdi                                ; SysV-to-MSVC ABI (save rdi)
         push        rsi                                ; SysV-to-MSVC ABI (save rsi)
                                                        ; function parameter #1 in RCX (gcc assumes RDI)
                                                        ; function parameter #2 in RDX (gcc assumes RSI)
                                                        ; function parameter #3 in R8 (gcc assumes RDX)
                                                        ; function parameter #4 in R9 (gcc assumes RCX)
         mov         rdi,rcx                            ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov         rsi,rdx                            ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov         rdx,r8                             ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov         rcx,r9                             ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         movd        xmm4,ecx                           ; 
         mov         eax,040h                           ; 
         sub         eax,ecx                            ; 
         movd        xmm5,eax                           ; 
         neg         ecx                                ; 
         mov         rax,qword ptr [rsi+rdx*8-08h]      ; 
         shr         rax,cl                             ; 
         pcmpeqb     xmm3,xmm3                          ; 
         cmp         rdx,03h                            ; 
         jle         l_0150                             ; 
         lea         ecx,[rdi+rdx*8]                    ; 
         test        cl,08h                             ; 
         je          l_0054                             ; 
         movq        xmm0,qword ptr [rsi+rdx*8-08h]     ; 
         movq        xmm1,qword ptr [rsi+rdx*8-010h]    ; 
         psllq       xmm0,xmm4                          ; 
         psrlq       xmm1,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movq        qword ptr [rdi+rdx*8-08h],xmm0     ; 
         dec         rdx                                ; 
l_0054:  lea         r8d,[rdx+01h]                      ; 
         and         r8d,06h                            ; 
         je          l_006C                             ; 
         cmp         r8d,04h                            ; 
         je          l_0072                             ; 
         jb          l_0078                             ; 
         add         rdx,0fffffffffffffffch             ; 
         jmp         l_00D4                             ; 
         ALIGN       16                                 ;
l_006C:  add         rdx,0fffffffffffffffah             ; 
         jmp         l_00B2                             ; 
         ALIGN       16                                 ;
l_0072:  add         rdx,0fffffffffffffffeh             ; 
         jmp         l_00F6                             ; 
         ALIGN       16                                 ;
l_0078:  add         rdx,0fffffffffffffff8h             ; 
         jle         l_0120                             ; 
         ALIGN       16                                 ; 
l_0090:  movdqu      xmm1,xmmword ptr [rsi+rdx*8+028h]  ; 
         movdqu      xmm0,xmmword ptr [rsi+rdx*8+030h]  ; 
         psllq       xmm0,xmm4                          ; 
         psrlq       xmm1,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movdqa      xmmword ptr [rdi+rdx*8+030h],xmm0  ; 
l_00B2:  movdqu      xmm1,xmmword ptr [rsi+rdx*8+018h]  ; 
         movdqu      xmm0,xmmword ptr [rsi+rdx*8+020h]  ; 
         psllq       xmm0,xmm4                          ; 
         psrlq       xmm1,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movdqa      xmmword ptr [rdi+rdx*8+020h],xmm0  ; 
l_00D4:  movdqu      xmm1,xmmword ptr [rsi+rdx*8+08h]   ; 
         movdqu      xmm0,xmmword ptr [rsi+rdx*8+010h]  ; 
         psllq       xmm0,xmm4                          ; 
         psrlq       xmm1,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movdqa      xmmword ptr [rdi+rdx*8+010h],xmm0  ; 
l_00F6:  movdqu      xmm1,xmmword ptr [rsi+rdx*8-08h]   ; 
         movdqu      xmm0,xmmword ptr [rsi+rdx*8]       ; 
         psllq       xmm0,xmm4                          ; 
         psrlq       xmm1,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movdqa      xmmword ptr [rdi+rdx*8],xmm0       ; 
         sub         rdx,08h                            ; 
         jg          l_0090                             ; 
l_0120:  test        dl,01h                             ; 
         jne         l_0197                             ; 
         movdqu      xmm1,xmmword ptr [rsi]             ; 
         pxor        xmm0,xmm0                          ; 
         punpcklqdq  xmm0,xmm1                          ; 
         psllq       xmm1,xmm4                          ; 
         psrlq       xmm0,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movdqa      xmmword ptr [rdi],xmm0             ; 
         pop         rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop         rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                            ; 
         ALIGN       16                                 ; 
l_0150:  dec         edx                                ; 
         je          l_0197                             ; 
         movq        xmm1,qword ptr [rsi+rdx*8]         ; 
         movq        xmm0,qword ptr [rsi+rdx*8-08h]     ; 
         psllq       xmm1,xmm4                          ; 
         psrlq       xmm0,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movq        qword ptr [rdi+rdx*8],xmm0         ; 
         sub         edx,02h                            ; 
         jl          l_0197                             ; 
         movq        xmm1,qword ptr [rsi+08h]           ; 
         movq        xmm0,qword ptr [rsi]               ; 
         psllq       xmm1,xmm4                          ; 
         psrlq       xmm0,xmm5                          ; 
         por         xmm0,xmm1                          ; 
         pxor        xmm0,xmm3                          ; 
         movq        qword ptr [rdi+08h],xmm0           ; 
l_0197:  movq        xmm0,qword ptr [rsi]               ; 
         psllq       xmm0,xmm4                          ; 
         pxor        xmm0,xmm3                          ; 
         movq        qword ptr [rdi],xmm0               ; 
         pop         rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop         rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                            ; 

__gmpn_lshiftc ENDP

              END
