# MS Visual C/C++ Makefile for the GNU MP Library
# 
# Copyright 2026 Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
# 
# The GNU MP Library is free software; you can redistribute it and/or modify
# it under the terms of either:
# 
#   * the GNU Lesser General Public License as published by the Free
#     Software Foundation; either version 3 of the License, or (at your
#     option) any later version.
# 
# or
# 
#   * the GNU General Public License as published by the Free Software
#     Foundation; either version 2 of the License, or (at your option) any
#     later version.
# 
# or both in parallel, as here.
# 
# The GNU MP Library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
# 
# You should have received copies of the GNU General Public License and the
# GNU Lesser General Public License along with the GNU MP Library.  If not,
# see https://www.gnu.org/licenses/.

#
# The main work was invested in the x86-64 assembler files, which have been
# converted from the GNU AS AT&T syntax to the Microsoft Assembler (Intel)
# syntax and the System V AMD64 ABI was converted to the MS Visual C AMD64 ABI.
#

#
# Use: ASSEMBLY=         to activate MASM x86-64 assembler
# ---- VERBOSE=          to show all nmake messages (default: inhibit all messages)
#      MORE_VERBOSE=     use /W3 for C compiler, which emits tons of warnings from original gcc-tailored source
#      DEBUG=            to build without optimizations and with debug infos
#      DEBUG_IN_RELEASE= emit everything with debugging symbols, but compile full optimized
#      DYNAMIC_RT=       to use dynamic C runtime (/MD or /MDd) instead of static runtime (/MT or /MTd - default)
#                        CAUTION: building DLLs with static runtime BREAKS certain
#                        -------- library functions using 'FILE*' because those pointers are INVALID within the DLL
#      LINK_DLL=         link tools (e.g. test tools and tuneup) with DLL (.dll, dynamically) and not with static library (.lib)
#      FULL_64BIT=       declare mp_size_t as full 64bit instead of (default) 32bit (because Visual C/C++ has only 32bit 'long')
#                        CAUTION: You MUST NOT use such a build with libmpfr because this breaks libmpfr
#      SECURITY=         enable additional runtime and stack checks
#      INTEL64=          use '/favor:INTEL64'
#      AMD64=            use '/favor:ADM64'
#      ARM64=            build this stuff for Aarch64 (aka ARM64) on Windows
#      ARCH=xxx          (only x86-64) use 'xxx=AVX2' or 'xxx=AVX512' to switch to this architecture, library might not run on other CPUs, though.
#      PATCH=<file>      specify patch utility location; defaults to 'git for Windows bundled patch'
#
# The Makefile switch '__DLL_EXPORTS__' is FOR INTERNAL USE ONLY!!!
#

!ifndef PATCH
PATCH = "c:\Program Files\Git\usr\bin\patch.exe"
!endif

!include win64\Makefile.libgmp.files

!ifdef ASSEMBLY
ALL_MAKEFILE_DEFINES = ASSEMBLY=
!else
ALL_MAKEFILE_DEFINES =
!endif

!ifdef LINK_DLL
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) LINK_DLL=
!endif

!ifdef MORE_VERBOSE
VERBOSE=
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) MORE_VERBOSE=
!endif

!ifdef VERBOSE
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) VERBOSE=
PREFIX =
SUFFIX =
!else
PREFIX = @
SUFFIX = >NUL
!endif

# for DLL builds, define both __GMP_LIBGMP_DLL and __GMP_WITHIN_GMP
#
# for programs importing a DLL, just define __GMP_LIBGMP_DLL
#

# You may include /W3 to all CFLAGS if you want to see lots of warnings...
# Please note that size_t is 64bit but long/signed long/long int and all unsigned types are 32bit only!

!ifndef ARM64
CFLAGS_COMMON = /D_CRT_SECURE_NO_WARNINGS /D_MBCS /Y- /DHAVE_CONFIG_H /fp:precise /DHAVE_HOST_CPU_zen=1 /nologo
!else
CFLAGS_COMMON = /D_CRT_SECURE_NO_WARNINGS /D_MBCS /Y- /DHAVE_CONFIG_H /fp:precise /nologo
!endif

#CFLAGS = $(CFLAGS_COMMON) /std:c17 /I. /I.\inc /I..
#CXXFLAGS = $(CFLAGS_COMMON) /std:c++20 /permissive- /GR /EHsc /I. /I.\inc /I..
# you may define /DTRACE to check what is going wrong with the tuneup.exe tool on MS Windows...
#CFLAGS_TUNEUP = $(CFLAGS_COMMON) /DTUNE_PROGRAM_BUILD=1 /std:c17 /I.\tests /I. /I.\inc /I. /I..

CFLAGS = $(CFLAGS_COMMON) /std:c17 /I. /I./mpn
CXXFLAGS = $(CFLAGS_COMMON) /std:c++20 /permissive- /GR /EHsc /I. /I./mpn
# you may define /DTRACE to check what is going wrong with the tuneup.exe tool on MS Windows...
CFLAGS_TUNEUP = $(CFLAGS_COMMON) /DTUNE_PROGRAM_BUILD=1 /std:c17 /I.\tests /I. /I./mpn


!ifdef FULL_64BIT
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) FULL_64BIT=
CFLAGS = $(CFLAGS) /D_MP_SIZE_64BIT=1
CXXFLAGS = $(CXXFLAGS) /D_MP_SIZE_64BIT=1
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /D_MP_SIZE_64BIT=1
!endif

!ifdef SECURITY
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) SECURITY=
CFLAGS = $(CFLAGS) /GS /RTCs /fsanitize=address /sdl
CXXFLAGS = $(CXXFLAGS) /GS /RTCs /fsanitize=address /sdl
!else
CFLAGS = $(CFLAGS) /GS-
CXXFLAGS = $(CXXFLAGS) /GS-
!endif

!ifdef DYNAMIC_RT

ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) DYNAMIC_RT=

!ifdef DEBUG
CFLAGS = $(CFLAGS) /MDd
CXXFLAGS = $(CXXFLAGS) /MDd
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /MDd
CFLAGS_libtest = $(CFLAGS_libtest) /MDd
!else
CFLAGS = $(CFLAGS) /MD
CXXFLAGS = $(CXXFLAGS) /MD
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /MD
CFLAGS_libtest = $(CFLAGS_libtest) /MD
!endif

