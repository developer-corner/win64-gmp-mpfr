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

                   EXTERN __gmpn_invert_limb_table : WORD

__gmpn_invert_limb PROC

  push    rdi                                       ; SysV-to-MSVC ABI (save rdi)
  push    rsi                                       ; SysV-to-MSVC ABI (save rsi)
                                                    ; function parameter #1 in RCX (gcc assumes RDI)
  mov     rdi,rcx                                   ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
  mov     rax,rdi                                   ; 
  shr     rax,037h                                  ; 
  mov     r8,-512 + offset __gmpn_invert_limb_table ; 
  movzx   ecx,word ptr [r8+rax*2]                   ; 
  mov     rsi,rdi                                   ; 
  mov     eax,ecx                                   ; 
  imul    ecx,ecx                                   ; 
  shr     rsi,018h                                  ; 
  inc     rsi                                       ; 
  imul    rcx,rsi                                   ; 
  shr     rcx,028h                                  ; 
  shl     eax,0bh                                   ; 
  dec     eax                                       ; 
  sub     eax,ecx                                   ; 
  mov     rcx,01000000000000000h                    ; 
  imul    rsi,rax                                   ; 
  sub     rcx,rsi                                   ; 
  imul    rcx,rax                                   ; 
  shl     rax,0dh                                   ; 
  shr     rcx,02fh                                  ; 
  add     rcx,rax                                   ; 
  mov     rsi,rdi                                   ; 
  shr     rsi,1                                     ; 
  sbb     rax,rax                                   ; 
  sub     rsi,rax                                   ; 
  imul    rsi,rcx                                   ; 
  and     rax,rcx                                   ; 
  shr     rax,1                                     ; 
  sub     rax,rsi                                   ; 
  mul     rcx                                       ; 
  shl     rcx,01fh                                  ; 
  shr     rdx,1                                     ; 
  add     rcx,rdx                                   ; 
  mov     rax,rdi                                   ; 
  mul     rcx                                       ; 
  add     rax,rdi                                   ; 
  mov     rax,rcx                                   ; 
  adc     rdx,rdi                                   ; 
  sub     rax,rdx                                   ; 
  pop     rsi                                       ; SysV-to-MSVC ABI (restore rsi)
  pop     rdi                                       ; SysV-to-MSVC ABI (restore rdi)
  ret                                               ; 

__gmpn_invert_limb ENDP

                   ALIGN 16

__gmpn_invert_limb_sysv_abi PROC                    ; THIS IS SPECIAL because other assembler code
                                                    ; calls '__gmpn_invert_limb', which is now 
                                                    ; implemented for Visual C 64bit ABI, **NOT**
                                                    ; SysV AMD64 ABI => solution: also provide
                                                    ; the identical function with the gcc/SysV ABI

  mov     rax,rdi                                   ; 
  shr     rax,037h                                  ; 
  mov     r8,-512 + offset __gmpn_invert_limb_table ; 
  movzx   ecx,word ptr [r8+rax*2]                   ; 
  mov     rsi,rdi                                   ; 
  mov     eax,ecx                                   ; 
  imul    ecx,ecx                                   ; 
  shr     rsi,018h                                  ; 
  inc     rsi                                       ; 
  imul    rcx,rsi                                   ; 
  shr     rcx,028h                                  ; 
  shl     eax,0bh                                   ; 
  dec     eax                                       ; 
  sub     eax,ecx                                   ; 
  mov     rcx,01000000000000000h                    ; 
  imul    rsi,rax                                   ; 
  sub     rcx,rsi                                   ; 
  imul    rcx,rax                                   ; 
  shl     rax,0dh                                   ; 
  shr     rcx,02fh                                  ; 
  add     rcx,rax                                   ; 
  mov     rsi,rdi                                   ; 
  shr     rsi,1                                     ; 
  sbb     rax,rax                                   ; 
  sub     rsi,rax                                   ; 
  imul    rsi,rcx                                   ; 
  and     rax,rcx                                   ; 
  shr     rax,1                                     ; 
  sub     rax,rsi                                   ; 
  mul     rcx                                       ; 
  shl     rcx,01fh                                  ; 
  shr     rdx,1                                     ; 
  add     rcx,rdx                                   ; 
  mov     rax,rdi                                   ; 
  mul     rcx                                       ; 
  add     rax,rdi                                   ; 
  mov     rax,rcx                                   ; 
  adc     rdx,rdi                                   ; 
  sub     rax,rdx                                   ; 
  ret                                               ; 

__gmpn_invert_limb_sysv_abi ENDP

                  END
