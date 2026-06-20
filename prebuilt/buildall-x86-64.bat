@ECHO OFF

@mkdir arm64 >NUL 2>&1
@mkdir x86-64\debug_static_noassembly >NUL 2>&1
@mkdir x86-64\debug_static_assembly >NUL 2>&1
@mkdir x86-64\debug_dynamic_noassembly >NUL 2>&1
@mkdir x86-64\debug_dynamic_assembly >NUL 2>&1
@mkdir x86-64\release_static_noassembly >NUL 2>&1
@mkdir x86-64\release_static_assembly >NUL 2>&1
@mkdir x86-64\release_dynamic_noassembly >NUL 2>&1
@mkdir x86-64\release_dynamic_assembly >NUL 2>&1
@mkdir x86-64\release_static_assembly_full64bit >NUL 2>&1
@mkdir x86-64\release_dynamic_assembly_full64bit >NUL 2>&1


cd ..\gmp-6.3.0
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
nmake /f win64\Makefile patch
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
cd ..\mpfr-4.2.2
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
nmake /f win64\Makefile patch
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
cd ..\gmp-6.3.0
IF NOT %ERRORLEVEL% == 0 GOTO ERROR

echo BUILDING: debug_static_noassembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= static_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.lib ..\prebuilt\x86-64\debug_static_noassembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= LIBGMP_BUILDDIR=..\gmp-6.3.0 static_lib check
copy libmpfr.lib ..\prebuilt\x86-64\debug_static_noassembly\
cd ..\gmp-6.3.0

echo BUILDING: debug_static_assembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= ASSEMBLY= static_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.lib ..\prebuilt\x86-64\debug_static_assembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= LIBGMP_BUILDDIR=..\gmp-6.3.0 static_lib check 
copy libmpfr.lib ..\prebuilt\x86-64\debug_static_assembly\
cd ..\gmp-6.3.0

echo BUILDING: debug_dynamic_noassembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= DYNAMIC_RT= LINK_DLL= dynamic_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.dll ..\prebuilt\x86-64\debug_dynamic_noassembly\
copy libgmp-imp.lib ..\prebuilt\x86-64\debug_dynamic_noassembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= DYNAMIC_RT= LINK_DLL= LIBGMP_BUILDDIR=..\gmp-6.3.0 dynamic_lib check 
copy libmpfr.dll ..\prebuilt\x86-64\debug_dynamic_noassembly\
copy libmpfr-imp.lib ..\prebuilt\x86-64\debug_dynamic_noassembly\
cd ..\gmp-6.3.0

echo BUILDING: debug_dynamic_assembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= DYNAMIC_RT= LINK_DLL= ASSEMBLY= dynamic_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.dll ..\prebuilt\x86-64\debug_dynamic_assembly\
copy libgmp-imp.lib ..\prebuilt\x86-64\debug_dynamic_assembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile DEBUG= DYNAMIC_RT= LINK_DLL= LIBGMP_BUILDDIR=..\gmp-6.3.0 dynamic_lib check
copy libmpfr.dll ..\prebuilt\x86-64\debug_dynamic_assembly\
copy libmpfr-imp.lib ..\prebuilt\x86-64\debug_dynamic_assembly\
cd ..\gmp-6.3.0


echo BUILDING: release_static_noassembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 static_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.lib ..\prebuilt\x86-64\release_static_noassembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 LIBGMP_BUILDDIR=..\gmp-6.3.0 static_lib check
copy libmpfr.lib ..\prebuilt\x86-64\release_static_noassembly\
cd ..\gmp-6.3.0

echo BUILDING: release_static_assembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 ASSEMBLY= static_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.lib ..\prebuilt\x86-64\release_static_assembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 LIBGMP_BUILDDIR=..\gmp-6.3.0 static_lib check 
copy libmpfr.lib ..\prebuilt\x86-64\release_static_assembly\
cd ..\gmp-6.3.0

echo BUILDING: release_dynamic_noassembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 DYNAMIC_RT= LINK_DLL= dynamic_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.dll ..\prebuilt\x86-64\release_dynamic_noassembly\
copy libgmp-imp.lib ..\prebuilt\x86-64\release_dynamic_noassembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 DYNAMIC_RT= LINK_DLL= LIBGMP_BUILDDIR=..\gmp-6.3.0 dynamic_lib check 
copy libmpfr.dll ..\prebuilt\x86-64\release_dynamic_noassembly\
copy libmpfr-imp.lib ..\prebuilt\x86-64\release_dynamic_noassembly\
cd ..\gmp-6.3.0

echo BUILDING: release_dynamic_assembly
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 DYNAMIC_RT= LINK_DLL= ASSEMBLY= dynamic_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.dll ..\prebuilt\x86-64\release_dynamic_assembly\
copy libgmp-imp.lib ..\prebuilt\x86-64\release_dynamic_assembly\
cd ..\mpfr-4.2.2
nmake /f win64\Makefile clean
nmake /f win64\Makefile ARCH=AVX2 DYNAMIC_RT= LINK_DLL= LIBGMP_BUILDDIR=..\gmp-6.3.0 dynamic_lib check
copy libmpfr.dll ..\prebuilt\x86-64\release_dynamic_assembly\
copy libmpfr-imp.lib ..\prebuilt\x86-64\release_dynamic_assembly\
cd ..\gmp-6.3.0


echo BUILDING: release_static_assembly_full64bit
nmake /f win64\Makefile clean
nmake /f win64\Makefile FULL64_BIT= ARCH=AVX2 ASSEMBLY= static_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.lib ..\prebuilt\x86-64\release_static_assembly_full64bit\

echo BUILDING: release_dynamic_assembly_full64bit
nmake /f win64\Makefile clean
nmake /f win64\Makefile FULL64_BIT= ARCH=AVX2 DYNAMIC_RT= LINK_DLL= ASSEMBLY= dynamic_lib check
IF NOT %ERRORLEVEL% == 0 GOTO ERROR
copy libgmp.dll ..\prebuilt\x86-64\release_dynamic_assembly_full64bit\
copy libgmp-imp.lib ..\prebuilt\x86-64\release_dynamic_assembly_full64bit\


EXIT /B 0

:ERROR
echo ERROR occurred build all kinds of libraries. STOP.
EXIT /B 1