!else

!ifdef DEBUG
CFLAGS = $(CFLAGS) /MTd /D_STATIC_RT
CXXFLAGS = $(CXXFLAGS) /MTd /D_STATIC_RT
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /MTd /D_STATIC_RT
CFLAGS_libtest = $(CFLAGS_libtest) /MTd /D_STATIC_RT
!else
CFLAGS = $(CFLAGS) /MT /D_STATIC_RT
CXXFLAGS = $(CXXFLAGS) /MT /D_STATIC_RT
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /MT /D_STATIC_RT
CFLAGS_libtest = $(CFLAGS_libtest) /MT /D_STATIC_RT
!endif

!endif

#
# can be only of SSE2|SSE4.2|AVX|AVX2|AVX512|AVX10.x for Intel/AMD CPUs, 
# for ARM64 it can be 'armv8.[0-9][+feature]' or 'armv9.[0-4][+feature]'
# => "armv8.0" is the default
#

!ifdef ARCH
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) ARCH=$(ARCH)
CFLAGS = $(CFLAGS) /arch:$(ARCH)
CXXFLAGS = $(CXXFLAGS) /arch:$(ARCH)
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /arch:$(ARCH)
!endif

!ifdef DEBUG
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) DEBUG=
CFLAGS = $(CFLAGS) /Od /Zi /D_DEBUG /DDEBUG /FR
CXXFLAGS = $(CXXFLAGS) /Od /Zi /D_DEBUG /DDEBUG /FR
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /Od /Zi /D_DEBUG /DDEBUG /FR
!ifdef ARM64
ASMFLAGS = -g
!else
ASMFLAGS = /Zi
!endif
!else
CFLAGS = $(CFLAGS) /Ox /Ob2 /Oi /Ot /Oy /DNDEBUG
CXXFLAGS = $(CXXFLAGS) /Ox /Ob2 /Oi /Ot /Oy /DNDEBUG
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /Ox /Ob2 /Oi /Ot /Oy /DNDEBUG
ASMFLAGS =
!endif

!ifdef DEBUG_IN_RELEASE
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) DEBUG_IN_RELEASE=
CFLAGS = $(CFLAGS) /Zi
CXXFLAGS = $(CXXFLAGS) /Zi
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /Zi
!ifdef ARM64
ASMFLAGS = -g
!else
ASMFLAGS = /Zi
!endif
!endif

!ifdef ARM64
MACHINE = ARM64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) ARM64=
AS = armasm64.exe
!else
MACHINE = X64
AS = ml64.exe
!ifdef INTEL64
CFLAGS = $(CFLAGS) /favor:INTEL64
CXXFLAGS = $(CXXFLAGS) /favor:INTEL64
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /favor:INTEL64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) INTEL64=
!else
!ifdef AMD64
CFLAGS = $(CFLAGS) /favor:AMD64
CXXFLAGS = $(CXXFLAGS) /favor:AMD64
CFLAGS_TUNEUP = $(CFLAGS_TUNEUP) /favor:AMD64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) AMD64=
!endif
!endif
!endif

!ifndef ARM64
!ifdef FULL_64BIT
ASMFLAGS = $(ASMFLAGS) /DFULL_64BIT=1
!else
ASMFLAGS = $(ASMFLAGS) /DFULL_64BIT=0
!endif
!endif

!ifdef VERBOSE
!ifdef MORE_VERBOSE
CFLAGS = /W3 $(CFLAGS)
CXXFLAGS = /W3 $(CXXFLAGS)
CFLAGS_TUNEUP = /W3 $(CFLAGS_TUNEUP)
!endif
!endif

CFLAGS_libtest = $(CFLAGS) /I.\tests

CFLAGS_LOCAL_TOOLS = /nologo /DNDEBUG /D_MBCS /MT /Ox /Ob2 /Oi /Ot /Oy

#
# DO *NOT* define __DLL_EXPORTS__ for nmake, this is just used internally!!!
#

!ifdef __DLL_EXPORTS__
CFLAGS = /D__GMP_LIBGMP_DLL=1 $(CFLAGS)
CXXFLAGS = /D__GMP_LIBGMP_DLL=1 $(CXXFLAGS)
CFLAGS_TUNEUP = /D__GMP_LIBGMP_DLL=1 $(CFLAGS_TUNEUP)
CFLAGS_libtest = /D__GMP_LIBGMP_DLL=1 $(CFLAGS_libtest)
!endif

!ifdef LINK_DLL
CFLAGS = /D__GMP_LIBGMP_DLL=1 $(CFLAGS)
CXXFLAGS = /D__GMP_LIBGMP_DLL=1 $(CXXFLAGS)
CFLAGS_TUNEUP = /D__GMP_LIBGMP_DLL=1 $(CFLAGS_TUNEUP)
CFLAGS_libtest = /D__GMP_LIBGMP_DLL=1 $(CFLAGS_libtest)
LIBGMP_NAME=libgmp-imp.lib
!else
LIBGMP_NAME=libgmp.lib
!endif

#
# DLL linker flags, please note that a static library is ALWAYS created first (by nmake recursion)
#

DLL_FLAGS = /DLL /MANIFEST /NXCOMPAT /MACHINE:$(MACHINE) /SUBSYSTEM:CONSOLE /OPT:NOREF /ERRORREPORT:PROMPT /DEBUG:NONE /nologo /TLBID:1 /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /DYNAMICBASE "kernel32.lib"
!ifdef DEBUG
DLL_FLAGS = $(DLL_FLAGS) /DEBUG:FULL /PDB:"libgmp.pdb"
!endif

!ifdef DEBUG
EXTRA_EXE_FLAGS = /DEBUG:FULL
!else
EXTRA_EXE_FLAGS =
!endif

!ifdef DEBUG_IN_RELEASE
DLL_FLAGS = $(DLL_FLAGS) /DEBUG:FULL
EXTRA_EXE_FLAGS = /DEBUG:FULL
!endif

!ifndef ARM64

!ifdef ASSEMBLY
MODULE_DEFINITION_FILE=win64\def\libgmp-x86-64-assembly.def
!else
MODULE_DEFINITION_FILE=win64\def\libgmp-x86-64-no-assembly.def
!endif

!else

