/**
 * @file   wintestrunner.c
 * @author Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
 * @brief  source file implementing a test runner for libgmp/libmpfr
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

#ifndef _CRT_SECURE_NO_WARNINGS
#define _CRT_SECURE_NO_WARNINGS
#endif
#ifndef WIN32
#define WIN32
#endif
#ifndef _WIN64
#define _WIN64
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

#include <io.h>
#define F_OK 0
#define access _access

#define likely(_x)    (_x)
#define unlikely(_x)  (_x)

#define CTRL_RESET              "\033[0;0;0m"
#define CTRL_RED                "\033[1;31m"
#define CTRL_GREEN              "\033[1;32m"
#define CTRL_YELLOW             "\033[1;33m"
#define CTRL_BLUE               "\033[1;34m"
#define CTRL_MAGENTA            "\033[1;35m"
#define CTRL_CYAN               "\033[1;36m"

#define NUM_DOTS                30

/******************************************************************************\
*       This is a part of the Microsoft Source Code Samples.
*       Copyright 1995 - 1997 Microsoft Corporation.
*       All rights reserved.
*       This source code is only intended as a supplement to
*       Microsoft Development Tools and/or WinHelp documentation.
*       See these sources for detailed information regarding the
*       Microsoft samples programs.
\******************************************************************************/

/*++
Copyright (c) 1997  Microsoft Corporation
Module Name:
    pipeex.c
Abstract:
    CreatePipe-like function that lets one or both handles be overlapped
Author:
    Dave Hart  Summer 1997
Revision History:
--*/

#include <windows.h>
#include <stdio.h>

static volatile long PipeSerialNumber;

BOOL
APIENTRY
MyCreatePipeEx(
  OUT LPHANDLE lpReadPipe,
  OUT LPHANDLE lpWritePipe,
  IN LPSECURITY_ATTRIBUTES lpPipeAttributes,
  IN DWORD nSize,
  DWORD dwReadMode,
  DWORD dwWriteMode
)

/*++
Routine Description:
    The CreatePipeEx API is used to create an anonymous pipe I/O device.
    Unlike CreatePipe FILE_FLAG_OVERLAPPED may be specified for one or
    both handles.
    Two handles to the device are created.  One handle is opened for
    reading and the other is opened for writing.  These handles may be
    used in subsequent calls to ReadFile and WriteFile to transmit data
    through the pipe.
Arguments:
    lpReadPipe - Returns a handle to the read side of the pipe.  Data
        may be read from the pipe by specifying this handle value in a
        subsequent call to ReadFile.
    lpWritePipe - Returns a handle to the write side of the pipe.  Data
        may be written to the pipe by specifying this handle value in a
        subsequent call to WriteFile.
    lpPipeAttributes - An optional parameter that may be used to specify
        the attributes of the new pipe.  If the parameter is not
        specified, then the pipe is created without a security
        descriptor, and the resulting handles are not inherited on
        process creation.  Otherwise, the optional security attributes
        are used on the pipe, and the inherit handles flag effects both
        pipe handles.
    nSize - Supplies the requested buffer size for the pipe.  This is
        only a suggestion and is used by the operating system to
        calculate an appropriate buffering mechanism.  A value of zero
        indicates that the system is to choose the default buffering
        scheme.
Return Value:
    TRUE - The operation was successful.
    FALSE/NULL - The operation failed. Extended error status is available
        using GetLastError.
--*/

{
  HANDLE ReadPipeHandle, WritePipeHandle;
  DWORD dwError;
  UCHAR PipeNameBuffer[MAX_PATH];

  //
  // Only one valid OpenMode flag - FILE_FLAG_OVERLAPPED
  //

  if ((dwReadMode | dwWriteMode) & (~FILE_FLAG_OVERLAPPED)) {
    SetLastError(ERROR_INVALID_PARAMETER);
    return FALSE;
  }

  //
  //  Set the default timeout to 120 seconds
  //

  if (nSize == 0) {
    nSize = 4096;
  }

  snprintf((char*)PipeNameBuffer, sizeof(PipeNameBuffer),
    "\\\\.\\Pipe\\RemoteExeAnon.%08x.%08x",
    GetCurrentProcessId(),
    InterlockedIncrement(&PipeSerialNumber)
  );

  ReadPipeHandle = CreateNamedPipeA(
    (const char*)PipeNameBuffer,
    PIPE_ACCESS_INBOUND | dwReadMode,
    PIPE_TYPE_BYTE | PIPE_WAIT,
    1,             // Number of pipes
    nSize,         // Out buffer size
    nSize,         // In buffer size
    120 * 1000,    // Timeout in ms
    lpPipeAttributes
  );

  if (!ReadPipeHandle) {
    return FALSE;
  }

  WritePipeHandle = CreateFileA(
    (const char*)PipeNameBuffer,
    GENERIC_WRITE,
    0,                         // No sharing
    lpPipeAttributes,
    OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL | dwWriteMode,
    NULL                       // Template file
  );

  if (INVALID_HANDLE_VALUE == WritePipeHandle) {
    dwError = GetLastError();
    CloseHandle(ReadPipeHandle);
    SetLastError(dwError);
    return FALSE;
  }

  *lpReadPipe = ReadPipeHandle;
  *lpWritePipe = WritePipeHandle;
  return(TRUE);
}

