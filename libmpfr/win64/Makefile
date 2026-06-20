# MS Visual C/C++ Makefile for the GNU MPFR Library
# 
# Copyright 2026 Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
# 
# The GNU MPFR Library is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at your
# option) any later version.
#
# The GNU MPFR Library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
# License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with the GNU MPFR Library; see the file COPYING.LESSER.
# If not, see <https://www.gnu.org/licenses/>.

#
# Use: LIBGMP_BUILDDIR=<folder>		(mandatory) to specify the build folder of libgmp
# ---- VERBOSE=        to show all nmake messages (default: inhibit all messages)
#      MORE_VERBOSE=			use /W3 for C compiler, which emits tons of warnings from original gcc-tailored source
#      DEBUG=          to build without optimizations and with debug infos
#      DEBUG_IN_RELEASE=	emit everything with debugging symbols, but compile full optimized
#      DYNAMIC_RT=     to use dynamic C runtime (/MD or /MDd) instead of static runtime (/MT or /MTd - default)
#                      CAUTION: building DLLs with static runtime BREAKS certain
#                      -------- library functions using 'FILE*' because those pointers are INVALID within the DLL
#      LINK_DLL=       link tools (e.g. test tools and tuneup) with DLL (.dll, dynamically) and not with static library (.lib)
#      FULL_64BIT=     TODO: currently NOT implemented
#      SECURITY=       enable additional runtime and stack checks
#      INTEL64=        use '/favor:INTEL64'
#      AMD64=          use '/favor:ADM64'
#      ARM64=          build this stuff for Aarch64 (aka ARM64) on Windows
#      ARCH=xxx        use 'xxx=AVX2' or 'xxx=AVX512' to switch to this architecture, library might not run on other CPUs, though.
#      LOGGING=        if we shall define MPFR_USE_LOGGING=1 (DOES NOT work on Windows!!!)
#
# The Makefile switch '__DLL_EXPORTS__' is FOR INTERNAL USE ONLY!!!
#

!ifndef PATCH
PATCH = "c:\Program Files\Git\usr\bin\patch.exe"
!endif

!include win64\Makefile.libmpfr.files

!ifdef FULL_64BIT
!error The feature FULL_64BIT is NOT YET implemented for libmpfr. STOP.
!endif

# define LIBGMP_BUILDDIR as <garbage> if the user does not define it or you have 
# to specify it also for targets such as 'clean'...
#
#!ifndef LIBGMP_BUILDDIR
#!error You have to define LIBGMP_BUILDDIR. STOP.
#!endif

!ifndef LIBGMP_BUILDDIR
LIBGMP_BUILDDIR=you-have-to-define-LIBGMP_BUILDDIR
!endif

ALL_MAKEFILE_DEFINES = LIBGMP_BUILDDIR=$(LIBGMP_BUILDDIR)

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

CFLAGS = /fp:precise /DHAVE_CONFIG_H /D_MBCS /std:c17 /nologo \
	/I. /Isrc /I$(LIBGMP_BUILDDIR) /I$(LIBGMP_BUILDDIR)\tune \
	/DHAVE_STDIO_H=1 \
	/DHAVE_INTTYPES_H=1 \
	/DHAVE_STDINT_H=1 \
	/DHAVE_LITTLE_ENDIAN=1 \
	/DHAVE_WCHAR_H=1 \
	/DHAVE_STDARG=1 \
	/DHAVE_ALLOCA=1 \
	/DHAVE_UINTPTR_T=1 \
	/DHAVE_VA_COPY=1 \
	/DHAVE_GETTIMEOFDAY=1 \
	/DHAVE_LONG_LONG=1 \
	/DHAVE_INTMAX_T=1 \
	/DMPFR_HAVE_INTMAX_MAX=1 \
	/DMPFR_HAVE_FESETROUND=1 \
	/DHAVE_SUBNORM_DBL=1 \
	/DHAVE_SUBNORM_FLT=1 \
	/DHAVE_SIGNEDZ=1 \
	/DHAVE_ROUND=1 \
	/DHAVE_TRUNC=1 \
	/DHAVE_FLOOR=1 \
	/DHAVE_CEIL=1 \
	/DHAVE_DOUBLE_IEEE_LITTLE_ENDIAN=1 \
	/DDECIMAL_BID_FORMAT=1 \
	/DMPFR_USE_STATIC_ASSERT=1 \
	/DMPFR_HAVE_GMP_IMPL=1 \
	/DPRINTF_L=1 \
	/DPRINTF_T=1 \
	/DPRINTF_A=1 \
	/DPRINTF_GROUPFLAG=1

