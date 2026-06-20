/*

Copyright 1996-2026 Free Software Foundation, Inc.

This file is part of the GNU MP Library.

The GNU MP Library is free software; you can redistribute it and/or modify
it under the terms of either:

  * the GNU Lesser General Public License as published by the Free
    Software Foundation; either version 3 of the License, or (at your
    option) any later version.

or

  * the GNU General Public License as published by the Free Software
    Foundation; either version 2 of the License, or (at your option) any
    later version.

or both in parallel, as here.

The GNU MP Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received copies of the GNU General Public License and the
GNU Lesser General Public License along with the GNU MP Library.  If not,
see https://www.gnu.org/licenses/.
*/

/* manually edited to work for MS Windows 64bit and MS Visual C/C++ 2026 CE */

#define PACKAGE "gmp"
#define VERSION "6.3.0"
#define PACKAGE_BUGREPORT "gmp-bugs@gmplib.org (see https://gmplib.org/manual/Reporting-Bugs.html)"
#define PACKAGE_NAME "GNU MP"
#define PACKAGE_STRING "GNU MP 6.3.0"
#define PACKAGE_TARNAME "gmp"
#define PACKAGE_URL "http://www.gnu.org/software/gmp/"
#define PACKAGE_VERSION "6.3.0"
#define SIZEOF_MP_LIMB_T 8
#define SIZEOF_UNSIGNED 4
#define SIZEOF_UNSIGNED_LONG 4
#define SIZEOF_UNSIGNED_SHORT 2
#define SIZEOF_VOID_P 8
#define GMP_MPARAM_H_SUGGEST "./mpn/generic/gmp-mparam.h"
#define HAVE_ALLOCA 1
#define HAVE_ALLOCA_H 1
#define HAVE_DECL_FGETC 1
#define HAVE_DECL_FSCANF 1
#define HAVE_DECL_UNGETC 1
#define HAVE_DECL_VFPRINTF 1
#define HAVE_DOUBLE_IEEE_LITTLE_ENDIAN 1
#define HAVE_FCNTL_H 1
#define HAVE_FLOAT_H 1
#define HAVE_GETTIMEOFDAY 1
#define HAVE_HOST_CPU_FAMILY_x86_64 1
#define HAVE_INTMAX_T 1
#define HAVE_INTPTR_T 1
#define HAVE_INTTYPES_H 1
#define HAVE_LIMB_LITTLE_ENDIAN 1
#define HAVE_LONG_DOUBLE 1
#define HAVE_LONG_LONG 1
#define HAVE_MEMORY_H 1
#define HAVE_MEMSET 1
#define HAVE_MMAP 1
#define HAVE_MPROTECT 1
#define HAVE_PTRDIFF_T 1
#define HAVE_QUAD_T 1
#define HAVE_RAISE 1
#define HAVE_SPEED_CYCLECOUNTER 2
#define HAVE_STACK_T 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRCHR 1
#define HAVE_STRERROR 1
#define HAVE_STRING_H 1
#define HAVE_STRNLEN 1
#define HAVE_STRTOL 1
#define HAVE_STRTOUL 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_UINT_LEAST32_T 1
#define HAVE_UNISTD_H 1
#define HAVE_VSNPRINTF 1
#define STDC_HEADERS 1
#define TIME_WITH_SYS_TIME 1
#define TUNE_SQR_TOOM2_MAX SQR_TOOM2_MAX_GENERIC
#define WANT_FFT 1
#define WANT_TMP_ALLOCA 1
#define restrict __restrict

#ifndef _M_ARM64 

#define X86_ASM_MULX 1