#define MAX_STDOUT_CAPTURE 1024

int execute_external_program_argv(uint8_t stdout_buffer[MAX_STDOUT_CAPTURE], bool wait_for_child, int argc, char *argv[])
{
  uint32_t                  i, num_args = 0, stdout_idx = 0, bufferAvailable, toBeTransferred, all_args_len = 0, l;
  char                     *prog_args, *run;
  SECURITY_ATTRIBUTES       saAttr;
  HANDLE                    g_hChildStd_IN_Rd = INVALID_HANDLE_VALUE;
  HANDLE                    g_hChildStd_IN_Wr = INVALID_HANDLE_VALUE;
  HANDLE                    g_hChildStd_OUT_Rd = INVALID_HANDLE_VALUE;
  HANDLE                    g_hChildStd_OUT_Wr = INVALID_HANDLE_VALUE;
  PROCESS_INFORMATION       piProcInfo;
  STARTUPINFO               siStartInfo;
  OVERLAPPED                asyncRead;
  HANDLE                    hEvents[2];
  DWORD                     dwWaitResult, dwNumEvents = 1, dwExitCode = 0, dwRead;
  bool                      bProcessTerminated = false, bIoFailed = false;
  uint8_t                   read_buffer[512];

  memset(&saAttr, 0, sizeof(saAttr));
  memset(&piProcInfo, 0, sizeof(piProcInfo));
  memset(&siStartInfo, 0, sizeof(siStartInfo));
  memset(&asyncRead, 0, sizeof(asyncRead));

  if (NULL != stdout_buffer)
  {
    memset(stdout_buffer, 0, MAX_STDOUT_CAPTURE);
    wait_for_child = true; // if we want to read child's output, we HAVE TO wait
  }

  all_args_len += ((uint32_t)strlen(argv[0])) + 1;
  for (i = 1; i < ((uint32_t)argc); i++)
  {
    all_args_len += ((uint32_t)strlen(argv[i])) + 1;
    num_args++;
  }

  prog_args = (char*)malloc(all_args_len);
  if (unlikely(NULL == prog_args))
    return 127;

  memset(prog_args, 0, all_args_len);
  run = prog_args;
  l = (uint32_t)strlen(argv[0]);
  memcpy(run, argv[0], l);
  run += l;
  for (i = 0; i < num_args; i++)
  {
    *(run++) = 0x20; // space

    l = (uint32_t)strlen(argv[i + 1]);
    memcpy(run, argv[i + 1], l);
    run += l;
  }

  saAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
  saAttr.bInheritHandle = TRUE;
  saAttr.lpSecurityDescriptor = NULL;

  // We DO need the special named pipe implementation to are able to use the FILE_FLAG_OVERLAPPED flag!
  // if (!CreatePipe(&g_hChildStd_OUT_Rd, &g_hChildStd_OUT_Wr, &saAttr, 0))
  if (!MyCreatePipeEx(&g_hChildStd_OUT_Rd, &g_hChildStd_OUT_Wr, &saAttr, MAX_STDOUT_CAPTURE, FILE_FLAG_OVERLAPPED, 0/*FILE_FLAG_OVERLAPPED*/))
  {
ErrorExit:

    if (NULL != piProcInfo.hThread)
      CloseHandle(piProcInfo.hThread);

    if (NULL != piProcInfo.hProcess)
      CloseHandle(piProcInfo.hProcess);

    if (INVALID_HANDLE_VALUE != g_hChildStd_IN_Rd)
      CloseHandle(g_hChildStd_IN_Rd);
    if (INVALID_HANDLE_VALUE != g_hChildStd_IN_Wr)
      CloseHandle(g_hChildStd_IN_Wr);
    if (INVALID_HANDLE_VALUE != g_hChildStd_OUT_Rd)
      CloseHandle(g_hChildStd_OUT_Rd);
    if (INVALID_HANDLE_VALUE != g_hChildStd_OUT_Wr)
      CloseHandle(g_hChildStd_OUT_Wr);

    if (NULL != prog_args)
      free(prog_args);

    if (NULL != asyncRead.hEvent)
      CloseHandle(asyncRead.hEvent);

    return 127;
  }

  if (!SetHandleInformation(g_hChildStd_OUT_Rd, HANDLE_FLAG_INHERIT, 0))
    goto ErrorExit;

  if (!CreatePipe(&g_hChildStd_IN_Rd, &g_hChildStd_IN_Wr, &saAttr, 0))
    goto ErrorExit;

  if (!SetHandleInformation(g_hChildStd_IN_Wr, HANDLE_FLAG_INHERIT, 0))
    goto ErrorExit;

  if (NULL != stdout_buffer)
  {
    asyncRead.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL); // manual reset event
    if (NULL == asyncRead.hEvent)
      goto ErrorExit;
  }

  siStartInfo.cb = sizeof(STARTUPINFO);
  siStartInfo.hStdError = g_hChildStd_OUT_Wr;
  siStartInfo.hStdOutput = g_hChildStd_OUT_Wr;
  siStartInfo.hStdInput = g_hChildStd_IN_Rd;
  siStartInfo.dwFlags |= STARTF_USESTDHANDLES;

  if (NULL != stdout_buffer)
  {
    if (!ReadFile(g_hChildStd_OUT_Rd, read_buffer, sizeof(read_buffer), NULL, &asyncRead))
    {
      if (ERROR_IO_PENDING != GetLastError())
        goto ErrorExit;
    }
    hEvents[1] = asyncRead.hEvent;
    dwNumEvents = 2;
  }

  // Create the child process. 

  if (!CreateProcess(argv[0], prog_args, NULL, NULL, TRUE, 0, NULL, NULL, &siStartInfo, &piProcInfo))
    goto ErrorExit;

  free(prog_args), prog_args = NULL;

  CloseHandle(g_hChildStd_OUT_Wr), g_hChildStd_OUT_Wr = INVALID_HANDLE_VALUE;
  CloseHandle(g_hChildStd_IN_Rd), g_hChildStd_IN_Rd = INVALID_HANDLE_VALUE;

  CloseHandle(piProcInfo.hThread); // always close thread handle LWP 0 (not needed anymore in the following code)
  piProcInfo.hThread = NULL;

  if (!wait_for_child) // asyncRead.hEvent is NULL in this case
  {
    CloseHandle(piProcInfo.hProcess);
    CloseHandle(g_hChildStd_OUT_Rd);
    CloseHandle(g_hChildStd_IN_Wr);
    return 0; // we do not wait for the child to be terminated, so just return 0 (OK) here
  }

  hEvents[0] = piProcInfo.hProcess;

  while (!bProcessTerminated && !bIoFailed)
  {
    dwWaitResult = WaitForMultipleObjects(dwNumEvents, hEvents, FALSE, INFINITE);
    switch (dwWaitResult)
    {
    case WAIT_OBJECT_0: // child process terminated
      if (!GetExitCodeProcess(piProcInfo.hProcess, &dwExitCode))
        dwExitCode = 127;
      bProcessTerminated = true;
      break;
    case WAIT_OBJECT_0 + 1: // stdout output from child is available (async. read)
      dwRead = 0;
      if ((GetOverlappedResult(g_hChildStd_OUT_Rd, &asyncRead, &dwRead, FALSE/*do not wait*/)) && (0 != dwRead))
      {
        bufferAvailable = MAX_STDOUT_CAPTURE - 1 - stdout_idx;
        toBeTransferred = (dwRead > bufferAvailable) ? bufferAvailable : dwRead;
        if (0 != toBeTransferred)
        {
          memcpy(&stdout_buffer[stdout_idx], read_buffer, toBeTransferred);
          stdout_idx += toBeTransferred;
        }
      }

      ResetEvent(asyncRead.hEvent); // should not be necessary (ReadFile normally does this) but anyway...
      asyncRead.Offset += dwRead; // maybe also not necessary for child process stdout reads but who knows...

      if (!ReadFile(g_hChildStd_OUT_Rd, read_buffer, sizeof(read_buffer), NULL, &asyncRead))
      {
        if (ERROR_IO_PENDING != GetLastError())
        {
          CancelIo(g_hChildStd_OUT_Rd);
          WaitForSingleObject(piProcInfo.hProcess, INFINITE);
          if (!GetExitCodeProcess(piProcInfo.hProcess, &dwExitCode))
            dwExitCode = 127;
          bIoFailed = true;
          break;
        }
      }

      break;

    default:
      CancelIo(g_hChildStd_OUT_Rd);
      WaitForSingleObject(piProcInfo.hProcess, INFINITE);
      if (!GetExitCodeProcess(piProcInfo.hProcess, &dwExitCode))
        dwExitCode = 127;
      bIoFailed = true;
      break;
    }
  }

  if (NULL != asyncRead.hEvent)
  {
    dwRead = 0;

    while ((GetOverlappedResult(g_hChildStd_OUT_Rd, &asyncRead, &dwRead, FALSE/*do not wait*/)) && (0 != dwRead))
    {
      bufferAvailable = MAX_STDOUT_CAPTURE - 1 - stdout_idx;
      toBeTransferred = (dwRead > bufferAvailable) ? bufferAvailable : dwRead;
      if (0 != toBeTransferred)
      {
        memcpy(&stdout_buffer[stdout_idx], read_buffer, toBeTransferred);
        stdout_idx += toBeTransferred;
      }

      ResetEvent(asyncRead.hEvent); // should not be necessary (ReadFile normally does this) but anyway...
      asyncRead.Offset += dwRead; // maybe also not necessary for child process stdout reads but who knows...
      dwRead = 0;

      if (!ReadFile(g_hChildStd_OUT_Rd, read_buffer, sizeof(read_buffer), NULL, &asyncRead))
      {
        if (ERROR_IO_PENDING != GetLastError())
          break;
      }
    }

    CancelIo(g_hChildStd_OUT_Rd); // for failsafe purposes...
    CloseHandle(asyncRead.hEvent);
  }

  CloseHandle(piProcInfo.hProcess);

  CloseHandle(g_hChildStd_OUT_Rd);
  CloseHandle(g_hChildStd_IN_Wr);

  return (int)dwExitCode;
}