!ifdef LOGGING
!error LOGGING does NOT work for libmpfr on MS Windows (required ISO attributes NOT supported by MS Visual C)
CFLAGS = $(CFLAGS) /DMPFR_USE_LOGGING=1
!endif

!ifdef ARM64
MACHINE = ARM64
DEF_INFIX = -arm64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) ARM64=
#CFLAGS = $(CFLAGS) /Iwin64\inc\mparam-arm64
!else
MACHINE = X64
DEF_INFIX =
!ifdef INTEL64
#CFLAGS = $(CFLAGS) /Iwin64\inc\mparam-x86-64-intel
CFLAGS = $(CFLAGS) /favor:INTEL64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) INTEL64=
!else
!ifdef AMD64
#CFLAGS = $(CFLAGS) /Iwin64\inc\mparam-x86-64-amd
CFLAGS = $(CFLAGS) /favor:AMD64
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) AMD64=
!endif
!endif
!endif

LINK_FLAGS = /NOLOGO /MACHINE:$(MACHINE) /OPT:NOREF /IGNORE:4217 /IGNORE:4286

!ifdef FULL_64BIT 
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) FULL_64BIT=
!ERROR The 'FULL_64BIT' option BREAKS the libmpfr build on MS Windows. Please build libgmp and libmpfr WITHOUT it. STOP.
CFLAGS = $(CFLAGS) /DMPFR_INTMAX_WITHIN_LIMB=1 /D_MP_SIZE_64BIT=1
!else
CFLAGS = $(CFLAGS) /DMPFR_LONG_WITHIN_LIMB=1
!endif

!ifdef VERBOSE
!ifdef MORE_VERBOSE
CFLAGS = /W3 $(CFLAGS)
!endif
!endif

!ifdef SECURITY
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) SECURITY=
CFLAGS = $(CFLAGS) /GS /RTCs /fsanitize=address
!else
CFLAGS = $(CFLAGS) /GS-
!endif

!ifdef DYNAMIC_RT

ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) DYNAMIC_RT=

!ifdef DEBUG
CFLAGS = $(CFLAGS) /MDd
LINK_FLAGS = $(LINK_FLAGS) /DEBUG:FULL
!else
CFLAGS = $(CFLAGS) /MD
LINK_FLAGS = $(LINK_FLAGS) /DEBUG:NONE
!endif

!else

!ifdef DEBUG
CFLAGS = $(CFLAGS) /MTd /D_STATIC_RT
!else
CFLAGS = $(CFLAGS) /MT /D_STATIC_RT
!endif

!endif

#
# can be only of SSE2|SSE4.2|AVX|AVX2|AVX512|AVX10.x
#

!ifdef ARCH
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) ARCH=$(ARCH)
CFLAGS = $(CFLAGS) /arch:$(ARCH)
!endif

!ifdef DEBUG
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) DEBUG=
CFLAGS = $(CFLAGS) /Od /Zi /D_DEBUG /DDEBUG /FR
!else
CFLAGS = $(CFLAGS) /Ox /Ob2 /Oi /Ot /Oy /DNDEBUG
!endif

#
# DO *NOT* define __DLL_EXPORTS__ for nmake, this is just used internally!!!
#

!ifdef __DLL_EXPORTS__
CFLAGS = /D__GMP_LIBGMP_DLL=1 $(CFLAGS)
!endif

!ifdef LINK_DLL
ALL_MAKEFILE_DEFINES = $(ALL_MAKEFILE_DEFINES) LINK_DLL=
CFLAGS = /D__GMP_LIBGMP_DLL=1 $(CFLAGS)
LIBGMP_NAME=libgmp-imp.lib
LIBMPFR_NAME=libmpfr-imp.lib
!else
LIBGMP_NAME=libgmp.lib
LIBMPFR_NAME=libmpfr.lib
!endif

