/*
 * Copyright 2026 Ingo A.Kubbilun <ingo.kubbilun@gmail.com>
 *
 * This file is part of the GNU MP Library(MS Windows port).
 *
 * The GNU MP Library is free software; you can redistribute it and /or modify
 * it under the terms of either :
 *
 *   * the GNU Lesser General Public License as published by the Free
 *     Software Foundation; either version 3 of the License, or (at your
 *     option) any later version.
 *
 * or
 *
 *   * the GNU General Public License as published by the Free Software
 *     Foundation; either version 2 of the License, or (at your option) any
 *     later version.
 *
 * or both in parallel, as here.
 *
 * The GNU MP Library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.See the GNU General Public License
 * for more details.
 *
 * You should have received copies of the GNU General Public License and the
 * GNU Lesser General Public License along with the GNU MP Library.If not,
 * see https://www.gnu.org/licenses/.
 *
 */

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

BOOL WINAPI DllMain ( HINSTANCE hinstDLL,
                      DWORD     fdwReason,
                      LPVOID    lpvReserved)
{
  switch (fdwReason)
  {
    case DLL_PROCESS_ATTACH:
      DisableThreadLibraryCalls(hinstDLL);
      break;

    case DLL_PROCESS_DETACH:
      break;

    case DLL_THREAD_ATTACH:
      break;

    case DLL_THREAD_DETACH:
      break;

    default:
      return FALSE;
  }

  return TRUE;
}