!ifdef ASSEMBLY
MODULE_DEFINITION_FILE=win64\def\libgmp-arm64-assembly.def
!else
MODULE_DEFINITION_FILE=win64\def\libgmp-arm64-no-assembly.def
!endif

!endif

#
# main menu follows...
#

all: static_lib check tuneup

patch:
	$(PATCH) < win64\patches\gmp-impl.h.patch
	$(PATCH) < win64\patches\longlong.h.patch
	$(PATCH) < win64\patches\memory.c.patch
	$(PATCH) -p1 < win64\patches\mpf.patch
	$(PATCH) -p1 < win64\patches\rand.patch
	$(PATCH) -p1 < win64\patches\tests.patch
	$(PATCH) -p1 < win64\patches\tune.patch

#
# WTF: Windows required Administrator privileges to establish
#      symbolic links -> we just copy the stuff here instead
#
	
mpn_copy:
	@copy .\mpn\generic\*.c mpn\ >NUL
	@copy .\mpn\generic\logops_n.c mpn\and_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\andn_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\nand_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\ior_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\iorn_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\nior_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\xor_n.c >NUL
	@copy .\mpn\generic\logops_n.c mpn\xnor_n.c >NUL
	@del .\mpn\logops_n.c >NUL
	@copy .\mpn\generic\popham.c mpn\hamdist.c >NUL
	@copy .\mpn\generic\popham.c mpn\popcount.c >NUL
	@del .\mpn\popham.c >NUL
	@copy .\mpn\generic\sec_aors_1.c mpn\sec_add_1.c >NUL
	@copy .\mpn\generic\sec_aors_1.c mpn\sec_sub_1.c >NUL
	@del .\mpn\sec_aors_1.c >NUL
	@copy .\mpn\generic\sec_div.c mpn\sec_div_qr.c >NUL
	@copy .\mpn\generic\sec_div.c mpn\sec_div_r.c >NUL
	@del .\mpn\sec_div.c >NUL
	@copy .\mpn\generic\sec_pi1_div.c mpn\sec_pi1_div_qr.c >NUL
	@copy .\mpn\generic\sec_pi1_div.c mpn\sec_pi1_div_r.c >NUL
	@del .\mpn\sec_pi1_div.c >NUL

generate_tables_headers:
	@cl $(CFLAGS_LOCAL_TOOLS) /Fecolored_print.exe win64\src\colored_print.c >NUL
	@colored_print "Generating tables / header files"
	@colored_print "Generating" --1st=fac_table.h --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-fac.obj /Fegen-fac.exe gen-fac.c >NUL
	@.\gen-fac.exe 64 0 >.\fac_table.h
	@colored_print "Generating" --1st=sieve_table.h --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-sieve.obj /Fegen-sieve.exe gen-sieve.c >NUL
	@.\gen-sieve.exe 64 >.\sieve_table.h
	@colored_print "Generating" --1st=fib_table.h --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-fib.obj /Fegen-fib.exe gen-fib.c >NUL
	@.\gen-fib header 64 0 >.\fib_table.h
	@colored_print "Generating" "--1st=mpn\fib_table.c" --level=2
	@.\gen-fib table 64 0 >.\mpn\fib_table.c
	@colored_print "Generating" --1st=mp-bases.h --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-bases.obj /Fegen-bases.exe gen-bases.c >NUL
	@.\gen-bases header 64 0 >.\mp_bases.h
	@colored_print "Generating" "--1st=mpn\mp_bases.c" --level=2
	@.\gen-bases table 64 0 >.\mpn\mp_bases.c
	@colored_print "Generating" --1st=trialdivtab.h --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-trialdivtab.obj /Fegen-trialdivtab.exe gen-trialdivtab.c >NUL
	@.\gen-trialdivtab.exe 64 8000 >.\trialdivtab.h
	@colored_print "Generating" "--1st=mpn\jacobitab.h" --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-jacobitab.obj /Fegen-jacobitab.exe gen-jacobitab.c >NUL
	@.\gen-jacobitab.exe >.\mpn\jacobitab.h
	@colored_print "Generating" "--1st=mpn\perfsqr.h" --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /I. /Fogen-psqr.obj /Fegen-psqr.exe gen-psqr.c >NUL
	@.\gen-psqr.exe 64 0 >.\mpn\perfsqr.h

prepare_headers:
	@copy .\win64\inc\gmp.h .\gmp.h >NUL
	@copy .\win64\inc\unistd.h .\unistd.h >NUL
!ifdef ASSEMBLY
	@copy .\win64\inc\config-with-asm.h .\config.h >NUL
!ifdef ARM64
	@copy .\win64\inc\mparam-arm64\gmp-mparam.h .\gmp-mparam.h >NUL
!else
!ifdef INTEL64
	@copy .\win64\inc\mparam-x86-64-intel\gmp-mparam.h .\gmp-mparam.h >NUL
!else
!ifdef AMD64
	@copy .\win64\inc\mparam-x86-64-amd\gmp-mparam.h .\gmp-mparam.h >NUL
!else
	@copy .\win64\inc\mparam-x86-64-generic\gmp-mparam.h .\gmp-mparam.h >NUL
!endif
!endif
!endif	
!else
	@copy .\win64\inc\config-without-asm.h .\config.h >NUL
	@copy .\win64\inc\mparam-generic\gmp-mparam.h .\gmp-mparam.h >NUL
!endif

prepare: generate_tables_headers prepare_headers mpn_copy
	@colored_print "Preparing"
	@colored_print "Checking for executable patch.exe tool" --level=2
	@$(PATCH) --version >NUL 2>&1
	@colored_print "Compiling + linking: version resource creation tool" --level=2
	@cl $(CFLAGS_LOCAL_TOOLS) /Fecreate_version_resource.exe win64\src\create_version_resource.c >NUL
	@colored_print "Creating build information" --level=2
!ifdef DEBUG
	@create_version_resource version.rc .\gmp.h DEBUG $(ALL_MAKEFILE_DEFINES) >.\build.c
!else
	@create_version_resource version.rc .\gmp.h RELEASE $(ALL_MAKEFILE_DEFINES) >.\build.c
!endif
	$(PREFIX)rc version.rc $(SUFFIX)
	@colored_print "Compiling generated build.c" --level=2
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Fobuild.obj /c build.c $(SUFFIX)