#
# DLL linker flags, please note that a static library is ALWAYS created first (by nmake recursion)
#

# /VERBOSE
DLL_FLAGS = /DLL /MANIFEST /NXCOMPAT /MACHINE:$(MACHINE) /SUBSYSTEM:CONSOLE /OPT:NOREF /ERRORREPORT:PROMPT /nologo /TLBID:1 /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /DYNAMICBASE "kernel32.lib"
!ifdef DEBUG
DLL_FLAGS = $(DLL_FLAGS) /DEBUG /PDB:"libmpfr.pdb"
!endif

#
# main:
#

CFLAGS_test = $(CFLAGS) /I.\tests
CFLAGS_libtest = $(CFLAGS) /I.\tests /I$(LIBGMP_BUILDDIR)\tests
CFLAGS_LOCAL_TOOLS = /nologo /DNDEBUG /D_MBCS /MT /Ox /Ob2 /Oi /Ot /Oy

all: static_lib check tuneup

patch:
	$(PATCH) -p1 < win64\patches\src.patch
	$(PATCH) -p1 < win64\patches\tests.patch
	$(PATCH) -p1 < win64\patches\tune.patch

prepare:
	@cl $(CFLAGS_LOCAL_TOOLS) /Fecolored_print.exe win64\src\colored_print.c >NUL
	@colored_print "Preparing"
	@cl $(CFLAGS_LOCAL_TOOLS) /Fecreate_version_resource.exe win64\src\create_version_resource.c >NUL
	@colored_print "Creating build information" --level=2
!ifdef DEBUG
	@create_version_resource version.rc .\src\mpfr.h DEBUG $(ALL_MAKEFILE_DEFINES) >.\src\build.c
!else
	@create_version_resource version.rc .\src\mpfr.h RELEASE $(ALL_MAKEFILE_DEFINES) >.\src\build.c
!endif
	$(PREFIX)rc version.rc $(SUFFIX)
	@copy win64\inc\mparam.h src >NUL
	@copy win64\src\get_patches.c src >NUL
	@copy tests\*.dat . >NUL
	@colored_print "Compiling generated build.c" --level=2
	$(PREFIX)cl $(CFLAGS) /Fosrc\build.obj /c src\build.c /D__GMP_WITHIN_GMP $(SUFFIX)

objects: $(libmpfr_OBJECTS)

static_lib: prepare objects
	$(PREFIX)lib /OUT:"libmpfr.lib" /MACHINE:$(MACHINE) /NOLOGO $(libmpfr_OBJECTS) src\build.obj $(SUFFIX)

dynamic_lib:
	@cl /nologo /MT /Ox /Ob2 /Oi /Ot /Oy /DNDEBUG /Fecolored_print.exe win64\src\colored_print.c >NUL
	@colored_print "Creating" "--1st=dynamic library" "--2nd=libmpfr.dll" --level=1 --section=DLL
	@colored_print "Creating" "--1st=static library" "--2nd=libmpfr.lib" --level=2 --section=DLL
	$(PREFIX)nmake /f win64\Makefile /nologo clean
	$(PREFIX)nmake /f win64\Makefile /nologo __DLL_EXPORTS__= $(ALL_MAKEFILE_DEFINES) static_lib
	@colored_print "C compiling" --1st=dllmain.c --2nd=dllmain.obj --level=2 --section=DLL
	$(PREFIX)cl $(CFLAGS) /Fosrc\dllmain.obj /c win64\src\dllmain.c $(SUFFIX)
	@colored_print "Linking dynamic library" --1st=libmpfr.dll "--inf=with import library" --2nd=libmpfr-imp.lib --level=2 --section=DLL
!ifdef LOGGING
	$(PREFIX)link /IGNORE:4273 $(DLL_FLAGS) /OUT:"libmpfr.dll" \
	/ManifestFile:"libmpfr.intermediate.manifest" \
	/IMPLIB:"libmpfr-imp.lib" \
	libmpfr.lib \
	$(LIBGMP_BUILDDIR)\libgmp-imp.lib \
	src\dllmain.obj \
	version.res \
	/DEF:"win64\def\libmpfr$(DEF_INFIX)-logging.def" $(SUFFIX)
