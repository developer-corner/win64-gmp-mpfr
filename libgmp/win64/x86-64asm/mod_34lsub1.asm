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

__gmpn_mod_34lsub1 PROC

         push    rdi                        ; SysV-to-MSVC ABI (save rdi)
         push    rsi                        ; SysV-to-MSVC ABI (save rsi)
                                            ; function parameter #1 in RCX (gcc assumes RDI)
                                            ; function parameter #2 in RDX (gcc assumes RSI)
         mov     rdi,rcx                    ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov     rsi,rdx                    ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov     r11,0ffffffffffffh         ; 
         mov     rax,qword ptr [rdi]        ; 
         cmp     rsi,02h                    ; 
         ja      Lgt2                       ;  
         jb      Lone                       ; 
         mov     rsi,qword ptr [rdi+08h]    ; 
         mov     rdx,rax                    ; 
         shr     rax,030h                   ; 
         and     rdx,r11                    ; 
         add     rax,rdx                    ; 
         mov     edx,esi                    ; 
         shr     rsi,020h                   ; 
         add     rax,rsi                    ; 
         shl     rdx,010h                   ; 
         add     rax,rdx                    ; 
Lone:    pop     rsi                        ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                        ; SysV-to-MSVC ABI (restore rdi)
         ret                                ; 
         ALIGN   16                         ;
Lgt2:    mov     rcx,qword ptr [rdi+08h]    ; 
         mov     rdx,qword ptr [rdi+010h]   ; 
         xor     r9,r9                      ; 
         add     rdi,018h                   ; 
         sub     rsi,0ch                    ; 
         jb      Lend                       ; 
         ALIGN   16                         ; 
Ltop:    add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rax,qword ptr [rdi+018h]   ; 
         adc     rcx,qword ptr [rdi+020h]   ; 
         adc     rdx,qword ptr [rdi+028h]   ; 
         adc     r9,00h                     ; 
         add     rax,qword ptr [rdi+030h]   ; 
         adc     rcx,qword ptr [rdi+038h]   ; 
         adc     rdx,qword ptr [rdi+040h]   ; 
         adc     r9,00h                     ; 
         add     rdi,048h                   ; 
         sub     rsi,09h                    ; 
         jnc     Ltop                       ; 
Lend:    mov     r8,offset Ltab             ; 
         jmp     qword ptr [r8+rsi*8+048h]  ; 

; THIS WAS ORIGINALLY:
;
;	lea	.Ltab(%rip), %r8
;	movslq	36(%r8,%rsi,4), %r10
;	add	%r10, %r8
;	jmp	*%r8

; r10 = r8 + rsi*4 + 0x24

         ALIGN   16                         ;
L6:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rdi,018h                   ; 
L3:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         jmp     l_0115                     ; 
         ALIGN   16                         ;
L7:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rdi,018h                   ; 
L4:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rdi,018h                   ; 
L1:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,00h                    ; 
         jmp     l_0111                     ; 
         ALIGN   16                         ;
L8:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rdi,018h                   ; 
L5:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
         adc     rdx,qword ptr [rdi+010h]   ; 
         adc     r9,00h                     ; 
         add     rdi,018h                   ; 
L2:      add     rax,qword ptr [rdi]        ; 
         adc     rcx,qword ptr [rdi+08h]    ; 
l_0111:  adc     rdx,00h                    ; 
l_0115:  adc     r9,00h                     ; 
L0:      add     rax,r9                     ; 
         adc     rcx,00h                    ; 
         adc     rdx,00h                    ; 
         adc     rax,00h                    ; 
         mov     rdi,rax                    ; 
         shr     rax,030h                   ; 
         and     rdi,r11                    ; 
         mov     r10d,ecx                   ; 
         shr     rcx,020h                   ; 
         add     rax,rdi                    ; 
         movzx   edi,dx                     ; 
         shl     r10,010h                   ; 
         add     rax,rcx                    ; 
         shr     rdx,010h                   ; 
         add     rax,r10                    ; 
         shl     rdi,020h                   ; 
         add     rax,rdx                    ; 
         add     rax,rdi                    ; 
         pop     rsi                        ; SysV-to-MSVC ABI (restore rsi)
         pop     rdi                        ; SysV-to-MSVC ABI (restore rdi)
         ret                                ; 
                                            ;
         ALIGN   16                         ;
Ltab:	                                      ;
         dq      offset L0                  ;
         dq      offset L1                  ;
         dq      offset L2                  ;
         dq      offset L3                  ;
         dq      offset L4                  ;
         dq      offset L5                  ;
         dq      offset L6                  ;
         dq      offset L7                  ;
         dq      offset L8                  ;

__gmpn_mod_34lsub1 ENDP

                  END
