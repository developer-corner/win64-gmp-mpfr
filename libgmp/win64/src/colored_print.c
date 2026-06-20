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

int main(int argc, char* argv[])
{
  int            i, l, rc = 0, level = 1;
  const char    *command;
  const char    *str_1st = NULL;
  const char    *str_2nd = NULL;
  const char    *str_inf = NULL;
  const char    *str_section = NULL;

  hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
  if (GetConsoleMode(hConsole, &dwMode))
  {
    dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
    reset_console = 1;
  }
  SetConsoleCtrlHandler(CtrlHandler, TRUE);

  if (argc < 2)
  {
Usage:
    fprintf(stdout, "usage: %s <command> [--1st=<string>] [--2nd=<string>] [--inf=<string>] [--level=N] [--section=<string>]\n", argv[0]);
    fprintf(stdout, "------\n\n");
    fprintf(stdout, "    <command> is the command to be printed in " CTRL_CYAN "cyan" CTRL_RESET "\n");
    fprintf(stdout, "     if 1st string specified, then it is printed in " CTRL_YELLOW "yellow" CTRL_RESET "\n");
    fprintf(stdout, "     if 2nd string specified, then it is printed in " CTRL_GREEN "green" CTRL_RESET "\n");
    fprintf(stdout, "     if inf(ix) string specified, then it is printed in " CTRL_MAGENTA "magenta" CTRL_RESET "\n");
    fprintf(stdout, "     if inf(ix) is NOT specified, then an arrow '=>' is printed in " CTRL_MAGENTA "magenta" CTRL_RESET "\n");
    fprintf(stdout, "     <level N> may be one or two, defaults to one.\n");
    fprintf(stdout, "     if section string specified, then printed in front of everything else\n");
    fprintf(stdout, "     in " CTRL_RED "red" CTRL_RESET " with square brackets.\n");
    fprintf(stdout, "\n");
    rc = 1;
    goto DoExit;
  }

  command = argv[1];

  for (i = 2; i < argc; i++)
  {
    l = (int)strlen(argv[i]);
    if ((l >= 6) && (!memcmp(argv[i], "--1st=", 6)))
      str_1st = &argv[i][6];
    else
    if ((l >= 6) && (!memcmp(argv[i], "--2nd=", 6)))
      str_2nd = &argv[i][6];
    else
    if ((l >= 6) && (!memcmp(argv[i], "--inf=", 6)))
      str_inf = &argv[i][6];
    else
    if ((l >= 8) && (!memcmp(argv[i], "--level=", 8)))
      level = atoi(&argv[i][8]);
    else
    if ((l >= 10) && (!memcmp(argv[i], "--section=", 10)))
      str_section = &argv[i][10];
    else
      goto Usage;
  }

  if (level < 1)
    level = 1;
  if (level > 2)
    level = 2;

  fprintf(stdout, "%s", 1 == level ? " * " : "   + ");

  if (NULL != str_section)
  fprintf(stdout, "[" CTRL_RED "%s" CTRL_RESET "] ", str_section);

  fprintf(stdout, CTRL_CYAN "%s " CTRL_RESET, command);

  if (NULL != str_1st)
    fprintf(stdout, CTRL_YELLOW "%s " CTRL_RESET, str_1st);

  if (NULL != str_inf)
    fprintf(stdout, CTRL_MAGENTA "%s " CTRL_RESET, str_inf);
  else
  if ((NULL != str_1st) && (NULL != str_2nd))
    fprintf(stdout, CTRL_MAGENTA "=> " CTRL_RESET);

  if (NULL != str_2nd)
    fprintf(stdout, CTRL_GREEN "%s " CTRL_RESET, str_2nd);

  fprintf(stdout, CTRL_CYAN "..." CTRL_RESET "\n");

DoExit:

  if (0 != reset_console)
  {
    dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
  }

  SetConsoleCtrlHandler(CtrlHandler, FALSE);

  return rc;
}
