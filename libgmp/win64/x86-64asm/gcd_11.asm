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

__gmpn_gcd_11 PROC

         push   rdi      ; SysV-to-MSVC ABI (save rdi)
         push   rsi      ; SysV-to-MSVC ABI (save rsi)
                         ; function parameter #1 in RCX (gcc assumes RDI)
                         ; function parameter #2 in RDX (gcc assumes RSI)
         mov    rdi,rcx  ; SysV-to-MSVC ABI (parameter #1 from rcx to rdi)
         mov    rsi,rdx  ; SysV-to-MSVC ABI (parameter #2 from rdx to rsi)
         mov    rdx,rsi  ; 
         sub    rdx,rdi  ; 
         je     l_002E   ; 
         ALIGN  16       ; 
l_0010:  tzcnt  rcx,rdx  ; 
         mov    rax,rdi  ; 
         sub    rdi,rsi  ; 
         cmovb  rdi,rdx  ; 
         cmovb  rsi,rax  ; 
         shr    rdi,cl   ; 
         mov    rdx,rsi  ; 
         sub    rdx,rdi  ; 
         jne    l_0010   ; 
l_002E:  mov    rax,rsi  ; 
         pop    rsi      ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi      ; SysV-to-MSVC ABI (restore rdi)
         ret             ; 

__gmpn_gcd_11 ENDP

;
; The next function is NOT USED anymore because Visual C is unable to return 128bit
; values (e.g. two 64bit in one struct) in the register pair RDX:RAX.
; The GNU Compiler Collection DOES exactly this. It is completely beyond me why
; Microsoft does not support this, too, because in former times, a multiplication
; of two 16bit values was INDEED returned in DX:AX (32bit result) - also by
; Microsoft C/C++ compilers...
;

              ALIGN 16

__gmpn_gcd_11_sysv_abi_cleanup PROC ; gcc_22.asm jumps to this SysV ABI function, 
                                    ; so we add the suffix '_cleanup' because this
                                    ; 'epilogue function' has to perform the
                                    ; cleanup of the ABI compatibility layer...
                                    ;
         mov    rdx,rsi             ; 
         sub    rdx,rdi             ; 
         je     l_002Ea             ; 
         ALIGN  16                  ; 
l_0010a: tzcnt  rcx,rdx             ; 
         mov    rax,rdi             ; 
         sub    rdi,rsi             ; 
         cmovb  rdi,rdx             ; 
         cmovb  rsi,rax             ; 
         shr    rdi,cl              ; 
         mov    rdx,rsi             ; 
         sub    rdx,rdi             ; 
         jne    l_0010a             ; 
l_002Ea: mov    rax,rsi             ; 
         pop    rsi                 ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                 ; SysV-to-MSVC ABI (restore rdi)
         ret                        ; 

__gmpn_gcd_11_sysv_abi_cleanup ENDP

             END
