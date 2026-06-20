/**
 * @file   create_version_resource.c
 * @author Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
 * @brief  source file implementing the generation of a DLL version resource
 *         for Windows libgmp/libmpfr
 *
 * [MIT license]
 *
 * Copyright (c) 2026 Ingo A. Kubbilun
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#define _CRT_SECURE_NO_WARNINGS
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdbool.h>

static bool get_lib_version(const char *header_file, bool is_gmp, int *version_major, int *version_minor, int *version_patch)
{
  FILE* f = fopen(header_file, "rt");
  char buffer[1024], *p;

  if (NULL == f)
  {
    fprintf(stderr, "ERROR: Unable to open header file: %s\n", header_file);
    return false;
  }

  *version_major = -1;
  *version_minor = -1;
  *version_patch = -1;

  memset(buffer, 0x00, sizeof(buffer));
  while (fgets(buffer, sizeof(buffer) - 1, f))
  {
    if (is_gmp)
    {
      p = strstr(buffer, "#define __GNU_MP_VERSION_PATCHLEVEL");
      if (NULL != p)
        *version_patch = (int)strtoul(p + sizeof("#define __GNU_MP_VERSION_PATCHLEVEL"), NULL, 10);
      else
      {
        p = strstr(buffer, "#define __GNU_MP_VERSION_MINOR");
        if (NULL != p)
          *version_minor = (int)strtoul(p + sizeof("#define __GNU_MP_VERSION_MINOR"), NULL, 10);
        else
        {
          p = strstr(buffer, "#define __GNU_MP_VERSION");
          if (NULL != p)
            *version_major = (int)strtoul(p + sizeof("#define __GNU_MP_VERSION"), NULL, 10);
        }
      }
    }
    else
    {
      p = strstr(buffer, "#define MPFR_VERSION_PATCHLEVEL");
      if (NULL != p)
        *version_patch = (int)strtoul(p + sizeof("#define MPFR_VERSION_PATCHLEVEL"), NULL, 10);
      else
      {
        p = strstr(buffer, "#define MPFR_VERSION_MINOR");
        if (NULL != p)
          *version_minor = (int)strtoul(p + sizeof("#define MPFR_VERSION_MINOR"), NULL, 10);
        else
        {
          p = strstr(buffer, "#define MPFR_VERSION_MAJOR");
          if (NULL != p)
            *version_major = (int)strtoul(p + sizeof("#define MPFR_VERSION_MAJOR"), NULL, 10);
        }
      }
    }

    memset(buffer, 0x00, sizeof(buffer));
  }
  fclose(f);

  return (0 != *version_major && -1 != *version_minor && -1 != *version_patch) ? true : false;
}

int main(int argc, char* argv[])
{
  const char           *rc_file;
  const char           *header_file;
  char                  build_string[512], libname[32], libname_long[64];
  bool                  is_debug, is_gmp;
  int                   assembly   = -1, 
                        full_64bit = -1, 
                        security   = -1, 
                        dynamic_rt =  0, 
                        arm64      = -1,
                        intel64    = -1, 
                        amd64      = -1; // -1 = not defined, 0 = false, 1 = true
  char                  arch[64];
  int                   i, version_major = 0, version_minor = 0, version_patch = 0;
  uint32_t              file_flags = 0x4; /* 0x20 for special build, 0x04 for patched build*/
  FILE                 *f;

  if (argc < 4)
  {
ShowHelp:
    fprintf(stdout, "usage: %s <output file.rc> <library header file with version> <DEBUG|RELEASE> [<build options>...]\n", argv[0]);
    fprintf(stdout, "------\n\n");
    fprintf(stdout, "       DEBUG or RELEASE build\n");
    fprintf(stdout, "       'ASSEMBLY='   if x86-64 assembler is included\n");
    fprintf(stdout, "       'FULL_64BIT=' if mp_size_t is 64bit instead of 32bit (default)\n");
    fprintf(stdout, "       'SECURITY='   if DLL was compiled with additional security options\n");
    fprintf(stdout, "       'DYNAMIC_RT=' if DLL was compiled /MD or /MDd instead of /MT or /MTd\n");
    fprintf(stdout, "       'ARCH=<arch>' if DLL was compiled for specific CPU architecture\n");
    fprintf(stdout, "       'INTEL64='    if DLL was compiled with '/favor:INTEL64'\n");
    fprintf(stdout, "       'AMD64='      if DLL was compiled with '/favor:AMD64'\n");
    fprintf(stdout, "       'ARM64='      if DLL was compiled for Aarch64/ARM64\n");
    fprintf(stdout, "\n");
    return 1;
  }

  memset(arch, 0x00, sizeof(arch));
  memset(build_string, 0x00, sizeof(build_string));

  rc_file = argv[1];

  header_file = argv[2];

  if (strstr(header_file, "gmp.h"))
  {
    is_gmp = true;
    strcpy(libname, "libgmp");
    strcpy(libname_long, "The GNU MP Library");
  }
  else
  if (strstr(header_file, "mpfr.h"))
  {
    is_gmp = false;
    strcpy(libname, "libmpfr");
    strcpy(libname_long, "The GNU MPFR Library");
  }
  else
  {
    fprintf(stderr, "ERROR: This program supports only 'gmp.h' and 'mpfr.h' as header files. STOP.\n");
    return 1;
  }

  if (!get_lib_version(header_file, is_gmp, &version_major, &version_minor, &version_patch))
  {
    fprintf(stderr, "ERROR: Unable to extract versioning information from header file: %s\n", header_file);
    return 1;
  }

  if (!_stricmp(argv[3], "DEBUG"))
  {
    is_debug = true;
    strncat(build_string, "build=DEBUG", sizeof(build_string) - 1);
    file_flags |= 0x1;
  }
  else
  if (!_stricmp(argv[3], "RELEASE"))
  {
    is_debug = false;
    strncat(build_string, "build=RELEASE", sizeof(build_string) - 1);
  }
  else
    goto ShowHelp;

  for (i = 4; i < argc; i++)
  {
    if (!_stricmp(argv[i], "ASSEMBLY="))
    {
      assembly = 1;
      if (is_gmp) // there is no assembly in libmpfr
        strncat(build_string, ", assembly=true", sizeof(build_string) - 1);
    }
    else
    if (!_stricmp(argv[i], "FULL_64BIT="))
    {
      full_64bit = 1;
      strncat(build_string, ", mp_size_t=64bit", sizeof(build_string) - 1);
      file_flags |= 0x20;
    }
    else
    if (!_stricmp(argv[i], "SECURITY="))
    {
      security = 1;
      strncat(build_string, ", security=true", sizeof(build_string) - 1);
    }
    else
    if (!_stricmp(argv[i], "DYNAMIC_RT="))
    {
      dynamic_rt = 1;
      strncat(build_string, ", dynamic_runtime", sizeof(build_string) - 1);
    }
    else
    if (!_stricmp(argv[i], "INTEL64="))
    {
      intel64 = 1;
      strncat(build_string, ", favor=intel64", sizeof(build_string) - 1);
    }
    else
    if (!_stricmp(argv[i], "AMD64="))
    {
      amd64 = 1;
      strncat(build_string, ", favor=amd64", sizeof(build_string) - 1);
    }
    else
    if (!_stricmp(argv[i], "ARM64="))
    {
      arm64 = 1;
      strncat(build_string, ", AArch64/ARM64", sizeof(build_string) - 1);
    }
    else
    if ((strlen(argv[i]) > 5) && (!_memicmp(argv[i], "ARCH=", 5)))
    {
      strncpy(arch, &argv[i][5], sizeof(arch) - 1);
      _strlwr(arch);
      strncat(build_string, ", arch=", sizeof(build_string) - 1);
      strncat(build_string, arch, sizeof(build_string) - 1);
      file_flags |= 0x20;
    }
    // ignore all other, unknown options
  }

  if (-1 == arm64)
    strncat(build_string, ", X86-64", sizeof(build_string) - 1);

  if (-1 == assembly && is_gmp) // there is no assembly in libmpfr
  {
    assembly = 0;
    strncat(build_string, ", assembly=false", sizeof(build_string) - 1);
  }

  if (-1 == full_64bit)
  {
    full_64bit = 0;
    strncat(build_string, ", mp_size_t=32bit", sizeof(build_string) - 1);
  }

  if (-1 == security)
  {
    security = 0;
    strncat(build_string, ", security=false", sizeof(build_string) - 1);
  }

  if (0 == dynamic_rt)
  {
    security = 0;
    strncat(build_string, ", static_runtime", sizeof(build_string) - 1);
  }

  f = fopen(rc_file, "wt");
  if (NULL == f)
  {
    fprintf(stderr, "ERROR: Unable to create resource script file: %s\n", rc_file);
    return 1;
  }

  fprintf(f, "VS_VERSION_INFO VERSIONINFO\n");
  fprintf(f, "  FILEVERSION %i,%i,%i,0\n", version_major, version_minor, version_patch);
  fprintf(f, "  PRODUCTVERSION %i,%i,%i,0\n", version_major, version_minor, version_patch);
  fprintf(f, "  FILEFLAGSMASK 0x3fL\n");
  fprintf(f, "  FILEFLAGS 0x%xL\n", file_flags);
  fprintf(f, "  FILEOS 0x40004L\n");
  fprintf(f, "  FILETYPE 0x2L\n");
  fprintf(f, "  FILESUBTYPE 0x0L\n");
  fprintf(f, "BEGIN\n");
  fprintf(f, "  BLOCK \"StringFileInfo\"\n");
  fprintf(f, "  BEGIN\n");
  fprintf(f, "    BLOCK \"000004E4\"\n");
  fprintf(f, "    BEGIN\n");
  fprintf(f, "      VALUE \"CompanyName\", \"Free Software Foundation, Inc.\"\n");
  fprintf(f, "      VALUE \"FileDescription\", \"%s (native Windows port)\"\n", libname_long);
  fprintf(f, "      VALUE \"FileVersion\", \"%i.%i.%i.0\"\n", version_major, version_minor, version_patch);
  fprintf(f, "      VALUE \"InternalName\", \"%s\"\n", libname);
  fprintf(f, "      VALUE \"LegalCopyright\", \"Copyright(C) 2026 Free Software Foundation, Inc.\"\n");
  fprintf(f, "      VALUE \"OriginalFilename\", \"%s.dll\"\n", libname);
  fprintf(f, "      VALUE \"ProductName\", \"%s\"\n", libname_long);
  fprintf(f, "      VALUE \"ProductVersion\", \"%i.%i.%i.0\"\n", version_major, version_minor, version_patch);
  fprintf(f, "      VALUE \"SpecialBuild\", \"%s\"\n", build_string);
  fprintf(f, "    END\n");
  fprintf(f, "  END\n");
  fprintf(f, "END\n");
  fprintf(f, "\n");

  fclose(f);

  if (is_gmp)
  {
    fprintf(stdout, "#include <gmp-impl.h>\n");
    fprintf(stdout, "__GMP_DECLSPEC const char * const __gmp_build = \"%s\";\n", build_string);
  }
  else
  {
    fprintf(stdout, "#include <mpfr-impl.h>\n");
    fprintf(stdout, "__MPFR_DECLSPEC const char * const mpfr_build = \"%s\";\n", build_string);
  }

  return 0;
}