!ifdef ARM64
BITSCAN_OBJECT = win64\arm64asm\bitscan.obj
!else
BITSCAN_OBJECT = win64\x86-64asm\bitscan.obj
!endif
objects: prepare mpn mpz mpq mpf printf scanf rand libgmp cxx $(BITSCAN_OBJECT)

#
# static_lib: do NOT use "$**" here
#

!ifdef ASSEMBLY

static_lib: objects
	@colored_print "Linking" "--1st=static library" "--2nd=libgmp.lib" --level=2
!ifdef ARM64
	$(PREFIX)lib /OUT:".\libgmp.lib" /IGNORE:4006 /MACHINE:$(MACHINE) /nologo $(MPN_ASM_FILES_ARM64) $(MPN_FILES_ASM_ARM64) $(MPZ_FILES) $(MPQ_FILES) $(MPF_FILES) $(PRINTF_FILES) $(SCANF_FILES) $(RAND_FILES) $(LIBGMP_FILES) $(CXX_FILES) $(BITSCAN_OBJECT) build.obj $(SUFFIX)
!else
	$(PREFIX)lib /OUT:".\libgmp.lib" /IGNORE:4006 /MACHINE:$(MACHINE) /nologo $(MPN_ASM_FILES) $(MPN_FILES_ASM) $(MPZ_FILES) $(MPQ_FILES) $(MPF_FILES) $(PRINTF_FILES) $(SCANF_FILES) $(RAND_FILES) $(LIBGMP_FILES) $(CXX_FILES) $(BITSCAN_OBJECT) build.obj $(SUFFIX)
!endif

!else

static_lib: objects
	@colored_print "Linking" "--1st=static library" "--2nd=libgmp.lib" --level=2
	$(PREFIX)lib /OUT:".\libgmp.lib" /IGNORE:4006 /MACHINE:$(MACHINE) /nologo $(MPN_FILES) $(MPZ_FILES) $(MPQ_FILES) $(MPF_FILES) $(PRINTF_FILES) $(SCANF_FILES) $(RAND_FILES) $(LIBGMP_FILES) $(CXX_FILES) $(BITSCAN_OBJECT) build.obj $(SUFFIX)

!endif

dynamic_lib:
  @cl $(CFLAGS_LOCAL_TOOLS) /Fecolored_print.exe win64\src\colored_print.c >NUL
	@colored_print "Creating" "--1st=dynamic library" "--2nd=libgmp.dll" --level=1 --section=DLL
	@colored_print "Creating" "--1st=static library" "--2nd=libgmp.lib" --level=2 --section=DLL
	$(PREFIX)nmake /f win64\Makefile /nologo clean
	$(PREFIX)nmake /f win64\Makefile /nologo __DLL_EXPORTS__= $(ALL_MAKEFILE_DEFINES) static_lib
	@copy win64\src\dllmain.c dllmain.c >NUL
	@colored_print "C compiling" --1st=dllmain.c --2nd=dllmain.obj --level=2 --section=DLL
	$(PREFIX)cl $(CFLAGS) /Fodllmain.obj /c dllmain.c $(SUFFIX)
	@colored_print "Linking dynamic library" --1st=libgmp.dll "--inf=with import library" --2nd=libgmp-imp.lib --level=2 --section=DLL
	$(PREFIX)link /IGNORE:4273 $(DLL_FLAGS) /OUT:"libgmp.dll" /ManifestFile:"libgmp.intermediate.manifest" \
	/IMPLIB:"libgmp-imp.lib" libgmp.lib dllmain.obj version.res /DEF:"$(MODULE_DEFINITION_FILE)" $(SUFFIX)

libtests: $(LIBTEST_FILES)
	$(PREFIX)lib /OUT:".\tests\libtests.lib" /MACHINE:$(MACHINE) /nologo $(LIBTEST_FILES) $(SUFFIX)

!ifdef LINK_DLL

check:	dynamic_lib libtests $(CHECK_FILES)
	@copy win64\src\wintestrunner.c .\tests\ >NUL
	@copy win64\src\all_tests.rsp .\tests\ >NUL
	@cl $(CFLAGS_libtest) /Fetests\wintestrunner.exe tests\wintestrunner.c >NUL
	$(PREFIX).\tests\wintestrunner.exe .\tests\all_tests.rsp

!else

check:	static_lib libtests $(CHECK_FILES)
	@copy win64\src\wintestrunner.c .\tests\ >NUL
	@copy win64\src\all_tests.rsp .\tests\ >NUL
	@cl $(CFLAGS_libtest) /Fetests\wintestrunner.exe tests\wintestrunner.c >NUL
	$(PREFIX).\tests\wintestrunner.exe .\tests\all_tests.rsp

!endif

clean:
	@echo Cleaning up...
	@del .\fac_table.h >NUL 2>&1
	@del .\sieve_table.h >NUL 2>&1
	@del .\fib_table.h >NUL 2>&1
	@del .\mpn\fib_table.c >NUL 2>&1
	@del .\mp_bases.h >NUL 2>&1
	@del .\mpn\mp_bases.c >NUL 2>&1
	@del .\trialdivtab.h >NUL 2>&1
	@del .\mpn\jacobitab.h >NUL 2>&1
	@del .\mpn\perfsqr.h >NUL 2>&1
	@del /q/s *.obj >NUL 2>&1
	@del /q/s *.lib >NUL 2>&1
	@del /q/s *.exe >NUL 2>&1
	@del /q/s *.obj >NUL 2>&1
	@del /q/s *.pdb >NUL 2>&1
	@del /q/s *.ilk >NUL 2>&1
	@del /q/s *.sbr >NUL 2>&1
	@del /q/s *.exp >NUL 2>&1
	@del /q/s *.dll >NUL 2>&1
	@del /q/s *.out >NUL 2>&1
	@del /q/s *.intermediate.manifest >NUL 2>&1
	@del __time__consumed >NUL 2>&1
	@del build.c >NUL 2>&1
	@del version.rc >NUL 2>&1
	@del version.res >NUL 2>&1

!ifdef ASSEMBLY

!ifdef ARM64
mpn:	$(MPN_ASM_FILES_ARM64) $(MPN_FILES_ASM_ARM64)
!else
mpn:  	$(MPN_ASM_FILES) $(MPN_FILES_ASM)
!endif

!else

mpn:	$(MPN_FILES)

!endif

mpz:	$(MPZ_FILES)

mpq:	$(MPQ_FILES)

