/**
 * This is a very small 'drop-in' replacement for the UNIX-like
 * unistd.h for the libgmp
 * It declares just some minor stuff on MS Windows systems together
 * with gettimeofday function replacement.
 *
 * Nothing special, though...
 */

#ifndef _UNISTD_H
#define _UNISTD_H       1

#ifdef __cplusplus
extern "C" {
#endif

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

#include <io.h>
#include <process.h>
#define access _access
#define unlink _unlink
#define rmdir _rmdir
#define isatty _isatty

#ifndef STDIN_FILENO
#define STDIN_FILENO 0
#endif

#ifndef STDOUT_FILENO
#define STDOUT_FILENO 1
#endif

#ifndef STDERR_FILENO
#define STDERR_FILENO 2
#endif

extern void my_abort(const char *file, int line);

struct timeval
{
  long    tv_sec;         /* seconds */
  long    tv_usec;        /* and microseconds */
};

inline int gettimeofday(struct timeval* tp, struct timezone* tzp)
{
  (void)tzp;
  FILETIME    file_time;
  SYSTEMTIME  system_time;
  ULARGE_INTEGER ularge;

  GetSystemTime(&system_time);
  SystemTimeToFileTime(&system_time, &file_time);
  ularge.LowPart = file_time.dwLowDateTime;
  ularge.HighPart = file_time.dwHighDateTime;

  tp->tv_sec = (long)((ularge.QuadPart - ((unsigned __int64)116444736000000000ULL)) / 10000000L);
  tp->tv_usec = (long)(system_time.wMilliseconds * 1000);

  return 0;
}

#ifdef __cplusplus
}
#endif

#endif /* _UNISTD_H */
