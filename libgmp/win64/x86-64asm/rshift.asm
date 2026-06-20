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

__gmpn_rshift PROC

         push    rdi                                ; SysV-to-MSVC ABI (save rdi)
         push    rsi                                ; SysV-to-MSVC ABI (save rsi)
                                                    ; function parameter #1 in RCX (gcc assumes RDI)
                                                    ; function parameter #2 in RDX (gcc assumes RSI)
                                                    ; function parameter #3 in R8 (gcc assumes RDX)
                                                    ; function parameter #4 in R9 (gcc assumes RCX)
         mov     rdi,rcx                            ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                            ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                             ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                             ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         movd    xmm4,ecx                           ; 
         mov     eax,040h                           ; 
         sub     eax,ecx                            ; 
         movd    xmm5,eax                           ; 
         neg     ecx                                ; 
         mov     rax,qword ptr [rsi]                ; 
         shl     rax,cl                             ; 
         cmp     rdx,03h                            ; 
         jle     l_0130                             ; 
         test    dil,08h                            ; 
         je      l_004B                             ; 
         movq    xmm0,qword ptr [rsi]               ; 
         movq    xmm1,qword ptr [rsi+08h]           ; 
         psrlq   xmm0,xmm4                          ; 
         psllq   xmm1,xmm5                          ; 
         por     xmm0,xmm1                          ; 
         movq    qword ptr [rdi],xmm0               ; 
         lea     rsi,[rsi+08h]                      ; 
         lea     rdi,[rdi+08h]                      ; 
         dec     rdx                                ; 
l_004B:  lea     r8d,[rdx+01h]                      ; 
         lea     rsi,[rsi+rdx*8]                    ; 
         lea     rdi,[rdi+rdx*8]                    ; 
         neg     rdx                                ; 
         and     r8d,06h                            ; 
         je      l_006E                             ; 
         cmp     r8d,04h                            ; 
         je      l_0074                             ; 
         jb      l_007A                             ; 
         add     rdx,04h                            ; 
         jmp     l_00BC                             ; 
         ALIGN   16                                 ;
l_006E:  add     rdx,06h                            ; 
         jmp     l_009E                             ; 
         ALIGN   16                                 ;
l_0074:  add     rdx,02h                            ; 
         jmp     l_00DA                             ; 
         ALIGN   16                                 ;
l_007A:  add     rdx,08h                            ; 
         jge     l_00FE                             ; 
         ALIGN   16                                 ;
l_0080:  movdqu  xmm1,xmmword ptr [rsi+rdx*8-040h]  ; 
         movdqu  xmm0,xmmword ptr [rsi+rdx*8-038h]  ; 
         psllq   xmm0,xmm5                          ; 
         psrlq   xmm1,xmm4                          ; 
         por     xmm0,xmm1                          ; 
         movdqa  xmmword ptr [rdi+rdx*8-040h],xmm0  ; 
l_009E:  movdqu  xmm1,xmmword ptr [rsi+rdx*8-030h]  ; 
         movdqu  xmm0,xmmword ptr [rsi+rdx*8-028h]  ; 
         psllq   xmm0,xmm5                          ; 
         psrlq   xmm1,xmm4                          ; 
         por     xmm0,xmm1                          ; 
         movdqa  xmmword ptr [rdi+rdx*8-030h],xmm0  ; 
l_00BC:  movdqu  xmm1,xmmword ptr [rsi+rdx*8-020h]  ; 
         movdqu  xmm0,xmmword ptr [rsi+rdx*8-018h]  ; 
         psllq   xmm0,xmm5                          ; 
         psrlq   xmm1,xmm4                          ; 
         por     xmm0,xmm1                          ; 
         movdqa  xmmword ptr [rdi+rdx*8-020h],xmm0  ; 
l_00DA:  movdqu  xmm1,xmmword ptr [rsi+rdx*8-010h]  ; 
         movdqu  xmm0,xmmword ptr [rsi+rdx*8-08h]   ; 
         psllq   xmm0,xmm5                          ; 
         psrlq   xmm1,xmm4                          ; 
         por     xmm0,xmm1                          ; 
         movdqa  xmmword ptr [rdi+rdx*8-010h],xmm0  ; 
         add     rdx,08h                            ; 
         jl      l_0080                             ; 
l_00FE:  test    dl,01h                             ; 
         jne     l_011F                             ; 
         movdqu  xmm1,xmmword ptr [rsi-010h]        ; 
         movq    xmm0,qword ptr [rsi-08h]           ; 
         psrlq   xmm1,xmm4                          ; 
         psllq   xmm0,xmm5                          ; 
         por     xmm0,xmm1                          ; 
         movdqa  xmmword ptr [rdi-010h],xmm0        ; 
         pop     rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN   16                                 ;
l_011F:  movq    xmm0,qword ptr [rsi-08h]           ; 
         psrlq   xmm0,xmm4                          ; 
         movq    qword ptr [rdi-08h],xmm0           ; 
         pop     rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN   16                                 ;
l_0130:  dec     edx                                ; 
         jne     l_0141                             ; 
         movq    xmm0,qword ptr [rsi]               ; 
         psrlq   xmm0,xmm4                          ; 
         movq    qword ptr [rdi],xmm0               ; 
         pop     rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN   16                                 ;
l_0141:  movq    xmm1,qword ptr [rsi]               ; 
         movq    xmm0,qword ptr [rsi+08h]           ; 
         psrlq   xmm1,xmm4                          ; 
         psllq   xmm0,xmm5                          ; 
         por     xmm0,xmm1                          ; 
         movq    qword ptr [rdi],xmm0               ; 
         dec     edx                                ; 
         jne     l_016D                             ; 
         movq    xmm0,qword ptr [rsi+08h]           ; 
         psrlq   xmm0,xmm4                          ; 
         movq    qword ptr [rdi+08h],xmm0           ; 
         pop     rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 
         ALIGN   16                                 ;
l_016D:  movq    xmm1,qword ptr [rsi+08h]           ; 
         movq    xmm0,qword ptr [rsi+010h]          ; 
         psrlq   xmm1,xmm4                          ; 
         psllq   xmm0,xmm5                          ; 
         por     xmm0,xmm1                          ; 
         movq    qword ptr [rdi+08h],xmm0           ; 
         movq    xmm0,qword ptr [rsi+010h]          ; 
         psrlq   xmm0,xmm4                          ; 
         movq    qword ptr [rdi+010h],xmm0          ; 
         pop     rsi                                ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                                ; SysV-to-MSVC ABI (restore rdi)
         ret                                        ; 

__gmpn_rshift ENDP

             END