mpf:	$(MPF_FILES)

printf:	$(PRINTF_FILES)

scanf:	$(SCANF_FILES)

rand:	$(RAND_FILES)

libgmp:	$(LIBGMP_FILES)

cxx:	$(CXX_FILES)

#
# Rules
#

{tests}.c{tests}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=LIBTEST
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\$(*B).obj /c tests\$(*B).c $(SUFFIX)

{cxx}.cc{cxx}.obj:
	@colored_print "C++ compiling" --1st=$(*B).cc --2nd=$(*B).obj --section=CXX
	$(PREFIX)cl $(CXXFLAGS) /D__GMP_WITHIN_GMP=1 /Focxx\$(*B).obj /c cxx\$(*B).cc $(SUFFIX)

{mpn}.c{mpn}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=MPN
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /DOPERATION_$(*B) /Fompn\$(*B).obj /c mpn\$(*B).c $(SUFFIX)

{mpz}.c{mpz}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=MPZ
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Fompz\$(*B).obj /c mpz\$(*B).c $(SUFFIX)

{mpq}.c{mpq}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=MPQ
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Fompq\$(*B).obj /c mpq\$(*B).c $(SUFFIX)

{mpf}.c{mpf}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=MPF
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Fompf\$(*B).obj /c mpf\$(*B).c $(SUFFIX)

{printf}.c{printf}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=PRINTF
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Foprintf\$(*B).obj /c printf\$(*B).c $(SUFFIX)

{scanf}.c{scanf}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=SCANF
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Foscanf\$(*B).obj /c scanf\$(*B).c $(SUFFIX)

{rand}.c{rand}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=RAND
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Forand\$(*B).obj /c rand\$(*B).c $(SUFFIX)

{.}.c{.}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj "--section=<toplevel>"
	$(PREFIX)cl $(CFLAGS) /D__GMP_WITHIN_GMP=1 /Fo.\$(*B).obj /c .\$(*B).c $(SUFFIX)

{tune}.c{tune}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=TUNE
	$(PREFIX)cl $(CFLAGS_TUNEUP) /Fotune\$(*B).obj /c tune\$(*B).c $(SUFFIX)

{tests\misc}.c{tests\misc}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/MISC
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\misc\$(*B).obj /Fetests\misc\$(*B).exe tests\misc\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\rand}.c{tests\rand}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/RAND
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\rand\$(*B).obj /Fetests\rand\$(*B).exe tests\rand\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\mpn}.c{tests\mpn}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/MPN
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\mpn\$(*B).obj /Fetests\mpn\$(*B).exe tests\mpn\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\mpz}.c{tests\mpz}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/MPZ
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\mpz\$(*B).obj /Fetests\mpz\$(*B).exe tests\mpz\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\mpf}.c{tests\mpf}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/MPF
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\mpf\$(*B).obj /Fetests\mpf\$(*B).exe tests\mpf\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\mpq}.c{tests\mpq}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe --section=TESTS/MPQ
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\mpq\$(*B).obj /Fetests\mpq\$(*B).exe tests\mpq\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests}.c{tests}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe "--section=TESTS/<toplevel>"
	$(PREFIX)cl $(CFLAGS_libtest) /Fotests\$(*B).obj /Fetests\$(*B).exe tests\$(*B).c tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{tests\cxx}.cc{tests\cxx}.exe:
	@colored_print "C++ compiling + linking" --1st=$(*B).cc --2nd=$(*B).exe --section=TESTS/CXX
	$(PREFIX)cl $(CXXFLAGS) /Fotests\cxx\$(*B).obj /Fetests\cxx\$(*B).exe tests\cxx\$(*B).cc /Itests /D_CRT_SUPPRESS_RESTRICT tests\libtests.lib $(LIBGMP_NAME) $(SUFFIX)

{win64\x86-64asm}.asm{win64\x86-64asm}.obj:
	@colored_print "Assembling (X86-64)" --1st=$(*B).asm --2nd=$(*B).obj --section=ASM
	$(PREFIX)$(AS) /nologo /c $(ASMFLAGS) /Fo$*.obj $*.asm $(SUFFIX)

{win64\arm64asm}.asm{win64\arm64asm}.obj:
	@colored_print "Assembling (ARM64)" --1st=$(*B).asm --2nd=$(*B).obj --section=ASM
	$(PREFIX)$(AS) -nologo $(ASMFLAGS) -machine ARM64 -o $*.obj $*.asm $(SUFFIX)

.PHONY: prepare prepare_headers clean

#
# tuneup tool
#