!else
	$(PREFIX)link /IGNORE:4273 $(DLL_FLAGS) /OUT:"libmpfr.dll" \
	/ManifestFile:"libmpfr.intermediate.manifest" \
	/IMPLIB:"libmpfr-imp.lib" \
	libmpfr.lib \
	$(LIBGMP_BUILDDIR)\libgmp-imp.lib \
	src\dllmain.obj \
	version.res \
	/DEF:"win64\def\libmpfr$(DEF_INFIX).def" $(SUFFIX)
!endif

libfrtests_OBJECTS = \
	tests\memory.obj \
	tests\rnd_mode.obj \
	tests\tests.obj \
	tests\cmp_str.obj \
	tests\random2.obj

test_lib: $(libfrtests_OBJECTS)
	$(PREFIX)lib /OUT:"libfrtests.lib" /MACHINE:$(MACHINE) /NOLOGO $(libfrtests_OBJECTS) $(SUFFIX)

!ifdef LINK_DLL

check:	dynamic_lib test_lib $(test_EXES)
	@cl $(CFLAGS_libtest) /Fetests/wintestrunner.exe win64\src\wintestrunner.c >NUL
	@del tests\libgmp.dll >NUL 2>&1
	@del tests\libmpfr.dll >NUL 2>&1
	@copy libmpfr.dll tests >NUL
	@copy $(LIBGMP_BUILDDIR)\libgmp.dll tests >NUL
	@copy win64\src\all_tests.rsp tests >NUL
	$(PREFIX).\tests\wintestrunner.exe .\tests\all_tests.rsp

!else

check:	static_lib test_lib $(test_EXES)
	@cl $(CFLAGS_libtest) /Fetests/wintestrunner.exe win64\src\wintestrunner.c >NUL
	@copy win64\src\all_tests.rsp tests >NUL
	$(PREFIX).\tests\wintestrunner.exe .\tests\all_tests.rsp

!endif

tuneup:	static_lib test_lib tune\tuneup.obj
  $(PREFIX)cl $(CFLAGS) /D_I_AM_IN_LIBMPFR /I$(LIBGMP_BUILDDIR)\tests /Fotune\tuneup_libgmp.obj /c $(LIBGMP_BUILDDIR)\tune\tuneup.c $(SUFFIX)
	$(PREFIX)cl $(CFLAGS_TUNEUP) /Fetune/tuneup.exe tune\tuneup.obj tune\tuneup_libgmp.obj $(LIBGMP_BUILDDIR)\libgmp.lib $(LIBMPFR_NAME) libfrtests.lib \
	$(LIBGMP_TUNEUP_FILES) $(LIBGMP_BUILDDIR)\tests\libtests.lib $(SUFFIX)

clean:
	@echo Cleaning up...
	@del *.dat >NUL 2>&1
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
	@del *_out.txt >NUL 2>&1

#
# Rules
#

{tests}.c{tests}.exe:
	@colored_print "C compiling + linking" --1st=$(*B).c --2nd=$(*B).exe "--section=TESTS/<toplevel>"
	$(PREFIX)cl $(CFLAGS_test) /Fotests\$(*B).obj /c tests\$(*B).c $(SUFFIX)
	$(PREFIX)link $(LINK_FLAGS) /OUT:tests\$(*B).exe tests\$(*B).obj $(LIBGMP_BUILDDIR)\$(LIBGMP_NAME) $(LIBMPFR_NAME) libfrtests.lib $(SUFFIX)

{tests}.c{tests}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=LIBTEST
	$(PREFIX)cl $(CFLAGS_test) /Fotests\$(*B).obj /c tests\$(*B).c $(SUFFIX)

{tune}.c{tune}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=TUNEUP
	$(PREFIX)cl $(CFLAGS) /Fotune\$(*B).obj /c tune\$(*B).c $(SUFFIX)

{src}.c{src}.obj:
	@colored_print "C compiling" --1st=$(*B).c --2nd=$(*B).obj --section=MPFR
	$(PREFIX)cl $(CFLAGS) /D__MPFR_WITHIN_MPFR /Fosrc\$(*B).obj /c src\$(*B).c $(SUFFIX)

.PHONY: prepare clean