static void print_dots(int dots)
{
  char          s_dots[128];

  if (dots <= 0)
    return;

  memset(s_dots, 0x00, sizeof(s_dots));
  memset(s_dots, '.', dots);
  fprintf(stdout, "%s", s_dots);
}

static int    reset_console = 0;
static DWORD  dwMode = 0;
static HANDLE hConsole = INVALID_HANDLE_VALUE;

BOOL WINAPI CtrlHandler(DWORD fdwCtrlType)
{
  switch (fdwCtrlType)
  {
  case CTRL_C_EVENT:
  case CTRL_BREAK_EVENT:
    if (0 != reset_console)
    {
      if (INVALID_HANDLE_VALUE != hConsole)
      {
        dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
        SetConsoleMode(hConsole, dwMode);
      }
    }
    break;

  default:
    break;
  }

  return FALSE;
}

static char stdout_buffer[MAX_STDOUT_CAPTURE];

static int find_out_which_compiler_is_active(void)
{
  char       *_argv[4];
  char       *p, *p2, *p_x86_64, *p_arm64;
  int         status;
  char        system_folder[256], where_exe_path[256], compiler_exe[256];;

  memset(system_folder, 0x00, sizeof(system_folder));
  memset(where_exe_path, 0x00, sizeof(where_exe_path));
  memset(compiler_exe, 0x00, sizeof(compiler_exe));

  GetSystemDirectoryA(system_folder, sizeof(system_folder) - 1);
  snprintf(where_exe_path, sizeof(where_exe_path), "%s\\where.exe", system_folder);

  // 1.) Use "where.exe" to get the cl.exe that gets executed

  memset(stdout_buffer, 0x00, sizeof(stdout_buffer));
  _argv[0] = where_exe_path;
  _argv[1] = "cl.exe";
  _argv[2] = NULL;

  status = execute_external_program_argv((uint8_t*)stdout_buffer, true, 2, _argv);
  if (0 != status)
    return 1;

  p = strchr(stdout_buffer, '\r');
  if (NULL == p)
    p = strchr(stdout_buffer, '\n');
  if (NULL != p)
    *p = 0;
  strncpy(compiler_exe, stdout_buffer, sizeof(compiler_exe) - 1);

  memset(stdout_buffer, 0x00, sizeof(stdout_buffer));
  _argv[0] = compiler_exe;
  _argv[1] = "/?";
  _argv[2] = NULL;

  status = execute_external_program_argv((uint8_t*)stdout_buffer, true, 2, _argv);
  if (0 != status)
    return 1;

  p = strchr(stdout_buffer, '\r');
  if (NULL == p)
    p = strchr(stdout_buffer, '\n');
  if (NULL != p)
    *p = 0;

  p = strstr(stdout_buffer, "Optimizing Compiler");
  if (NULL == p)
    return 1;
  p2 = strchr(p, '\r');
  if (NULL == p2)
    p2 = strchr(p, '\n');
  if (NULL != p2)
    *p2 = 0;

  p_x86_64 = strstr(p + sizeof("Optimizing Compiler") - 1, "for x64");
  p_arm64 = strstr(p + sizeof("Optimizing Compiler") - 1, "for ARM64");

  if (NULL != p_x86_64 && NULL != p_arm64)
    return 1;

  if (NULL != p_x86_64)
  {
    fprintf(stdout, "X86-64\n");
  }
  else
  if (NULL != p_arm64)
  {
    fprintf(stdout, "ARM64\n");
  }
  else
  {
    fprintf(stdout, "UNKNOWN\n");
  }

  return 0;
}