!ifndef LINK_DLL
tuneup: libtests
	$(PREFIX)cl $(CFLAGS_LOCAL_TOOLS) /Fecolored_print.exe win64\src\colored_print.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\tuneup.c" "--2nd=tune\tuneup.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\tuneup.obj /c tune\tuneup.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2.c" "--2nd=tune\hgcd2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2.obj /c tune\hgcd2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\sqr_basecase.c" "--2nd=tune\sqr_basecase.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sqr_basecase.obj /c tune\sqr_basecase.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\fac_ui.c
	@echo #define __gmpz_fac_ui mpz_fac_ui_tune >> tune\fac_ui.c
	@echo #define __gmpz_oddfac_1 mpz_oddfac_1_tune >> tune\fac_ui.c
	@echo #include "mpz/oddfac_1.c" >> tune\fac_ui.c
	@echo #include "mpz/fac_ui.c" >> tune\fac_ui.c
	@colored_print "C compiling" "--1st=tune\fac_ui.c" "--2nd=tune\fac_ui.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\fac_ui.obj /c tune\fac_ui.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\div_qr_2.c
	@echo #include "mpn/generic/div_qr_2.c" >> tune\div_qr_2.c
	@colored_print "C compiling" "--1st=tune\div_qr_2.c" "--2nd=tune\div_qr_2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_2.obj /c tune\div_qr_2.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\bdiv_q.c
	@echo #include "mpn/generic/bdiv_q.c" >> tune\bdiv_q.c
	@colored_print "C compiling" "--1st=tune\bdiv_q.c" "--2nd=tune\bdiv_q.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\bdiv_q.obj /c tune\bdiv_q.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\bdiv_qr.c
	@echo #include "mpn/generic/bdiv_qr.c" >> tune\bdiv_qr.c
	@colored_print "C compiling" "--1st=tune\bdiv_qr.c" "--2nd=tune\bdiv_qr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\bdiv_qr.obj /c tune\bdiv_qr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\dcpi1_div_qr.c
	@echo #include "mpn/generic/dcpi1_div_qr.c" >> tune\dcpi1_div_qr.c
	@colored_print "C compiling" "--1st=tune\dcpi1_div_qr.c" "--2nd=tune\dcpi1_div_qr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\dcpi1_div_qr.obj /c tune\dcpi1_div_qr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\dcpi1_divappr_q.c
	@echo #include "mpn/generic/dcpi1_divappr_q.c" >> tune\dcpi1_divappr_q.c
	@colored_print "C compiling" "--1st=tune\dcpi1_divappr_q.c" "--2nd=tune\dcpi1_divappr_q.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\dcpi1_divappr_q.obj /c tune\dcpi1_divappr_q.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\dcpi1_bdiv_qr.c
	@echo #include "mpn/generic/dcpi1_bdiv_qr.c" >> tune\dcpi1_bdiv_qr.c
	@colored_print "C compiling" "--1st=tune\dcpi1_bdiv_qr.c" "--2nd=tune\dcpi1_bdiv_qr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\dcpi1_bdiv_qr.obj /c tune\dcpi1_bdiv_qr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\dcpi1_bdiv_q.c
	@echo #include "mpn/generic/dcpi1_bdiv_q.c" >> tune\dcpi1_bdiv_q.c
	@colored_print "C compiling" "--1st=tune\dcpi1_bdiv_q.c" "--2nd=tune\dcpi1_bdiv_q.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\dcpi1_bdiv_q.obj /c tune\dcpi1_bdiv_q.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\invertappr.c
	@echo #include "mpn/generic/invertappr.c" >> tune\invertappr.c
	@colored_print "C compiling" "--1st=tune\invertappr.c" "--2nd=tune\invertappr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\invertappr.obj /c tune\invertappr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\invert.c
	@echo #include "mpn/generic/invert.c" >> tune\invert.c
	@colored_print "C compiling" "--1st=tune\invert.c" "--2nd=tune\invert.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\invert.obj /c tune\invert.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\binvert.c
	@echo #include "mpn/generic/binvert.c" >> tune\binvert.c
	@colored_print "C compiling" "--1st=tune\binvert.c" "--2nd=tune\binvert.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\binvert.obj /c tune\binvert.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\divrem_2.c
	@echo #include "mpn/generic/divrem_2.c" >> tune\divrem_2.c
	@colored_print "C compiling" "--1st=tune\divrem_2.c" "--2nd=tune\divrem_2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem_2.obj /c tune\divrem_2.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\gcd.c
	@echo #include "mpn/generic/gcd.c" >> tune\gcd.c
	@colored_print "C compiling" "--1st=tune\gcd.c" "--2nd=tune\gcd.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcd.obj /c tune\gcd.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\gcdext.c
	@echo #include "mpn/generic/gcdext.c" >> tune\gcdext.c
	@colored_print "C compiling" "--1st=tune\gcdext.c" "--2nd=tune\gcdext.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcdext.obj /c tune\gcdext.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\get_str.c
	@echo #include "mpn/generic/get_str.c" >> tune\get_str.c
	@colored_print "C compiling" "--1st=tune\get_str.c" "--2nd=tune\get_str.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\get_str.obj /c tune\get_str.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\set_str.c
	@echo #include "mpn/generic/set_str.c" >> tune\set_str.c
	@colored_print "C compiling" "--1st=tune\set_str.c" "--2nd=tune\set_str.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\set_str.obj /c tune\set_str.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\matrix22_mul.c
	@echo #include "mpn/generic/matrix22_mul.c" >> tune\matrix22_mul.c
	@colored_print "C compiling" "--1st=tune\matrix22_mul.c" "--2nd=tune\matrix22_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\matrix22_mul.obj /c tune\matrix22_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\hgcd.c
	@echo #include "mpn/generic/hgcd.c" >> tune\hgcd.c
	@colored_print "C compiling" "--1st=tune\hgcd.c" "--2nd=tune\hgcd.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd.obj /c tune\hgcd.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\hgcd_appr.c
	@echo #include "mpn/generic/hgcd_appr.c" >> tune\hgcd_appr.c
	@colored_print "C compiling" "--1st=tune\hgcd_appr.c" "--2nd=tune\hgcd_appr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_appr.obj /c tune\hgcd_appr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\hgcd_reduce.c
	@echo #include "mpn/generic/hgcd_reduce.c" >> tune\hgcd_reduce.c
	@colored_print "C compiling" "--1st=tune\hgcd_reduce.c" "--2nd=tune\hgcd_reduce.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_reduce.obj /c tune\hgcd_reduce.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mul_n.c
	@echo #include "mpn/generic/mul_n.c" >> tune\mul_n.c
	@colored_print "C compiling" "--1st=tune\mul_n.c" "--2nd=tune\mul_n.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mul_n.obj /c tune\mul_n.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\sqr.c
	@echo #include "mpn/generic/sqr.c" >> tune\sqr.c
	@colored_print "C compiling" "--1st=tune\sqr.c" "--2nd=tune\sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sqr.obj /c tune\sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\sec_powm.c
	@echo #include "mpn/generic/sec_powm.c" >> tune\sec_powm.c
	@colored_print "C compiling" "--1st=tune\sec_powm.c" "--2nd=tune\sec_powm.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sec_powm.obj /c tune\sec_powm.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mullo_n.c
	@echo #include "mpn/generic/mullo_n.c" >> tune\mullo_n.c
	@colored_print "C compiling" "--1st=tune\mullo_n.c" "--2nd=tune\mullo_n.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mullo_n.obj /c tune\mullo_n.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mul_fft.c
	@echo #include "mpn/generic/mul_fft.c" >> tune\mul_fft.c
	@colored_print "C compiling" "--1st=tune\mul_fft.c" "--2nd=tune\mul_fft.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mul_fft.obj /c tune\mul_fft.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mul.c
	@echo #include "mpn/generic/mul.c" >> tune\mul.c
	@colored_print "C compiling" "--1st=tune\mul.c" "--2nd=tune\mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mul.obj /c tune\mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\tdiv_qr.c
	@echo #include "mpn/generic/tdiv_qr.c" >> tune\tdiv_qr.c
	@colored_print "C compiling" "--1st=tune\tdiv_qr.c" "--2nd=tune\tdiv_qr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\tdiv_qr.obj /c tune\tdiv_qr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mulmod_bnm1.c
	@echo #include "mpn/generic/mulmod_bnm1.c" >> tune\mulmod_bnm1.c
	@colored_print "C compiling" "--1st=tune\mulmod_bnm1.c" "--2nd=tune\mulmod_bnm1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mulmod_bnm1.obj /c tune\mulmod_bnm1.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\sqrmod_bnm1.c
	@echo #include "mpn/generic/sqrmod_bnm1.c" >> tune\sqrmod_bnm1.c
	@colored_print "C compiling" "--1st=tune\sqrmod_bnm1.c" "--2nd=tune\sqrmod_bnm1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sqrmod_bnm1.obj /c tune\sqrmod_bnm1.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mulmid.c
	@echo #include "mpn/generic/mulmid.c" >> tune\mulmid.c
	@colored_print "C compiling" "--1st=tune\mulmid.c" "--2nd=tune\mulmid.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mulmid.obj /c tune\mulmid.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\mulmid_n.c
	@echo #include "mpn/generic/mulmid_n.c" >> tune\mulmid_n.c
	@colored_print "C compiling" "--1st=tune\mulmid_n.c" "--2nd=tune\mulmid_n.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mulmid_n.obj /c tune\mulmid_n.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom42_mulmid.c
	@echo #include "mpn/generic/toom42_mulmid.c" >> tune\toom42_mulmid.c
	@colored_print "C compiling" "--1st=tune\toom42_mulmid.c" "--2nd=tune\toom42_mulmid.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom42_mulmid.obj /c tune\toom42_mulmid.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\sqrlo.c
	@echo #include "mpn/generic/sqrlo.c" >> tune\sqrlo.c
	@colored_print "C compiling" "--1st=tune\sqrlo.c" "--2nd=tune\sqrlo.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sqrlo.obj /c tune\sqrlo.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\sqrlo_basecase.c
	@echo #include "mpn/generic/sqrlo_basecase.c" >> tune\sqrlo_basecase.c
	@colored_print "C compiling" "--1st=tune\sqrlo_basecase.c" "--2nd=tune\sqrlo_basecase.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\sqrlo_basecase.obj /c tune\sqrlo_basecase.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\nussbaumer_mul.c
	@echo #include "mpn/generic/nussbaumer_mul.c" >> tune\nussbaumer_mul.c
	@colored_print "C compiling" "--1st=tune\nussbaumer_mul.c" "--2nd=tune\nussbaumer_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\nussbaumer_mul.obj /c tune\nussbaumer_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom6h_mul.c
	@echo #include "mpn/generic/toom6h_mul.c" >> tune\toom6h_mul.c
	@colored_print "C compiling" "--1st=tune\toom6h_mul.c" "--2nd=tune\toom6h_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom6h_mul.obj /c tune\toom6h_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom8h_mul.c
	@echo #include "mpn/generic/toom8h_mul.c" >> tune\toom8h_mul.c
	@colored_print "C compiling" "--1st=tune\toom8h_mul.c" "--2nd=tune\toom8h_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom8h_mul.obj /c tune\toom8h_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom6_sqr.c
	@echo #include "mpn/generic/toom6_sqr.c" >> tune\toom6_sqr.c
	@colored_print "C compiling" "--1st=tune\toom6_sqr.c" "--2nd=tune\toom6_sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom6_sqr.obj /c tune\toom6_sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom8_sqr.c
	@echo #include "mpn/generic/toom8_sqr.c" >> tune\toom8_sqr.c
	@colored_print "C compiling" "--1st=tune\toom8_sqr.c" "--2nd=tune\toom8_sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom8_sqr.obj /c tune\toom8_sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom22_mul.c
	@echo #include "mpn/generic/toom22_mul.c" >> tune\toom22_mul.c
	@colored_print "C compiling" "--1st=tune\toom22_mul.c" "--2nd=tune\toom22_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom22_mul.obj /c tune\toom22_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom2_sqr.c
	@echo #include "mpn/generic/toom2_sqr.c" >> tune\toom2_sqr.c
	@colored_print "C compiling" "--1st=tune\toom2_sqr.c" "--2nd=tune\toom2_sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom2_sqr.obj /c tune\toom2_sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom33_mul.c
	@echo #include "mpn/generic/toom33_mul.c" >> tune\toom33_mul.c
	@colored_print "C compiling" "--1st=tune\toom33_mul.c" "--2nd=tune\toom33_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom33_mul.obj /c tune\toom33_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom3_sqr.c
	@echo #include "mpn/generic/toom3_sqr.c" >> tune\toom3_sqr.c
	@colored_print "C compiling" "--1st=tune\toom3_sqr.c" "--2nd=tune\toom3_sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom3_sqr.obj /c tune\toom3_sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom44_mul.c
	@echo #include "mpn/generic/toom44_mul.c" >> tune\toom44_mul.c
	@colored_print "C compiling" "--1st=tune\toom44_mul.c" "--2nd=tune\toom44_mul.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom44_mul.obj /c tune\toom44_mul.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 > tune\toom4_sqr.c
	@echo #include "mpn/generic/toom4_sqr.c" >> tune\toom4_sqr.c
	@colored_print "C compiling" "--1st=tune\toom4_sqr.c" "--2nd=tune\toom4_sqr.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\toom4_sqr.obj /c tune\toom4_sqr.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 >tune\divrem_1.c
	@echo #define __gmpn_divrem_1  mpn_divrem_1_tune >>tune\divrem_1.c
	@echo #include "mpn/generic/divrem_1.c" >>tune\divrem_1.c
	@colored_print "C compiling" "--1st=tune\divrem_1.c" "--2nd=tune\divrem_1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem_1.obj /c tune\divrem_1.c $(SUFFIX)
	@echo #define TUNE_PROGRAM_BUILD 1 >tune\mod_1.c
	@echo #define __gmpn_mod_1  mpn_mod_1_tune >>tune\mod_1.c
	@echo #include "mpn/generic/mod_1.c" >>tune\mod_1.c
	@colored_print "C compiling" "--1st=tune\mod_1.c" "--2nd=tune\mod_1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mod_1.obj /c tune\mod_1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\common.c" "--2nd=tune\common.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\common.obj /c tune\common.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\divrem1div.c" "--2nd=tune\divrem1div.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem1div.obj /c tune\divrem1div.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\divrem1inv.c" "--2nd=tune\divrem1inv.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem1inv.obj /c tune\divrem1inv.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\divrem2div.c" "--2nd=tune\divrem2div.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem2div.obj /c tune\divrem2div.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\divrem2inv.c" "--2nd=tune\divrem2inv.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\divrem2inv.obj /c tune\divrem2inv.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\div_qr_1n_pi1_1.c" "--2nd=tune\div_qr_1n_pi1_1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_1n_pi1_1.obj /c tune\div_qr_1n_pi1_1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\div_qr_1n_pi1_2.c" "--2nd=tune\div_qr_1n_pi1_2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_1n_pi1_2.obj /c tune\div_qr_1n_pi1_2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\div_qr_1n_pi1_3.c" "--2nd=tune\div_qr_1n_pi1_3.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_1n_pi1_3.obj /c tune\div_qr_1n_pi1_3.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\div_qr_1n_pi1_4.c" "--2nd=tune\div_qr_1n_pi1_4.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_1n_pi1_4.obj /c tune\div_qr_1n_pi1_4.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\div_qr_1_tune.c" "--2nd=tune\div_qr_1_tune.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\div_qr_1_tune.obj /c tune\div_qr_1_tune.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\freq.c" "--2nd=tune\freq.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\freq.obj /c tune\freq.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\gcdext_single.c" "--2nd=tune\gcdext_single.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcdext_single.obj /c tune\gcdext_single.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\gcdext_double.c" "--2nd=tune\gcdext_double.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcdext_double.obj /c tune\gcdext_double.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\gcdextod.c" "--2nd=tune\gcdextod.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcdextod.obj /c tune\gcdextod.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\gcdextos.c" "--2nd=tune\gcdextos.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\gcdextos.obj /c tune\gcdextos.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd_lehmer.c" "--2nd=tune\hgcd_lehmer.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_lehmer.obj /c tune\hgcd_lehmer.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd_appr_lehmer.c" "--2nd=tune\hgcd_appr_lehmer.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_appr_lehmer.obj /c tune\hgcd_appr_lehmer.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd_reduce_1.c" "--2nd=tune\hgcd_reduce_1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_reduce_1.obj /c tune\hgcd_reduce_1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd_reduce_2.c" "--2nd=tune\hgcd_reduce_2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd_reduce_2.obj /c tune\hgcd_reduce_2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\jacbase1.c" "--2nd=tune\jacbase1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\jacbase1.obj /c tune\jacbase1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\jacbase2.c" "--2nd=tune\jacbase2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\jacbase2.obj /c tune\jacbase2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\jacbase3.c" "--2nd=tune\jacbase3.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\jacbase3.obj /c tune\jacbase3.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\jacbase4.c" "--2nd=tune\jacbase4.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\jacbase4.obj /c tune\jacbase4.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2-1.c" "--2nd=tune\hgcd2-1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2-1.obj /c tune\hgcd2-1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2-2.c" "--2nd=tune\hgcd2-2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2-2.obj /c tune\hgcd2-2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2-3.c" "--2nd=tune\hgcd2-3.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2-3.obj /c tune\hgcd2-3.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2-4.c" "--2nd=tune\hgcd2-4.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2-4.obj /c tune\hgcd2-4.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\hgcd2-5.c" "--2nd=tune\hgcd2-5.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\hgcd2-5.obj /c tune\hgcd2-5.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\mod_1_div.c" "--2nd=tune\mod_1_div.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mod_1_div.obj /c tune\mod_1_div.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\mod_1_inv.c" "--2nd=tune\mod_1_inv.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mod_1_inv.obj /c tune\mod_1_inv.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\mod_1_1-1.c" "--2nd=tune\mod_1_1-1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mod_1_1-1.obj /c tune\mod_1_1-1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\mod_1_1-2.c" "--2nd=tune\mod_1_1-2.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\mod_1_1-2.obj /c tune\mod_1_1-2.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\modlinv.c" "--2nd=tune\modlinv.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\modlinv.obj /c tune\modlinv.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\noop.c" "--2nd=tune\noop.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\noop.obj /c tune\noop.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\powm_mod.c" "--2nd=tune\powm_mod.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\powm_mod.obj /c tune\powm_mod.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\powm_redc.c" "--2nd=tune\powm_redc.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\powm_redc.obj /c tune\powm_redc.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\pre_divrem_1.c" "--2nd=tune\pre_divrem_1.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\pre_divrem_1.obj /c tune\pre_divrem_1.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\set_strb.c" "--2nd=tune\set_strb.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\set_strb.obj /c tune\set_strb.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\set_strs.c" "--2nd=tune\set_strs.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\set_strs.obj /c tune\set_strs.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\set_strp.c" "--2nd=tune\set_strp.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\set_strp.obj /c tune\set_strp.c $(SUFFIX)
	@colored_print "C compiling" "--1st=tune\time.c" "--2nd=tune\time.obj" --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /I. /I.. /Itests /Fotune\time.obj /c tune\time.c $(SUFFIX)
	@colored_print "Assembling" --1st=speed_cyclecounter.asm "--2nd=tune\speed_cyclecounter.obj" --section=TUNEUP
!ifdef ARM64
	$(PREFIX)$(AS) -nologo $(ASMFLAGS) -machine ARM64 -o tune\speed_cyclecounter.obj win64\arm64asm\speed_cyclecounter.asm $(SUFFIX)
!else
	$(PREFIX)$(AS) /nologo /c $(ASMFLAGS) /Fotune\speed_cyclecounter.obj win64\x86-64asm\speed_cyclecounter.asm $(SUFFIX)
!endif
	@colored_print "Linking" --1st=tuneup.exe --section=TUNEUP
	$(PREFIX)link \
	/NOLOGO /NOIMPLIB /NOEXP /SUBSYSTEM:CONSOLE $(EXTRA_EXE_FLAGS) \
	/DYNAMICBASE "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" \
	/MACHINE:$(MACHINE) tests\libtests.lib \
	/OUT:"tune\tuneup.exe" $(LIBGMP_NAME) $(TUNEUP_FILES) $(SUFFIX)
!endif
