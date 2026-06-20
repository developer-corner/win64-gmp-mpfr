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

              EXTERN  __gmpn_gcd_11_sysv_abi_cleanup : PROC ; not used anymore, read this:

;
; Folks, this is REALLY weird: In former times, all Microsoft C/C++ compilers
; were able to return 32bit values in the register pair DX:AX and 64bit values in
; the register pair EDX:EAX (might be the result of a MUL mnemonic).
;
; Guess what: They now DO NOT support the return of 128bit values in the register 
; pair RDX:RAX... The GNU Compiler Collection acts in exactly this way:
;
; The C function 'mpn_gcd_22' returns 'mp_double_limb_t', which is declared as follows:
;
; typedef struct
; {
;   mp_limb_t d0, d1; 
; } mp_double_limb_t;
;
; 'mp_limb_t' is always 64bit (UNIXs and MS Windows), i.e. this struct may be seen
; as a '128bit value'.
;
; The SysV AMD64 ABI (e.g. gcc) returns this in the register pair RDX:RAX. The
; original assembler implementation does exactly this. Moreover, it may forward to
; 'mpn_gcd_11', which just computes RAX (RDX is handles by 'mpn_gcd_22' in this
; case).
;
; OK, this DOES NOT work for our SysV AMD64 ABI to MSVC 64bit ABI compatibility
; layer, which is used by almost all assembler functions in this folder.
;
; So, how does this 'MS weird thing' works? The caller has to allocate space for
; a struct returned by a function. It passes the pointer to this memory in a
; 'HIDDEN FIRST ARGUMENT' to the callee.
; The callee has to fill the struct on exit AND has to return the pointer to this
; struct (used to be the initial, hidden argument) in the CPU register RAX - 
; WHAT A MESS...
;
; This means (for MSVC):
; ======================
;
; 1.) This function does NOT have four parameters:
;     __GMP_DECLSPEC mp_double_limb_t mpn_gcd_22 (mp_limb_t l1, mp_limb_t l2, mp_limb_t l3, mp_limb_t l4);
;     BUT FIVE (5) parameters INSTEAD:
;     __GMP_DECLSPEC mp_double_limb_t mpn_gcd_22 (**hidden parameter**, mp_limb_t, mp_limb_t, mp_limb_t, mp_limb_t);
; 2.) We have to adjust the register/stack locations of the four (normal) parameters, which fit into CPU registers
;     for both ABIs (SysV AMD64 ABI can carry up to six (6) parameters in registers, MSVC can carry up to
;     four (4) parameters in registers).
; 3.) We make use of the "spill stack area" or "home space" or "shadow space" - or
;     however this might be called - to store the first (hidden) parameter RCX for later usage.
;
; The stack (MSVC 64bit ABI) looks like this on function entry: (recall: originally, the four parameters went into RCX, RDX, R8, and R9)
; =============================================================
;
; with saving RDI and RSI: | without saving RDI and RSI: | content:
; -------------------------+-----------------------------+----------------------------------------------------------
;        [ESP+38]          |          [ESP+28]           | the (new) fifth function parameter (the fourth parameter
;                          |                             | in C) - parameter "mp_limb_t l4"
;        [ESP+30]          |          [ESP+20]           | "spill slot #4" for parameter #4 = R9
;        [ESP+28]          |          [ESP+18]           | "spill slot #3" for parameter #3 = R8
;        [ESP+20]          |          [ESP+10]           | "spill slot #2" for parameter #2 = RDX
;        [ESP+18]          |          [ESP+08]           | "spill slot #1" for parameter #1 = RCX
; -------------------------+-----------------------------+----------------------------------------------------------
;        [ESP+10]          |          [ESP+00]           | return address of caller that called __gmpn_gcd_22
; -------------------------+-----------------------------+----------------------------------------------------------
;        [ESP+08]          |            n/a              | pushed register RDI
;        [ESP+00]          |            n/a              | pushed register RSI
; -------------------------------------------------------+----------------------------------------------------------
;                         R9                             | parameter "mp_limb_t l3"
;                         R8                             | parameter "mp_limb_t l2"
;                         RDX                            | parameter "mp_limb_t l1"
;                         RCX                            | hidden first parameter pointing to two 64bit values, 
;                                                        | which will be the function's 128bit result
; -------------------------------------------------------+----------------------------------------------------------
;                           RETURN VALUE: RAX carries "hidden first parameter value"
;

              ALIGN 16