#define HAVE_NATIVE_mpn_copyd 1
#define HAVE_NATIVE_mpn_copyi 1
#define HAVE_NATIVE_mpn_add_n 1
#define HAVE_NATIVE_mpn_add_nc 1
#define HAVE_NATIVE_mpn_and_n 1
#define HAVE_NATIVE_mpn_andn_n 1
#define HAVE_NATIVE_mpn_ior_n 1
#define HAVE_NATIVE_mpn_iorn_n 1
#define HAVE_NATIVE_mpn_lshift 1
#define HAVE_NATIVE_mpn_lshiftc 1
#define HAVE_NATIVE_mpn_nand_n 1
#define HAVE_NATIVE_mpn_nior_n 1
#define HAVE_NATIVE_mpn_popcount 1
#define HAVE_NATIVE_mpn_rshift 1
#define HAVE_NATIVE_mpn_sub_n 1
#define HAVE_NATIVE_mpn_sub_nc 1
#define HAVE_NATIVE_mpn_xor_n 1
#define HAVE_NATIVE_mpn_xnor_n 1
#define HAVE_NATIVE_mpn_mul_1 1
#define HAVE_NATIVE_mpn_mul_1c 1
#define HAVE_NATIVE_mpn_mul_2 1
#define HAVE_NATIVE_mpn_mul_basecase 1
#define HAVE_NATIVE_mpn_mullo_basecase 1
#define HAVE_NATIVE_mpn_mod_34lsub1 1
#define HAVE_NATIVE_mpn_addlsh1_n 1
#define HAVE_NATIVE_mpn_addlsh2_n 1
#define HAVE_NATIVE_mpn_addlsh_n 1
#define HAVE_NATIVE_mpn_addlsh1_nc 1
#define HAVE_NATIVE_mpn_bdiv_dbm1c 1
#define HAVE_NATIVE_mpn_bdiv_q_1 1
#define HAVE_NATIVE_mpn_pi1_bdiv_q_1 1
#define HAVE_NATIVE_mpn_cnd_add_n 1
#define HAVE_NATIVE_mpn_cnd_sub_n 1
#define HAVE_NATIVE_mpn_com 1
#define HAVE_NATIVE_mpn_div_qr_1n_pi1 1
#define HAVE_NATIVE_mpn_divexact_1 1
#define HAVE_NATIVE_mpn_divrem_1 1
#define HAVE_NATIVE_mpn_divrem_2 1
#define HAVE_NATIVE_mpn_gcd_11 1
#define HAVE_NATIVE_mpn_gcd_22 1
#define HAVE_NATIVE_mpn_hamdist 1
#define HAVE_NATIVE_mpn_invert_limb 1
#define HAVE_NATIVE_mpn_mod_1_1p 1
#define HAVE_NATIVE_mpn_mod_1s_2p 1
#define HAVE_NATIVE_mpn_mod_1s_4p 1
#define HAVE_NATIVE_mpn_modexact_1_odd 1
#define HAVE_NATIVE_mpn_modexact_1c_odd 1
#define HAVE_NATIVE_mpn_preinv_divrem_1 1
#define HAVE_NATIVE_mpn_rsblsh1_n 1
#define HAVE_NATIVE_mpn_rsblsh2_n 1
#define HAVE_NATIVE_mpn_rsblsh_n 1
#define HAVE_NATIVE_mpn_rsblsh1_nc 1
#define HAVE_NATIVE_mpn_rsh1add_n 1
#define HAVE_NATIVE_mpn_rsh1add_nc 1
#define HAVE_NATIVE_mpn_rsh1sub_n 1
#define HAVE_NATIVE_mpn_rsh1sub_nc 1
#define HAVE_NATIVE_mpn_sbpi1_bdiv_r 1
#define HAVE_NATIVE_mpn_sqr_basecase 1
#define HAVE_NATIVE_mpn_sqr_diag_addlsh1 1
#define HAVE_NATIVE_mpn_sublsh1_n 1
#define HAVE_NATIVE_mpn_sublsh1_nc 1

#else /* _M_ARM64 */

#define HAVE_NATIVE_mpn_addaddmul_1msb0 1           /* from the GNU MP Library with Apple M1 => works on Asus Notebook with Snapdragon X */
#define HAVE_NATIVE_mpn_addmul_1c 1                 /* from the GNU MP Library with Apple M1 => works on Asus Notebook with Snapdragon X */
#define HAVE_NATIVE_mpn_sqr_basecase 1              /* from the GNU MP Library with Apple M1 => works on Asus Notebook with Snapdragon X */

#define HAVE_NATIVE_mpn_add_n 1
#define HAVE_NATIVE_mpn_add_nc 1
#define HAVE_NATIVE_mpn_addlsh1_n 1
#define HAVE_NATIVE_mpn_addlsh2_n 1
#define HAVE_NATIVE_mpn_and_n 1
#define HAVE_NATIVE_mpn_andn_n 1
#define HAVE_NATIVE_mpn_bdiv_dbm1c 1
#define HAVE_NATIVE_mpn_bdiv_q_1 1
#define HAVE_NATIVE_mpn_pi1_bdiv_q_1 1
#define HAVE_NATIVE_mpn_cnd_add_n 1
#define HAVE_NATIVE_mpn_cnd_sub_n 1
#define HAVE_NATIVE_mpn_com 1
#define HAVE_NATIVE_mpn_copyd 1
#define HAVE_NATIVE_mpn_copyi 1
#define HAVE_NATIVE_mpn_divrem_1 1
#define HAVE_NATIVE_mpn_gcd_11 1
#define HAVE_NATIVE_mpn_gcd_22 1
#define HAVE_NATIVE_mpn_hamdist 1
#define HAVE_NATIVE_mpn_invert_limb 1
#define HAVE_NATIVE_mpn_ior_n 1
#define HAVE_NATIVE_mpn_iorn_n 1
#define HAVE_NATIVE_mpn_lshift 1
#define HAVE_NATIVE_mpn_lshiftc 1
#define HAVE_NATIVE_mpn_mod_34lsub1 1
#define HAVE_NATIVE_mpn_mul_1 1
#define HAVE_NATIVE_mpn_mul_1c 1
#define HAVE_NATIVE_mpn_nand_n 1
#define HAVE_NATIVE_mpn_nior_n 1
#define HAVE_NATIVE_mpn_popcount 1
#define HAVE_NATIVE_mpn_preinv_divrem_1 1
#define HAVE_NATIVE_mpn_rsblsh1_n 1
#define HAVE_NATIVE_mpn_rsblsh2_n 1
#define HAVE_NATIVE_mpn_rsh1add_n 1
#define HAVE_NATIVE_mpn_rsh1sub_n 1
#define HAVE_NATIVE_mpn_rshift 1
#define HAVE_NATIVE_mpn_sqr_diag_addlsh1 1
#define HAVE_NATIVE_mpn_sub_n 1
#define HAVE_NATIVE_mpn_sub_nc 1
#define HAVE_NATIVE_mpn_sublsh1_n 1
#define HAVE_NATIVE_mpn_sublsh2_n 1
#define HAVE_NATIVE_mpn_xor_n 1
#define HAVE_NATIVE_mpn_xnor_n 1

#endif

#define RETSIGTYPE void
#define HAVE_ALARM 1
#define HAVE_RAISE 1
