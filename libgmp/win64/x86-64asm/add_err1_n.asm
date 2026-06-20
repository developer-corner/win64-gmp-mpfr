; Copyright 2003-2026 Free Software Foundation, Inc.
;
; This file is part of the GNU MP Library.
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

__gmpn_add_err1_n PROC
                                                ; #1 = mp_ptr rp, #2 = mp_srcptr up, #3 = mp_srcptr vp, #4 = mp_ptr ep, #5 = mp_srcptr yp, #6 = mp_size_t n, #7 = mp_limb_t cy
         push    rdi                            ; SysV-to-MSVC ABI (save rdi)
         push    rsi                            ; SysV-to-MSVC ABI (save rsi)
                                                ; function parameter #1 in RCX (gcc assumes RDI)
                                                ; function parameter #2 in RDX (gcc assumes RSI)
                                                ; function parameter #3 in R8 (gcc assumes RDX)
                                                ; function parameter #4 in R9 (gcc assumes RCX)
                                                ; function parameter #5 on stack [RSP+0x38] (gcc assumes R8)
                                                ; function parameter #6 on stack [RSP+0x40] (gcc assumes R9)
                                                ; function parameter #7 on stack [RSP+0x48] (gcc assumes [RSP+0x8]
         mov     rdi,rcx                        ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                        ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     rdx,r8                         ; SysV-to-MSVC ABI (parameter #3 from r8 to rdx)
         mov     rcx,r9                         ; SysV-to-MSVC ABI (parameter #4 from r9 to rcx)
         mov     r8 ,qword ptr [rsp+038h]       ; SysV-to-MSVC ABI (parameter #5 from stack to r8)
IF FULL_64BIT                                   ;
         mov     r9,qword ptr [rsp+040h]        ; SysV-to-MSVC ABI (parameter #6 from stack to r9)
ELSE                                            ;
         mov     r9d,dword ptr [rsp+040h]       ; SysV-to-MSVC ABI (parameter #6 from stack to r9) ; do NOT use r9 here because of possible 'stack polution' (mp_size_t is 32bit)
ENDIF                                           ;
                                                ; SysV-to-MSVC ABI (parameter #7 on stack at 0x48 - now)
         mov     rax,qword ptr [rsp+048h]       ; mp_limb_t (64bit)
         push    rbx                            ; 
         push    rbp                            ; 
         push    r12                            ; 
         push    r13                            ; 
         push    r14                            ; 
         push    r15                            ; 
         lea     rsi,[rsi+r9*8]                 ; 
         lea     rdx,[rdx+r9*8]                 ; 
         lea     rdi,[rdi+r9*8]                 ; 
         mov     r10d,r9d                       ; 
         and     r10d,03h                       ; 
         je      l_00A0                         ; 
         cmp     r10d,02h                       ; 
         jb      l_00B0                         ; 
         je      l_00E0                         ; 
         xor     ebx,ebx                        ; 
         xor     ebp,ebp                        ; 
         xor     r10d,r10d                      ; 
         xor     r11d,r11d                      ; 
         lea     r8,[r8+r9*8-018h]              ; 
         neg     r9                             ; 
         shr     al,1                           ; 
         mov     r14,qword ptr [rsi+r9*8]       ; 
         mov     r15,qword ptr [rsi+r9*8+08h]   ; 
         adc     r14,qword ptr [rdx+r9*8]       ; 
         mov     qword ptr [rdi+r9*8],r14       ; 
         cmovb   rbx,qword ptr [r8+010h]        ; 
         adc     r15,qword ptr [rdx+r9*8+08h]   ; 
         mov     qword ptr [rdi+r9*8+08h],r15   ; 
         cmovb   r10,qword ptr [r8+08h]         ; 
         mov     r14,qword ptr [rsi+r9*8+010h]  ; 
         adc     r14,qword ptr [rdx+r9*8+010h]  ; 
         mov     qword ptr [rdi+r9*8+010h],r14  ; 
         cmovb   r11,qword ptr [r8]             ; 
         setb    al                             ; 
         add     rbx,r10                        ; 
         adc     rbp,00h                        ; 
         add     rbx,r11                        ; 
         adc     rbp,00h                        ; 
         add     r9,03h                         ; 
         jne     l_0140                         ; 
         jmp     l_01CB                         ; 
         ALIGN   16                             ;
l_00A0:  xor     ebx,ebx                        ; 
         xor     ebp,ebp                        ; 
         lea     r8,[r8+r9*8]                   ; 
         neg     r9                             ; 
         jmp     l_0140                         ; 
         ALIGN   16                             ;
l_00B0:  xor     ebx,ebx                        ; 
         xor     ebp,ebp                        ; 
         lea     r8,[r8+r9*8-08h]               ; 
         neg     r9                             ; 
         shr     al,1                           ; 
         mov     r14,qword ptr [rsi+r9*8]       ; 
         adc     r14,qword ptr [rdx+r9*8]       ; 
         mov     qword ptr [rdi+r9*8],r14       ; 
         cmovb   rbx,qword ptr [r8]             ; 
         setb    al                             ; 
         add     r9,01h                         ; 
         jne     l_0140                         ; 
         jmp     l_01CB                         ; 
         ALIGN   16                             ; 
l_00E0:  xor     ebx,ebx                        ; 
         xor     ebp,ebp                        ; 
         xor     r10d,r10d                      ; 
         lea     r8,[r8+r9*8-010h]              ; 
         neg     r9                             ; 
         shr     al,1                           ; 
         mov     r14,qword ptr [rsi+r9*8]       ; 
         mov     r15,qword ptr [rsi+r9*8+08h]   ; 
         adc     r14,qword ptr [rdx+r9*8]       ; 
         mov     qword ptr [rdi+r9*8],r14       ; 
         cmovb   rbx,qword ptr [r8+08h]         ; 
         adc     r15,qword ptr [rdx+r9*8+08h]   ; 
         mov     qword ptr [rdi+r9*8+08h],r15   ; 
         cmovb   r10,qword ptr [r8]             ; 
         setb    al                             ; 
         add     rbx,r10                        ; 
         adc     rbp,00h                        ; 
         add     r9,02h                         ; 
         jne     l_0140                         ; 
         jmp     l_01CB                         ; 
         ALIGN   16                             ; 
l_0140:  shr     al,1                           ; 
         mov     r10,qword ptr [r8-08h]         ; 
         mov     r13d,00h                       ; 
         mov     r14,qword ptr [rsi+r9*8]       ; 
         mov     r15,qword ptr [rsi+r9*8+08h]   ; 
         adc     r14,qword ptr [rdx+r9*8]       ; 
         cmovae  r10,r13                        ; 
         adc     r15,qword ptr [rdx+r9*8+08h]   ; 
         mov     r11,qword ptr [r8-010h]        ; 
         mov     qword ptr [rdi+r9*8],r14       ; 
         mov     r14,qword ptr [rsi+r9*8+010h]  ; 
         mov     qword ptr [rdi+r9*8+08h],r15   ; 
         cmovae  r11,r13                        ; 
         mov     r12,qword ptr [r8-018h]        ; 
         adc     r14,qword ptr [rdx+r9*8+010h]  ; 
         cmovae  r12,r13                        ; 
         mov     r15,qword ptr [rsi+r9*8+018h]  ; 
         adc     r15,qword ptr [rdx+r9*8+018h]  ; 
         cmovb   r13,qword ptr [r8-020h]        ; 
         setb    al                             ; 
         add     rbx,r10                        ; 
         adc     rbp,00h                        ; 
         add     rbx,r11                        ; 
         adc     rbp,00h                        ; 
         add     rbx,r12                        ; 
         adc     rbp,00h                        ; 
         mov     qword ptr [rdi+r9*8+010h],r14  ; 
         add     rbx,r13                        ; 
         lea     r8,[r8-020h]                   ; 
         adc     rbp,00h                        ; 
         mov     qword ptr [rdi+r9*8+018h],r15  ; 
         add     r9,04h                         ; 
         jne     l_0140                         ; 
l_01CB:  mov     qword ptr [rcx],rbx            ; 
         mov     qword ptr [rcx+08h],rbp        ; 
         pop     r15                            ; 
         pop     r14                            ; 
         pop     r13                            ; 
         pop     r12                            ; 
         pop     rbp                            ; 
         pop     rbx                            ; 
         pop     rsi                            ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                            ; SysV-to-MSVC ABI (restore rdi)
         ret                                    ; 

__gmpn_add_err1_n ENDP

                 END