__gmpn_gcd_22 PROC

         push   rdi                      ; SysV-to-MSVC ABI (save rdi)
         push   rsi                      ; SysV-to-MSVC ABI (save rsi)
                                         ;
         mov    qword ptr [rsp+018h],rcx ; store hidden parameter #1 in spill slot #1
                                         ;
         mov    rdi,rdx                  ; function parameter #1 for gcc in RDI
         mov    rsi,r8                   ; function parameter #2 for gcc in RSI
         mov    rdx,r9                   ; function parameter #3 for gcc in RDX
         mov    rcx,qword ptr [rsp+038h] ; function parameter #4 for gcc in RCX
                                         ;
         ALIGN  16                       ;
                                         ;
l_0000:  mov    r10,rcx                  ; 
         sub    r10,rsi                  ; 
         je     l_0059                   ; 
         mov    r11,rdx                  ; 
         sbb    r11,rdi                  ; 
         tzcnt  rax,r10                  ; 
         mov    r8,rsi                   ; 
         sub    rsi,rcx                  ; 
         mov    r9,rdi                   ; 
         sbb    rdi,rdx                  ; 
l_001F:  cmovb  rsi,r10                  ; 
         cmovb  rdi,r11                  ; 
         cmovb  rcx,r8                   ; 
         cmovb  rdx,r9                   ; 
         xor    r10d,r10d                ; 
         sub    r10,rax                  ; 
         shlx   r9,rdi,r10               ; 
         shrx   rsi,rsi,rax              ; 
         shrx   rdi,rdi,rax              ; 
         or     rsi,r9                   ; 
         test   rdx,rdx                  ; 
         jne    l_0000                   ; 
         test   rdi,rdi                  ; 
         jne    l_0000                   ; 
         mov    rdi,rcx                  ; 
                                         ;
                                         ; in former times: jmp    __gmpn_gcd_11_sysv_abi_cleanup ; 
                                         ; 
         mov    rdx,rsi                  ; 
         sub    rdx,rdi                  ; 
         je     l_002Ea                  ; 
         ALIGN  16                       ; 
l_0010a: tzcnt  rcx,rdx                  ; 
         mov    rax,rdi                  ; 
         sub    rdi,rsi                  ; 
         cmovb  rdi,rdx                  ; 
         cmovb  rsi,rax                  ; 
         shr    rdi,cl                   ; 
         mov    rdx,rsi                  ; 
         sub    rdx,rdi                  ; 
         jne    l_0010a                  ; 
l_002Ea: mov    rax,rsi                  ; 
         mov    rcx,qword ptr [rsp+018h] ; get first hidden parameter back from spill area
         pop    rsi                      ; SysV-to-MSVC ABI (restore rsi)
         pop    rdi                      ; SysV-to-MSVC ABI (restore rdi)
         mov    [rcx],rax                ; store low result
         mov    [rcx+08h],rdx            ; store high result
         mov    rax,rcx                  ; return pointer to returned 128bit struct
         ret                             ; 
                                         ;
         ALIGN  16                       ;
l_0059:  mov    r10,rdx                  ; 
         sub    r10,rdi                  ; 
         je     l_007A                   ; 
         xor    r11,r11                  ; 
         mov    r8,rsi                   ; 
         mov    r9,rdi                   ; 
         tzcnt  rax,r10                  ; 
         mov    rsi,rdi                  ; 
         xor    rdi,rdi                  ; 
         sub    rsi,rdx                  ; 
         jmp    l_001F                   ; 
         ALIGN  16                       ;
l_007A:  mov    rax,rcx                  ; 
         pop    rsi                      ; SysV-to-MSVC ABI (restore rsi)
         mov    rcx,qword ptr [rsp+010h] ; get first hidden parameter back from spill area
         pop    rdi                      ; SysV-to-MSVC ABI (restore rdi)
         mov    [rcx],rax                ; store low result
         mov    [rcx+08h],rdx            ; store high result
         mov    rax,rcx                  ; return pointer to returned 128bit struct
         ret                             ; 

__gmpn_gcd_22 ENDP

             END