int main(int argc, char* argv[])
{
  int           rc = 0, status, errors = 0, skipped = 0, succeeded = 0, overall = 0;
  char          szCurrDir[256], szFileName[256], szLine[256], szMessage[128];
  char         *_argv[2];
  FILE         *f = NULL, *g;
  size_t        len;
  LARGE_INTEGER frequency;
  LARGE_INTEGER start;
  LARGE_INTEGER end;
  double        time_consumed;
  char          str_time_consumed[128];
  uint64_t      overall_core_time = 0;

  // This is to check for the current MS Visual C environment, i.e. if it is
  // x86-64 or ARM64 (AARCH64)

  if (2 == argc && !_stricmp(argv[1], "--check-compiler"))
    return find_out_which_compiler_is_active();

  //////////////////////////////////////////////////////////////////////////////////////////

  hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
  if (GetConsoleMode(hConsole, &dwMode))
  {
    dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
    reset_console = 1;
  }
  SetConsoleCtrlHandler(CtrlHandler, TRUE);

  GetCurrentDirectory(sizeof(szCurrDir), szCurrDir);

  if (2 != argc)
  {
    fprintf(stdout, CTRL_CYAN "usage: %s " CTRL_GREEN "<text file with test binaries>" CTRL_RESET "\n", argv[0]);
    rc = 1;
    goto DoExit2;
  }

  f = fopen(argv[1], "rt");
  if (NULL == f)
  {
    fprintf(stderr, CTRL_RED "ERROR" CTRL_RESET ": input file '%s' NOT found. STOP.\n", argv[1]);
    rc = 1;
    goto DoExit2;
  }

  QueryPerformanceFrequency(&frequency);
  QueryPerformanceCounter(&start);

  memset(szLine, 0x00, sizeof(szLine));
  while (fgets(szLine, sizeof(szLine), f))
  {
    len = strlen(szLine);
    if (0 == len)
      goto Cont;
    if ('#' == szLine[0])
      goto Cont;
    if (szLine[len - 1] == 0x0A)
      szLine[--len] = 0;
    if (0 == len)
      goto Cont;
    if (szLine[len - 1] == 0x0D)
      szLine[--len] = 0;
    if (0 == len)
      goto Cont;

    snprintf(szFileName, sizeof(szFileName), "%s\\tests\\%s.exe", szCurrDir, szLine);
    if (0 != access(szFileName, F_OK))
    {
      fprintf(stderr, CTRL_RED "ERROR" CTRL_RESET ": Test applet NOT found: %s\n", szFileName);
      rc = 1;
      goto DoExit;
    }

    snprintf(szMessage, sizeof(szMessage), CTRL_CYAN "Running test '" CTRL_MAGENTA "%s" CTRL_CYAN "' ", szLine);
    fprintf(stdout, "%s", szMessage);
    print_dots( (int)(NUM_DOTS - strlen(szLine)));
    fflush(stdout);

    memset(stdout_buffer, 0x00, sizeof(stdout_buffer));
    _argv[0] = szFileName;
    _argv[1] = NULL;

    overall++;

    status = execute_external_program_argv((uint8_t*)stdout_buffer, true, 1, _argv);

    memset(str_time_consumed, 0x00, sizeof(str_time_consumed));
    g = fopen("__time__consumed", "rt");
    char *p = NULL;
    if (NULL == g)
    {
      strcpy(str_time_consumed, "  n/a      sec(s)\n");
      p = str_time_consumed;
    }
    else
    {
      fgets(str_time_consumed, sizeof(str_time_consumed) - 1, g);
      p = strchr(str_time_consumed, '|');
      if (NULL != p)
      {
        *p = 0;
        p += 2;
        overall_core_time += strtoull(str_time_consumed, NULL, 10);
      }
      else
        p = str_time_consumed;
      fclose(g);
    }

    switch(status)
    {
      case 0:
        fprintf(stdout, CTRL_GREEN " PASS: " CTRL_YELLOW "took %s" CTRL_RESET, p);
        succeeded++;
        break;
      case 77:
        fprintf(stdout, CTRL_YELLOW " SKIP" CTRL_RESET "\n");
        skipped++;
        break;
      case 99: // test applet does NOT work because it uses libgmp.dll but the static runtime was
               // compiled in; any 'FILE*' used in the applet would point into a 'black hole'...
               // (crashing the app)
        fprintf(stdout, CTRL_YELLOW " SKIP" CTRL_RESET " (static runtime in DLL!)\n");
        skipped++;
        break;
      case 101:
        fprintf(stdout, CTRL_RED " FAIL (memory leak(s) detected)" CTRL_RESET "\n");
        errors++;
        break;
      case 125: // applet called abort()
        fprintf(stdout, CTRL_RED " FAIL" CTRL_RESET "\n");
        errors++;
        break;
      case 0x80000003:
        fprintf(stdout, CTRL_RED " FAIL (DEBUG BREAKPOINT REACHED)" CTRL_RESET "\n");
        errors++;
        break;
      case 0xC0000005:
        fprintf(stdout, CTRL_RED " FAIL (CRASHED WITH CPU EXCEPTION)" CTRL_RESET "\n");
        errors++;
        break;
      case 0xC0000409:
        fprintf(stdout, CTRL_RED " FAIL (CRASHED WITH CPU EXCEPTION - POSSIBLY STATIC-RT PROBLEM)" CTRL_RESET "\n");
        errors++;
        break;
      default:
        fprintf(stdout, CTRL_RED " FAIL: " CTRL_YELLOW "with error code %i" CTRL_RESET "\n", status);
        fprintf(stdout, "=> test applet output is:\n%s", (const char*)stdout_buffer);
        errors++;
        break;
    }

Cont:
    memset(szLine, 0x00, sizeof(szLine));
  }

DoExit:

  QueryPerformanceCounter(&end);
  time_consumed = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart;

  fprintf(stdout, "\n"
                  CTRL_YELLOW "%u" CTRL_CYAN " overall, " 
                  CTRL_GREEN "%u" CTRL_CYAN " succeeded, "
                  CTRL_RED "%u" CTRL_CYAN " failed, "
                  CTRL_MAGENTA "%u" CTRL_CYAN " skipped" CTRL_RESET ".\n", overall, succeeded, errors, skipped);

  fprintf(stdout, CTRL_CYAN "Test suite ran " CTRL_YELLOW "%3.6f" CTRL_CYAN " sec(s)" CTRL_RESET ".\n", time_consumed);
  time_consumed = (double)(overall_core_time) / frequency.QuadPart;
  fprintf(stdout, CTRL_CYAN "Tests within test suite consumed " CTRL_YELLOW "%3.6f" CTRL_CYAN " sec(s)" CTRL_RESET ".\n", time_consumed);

DoExit2:

  if (NULL != f)
    fclose(f);

  if (0 != reset_console)
  {
    dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
  }

  SetConsoleCtrlHandler(CtrlHandler, FALSE);

  return rc;
}