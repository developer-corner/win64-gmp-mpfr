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

__gmpn_com PROC

         push     rdi                          ; SysV-to-MSVC ABI (save rdi)
         push     rsi                          ; SysV-to-MSVC ABI (save rsi)
                                               ; function parameter #1 in RCX (gcc assumes RDI)
                                               ; function parameter #2 in RDX (gcc assumes RSI)
                                               ; function parameter #3 in R8 (gcc assumes RDX)
         movdqu   xmmword ptr [rsp+018h],xmm6  ; in MS VC AMD64 ABI, XMM6 is NOT volatile -> use spill area to save
         movdqu   xmmword ptr [rsp+028h],xmm7  ; in MS VC AMD64 ABI, XMM7 is NOT volatile -> use spill area to save
         mov      rdi,rcx                      ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov      rsi,rdx                      ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov      rdx,r8                       ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         pcmpeqb  xmm7,xmm7                    ; 
         test     dil,08h                      ; 
         je       l_0098                       ; 
         mov      rax,qword ptr [rsi]          ; 
         lea      rsi,[rsi+08h]                ; 
         not      rax                          ; 
         mov      qword ptr [rdi],rax          ; 
         lea      rdi,[rdi+08h]                ; 
         dec      rdx                          ; 
         sub      rdx,0eh                      ; 
         jb       l_009E                       ; 
         ALIGN    16                           ; 
l_0030:  movdqu   xmm0,xmmword ptr [rsi]       ; 
         movdqu   xmm1,xmmword ptr [rsi+010h]  ; 
         movdqu   xmm2,xmmword ptr [rsi+020h]  ; 
         movdqu   xmm3,xmmword ptr [rsi+030h]  ; 
         movdqu   xmm4,xmmword ptr [rsi+040h]  ; 
         movdqu   xmm5,xmmword ptr [rsi+050h]  ; 
         movdqu   xmm6,xmmword ptr [rsi+060h]  ; 
         lea      rsi,[rsi+070h]               ; 
         pxor     xmm0,xmm7                    ; 
         pxor     xmm1,xmm7                    ; 
         pxor     xmm2,xmm7                    ; 
         pxor     xmm3,xmm7                    ; 
         pxor     xmm4,xmm7                    ; 
         pxor     xmm5,xmm7                    ; 
         pxor     xmm6,xmm7                    ; 
         movdqa   xmmword ptr [rdi],xmm0       ; 
         movdqa   xmmword ptr [rdi+010h],xmm1  ; 
         movdqa   xmmword ptr [rdi+020h],xmm2  ; 
         movdqa   xmmword ptr [rdi+030h],xmm3  ; 
         movdqa   xmmword ptr [rdi+040h],xmm4  ; 
         movdqa   xmmword ptr [rdi+050h],xmm5  ; 
         movdqa   xmmword ptr [rdi+060h],xmm6  ; 
         lea      rdi,[rdi+070h]               ; 
l_0098:  sub      rdx,0eh                      ; 
         jae      l_0030                       ; 
l_009E:  add      rdx,0eh                      ; 
         test     dl,08h                       ; 
         je       l_00E5                       ; 
         movdqu   xmm0,xmmword ptr [rsi]       ; 
         movdqu   xmm1,xmmword ptr [rsi+010h]  ; 
         movdqu   xmm2,xmmword ptr [rsi+020h]  ; 
         movdqu   xmm3,xmmword ptr [rsi+030h]  ; 
         lea      rsi,[rsi+040h]               ; 
         pxor     xmm0,xmm7                    ; 
         pxor     xmm1,xmm7                    ; 
         pxor     xmm2,xmm7                    ; 
         pxor     xmm3,xmm7                    ; 
         movdqa   xmmword ptr [rdi],xmm0       ; 
         movdqa   xmmword ptr [rdi+010h],xmm1  ; 
         movdqa   xmmword ptr [rdi+020h],xmm2  ; 
         movdqa   xmmword ptr [rdi+030h],xmm3  ; 
         lea      rdi,[rdi+040h]               ; 
l_00E5:  test     dl,04h                       ; 
         je       l_010C                       ; 
         movdqu   xmm0,xmmword ptr [rsi]       ; 
         movdqu   xmm1,xmmword ptr [rsi+010h]  ; 
         lea      rsi,[rsi+020h]               ; 
         pxor     xmm0,xmm7                    ; 
         pxor     xmm1,xmm7                    ; 
         movdqa   xmmword ptr [rdi],xmm0       ; 
         movdqa   xmmword ptr [rdi+010h],xmm1  ; 
         lea      rdi,[rdi+020h]               ; 
l_010C:  test     dl,02h                       ; 
         je       l_0125                       ; 
         movdqu   xmm0,xmmword ptr [rsi]       ; 
         lea      rsi,[rsi+010h]               ; 
         pxor     xmm0,xmm7                    ; 
         movdqa   xmmword ptr [rdi],xmm0       ; 
         lea      rdi,[rdi+010h]               ; 
l_0125:  test     dl,01h                       ; 
         je       l_0133                       ; 
         mov      rax,qword ptr [rsi]          ; 
         not      rax                          ; 
         mov      qword ptr [rdi],rax          ; 
l_0133:  movdqu   xmm6,xmmword ptr [rsp+018h]  ; in MS VC AMD64 ABI, XMM6 is NOT volatile -> use spill area to restore
         movdqu   xmm7,xmmword ptr [rsp+028h]  ; in MS VC AMD64 ABI, XMM7 is NOT volatile -> use spill area to restore
         pop      rsi                          ; SysV-to-MSVC ABI (restore rsi)
         pop      rdi                          ; SysV-to-MSVC ABI (restore rdi)
         ret                                   ; 

__gmpn_com ENDP

          END
